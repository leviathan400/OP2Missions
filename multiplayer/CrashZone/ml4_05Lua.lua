-- ml4_05Lua.lua  -  4 Player, LastOne, 'Crash Zone' map. (Lua)
--
-- Converted by op2dll from ml4_05.dll ("4 Player, LastOne, 'Crash Zone' map."): its setup replayed. `on_init` makes the original's
-- draws of the game's random numbers in its order and, from them and the lobby, the same units,
-- beacons, walls and settings in the same order, as the original's setup did in every game
-- sampled (every player count, the lobby's colonies, resource levels, vehicles, day and night,
-- morale and disasters). Anything not converted is listed at the end. Coordinates are the in-game
-- status-bar ones (map file tile + 1).

-- Where lava may flow from an eruption, as areas { x1, y1, x2, y2 }.
local LAVA_POSSIBLE = {
  { 219, 41, 220, 41 }, { 216, 42, 220, 42 }, { 216, 43, 221, 43 }, { 218, 44, 223, 44 }, { 220, 45, 223, 47 }, { 219, 48, 224, 48 },
  { 216, 49, 225, 49 }, { 216, 50, 226, 50 }, { 216, 51, 227, 51 }, { 216, 52, 225, 52 }, { 218, 53, 224, 53 }, { 218, 54, 222, 54 },
  { 219, 55, 222, 55 }, { 219, 56, 221, 56 }, { 219, 57, 222, 57 }, { 219, 58, 223, 59 }, { 219, 60, 224, 60 }, { 219, 61, 222, 61 },
  { 219, 62, 221, 63 }, { 214, 64, 215, 65 }, { 218, 64, 221, 64 }, { 198, 65, 198, 65 }, { 200, 65, 201, 65 }, { 208, 65, 209, 65 },
  { 217, 65, 222, 65 }, { 198, 66, 202, 66 }, { 207, 66, 221, 66 }, { 198, 67, 203, 67 }, { 207, 67, 220, 67 }, { 198, 68, 220, 68 },
  { 195, 69, 195, 69 }, { 197, 69, 220, 69 }, { 195, 70, 220, 72 }, { 194, 73, 220, 73 }, { 191, 74, 220, 74 }, { 190, 75, 220, 75 },
  { 187, 76, 211, 76 }, { 217, 76, 220, 76 }, { 187, 77, 210, 78 }, { 219, 77, 219, 78 }, { 188, 79, 210, 79 }, { 219, 79, 220, 80 },
  { 189, 80, 210, 81 }, { 218, 81, 220, 81 }, { 185, 82, 211, 82 }, { 217, 82, 221, 82 }, { 185, 83, 210, 83 }, { 216, 83, 224, 83 },
  { 186, 84, 194, 84 }, { 206, 84, 224, 84 }, { 184, 85, 193, 85 }, { 209, 85, 221, 85 }, { 182, 86, 192, 86 }, { 216, 86, 221, 86 },
  { 181, 87, 191, 87 }, { 217, 87, 220, 87 }, { 176, 88, 188, 88 }, { 215, 88, 220, 88 }, { 174, 89, 185, 89 }, { 215, 89, 221, 89 },
  { 174, 90, 183, 90 }, { 215, 90, 220, 90 }, { 175, 91, 181, 91 }, { 216, 91, 220, 91 }, { 175, 92, 182, 92 }, { 218, 92, 219, 92 },
  { 178, 93, 182, 93 }, { 179, 94, 182, 94 }, { 180, 95, 181, 95 },
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
local Lava, Tornados

function Lava(t)
  game.create_eruption({ 217, 82 }, 200)
end

function Tornados(t)
  local r1 = game.rand(127)
  local r2 = game.rand(256)
  local r3 = game.rand(10)
  local r4 = game.rand(127)
  local r5 = game.rand(256)
  game.create_tornado({ r5 + 1, r4 + 2 }, { r2 + 1, r1 + 2 }, r3 + 10)
end

function on_init()
  local n = game.num_players()
  if n == 2 then
    for _, area in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(area) end
    game.initial_set_tile({ 215, 80 }, 1161)
    game.initial_set_tile({ 215, 81 }, 1184)
    game.initial_set_tile({ 216, 80 }, 1172)
    game.initial_set_tile({ 216, 81 }, 1195)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 145, 4 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 230, 92 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 10, 98 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 62, 6 } }
    R[0] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 90, [1] = 125, [2] = 90, [3] = 101 })[R[0]], ({ [0] = 6, [1] = 33, [2] = 40, [3] = 22 })[R[0]] } }
    R[1] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 83, [1] = 112, [2] = 115, [3] = 87 })[R[1]], ({ [0] = 105, [1] = 63, [2] = 82, [3] = 79 })[R[1]] } }
    R[2] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 155, [1] = 185, [2] = 232, [3] = 155 })[R[2]], ({ [0] = 101, [1] = 71, [2] = 80, [3] = 73 })[R[2]] } }
    R[3] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 164, [1] = 236, [2] = 138, [3] = 129 })[R[3]], ({ [0] = 41, [1] = 44, [2] = 55, [3] = 27 })[R[3]] } }
    R[4] = draw_avoid(4, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 90, [1] = 125, [2] = 90, [3] = 101 })[R[4]], ({ [0] = 6, [1] = 33, [2] = 40, [3] = 22 })[R[4]] } }
    R[5] = draw_avoid(4, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 83, [1] = 112, [2] = 115, [3] = 87 })[R[5]], ({ [0] = 105, [1] = 63, [2] = 82, [3] = 79 })[R[5]] } }
    R[6] = draw_avoid(4, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 155, [1] = 185, [2] = 232, [3] = 155 })[R[6]], ({ [0] = 101, [1] = 71, [2] = 80, [3] = 73 })[R[6]] } }
    R[7] = draw_avoid(4, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 164, [1] = 236, [2] = 138, [3] = 129 })[R[7]], ({ [0] = 41, [1] = 44, [2] = 55, [3] = 27 })[R[7]] } }
    R[8] = draw_avoid(4, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 90, [1] = 125, [2] = 90, [3] = 101 })[R[8]], ({ [0] = 6, [1] = 33, [2] = 40, [3] = 22 })[R[8]] } }
    R[9] = draw_avoid(4, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 83, [1] = 112, [2] = 115, [3] = 87 })[R[9]], ({ [0] = 105, [1] = 63, [2] = 82, [3] = 79 })[R[9]] } }
    R[10] = draw_avoid(4, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 155, [1] = 185, [2] = 232, [3] = 155 })[R[10]], ({ [0] = 101, [1] = 71, [2] = 80, [3] = 73 })[R[10]] } }
    R[11] = draw_avoid(4, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 164, [1] = 236, [2] = 138, [3] = 129 })[R[11]], ({ [0] = 41, [1] = 44, [2] = 55, [3] = 27 })[R[11]] } }
    R[12] = draw_avoid(4, { R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 90, [1] = 125, [2] = 90, [3] = 101 })[R[12]], ({ [0] = 6, [1] = 33, [2] = 40, [3] = 22 })[R[12]] } }
    R[13] = draw_avoid(4, { R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 83, [1] = 112, [2] = 115, [3] = 87 })[R[13]], ({ [0] = 105, [1] = 63, [2] = 82, [3] = 79 })[R[13]] } }
    R[14] = draw_avoid(4, { R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 155, [1] = 185, [2] = 232, [3] = 155 })[R[14]], ({ [0] = 101, [1] = 71, [2] = 80, [3] = 73 })[R[14]] } }
    R[15] = draw_avoid(4, { R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 164, [1] = 236, [2] = 138, [3] = 129 })[R[15]], ({ [0] = 41, [1] = 44, [2] = 55, [3] = 27 })[R[15]] } }
    R[16] = game.rand(4)
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 55, [1] = 62, [2] = 165, [3] = 145 })[R[16]], ({ [0] = 40, [1] = 71, [2] = 122, [3] = 29 })[R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 49, [1] = 36, [2] = 180, [3] = 211 })[R[16]], ({ [0] = 41, [1] = 66, [2] = 98, [3] = 37 })[R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[17] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [3] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [4] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [5] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [5] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [6] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [3] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [4] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [5] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [5] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [6] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[17]][R[16]] })
    if R[17] == 5 or R[17] == 6 or R[17] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [6] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [7] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 } })[R[17]][R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 } })[R[17]][R[16]], ({ [5] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [6] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [7] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 5 or R[17] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [7] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[17]][R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if R[17] == 5 then
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
        elseif R[17] == 7 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[17]", R[17])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [5] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 }, [7] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[17]][R[16]], ({ [5] = { [0] = 28, [1] = 113, [2] = 117, [3] = 17 }, [7] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        if R[17] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[17] == 7 then
        else
          unseen("R[17]", R[17])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [5] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [5] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [7] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [7] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[17]][R[16]], ({ [5] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [7] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[17] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [6] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 }, [7] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 } })[R[17]][R[16]], ({ [5] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [6] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [7] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[17] == 1 or R[17] == 2 or R[17] == 3 or R[17] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [3] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [4] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[17]][R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[16]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 19, [1] = 104, [2] = 108, [3] = 8 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 1 or R[17] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 } })[R[17]][R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[16]], ({ [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 } })[R[17]][R[16]], ({ [1] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 } })[R[17]][R[16]], ({ [1] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [2] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [2] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 } })[R[17]][R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[17]", R[17])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[17]], player = players[1], at = { ({ [1] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [3] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 }, [4] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 } })[R[17]][R[16]], ({ [1] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [2] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [3] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [4] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[17]], player = players[1], at = { ({ [1] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [3] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [4] = { [0] = 46, [1] = 32, [2] = 207, [3] = 166 } })[R[17]][R[16]], ({ [1] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [2] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [3] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [4] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [2] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [3] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [4] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 } })[R[17]][R[16]], ({ [1] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [2] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [3] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [4] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[17] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[17]", R[17])
    end
    U[#U]:set_lights(true)
    if R[17] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 24, [1] = 109, [2] = 113, [3] = 13 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 24, [1] = 109, [2] = 113, [3] = 13 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[17]", R[17])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [3] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [4] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [5] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [6] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [7] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [5] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [6] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [7] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [1] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [3] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [4] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [5] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [6] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [7] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 } })[R[17]][R[16]], ({ [0] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [3] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 }, [4] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [5] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [6] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [7] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[17] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[18] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [1] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[18]][R[16]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 28, [1] = 113, [2] = 117, [3] = 17 } })[R[18]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        for i = 1, game.initial_units() do
          R[19] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[19]][R[16]], ({ [0] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [1] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [2] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 } })[R[19]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
        for i = 1, game.initial_units() do
          R[20] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [1] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 } })[R[20]][R[16]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[20]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [1] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [2] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[21]][R[16]], ({ [0] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 } })[R[21]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] })
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [1] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[22]][R[16]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[22]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 } })[R[23]][R[16]], ({ [0] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[23]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[24]][R[16]], ({ [0] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [1] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [2] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 } })[R[24]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[25]][R[16]], ({ [0] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[25]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[17]", R[17])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 145, [1] = 165, [2] = 62, [3] = 55 })[R[16]], ({ [0] = 29, [1] = 122, [2] = 71, [3] = 40 })[R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 211, [1] = 180, [2] = 36, [3] = 49 })[R[16]], ({ [0] = 37, [1] = 98, [2] = 66, [3] = 41 })[R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[26] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 172, [1] = 213, [2] = 38, [3] = 52 }, [1] = { [0] = 176, [1] = 217, [2] = 42, [3] = 56 }, [2] = { [0] = 176, [1] = 217, [2] = 42, [3] = 56 }, [3] = { [0] = 168, [1] = 209, [2] = 34, [3] = 48 }, [4] = { [0] = 172, [1] = 213, [2] = 38, [3] = 52 }, [5] = { [0] = 171, [1] = 212, [2] = 37, [3] = 51 }, [6] = { [0] = 168, [1] = 209, [2] = 34, [3] = 48 }, [7] = { [0] = 174, [1] = 215, [2] = 40, [3] = 54 } })[R[26]][R[16]], ({ [0] = { [0] = 15, [1] = 115, [2] = 111, [3] = 26 }, [1] = { [0] = 11, [1] = 111, [2] = 107, [3] = 22 }, [2] = { [0] = 15, [1] = 115, [2] = 111, [3] = 26 }, [3] = { [0] = 11, [1] = 111, [2] = 107, [3] = 22 }, [4] = { [0] = 14, [1] = 114, [2] = 110, [3] = 25 }, [5] = { [0] = 12, [1] = 112, [2] = 108, [3] = 23 }, [6] = { [0] = 9, [1] = 109, [2] = 105, [3] = 20 }, [7] = { [0] = 12, [1] = 112, [2] = 108, [3] = 23 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 172, [1] = 213, [2] = 38, [3] = 52 }, [1] = { [0] = 176, [1] = 217, [2] = 42, [3] = 56 }, [2] = { [0] = 176, [1] = 217, [2] = 42, [3] = 56 }, [3] = { [0] = 168, [1] = 209, [2] = 34, [3] = 48 }, [4] = { [0] = 172, [1] = 213, [2] = 38, [3] = 52 }, [5] = { [0] = 171, [1] = 212, [2] = 37, [3] = 51 }, [6] = { [0] = 168, [1] = 209, [2] = 34, [3] = 48 }, [7] = { [0] = 174, [1] = 215, [2] = 40, [3] = 54 } })[R[26]][R[16]], ({ [0] = { [0] = 15, [1] = 115, [2] = 111, [3] = 26 }, [1] = { [0] = 11, [1] = 111, [2] = 107, [3] = 22 }, [2] = { [0] = 15, [1] = 115, [2] = 111, [3] = 26 }, [3] = { [0] = 11, [1] = 111, [2] = 107, [3] = 22 }, [4] = { [0] = 14, [1] = 114, [2] = 110, [3] = 25 }, [5] = { [0] = 12, [1] = 112, [2] = 108, [3] = 23 }, [6] = { [0] = 9, [1] = 109, [2] = 105, [3] = 20 }, [7] = { [0] = 12, [1] = 112, [2] = 108, [3] = 23 } })[R[26]][R[16]] })
    if R[26] == 1 or R[26] == 2 or R[26] == 3 or R[26] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = { [0] = 176, [1] = 217, [2] = 42, [3] = 56 }, [2] = { [0] = 169, [1] = 210, [2] = 35, [3] = 49 }, [3] = { [0] = 173, [1] = 214, [2] = 39, [3] = 53 }, [4] = { [0] = 169, [1] = 210, [2] = 35, [3] = 49 } })[R[26]][R[16]], ({ [0] = 18, [1] = 118, [2] = 114, [3] = 29 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 169, [1] = 210, [2] = 35, [3] = 49 })[R[16]], ({ [0] = 10, [1] = 110, [2] = 106, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 173, [1] = 214, [2] = 39, [3] = 53 })[R[16]], ({ [0] = 11, [1] = 111, [2] = 107, [3] = 22 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 168, [1] = 209, [2] = 34, [3] = 48 })[R[16]], ({ [0] = 14, [1] = 114, [2] = 110, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 177, [1] = 218, [2] = 43, [3] = 57 })[R[16]], ({ [0] = 19, [1] = 119, [2] = 115, [3] = 30 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 171, [1] = 212, [2] = 37, [3] = 51 })[R[16]], ({ [0] = 8, [1] = 108, [2] = 104, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 168, [1] = 209, [2] = 34, [3] = 48 })[R[16]], ({ [0] = 19, [1] = 119, [2] = 115, [3] = 30 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 175, [1] = 216, [2] = 41, [3] = 55 })[R[16]], ({ [0] = 15, [1] = 115, [2] = 111, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 169, [1] = 210, [2] = 35, [3] = 49 })[R[16]], ({ [0] = 14, [1] = 114, [2] = 110, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 177, [1] = 218, [2] = 43, [3] = 57 })[R[16]], ({ [0] = 9, [1] = 109, [2] = 105, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 174, [1] = 215, [2] = 40, [3] = 54 })[R[16]], ({ [0] = 20, [1] = 120, [2] = 116, [3] = 31 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 1 or R[26] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [1] = { [0] = 167, [1] = 208, [2] = 33, [3] = 47 }, [2] = { [0] = 168, [1] = 209, [2] = 34, [3] = 48 } })[R[26]][R[16]], ({ [0] = 9, [1] = 109, [2] = 105, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 176, [1] = 217, [2] = 42, [3] = 56 })[R[16]], ({ [1] = { [0] = 14, [1] = 114, [2] = 110, [3] = 25 }, [2] = { [0] = 18, [1] = 118, [2] = 114, [3] = 29 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [1] = { [0] = 171, [1] = 212, [2] = 37, [3] = 51 }, [2] = { [0] = 172, [1] = 213, [2] = 38, [3] = 52 } })[R[26]][R[16]], ({ [1] = { [0] = 19, [1] = 119, [2] = 115, [3] = 30 }, [2] = { [0] = 15, [1] = 115, [2] = 111, [3] = 26 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = { [0] = 171, [1] = 212, [2] = 37, [3] = 51 }, [2] = { [0] = 176, [1] = 217, [2] = 42, [3] = 56 } })[R[26]][R[16]], ({ [1] = { [0] = 15, [1] = 115, [2] = 111, [3] = 26 }, [2] = { [0] = 12, [1] = 112, [2] = 108, [3] = 23 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 177, [1] = 218, [2] = 43, [3] = 57 }, [2] = { [0] = 175, [1] = 216, [2] = 41, [3] = 55 } })[R[26]][R[16]], ({ [0] = 20, [1] = 120, [2] = 116, [3] = 31 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[26]", R[26])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[26]], player = players[2], at = { ({ [1] = { [0] = 178, [1] = 219, [2] = 44, [3] = 58 }, [2] = { [0] = 177, [1] = 218, [2] = 43, [3] = 57 }, [3] = { [0] = 175, [1] = 216, [2] = 41, [3] = 55 }, [4] = { [0] = 172, [1] = 213, [2] = 38, [3] = 52 } })[R[26]][R[16]], ({ [1] = { [0] = 19, [1] = 119, [2] = 115, [3] = 30 }, [2] = { [0] = 20, [1] = 120, [2] = 116, [3] = 31 }, [3] = { [0] = 19, [1] = 119, [2] = 115, [3] = 30 }, [4] = { [0] = 9, [1] = 109, [2] = 105, [3] = 20 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[26]], player = players[2], at = { ({ [1] = { [0] = 175, [1] = 216, [2] = 41, [3] = 55 }, [2] = { [0] = 173, [1] = 214, [2] = 39, [3] = 53 }, [3] = { [0] = 176, [1] = 217, [2] = 42, [3] = 56 }, [4] = { [0] = 166, [1] = 207, [2] = 32, [3] = 46 } })[R[26]][R[16]], ({ [1] = { [0] = 20, [1] = 120, [2] = 116, [3] = 31 }, [2] = { [0] = 19, [1] = 119, [2] = 115, [3] = 30 }, [3] = { [0] = 20, [1] = 120, [2] = 116, [3] = 31 }, [4] = { [0] = 16, [1] = 116, [2] = 112, [3] = 27 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [1] = { [0] = 178, [1] = 219, [2] = 44, [3] = 58 }, [2] = { [0] = 170, [1] = 211, [2] = 36, [3] = 50 }, [3] = { [0] = 170, [1] = 211, [2] = 36, [3] = 50 }, [4] = { [0] = 170, [1] = 211, [2] = 36, [3] = 50 } })[R[26]][R[16]], ({ [1] = { [0] = 16, [1] = 116, [2] = 112, [3] = 27 }, [2] = { [0] = 20, [1] = 120, [2] = 116, [3] = 31 }, [3] = { [0] = 16, [1] = 116, [2] = 112, [3] = 27 }, [4] = { [0] = 12, [1] = 112, [2] = 108, [3] = 23 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 178, [1] = 219, [2] = 44, [3] = 58 })[R[16]], ({ [0] = 16, [1] = 116, [2] = 112, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 170, [1] = 211, [2] = 36, [3] = 50 })[R[16]], ({ [0] = 20, [1] = 120, [2] = 116, [3] = 31 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 170, [1] = 211, [2] = 36, [3] = 50 })[R[16]], ({ [0] = 16, [1] = 116, [2] = 112, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 170, [1] = 211, [2] = 36, [3] = 50 })[R[16]], ({ [0] = 12, [1] = 112, [2] = 108, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[26]", R[26])
      end
    elseif R[26] == 5 or R[26] == 6 or R[26] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [5] = { [0] = 168, [1] = 209, [2] = 34, [3] = 48 }, [6] = { [0] = 177, [1] = 218, [2] = 43, [3] = 57 }, [7] = { [0] = 168, [1] = 209, [2] = 34, [3] = 48 } })[R[26]][R[16]], ({ [0] = 19, [1] = 119, [2] = 115, [3] = 30 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [5] = { [0] = 176, [1] = 217, [2] = 42, [3] = 56 }, [6] = { [0] = 168, [1] = 209, [2] = 34, [3] = 48 }, [7] = { [0] = 176, [1] = 217, [2] = 42, [3] = 56 } })[R[26]][R[16]], ({ [5] = { [0] = 13, [1] = 113, [2] = 109, [3] = 24 }, [6] = { [0] = 18, [1] = 118, [2] = 114, [3] = 29 }, [7] = { [0] = 18, [1] = 118, [2] = 114, [3] = 29 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 168, [1] = 209, [2] = 34, [3] = 48 })[R[16]], ({ [0] = 15, [1] = 115, [2] = 111, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 168, [1] = 209, [2] = 34, [3] = 48 })[R[16]], ({ [0] = 12, [1] = 112, [2] = 108, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 173, [1] = 214, [2] = 39, [3] = 53 })[R[16]], ({ [0] = 10, [1] = 110, [2] = 106, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[26] == 5 or R[26] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [5] = { [0] = 176, [1] = 217, [2] = 42, [3] = 56 }, [7] = { [0] = 169, [1] = 210, [2] = 35, [3] = 49 } })[R[26]][R[16]], ({ [0] = 9, [1] = 109, [2] = 105, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if R[26] == 5 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 175, [1] = 216, [2] = 41, [3] = 55 })[R[16]], ({ [0] = 17, [1] = 117, [2] = 113, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 175, [1] = 216, [2] = 41, [3] = 55 })[R[16]], ({ [0] = 17, [1] = 117, [2] = 113, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 175, [1] = 216, [2] = 41, [3] = 55 })[R[16]], ({ [0] = 17, [1] = 117, [2] = 113, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[26] == 7 then
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
          unseen("R[26]", R[26])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [5] = { [0] = 171, [1] = 212, [2] = 37, [3] = 51 }, [7] = { [0] = 173, [1] = 214, [2] = 39, [3] = 53 } })[R[26]][R[16]], ({ [0] = 9, [1] = 109, [2] = 105, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if R[26] == 5 then
        elseif R[26] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 174, [1] = 215, [2] = 40, [3] = 54 })[R[16]], ({ [0] = 15, [1] = 115, [2] = 111, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[26]", R[26])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 171, [1] = 212, [2] = 37, [3] = 51 })[R[16]], ({ [5] = { [0] = 15, [1] = 115, [2] = 111, [3] = 26 }, [7] = { [0] = 12, [1] = 112, [2] = 108, [3] = 23 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 172, [1] = 213, [2] = 38, [3] = 52 })[R[16]], ({ [5] = { [0] = 14, [1] = 114, [2] = 110, [3] = 25 }, [7] = { [0] = 13, [1] = 113, [2] = 109, [3] = 24 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [5] = { [0] = 172, [1] = 213, [2] = 38, [3] = 52 }, [7] = { [0] = 177, [1] = 218, [2] = 43, [3] = 57 } })[R[26]][R[16]], ({ [5] = { [0] = 16, [1] = 116, [2] = 112, [3] = 27 }, [7] = { [0] = 13, [1] = 113, [2] = 109, [3] = 24 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[26]", R[26])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [5] = { [0] = 178, [1] = 219, [2] = 44, [3] = 58 }, [6] = { [0] = 175, [1] = 216, [2] = 41, [3] = 55 }, [7] = { [0] = 171, [1] = 212, [2] = 37, [3] = 51 } })[R[26]][R[16]], ({ [5] = { [0] = 11, [1] = 111, [2] = 107, [3] = 22 }, [6] = { [0] = 12, [1] = 112, [2] = 108, [3] = 23 }, [7] = { [0] = 10, [1] = 110, [2] = 106, [3] = 21 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 178, [1] = 219, [2] = 44, [3] = 58 })[R[16]], ({ [0] = 11, [1] = 111, [2] = 107, [3] = 22 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 175, [1] = 216, [2] = 41, [3] = 55 })[R[16]], ({ [0] = 12, [1] = 112, [2] = 108, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 175, [1] = 216, [2] = 41, [3] = 55 })[R[16]], ({ [0] = 12, [1] = 112, [2] = 108, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 170, [1] = 211, [2] = 36, [3] = 50 })[R[16]], ({ [0] = 20, [1] = 120, [2] = 116, [3] = 31 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 171, [1] = 212, [2] = 37, [3] = 51 })[R[16]], ({ [0] = 19, [1] = 119, [2] = 115, [3] = 30 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 171, [1] = 212, [2] = 37, [3] = 51 })[R[16]], ({ [0] = 10, [1] = 110, [2] = 106, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[26]", R[26])
      end
    elseif R[26] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 169, [1] = 210, [2] = 35, [3] = 49 })[R[16]], ({ [0] = 18, [1] = 118, [2] = 114, [3] = 29 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 174, [1] = 215, [2] = 40, [3] = 54 })[R[16]], ({ [0] = 18, [1] = 118, [2] = 114, [3] = 29 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 168, [1] = 209, [2] = 34, [3] = 48 })[R[16]], ({ [0] = 15, [1] = 115, [2] = 111, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 176, [1] = 217, [2] = 42, [3] = 56 })[R[16]], ({ [0] = 15, [1] = 115, [2] = 111, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 177, [1] = 218, [2] = 43, [3] = 57 })[R[16]], ({ [0] = 9, [1] = 109, [2] = 105, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 175, [1] = 216, [2] = 41, [3] = 55 })[R[16]], ({ [0] = 20, [1] = 120, [2] = 116, [3] = 31 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 176, [1] = 217, [2] = 42, [3] = 56 })[R[16]], ({ [0] = 19, [1] = 119, [2] = 115, [3] = 30 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 178, [1] = 219, [2] = 44, [3] = 58 })[R[16]], ({ [0] = 18, [1] = 118, [2] = 114, [3] = 29 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 171, [1] = 212, [2] = 37, [3] = 51 })[R[16]], ({ [0] = 20, [1] = 120, [2] = 116, [3] = 31 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 171, [1] = 212, [2] = 37, [3] = 51 })[R[16]], ({ [0] = 20, [1] = 120, [2] = 116, [3] = 31 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[26]", R[26])
    end
    U[#U]:set_lights(true)
    if R[26] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 171, [1] = 212, [2] = 37, [3] = 51 })[R[16]], ({ [0] = 20, [1] = 120, [2] = 116, [3] = 31 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 167, [1] = 208, [2] = 33, [3] = 47 })[R[16]], ({ [0] = 11, [1] = 111, [2] = 107, [3] = 22 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 167, [1] = 208, [2] = 33, [3] = 47 })[R[16]], ({ [0] = 11, [1] = 111, [2] = 107, [3] = 22 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 178, [1] = 219, [2] = 44, [3] = 58 })[R[16]], ({ [0] = 16, [1] = 116, [2] = 112, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 168, [1] = 209, [2] = 34, [3] = 48 })[R[16]], ({ [0] = 15, [1] = 115, [2] = 111, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 168, [1] = 209, [2] = 34, [3] = 48 })[R[16]], ({ [0] = 15, [1] = 115, [2] = 111, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 170, [1] = 211, [2] = 36, [3] = 50 })[R[16]], ({ [0] = 20, [1] = 120, [2] = 116, [3] = 31 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 172, [1] = 213, [2] = 38, [3] = 52 })[R[16]], ({ [0] = 11, [1] = 111, [2] = 107, [3] = 22 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 172, [1] = 213, [2] = 38, [3] = 52 })[R[16]], ({ [0] = 11, [1] = 111, [2] = 107, [3] = 22 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 170, [1] = 211, [2] = 36, [3] = 50 })[R[16]], ({ [0] = 16, [1] = 116, [2] = 112, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 171, [1] = 212, [2] = 37, [3] = 51 })[R[16]], ({ [0] = 12, [1] = 112, [2] = 108, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 171, [1] = 212, [2] = 37, [3] = 51 })[R[16]], ({ [0] = 12, [1] = 112, [2] = 108, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 170, [1] = 211, [2] = 36, [3] = 50 })[R[16]], ({ [0] = 12, [1] = 112, [2] = 108, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 167, [1] = 208, [2] = 33, [3] = 47 })[R[16]], ({ [0] = 20, [1] = 120, [2] = 116, [3] = 31 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 178, [1] = 219, [2] = 44, [3] = 58 })[R[16]], ({ [0] = 11, [1] = 111, [2] = 107, [3] = 22 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 178, [1] = 219, [2] = 44, [3] = 58 })[R[16]], ({ [0] = 17, [1] = 117, [2] = 113, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 175, [1] = 216, [2] = 41, [3] = 55 })[R[16]], ({ [0] = 12, [1] = 112, [2] = 108, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 170, [1] = 211, [2] = 36, [3] = 50 })[R[16]], ({ [0] = 20, [1] = 120, [2] = 116, [3] = 31 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 171, [1] = 212, [2] = 37, [3] = 51 })[R[16]], ({ [0] = 19, [1] = 119, [2] = 115, [3] = 30 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 173, [1] = 214, [2] = 39, [3] = 53 })[R[16]], ({ [0] = 20, [1] = 120, [2] = 116, [3] = 31 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 171, [1] = 212, [2] = 37, [3] = 51 })[R[16]], ({ [0] = 13, [1] = 113, [2] = 109, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 173, [1] = 214, [2] = 39, [3] = 53 })[R[16]], ({ [0] = 20, [1] = 120, [2] = 116, [3] = 31 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 171, [1] = 212, [2] = 37, [3] = 51 })[R[16]], ({ [0] = 13, [1] = 113, [2] = 109, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 171, [1] = 212, [2] = 37, [3] = 51 })[R[16]], ({ [0] = 10, [1] = 110, [2] = 106, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 178, [1] = 219, [2] = 44, [3] = 58 })[R[16]], ({ [0] = 17, [1] = 117, [2] = 113, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[26]", R[26])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 168, [1] = 209, [2] = 34, [3] = 48 }, [1] = { [0] = 167, [1] = 208, [2] = 33, [3] = 47 }, [2] = { [0] = 173, [1] = 214, [2] = 39, [3] = 53 }, [3] = { [0] = 172, [1] = 213, [2] = 38, [3] = 52 }, [4] = { [0] = 170, [1] = 211, [2] = 36, [3] = 50 }, [5] = { [0] = 177, [1] = 218, [2] = 43, [3] = 57 }, [6] = { [0] = 172, [1] = 213, [2] = 38, [3] = 52 }, [7] = { [0] = 177, [1] = 218, [2] = 43, [3] = 57 } })[R[26]][R[16]], ({ [0] = { [0] = 12, [1] = 112, [2] = 108, [3] = 23 }, [1] = { [0] = 14, [1] = 114, [2] = 110, [3] = 25 }, [2] = { [0] = 10, [1] = 110, [2] = 106, [3] = 21 }, [3] = { [0] = 11, [1] = 111, [2] = 107, [3] = 22 }, [4] = { [0] = 20, [1] = 120, [2] = 116, [3] = 31 }, [5] = { [0] = 15, [1] = 115, [2] = 111, [3] = 26 }, [6] = { [0] = 14, [1] = 114, [2] = 110, [3] = 25 }, [7] = { [0] = 20, [1] = 120, [2] = 116, [3] = 31 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 169, [1] = 210, [2] = 35, [3] = 49 }, [1] = { [0] = 169, [1] = 210, [2] = 35, [3] = 49 }, [2] = { [0] = 172, [1] = 213, [2] = 38, [3] = 52 }, [3] = { [0] = 171, [1] = 212, [2] = 37, [3] = 51 }, [4] = { [0] = 171, [1] = 212, [2] = 37, [3] = 51 }, [5] = { [0] = 178, [1] = 219, [2] = 44, [3] = 58 }, [6] = { [0] = 173, [1] = 214, [2] = 39, [3] = 53 }, [7] = { [0] = 178, [1] = 219, [2] = 44, [3] = 58 } })[R[26]][R[16]], ({ [0] = { [0] = 12, [1] = 112, [2] = 108, [3] = 23 }, [1] = { [0] = 13, [1] = 113, [2] = 109, [3] = 24 }, [2] = { [0] = 9, [1] = 109, [2] = 105, [3] = 20 }, [3] = { [0] = 10, [1] = 110, [2] = 106, [3] = 21 }, [4] = { [0] = 19, [1] = 119, [2] = 115, [3] = 30 }, [5] = { [0] = 14, [1] = 114, [2] = 110, [3] = 25 }, [6] = { [0] = 13, [1] = 113, [2] = 109, [3] = 24 }, [7] = { [0] = 20, [1] = 120, [2] = 116, [3] = 31 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[26] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[27] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 167, [1] = 208, [2] = 33, [3] = 47 }, [1] = { [0] = 172, [1] = 213, [2] = 38, [3] = 52 }, [2] = { [0] = 177, [1] = 218, [2] = 43, [3] = 57 } })[R[27]][R[16]], ({ [0] = { [0] = 8, [1] = 108, [2] = 104, [3] = 19 }, [1] = { [0] = 11, [1] = 111, [2] = 107, [3] = 22 }, [2] = { [0] = 17, [1] = 117, [2] = 113, [3] = 28 } })[R[27]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 171, [1] = 212, [2] = 37, [3] = 51 })[R[16]], ({ [0] = 17, [1] = 117, [2] = 113, [3] = 28 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 171, [1] = 212, [2] = 37, [3] = 51 })[R[16]], ({ [0] = 17, [1] = 117, [2] = 113, [3] = 28 })[R[16]] })
        for i = 1, game.initial_units() do
          R[28] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 167, [1] = 208, [2] = 33, [3] = 47 }, [1] = { [0] = 171, [1] = 212, [2] = 37, [3] = 51 }, [2] = { [0] = 174, [1] = 215, [2] = 40, [3] = 54 } })[R[28]][R[16]], ({ [0] = { [0] = 18, [1] = 118, [2] = 114, [3] = 29 }, [1] = { [0] = 12, [1] = 112, [2] = 108, [3] = 23 }, [2] = { [0] = 8, [1] = 108, [2] = 104, [3] = 19 } })[R[28]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 172, [1] = 213, [2] = 38, [3] = 52 })[R[16]], ({ [0] = 17, [1] = 117, [2] = 113, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 172, [1] = 213, [2] = 38, [3] = 52 })[R[16]], ({ [0] = 18, [1] = 118, [2] = 114, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 173, [1] = 214, [2] = 39, [3] = 53 })[R[16]], ({ [0] = 18, [1] = 118, [2] = 114, [3] = 29 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 172, [1] = 213, [2] = 38, [3] = 52 })[R[16]], ({ [0] = 17, [1] = 117, [2] = 113, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 172, [1] = 213, [2] = 38, [3] = 52 })[R[16]], ({ [0] = 18, [1] = 118, [2] = 114, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 173, [1] = 214, [2] = 39, [3] = 53 })[R[16]], ({ [0] = 18, [1] = 118, [2] = 114, [3] = 29 })[R[16]] })
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 176, [1] = 217, [2] = 42, [3] = 56 }, [1] = { [0] = 168, [1] = 209, [2] = 34, [3] = 48 }, [2] = { [0] = 172, [1] = 213, [2] = 38, [3] = 52 } })[R[29]][R[16]], ({ [0] = { [0] = 8, [1] = 108, [2] = 104, [3] = 19 }, [1] = { [0] = 13, [1] = 113, [2] = 109, [3] = 24 }, [2] = { [0] = 18, [1] = 118, [2] = 114, [3] = 29 } })[R[29]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 169, [1] = 210, [2] = 35, [3] = 49 })[R[16]], ({ [0] = 17, [1] = 117, [2] = 113, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 172, [1] = 213, [2] = 38, [3] = 52 })[R[16]], ({ [0] = 14, [1] = 114, [2] = 110, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 173, [1] = 214, [2] = 39, [3] = 53 })[R[16]], ({ [0] = 14, [1] = 114, [2] = 110, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 175, [1] = 216, [2] = 41, [3] = 55 })[R[16]], ({ [0] = 17, [1] = 117, [2] = 113, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 175, [1] = 216, [2] = 41, [3] = 55 })[R[16]], ({ [0] = 18, [1] = 118, [2] = 114, [3] = 29 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 169, [1] = 210, [2] = 35, [3] = 49 })[R[16]], ({ [0] = 17, [1] = 117, [2] = 113, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 172, [1] = 213, [2] = 38, [3] = 52 })[R[16]], ({ [0] = 14, [1] = 114, [2] = 110, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 173, [1] = 214, [2] = 39, [3] = 53 })[R[16]], ({ [0] = 14, [1] = 114, [2] = 110, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 175, [1] = 216, [2] = 41, [3] = 55 })[R[16]], ({ [0] = 17, [1] = 117, [2] = 113, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 175, [1] = 216, [2] = 41, [3] = 55 })[R[16]], ({ [0] = 18, [1] = 118, [2] = 114, [3] = 29 })[R[16]] })
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 177, [1] = 218, [2] = 43, [3] = 57 }, [1] = { [0] = 173, [1] = 214, [2] = 39, [3] = 53 }, [2] = { [0] = 169, [1] = 210, [2] = 35, [3] = 49 } })[R[30]][R[16]], ({ [0] = { [0] = 19, [1] = 119, [2] = 115, [3] = 30 }, [1] = { [0] = 13, [1] = 113, [2] = 109, [3] = 24 }, [2] = { [0] = 8, [1] = 108, [2] = 104, [3] = 19 } })[R[30]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 168, [1] = 209, [2] = 34, [3] = 48 })[R[16]], ({ [0] = 16, [1] = 116, [2] = 112, [3] = 27 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 168, [1] = 209, [2] = 34, [3] = 48 })[R[16]], ({ [0] = 16, [1] = 116, [2] = 112, [3] = 27 })[R[16]] })
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 176, [1] = 217, [2] = 42, [3] = 56 }, [1] = { [0] = 177, [1] = 218, [2] = 43, [3] = 57 }, [2] = { [0] = 173, [1] = 214, [2] = 39, [3] = 53 } })[R[31]][R[16]], ({ [0] = { [0] = 8, [1] = 108, [2] = 104, [3] = 19 }, [1] = { [0] = 14, [1] = 114, [2] = 110, [3] = 25 }, [2] = { [0] = 18, [1] = 118, [2] = 114, [3] = 29 } })[R[31]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 173, [1] = 214, [2] = 39, [3] = 53 }, [1] = { [0] = 167, [1] = 208, [2] = 33, [3] = 47 }, [2] = { [0] = 167, [1] = 208, [2] = 33, [3] = 47 } })[R[32]][R[16]], ({ [0] = { [0] = 19, [1] = 119, [2] = 115, [3] = 30 }, [1] = { [0] = 14, [1] = 114, [2] = 110, [3] = 25 }, [2] = { [0] = 9, [1] = 109, [2] = 105, [3] = 20 } })[R[32]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 177, [1] = 218, [2] = 43, [3] = 57 }, [1] = { [0] = 176, [1] = 217, [2] = 42, [3] = 56 }, [2] = { [0] = 173, [1] = 214, [2] = 39, [3] = 53 } })[R[33]][R[16]], ({ [0] = { [0] = 9, [1] = 109, [2] = 105, [3] = 20 }, [1] = { [0] = 15, [1] = 115, [2] = 111, [3] = 26 }, [2] = { [0] = 16, [1] = 116, [2] = 112, [3] = 27 } })[R[33]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 171, [1] = 212, [2] = 37, [3] = 51 }, [1] = { [0] = 167, [1] = 208, [2] = 33, [3] = 47 }, [2] = { [0] = 177, [1] = 218, [2] = 43, [3] = 57 } })[R[34]][R[16]], ({ [0] = { [0] = 18, [1] = 118, [2] = 114, [3] = 29 }, [1] = { [0] = 14, [1] = 114, [2] = 110, [3] = 25 }, [2] = { [0] = 9, [1] = 109, [2] = 105, [3] = 20 } })[R[34]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    for _, area in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(area) end
    game.initial_set_tile({ 215, 80 }, 1161)
    game.initial_set_tile({ 215, 81 }, 1184)
    game.initial_set_tile({ 216, 80 }, 1172)
    game.initial_set_tile({ 216, 81 }, 1195)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 145, 4 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 230, 92 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 10, 98 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 62, 6 } }
    R[0] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 90, [1] = 125, [2] = 90, [3] = 101 })[R[0]], ({ [0] = 6, [1] = 33, [2] = 40, [3] = 22 })[R[0]] } }
    R[1] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 83, [1] = 112, [2] = 115, [3] = 87 })[R[1]], ({ [0] = 105, [1] = 63, [2] = 82, [3] = 79 })[R[1]] } }
    R[2] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 155, [1] = 185, [2] = 232, [3] = 155 })[R[2]], ({ [0] = 101, [1] = 71, [2] = 80, [3] = 73 })[R[2]] } }
    R[3] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 164, [1] = 236, [2] = 138, [3] = 129 })[R[3]], ({ [0] = 41, [1] = 44, [2] = 55, [3] = 27 })[R[3]] } }
    R[4] = draw_avoid(4, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 90, [1] = 125, [2] = 90, [3] = 101 })[R[4]], ({ [0] = 6, [1] = 33, [2] = 40, [3] = 22 })[R[4]] } }
    R[5] = draw_avoid(4, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 83, [1] = 112, [2] = 115, [3] = 87 })[R[5]], ({ [0] = 105, [1] = 63, [2] = 82, [3] = 79 })[R[5]] } }
    R[6] = draw_avoid(4, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 155, [1] = 185, [2] = 232, [3] = 155 })[R[6]], ({ [0] = 101, [1] = 71, [2] = 80, [3] = 73 })[R[6]] } }
    R[7] = draw_avoid(4, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 164, [1] = 236, [2] = 138, [3] = 129 })[R[7]], ({ [0] = 41, [1] = 44, [2] = 55, [3] = 27 })[R[7]] } }
    R[8] = draw_avoid(4, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 90, [1] = 125, [2] = 90, [3] = 101 })[R[8]], ({ [0] = 6, [1] = 33, [2] = 40, [3] = 22 })[R[8]] } }
    R[9] = draw_avoid(4, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 83, [1] = 112, [2] = 115, [3] = 87 })[R[9]], ({ [0] = 105, [1] = 63, [2] = 82, [3] = 79 })[R[9]] } }
    R[10] = draw_avoid(4, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 155, [1] = 185, [2] = 232, [3] = 155 })[R[10]], ({ [0] = 101, [1] = 71, [2] = 80, [3] = 73 })[R[10]] } }
    R[11] = draw_avoid(4, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 164, [1] = 236, [2] = 138, [3] = 129 })[R[11]], ({ [0] = 41, [1] = 44, [2] = 55, [3] = 27 })[R[11]] } }
    R[12] = draw_avoid(4, { R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 90, [1] = 125, [2] = 90, [3] = 101 })[R[12]], ({ [0] = 6, [1] = 33, [2] = 40, [3] = 22 })[R[12]] } }
    R[13] = draw_avoid(4, { R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 83, [1] = 112, [2] = 115, [3] = 87 })[R[13]], ({ [0] = 105, [1] = 63, [2] = 82, [3] = 79 })[R[13]] } }
    R[14] = draw_avoid(4, { R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 155, [1] = 185, [2] = 232, [3] = 155 })[R[14]], ({ [0] = 101, [1] = 71, [2] = 80, [3] = 73 })[R[14]] } }
    R[15] = draw_avoid(4, { R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 164, [1] = 236, [2] = 138, [3] = 129 })[R[15]], ({ [0] = 41, [1] = 44, [2] = 55, [3] = 27 })[R[15]] } }
    pick(4, 3, { 16, 35, 36 })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 55, [1] = 62, [2] = 165, [3] = 145 })[R[16]], ({ [0] = 40, [1] = 71, [2] = 122, [3] = 29 })[R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 49, [1] = 36, [2] = 180, [3] = 211 })[R[16]], ({ [0] = 41, [1] = 66, [2] = 98, [3] = 37 })[R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[17] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [3] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [4] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [5] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [5] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [6] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [3] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [4] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [5] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [5] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [6] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[17]][R[16]] })
    if R[17] == 5 or R[17] == 6 or R[17] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [6] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [7] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 } })[R[17]][R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 } })[R[17]][R[16]], ({ [5] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [6] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [7] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[17] == 5 or R[17] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [7] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[17]][R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if R[17] == 5 then
          if LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[17] == 7 then
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
          unseen("R[17]", R[17])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [5] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [7] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[17]][R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if R[17] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[17] == 5 then
        else
          unseen("R[17]", R[17])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [5] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [5] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [7] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [7] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[17]][R[16]], ({ [5] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [7] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[17]", R[17])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [6] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 }, [7] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 } })[R[17]][R[16]], ({ [5] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [6] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [7] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[17] == 1 or R[17] == 2 or R[17] == 3 or R[17] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [3] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [4] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[17]][R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 1 or R[17] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 } })[R[17]][R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[16]], ({ [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 } })[R[17]][R[16]], ({ [1] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 } })[R[17]][R[16]], ({ [1] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [2] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [2] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 } })[R[17]][R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[17]][R[16]], ({ [1] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [2] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[16]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 19, [1] = 104, [2] = 108, [3] = 8 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[17]", R[17])
      end
      U[#U]:set_lights(true)
      if R[17] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 46, [1] = 32, [2] = 207, [3] = 166 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
      U[#U]:set_lights(true)
      if R[17] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 46, [1] = 32, [2] = 207, [3] = 166 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [2] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [3] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [4] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 } })[R[17]][R[16]], ({ [1] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [2] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [3] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [4] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[17]", R[17])
    end
    U[#U]:set_lights(true)
    if R[17] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 24, [1] = 109, [2] = 113, [3] = 13 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 24, [1] = 109, [2] = 113, [3] = 13 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[17]", R[17])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [3] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [4] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [5] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [6] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [7] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [5] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [6] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [7] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [1] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [3] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [4] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [5] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [6] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [7] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 } })[R[17]][R[16]], ({ [0] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [3] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 }, [4] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [5] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [6] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [7] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[17] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[37] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [1] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[37]][R[16]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 28, [1] = 113, [2] = 117, [3] = 17 } })[R[37]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[38]][R[16]], ({ [0] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [1] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [2] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 } })[R[38]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [1] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 } })[R[39]][R[16]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[39]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [1] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [2] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[40]][R[16]], ({ [0] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 } })[R[40]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] })
        for i = 1, game.initial_units() do
          R[41] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [1] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[41]][R[16]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[41]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 } })[R[42]][R[16]], ({ [0] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[42]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[43]][R[16]], ({ [0] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [1] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [2] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 } })[R[43]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[44]][R[16]], ({ [0] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[44]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[17]", R[17])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 55, [1] = 62, [2] = 165, [3] = 145 })[R[35]], ({ [0] = 40, [1] = 71, [2] = 122, [3] = 29 })[R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 49, [1] = 36, [2] = 180, [3] = 211 })[R[35]], ({ [0] = 41, [1] = 66, [2] = 98, [3] = 37 })[R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[26] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 52, [1] = 56, [2] = 56, [3] = 48, [4] = 52, [5] = 51, [6] = 48, [7] = 54 }, [1] = { [0] = 38, [1] = 42, [2] = 42, [3] = 34, [4] = 38, [5] = 37, [6] = 34, [7] = 40 }, [2] = { [0] = 213, [1] = 217, [2] = 217, [3] = 209, [4] = 213, [5] = 212, [6] = 209, [7] = 215 }, [3] = { [0] = 172, [1] = 176, [2] = 176, [3] = 168, [4] = 172, [5] = 171, [6] = 168, [7] = 174 } })[R[35]][R[26]], ({ [0] = { [0] = 26, [1] = 22, [2] = 26, [3] = 22, [4] = 25, [5] = 23, [6] = 20, [7] = 23 }, [1] = { [0] = 111, [1] = 107, [2] = 111, [3] = 107, [4] = 110, [5] = 108, [6] = 105, [7] = 108 }, [2] = { [0] = 115, [1] = 111, [2] = 115, [3] = 111, [4] = 114, [5] = 112, [6] = 109, [7] = 112 }, [3] = { [0] = 15, [1] = 11, [2] = 15, [3] = 11, [4] = 14, [5] = 12, [6] = 9, [7] = 12 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 52, [1] = 56, [2] = 56, [3] = 48, [4] = 52, [5] = 51, [6] = 48, [7] = 54 }, [1] = { [0] = 38, [1] = 42, [2] = 42, [3] = 34, [4] = 38, [5] = 37, [6] = 34, [7] = 40 }, [2] = { [0] = 213, [1] = 217, [2] = 217, [3] = 209, [4] = 213, [5] = 212, [6] = 209, [7] = 215 }, [3] = { [0] = 172, [1] = 176, [2] = 176, [3] = 168, [4] = 172, [5] = 171, [6] = 168, [7] = 174 } })[R[35]][R[26]], ({ [0] = { [0] = 26, [1] = 22, [2] = 26, [3] = 22, [4] = 25, [5] = 23, [6] = 20, [7] = 23 }, [1] = { [0] = 111, [1] = 107, [2] = 111, [3] = 107, [4] = 110, [5] = 108, [6] = 105, [7] = 108 }, [2] = { [0] = 115, [1] = 111, [2] = 115, [3] = 111, [4] = 114, [5] = 112, [6] = 109, [7] = 112 }, [3] = { [0] = 15, [1] = 11, [2] = 15, [3] = 11, [4] = 14, [5] = 12, [6] = 9, [7] = 12 } })[R[35]][R[26]] })
    if R[26] == 5 or R[26] == 6 or R[26] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [5] = 48, [6] = 57, [7] = 48 }, [1] = { [5] = 34, [6] = 43, [7] = 34 }, [2] = { [5] = 209, [6] = 218, [7] = 209 }, [3] = { [5] = 168, [6] = 177, [7] = 168 } })[R[35]][R[26]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [5] = 56, [6] = 48, [7] = 56 }, [1] = { [5] = 42, [6] = 34, [7] = 42 }, [2] = { [5] = 217, [6] = 209, [7] = 217 }, [3] = { [5] = 176, [6] = 168, [7] = 176 } })[R[35]][R[26]], ({ [0] = { [5] = 24, [6] = 29, [7] = 29 }, [1] = { [5] = 109, [6] = 114, [7] = 114 }, [2] = { [5] = 113, [6] = 118, [7] = 118 }, [3] = { [5] = 13, [6] = 18, [7] = 18 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 5 or R[26] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [5] = 56, [7] = 49 }, [1] = { [5] = 42, [7] = 35 }, [2] = { [5] = 217, [7] = 210 }, [3] = { [5] = 176, [7] = 169 } })[R[35]][R[26]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        if R[26] == 5 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[26] == 7 then
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
          unseen("R[26]", R[26])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [5] = 51, [7] = 53 }, [1] = { [5] = 37, [7] = 39 }, [2] = { [5] = 212, [7] = 214 }, [3] = { [5] = 171, [7] = 173 } })[R[35]][R[26]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        if R[26] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[35]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[26] == 5 then
        else
          unseen("R[26]", R[26])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = { [5] = 26, [7] = 23 }, [1] = { [5] = 111, [7] = 108 }, [2] = { [5] = 115, [7] = 112 }, [3] = { [5] = 15, [7] = 12 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = { [5] = 25, [7] = 24 }, [1] = { [5] = 110, [7] = 109 }, [2] = { [5] = 114, [7] = 113 }, [3] = { [5] = 14, [7] = 13 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [5] = 52, [7] = 57 }, [1] = { [5] = 38, [7] = 43 }, [2] = { [5] = 213, [7] = 218 }, [3] = { [5] = 172, [7] = 177 } })[R[35]][R[26]], ({ [0] = { [5] = 27, [7] = 24 }, [1] = { [5] = 112, [7] = 109 }, [2] = { [5] = 116, [7] = 113 }, [3] = { [5] = 16, [7] = 13 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[26] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[26]", R[26])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [5] = 58, [6] = 55, [7] = 51 }, [1] = { [5] = 44, [6] = 41, [7] = 37 }, [2] = { [5] = 219, [6] = 216, [7] = 212 }, [3] = { [5] = 178, [6] = 175, [7] = 171 } })[R[35]][R[26]], ({ [0] = { [5] = 22, [6] = 23, [7] = 21 }, [1] = { [5] = 107, [6] = 108, [7] = 106 }, [2] = { [5] = 111, [6] = 112, [7] = 110 }, [3] = { [5] = 11, [6] = 12, [7] = 10 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[35]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[26]", R[26])
      end
    elseif R[26] == 1 or R[26] == 2 or R[26] == 3 or R[26] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 56, [2] = 49, [3] = 53, [4] = 49 }, [1] = { [1] = 42, [2] = 35, [3] = 39, [4] = 35 }, [2] = { [1] = 217, [2] = 210, [3] = 214, [4] = 210 }, [3] = { [1] = 176, [2] = 169, [3] = 173, [4] = 169 } })[R[35]][R[26]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 1 or R[26] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [1] = 47, [2] = 48 }, [1] = { [1] = 33, [2] = 34 }, [2] = { [1] = 208, [2] = 209 }, [3] = { [1] = 167, [2] = 168 } })[R[35]][R[26]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[35]], ({ [0] = { [1] = 25, [2] = 29 }, [1] = { [1] = 110, [2] = 114 }, [2] = { [1] = 114, [2] = 118 }, [3] = { [1] = 14, [2] = 18 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [1] = 51, [2] = 52 }, [1] = { [1] = 37, [2] = 38 }, [2] = { [1] = 212, [2] = 213 }, [3] = { [1] = 171, [2] = 172 } })[R[35]][R[26]], ({ [0] = { [1] = 30, [2] = 26 }, [1] = { [1] = 115, [2] = 111 }, [2] = { [1] = 119, [2] = 115 }, [3] = { [1] = 19, [2] = 15 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [1] = 51, [2] = 56 }, [1] = { [1] = 37, [2] = 42 }, [2] = { [1] = 212, [2] = 217 }, [3] = { [1] = 171, [2] = 176 } })[R[35]][R[26]], ({ [0] = { [1] = 26, [2] = 23 }, [1] = { [1] = 111, [2] = 108 }, [2] = { [1] = 115, [2] = 112 }, [3] = { [1] = 15, [2] = 12 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 57, [2] = 55 }, [1] = { [1] = 43, [2] = 41 }, [2] = { [1] = 218, [2] = 216 }, [3] = { [1] = 177, [2] = 175 } })[R[35]][R[26]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 58, [2] = 57 }, [1] = { [1] = 44, [2] = 43 }, [2] = { [1] = 219, [2] = 218 }, [3] = { [1] = 178, [2] = 177 } })[R[35]][R[26]], ({ [0] = { [1] = 30, [2] = 31 }, [1] = { [1] = 115, [2] = 116 }, [2] = { [1] = 119, [2] = 120 }, [3] = { [1] = 19, [2] = 20 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[35]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[35]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 19, [1] = 104, [2] = 108, [3] = 8 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 2 then
        elseif LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[35]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[35]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[26]", R[26])
      end
      U[#U]:set_lights(true)
      if R[26] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 4 then
        if LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 46, [1] = 32, [2] = 207, [3] = 166 })[R[35]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[26]", R[26])
      end
      U[#U]:set_lights(true)
      if R[26] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[35]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[35]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[35]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 46, [1] = 32, [2] = 207, [3] = 166 })[R[35]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[26]", R[26])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [1] = 58, [2] = 50, [3] = 50, [4] = 50 }, [1] = { [1] = 44, [2] = 36, [3] = 36, [4] = 36 }, [2] = { [1] = 219, [2] = 211, [3] = 211, [4] = 211 }, [3] = { [1] = 178, [2] = 170, [3] = 170, [4] = 170 } })[R[35]][R[26]], ({ [0] = { [1] = 27, [2] = 31, [3] = 27, [4] = 23 }, [1] = { [1] = 112, [2] = 116, [3] = 112, [4] = 108 }, [2] = { [1] = 116, [2] = 120, [3] = 116, [4] = 112 }, [3] = { [1] = 16, [2] = 20, [3] = 16, [4] = 12 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[35]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[35]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[35]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[26]", R[26])
    end
    U[#U]:set_lights(true)
    if R[26] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[35]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[35]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[35]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[35]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[35]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[35]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 24, [1] = 109, [2] = 113, [3] = 13 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 24, [1] = 109, [2] = 113, [3] = 13 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[26]", R[26])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 48, [1] = 47, [2] = 53, [3] = 52, [4] = 50, [5] = 57, [6] = 52, [7] = 57 }, [1] = { [0] = 34, [1] = 33, [2] = 39, [3] = 38, [4] = 36, [5] = 43, [6] = 38, [7] = 43 }, [2] = { [0] = 209, [1] = 208, [2] = 214, [3] = 213, [4] = 211, [5] = 218, [6] = 213, [7] = 218 }, [3] = { [0] = 168, [1] = 167, [2] = 173, [3] = 172, [4] = 170, [5] = 177, [6] = 172, [7] = 177 } })[R[35]][R[26]], ({ [0] = { [0] = 23, [1] = 25, [2] = 21, [3] = 22, [4] = 31, [5] = 26, [6] = 25, [7] = 31 }, [1] = { [0] = 108, [1] = 110, [2] = 106, [3] = 107, [4] = 116, [5] = 111, [6] = 110, [7] = 116 }, [2] = { [0] = 112, [1] = 114, [2] = 110, [3] = 111, [4] = 120, [5] = 115, [6] = 114, [7] = 120 }, [3] = { [0] = 12, [1] = 14, [2] = 10, [3] = 11, [4] = 20, [5] = 15, [6] = 14, [7] = 20 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 49, [1] = 49, [2] = 52, [3] = 51, [4] = 51, [5] = 58, [6] = 53, [7] = 58 }, [1] = { [0] = 35, [1] = 35, [2] = 38, [3] = 37, [4] = 37, [5] = 44, [6] = 39, [7] = 44 }, [2] = { [0] = 210, [1] = 210, [2] = 213, [3] = 212, [4] = 212, [5] = 219, [6] = 214, [7] = 219 }, [3] = { [0] = 169, [1] = 169, [2] = 172, [3] = 171, [4] = 171, [5] = 178, [6] = 173, [7] = 178 } })[R[35]][R[26]], ({ [0] = { [0] = 23, [1] = 24, [2] = 20, [3] = 21, [4] = 30, [5] = 25, [6] = 24, [7] = 31 }, [1] = { [0] = 108, [1] = 109, [2] = 105, [3] = 106, [4] = 115, [5] = 110, [6] = 109, [7] = 116 }, [2] = { [0] = 112, [1] = 113, [2] = 109, [3] = 110, [4] = 119, [5] = 114, [6] = 113, [7] = 120 }, [3] = { [0] = 12, [1] = 13, [2] = 9, [3] = 10, [4] = 19, [5] = 14, [6] = 13, [7] = 20 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[26] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[45] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [1] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[45]][R[35]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 28, [1] = 113, [2] = 117, [3] = 17 } })[R[45]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] })
        for i = 1, game.initial_units() do
          R[46] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[46]][R[35]], ({ [0] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [1] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [2] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 } })[R[46]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] })
        for i = 1, game.initial_units() do
          R[47] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [1] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 } })[R[47]][R[35]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[47]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[35]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[35]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[35]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[35]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] })
        for i = 1, game.initial_units() do
          R[48] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [1] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [2] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[48]][R[35]], ({ [0] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 } })[R[48]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[35]] })
        for i = 1, game.initial_units() do
          R[49] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [1] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[49]][R[35]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[49]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 } })[R[50]][R[35]], ({ [0] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[50]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[51]][R[35]], ({ [0] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [1] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [2] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 } })[R[51]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[52]][R[35]], ({ [0] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[52]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[26]", R[26])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 55, [1] = 62, [2] = 165, [3] = 145 })[R[36]], ({ [0] = 40, [1] = 71, [2] = 122, [3] = 29 })[R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 49, [1] = 36, [2] = 180, [3] = 211 })[R[36]], ({ [0] = 41, [1] = 66, [2] = 98, [3] = 37 })[R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[53] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [3] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [4] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [5] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[53]][R[36]], ({ [0] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [5] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [6] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [3] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [4] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [5] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[53]][R[36]], ({ [0] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [5] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [6] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[53]][R[36]] })
    if R[53] == 5 or R[53] == 6 or R[53] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [6] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [7] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 } })[R[53]][R[36]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 } })[R[53]][R[36]], ({ [5] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [6] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [7] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[53] == 5 or R[53] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [5] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [7] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[53]][R[36]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        if R[53] == 5 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[53] == 7 then
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
          unseen("R[53]", R[53])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [5] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [7] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[53]][R[36]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        if R[53] == 5 then
        elseif R[53] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[36]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[53]", R[53])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [5] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [5] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [7] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [5] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [7] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[53]][R[36]], ({ [5] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [7] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[53]", R[53])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [6] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 }, [7] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 } })[R[53]][R[36]], ({ [5] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [6] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [7] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[36]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[53]", R[53])
      end
    elseif R[53] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[36]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[36]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[36]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[53] == 1 or R[53] == 2 or R[53] == 3 or R[53] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [3] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [4] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[53]][R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 1 or R[53] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 } })[R[53]][R[36]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[36]], ({ [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 } })[R[53]][R[36]], ({ [1] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 } })[R[53]][R[36]], ({ [1] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [2] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [2] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 } })[R[53]][R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[53]][R[36]], ({ [1] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [2] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[36]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[36]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[36]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[36]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 19, [1] = 104, [2] = 108, [3] = 8 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[53]", R[53])
      end
      U[#U]:set_lights(true)
      if R[53] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 46, [1] = 32, [2] = 207, [3] = 166 })[R[36]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[53]", R[53])
      end
      U[#U]:set_lights(true)
      if R[53] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[36]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[36]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[36]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 46, [1] = 32, [2] = 207, [3] = 166 })[R[36]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[53]", R[53])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [2] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [3] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [4] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 } })[R[53]][R[36]], ({ [1] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [2] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [3] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [4] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[53]", R[53])
    end
    U[#U]:set_lights(true)
    if R[53] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[36]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[36]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[36]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[36]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[36]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[53] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[36]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[53] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 24, [1] = 109, [2] = 113, [3] = 13 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 24, [1] = 109, [2] = 113, [3] = 13 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[53]", R[53])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [3] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [4] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [5] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [6] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [7] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[53]][R[36]], ({ [0] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [5] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [6] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [7] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [1] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [3] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [4] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [5] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [6] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [7] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 } })[R[53]][R[36]], ({ [0] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [3] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 }, [4] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [5] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [6] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [7] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[53] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[54] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [1] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[54]][R[36]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 28, [1] = 113, [2] = 117, [3] = 17 } })[R[54]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 1 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] })
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[55]][R[36]], ({ [0] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [1] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [2] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 } })[R[55]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] })
        for i = 1, game.initial_units() do
          R[56] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [1] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 } })[R[56]][R[36]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[56]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[36]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[36]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[36]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[36]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] })
        for i = 1, game.initial_units() do
          R[57] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [1] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [2] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[57]][R[36]], ({ [0] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 } })[R[57]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 4 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[36]] })
        for i = 1, game.initial_units() do
          R[58] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [1] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[58]][R[36]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[58]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[36]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[59] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 } })[R[59]][R[36]], ({ [0] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[59]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[60]][R[36]], ({ [0] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [1] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [2] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 } })[R[60]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[61]][R[36]], ({ [0] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[61]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    for _, area in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(area) end
    game.initial_set_tile({ 215, 80 }, 1161)
    game.initial_set_tile({ 215, 81 }, 1184)
    game.initial_set_tile({ 216, 80 }, 1172)
    game.initial_set_tile({ 216, 81 }, 1195)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 145, 4 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 230, 92 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 10, 98 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 62, 6 } }
    R[0] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 90, [1] = 125, [2] = 90, [3] = 101 })[R[0]], ({ [0] = 6, [1] = 33, [2] = 40, [3] = 22 })[R[0]] } }
    R[1] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 83, [1] = 112, [2] = 115, [3] = 87 })[R[1]], ({ [0] = 105, [1] = 63, [2] = 82, [3] = 79 })[R[1]] } }
    R[2] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 155, [1] = 185, [2] = 232, [3] = 155 })[R[2]], ({ [0] = 101, [1] = 71, [2] = 80, [3] = 73 })[R[2]] } }
    R[3] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 164, [1] = 236, [2] = 138, [3] = 129 })[R[3]], ({ [0] = 41, [1] = 44, [2] = 55, [3] = 27 })[R[3]] } }
    R[4] = draw_avoid(4, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 90, [1] = 125, [2] = 90, [3] = 101 })[R[4]], ({ [0] = 6, [1] = 33, [2] = 40, [3] = 22 })[R[4]] } }
    R[5] = draw_avoid(4, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 83, [1] = 112, [2] = 115, [3] = 87 })[R[5]], ({ [0] = 105, [1] = 63, [2] = 82, [3] = 79 })[R[5]] } }
    R[6] = draw_avoid(4, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 155, [1] = 185, [2] = 232, [3] = 155 })[R[6]], ({ [0] = 101, [1] = 71, [2] = 80, [3] = 73 })[R[6]] } }
    R[7] = draw_avoid(4, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 164, [1] = 236, [2] = 138, [3] = 129 })[R[7]], ({ [0] = 41, [1] = 44, [2] = 55, [3] = 27 })[R[7]] } }
    R[8] = draw_avoid(4, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 90, [1] = 125, [2] = 90, [3] = 101 })[R[8]], ({ [0] = 6, [1] = 33, [2] = 40, [3] = 22 })[R[8]] } }
    R[9] = draw_avoid(4, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 83, [1] = 112, [2] = 115, [3] = 87 })[R[9]], ({ [0] = 105, [1] = 63, [2] = 82, [3] = 79 })[R[9]] } }
    R[10] = draw_avoid(4, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 155, [1] = 185, [2] = 232, [3] = 155 })[R[10]], ({ [0] = 101, [1] = 71, [2] = 80, [3] = 73 })[R[10]] } }
    R[11] = draw_avoid(4, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 164, [1] = 236, [2] = 138, [3] = 129 })[R[11]], ({ [0] = 41, [1] = 44, [2] = 55, [3] = 27 })[R[11]] } }
    R[12] = draw_avoid(4, { R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 90, [1] = 125, [2] = 90, [3] = 101 })[R[12]], ({ [0] = 6, [1] = 33, [2] = 40, [3] = 22 })[R[12]] } }
    R[13] = draw_avoid(4, { R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 83, [1] = 112, [2] = 115, [3] = 87 })[R[13]], ({ [0] = 105, [1] = 63, [2] = 82, [3] = 79 })[R[13]] } }
    R[14] = draw_avoid(4, { R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 155, [1] = 185, [2] = 232, [3] = 155 })[R[14]], ({ [0] = 101, [1] = 71, [2] = 80, [3] = 73 })[R[14]] } }
    R[15] = draw_avoid(4, { R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 164, [1] = 236, [2] = 138, [3] = 129 })[R[15]], ({ [0] = 41, [1] = 44, [2] = 55, [3] = 27 })[R[15]] } }
    pick(4, 4, { 16, 35, 36, 62 })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 55, [1] = 62, [2] = 165, [3] = 145 })[R[16]], ({ [0] = 40, [1] = 71, [2] = 122, [3] = 29 })[R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 49, [1] = 36, [2] = 180, [3] = 211 })[R[16]], ({ [0] = 41, [1] = 66, [2] = 98, [3] = 37 })[R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[17] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [3] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [4] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [5] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [5] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [6] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [3] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [4] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [5] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [5] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [6] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[17]][R[16]] })
    if R[17] == 5 or R[17] == 6 or R[17] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [6] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [7] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 } })[R[17]][R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 } })[R[17]][R[16]], ({ [5] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [6] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [7] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[17] == 5 or R[17] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [7] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[17]][R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if R[17] == 5 then
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
        elseif R[17] == 7 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[17]", R[17])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [5] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 }, [7] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[17]][R[16]], ({ [5] = { [0] = 28, [1] = 113, [2] = 117, [3] = 17 }, [7] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        if R[17] == 7 then
        elseif R[17] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[17]", R[17])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [5] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [5] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [7] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [7] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[17]][R[16]], ({ [5] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [7] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[17]", R[17])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [6] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 }, [7] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 } })[R[17]][R[16]], ({ [5] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [6] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [7] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[17] == 1 or R[17] == 2 or R[17] == 3 or R[17] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [3] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [4] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[17]][R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 1 or R[17] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 } })[R[17]][R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[16]], ({ [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 } })[R[17]][R[16]], ({ [1] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 } })[R[17]][R[16]], ({ [1] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [2] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [2] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 } })[R[17]][R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[17]][R[16]], ({ [1] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [2] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[16]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 19, [1] = 104, [2] = 108, [3] = 8 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
      U[#U]:set_lights(true)
      if R[17] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 46, [1] = 32, [2] = 207, [3] = 166 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
      U[#U]:set_lights(true)
      if R[17] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 46, [1] = 32, [2] = 207, [3] = 166 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [2] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [3] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [4] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 } })[R[17]][R[16]], ({ [1] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [2] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [3] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [4] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[16]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[17]", R[17])
    end
    U[#U]:set_lights(true)
    if R[17] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 24, [1] = 109, [2] = 113, [3] = 13 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 24, [1] = 109, [2] = 113, [3] = 13 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[17]", R[17])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [3] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [4] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [5] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [6] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [7] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [5] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [6] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [7] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [1] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [3] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [4] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [5] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [6] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [7] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 } })[R[17]][R[16]], ({ [0] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [3] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 }, [4] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [5] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [6] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [7] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[17] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[63] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [1] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[63]][R[16]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 28, [1] = 113, [2] = 117, [3] = 17 } })[R[63]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        for i = 1, game.initial_units() do
          R[64] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[64]][R[16]], ({ [0] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [1] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [2] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 } })[R[64]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
        for i = 1, game.initial_units() do
          R[65] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [1] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 } })[R[65]][R[16]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[65]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
        for i = 1, game.initial_units() do
          R[66] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [1] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [2] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[66]][R[16]], ({ [0] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 } })[R[66]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[16]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[16]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[16]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[16]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[16]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[16]] })
        for i = 1, game.initial_units() do
          R[67] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [1] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[67]][R[16]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[67]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 } })[R[68]][R[16]], ({ [0] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[68]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[69]][R[16]], ({ [0] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [1] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [2] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 } })[R[69]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[70]][R[16]], ({ [0] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[70]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[17]", R[17])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 55, [1] = 62, [2] = 165, [3] = 145 })[R[35]], ({ [0] = 40, [1] = 71, [2] = 122, [3] = 29 })[R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 49, [1] = 36, [2] = 180, [3] = 211 })[R[35]], ({ [0] = 41, [1] = 66, [2] = 98, [3] = 37 })[R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[26] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 52, [1] = 56, [2] = 56, [3] = 48, [4] = 52, [5] = 51, [6] = 48, [7] = 54 }, [1] = { [0] = 38, [1] = 42, [2] = 42, [3] = 34, [4] = 38, [5] = 37, [6] = 34, [7] = 40 }, [2] = { [0] = 213, [1] = 217, [2] = 217, [3] = 209, [4] = 213, [5] = 212, [6] = 209, [7] = 215 }, [3] = { [0] = 172, [1] = 176, [2] = 176, [3] = 168, [4] = 172, [5] = 171, [6] = 168, [7] = 174 } })[R[35]][R[26]], ({ [0] = { [0] = 26, [1] = 22, [2] = 26, [3] = 22, [4] = 25, [5] = 23, [6] = 20, [7] = 23 }, [1] = { [0] = 111, [1] = 107, [2] = 111, [3] = 107, [4] = 110, [5] = 108, [6] = 105, [7] = 108 }, [2] = { [0] = 115, [1] = 111, [2] = 115, [3] = 111, [4] = 114, [5] = 112, [6] = 109, [7] = 112 }, [3] = { [0] = 15, [1] = 11, [2] = 15, [3] = 11, [4] = 14, [5] = 12, [6] = 9, [7] = 12 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 52, [1] = 56, [2] = 56, [3] = 48, [4] = 52, [5] = 51, [6] = 48, [7] = 54 }, [1] = { [0] = 38, [1] = 42, [2] = 42, [3] = 34, [4] = 38, [5] = 37, [6] = 34, [7] = 40 }, [2] = { [0] = 213, [1] = 217, [2] = 217, [3] = 209, [4] = 213, [5] = 212, [6] = 209, [7] = 215 }, [3] = { [0] = 172, [1] = 176, [2] = 176, [3] = 168, [4] = 172, [5] = 171, [6] = 168, [7] = 174 } })[R[35]][R[26]], ({ [0] = { [0] = 26, [1] = 22, [2] = 26, [3] = 22, [4] = 25, [5] = 23, [6] = 20, [7] = 23 }, [1] = { [0] = 111, [1] = 107, [2] = 111, [3] = 107, [4] = 110, [5] = 108, [6] = 105, [7] = 108 }, [2] = { [0] = 115, [1] = 111, [2] = 115, [3] = 111, [4] = 114, [5] = 112, [6] = 109, [7] = 112 }, [3] = { [0] = 15, [1] = 11, [2] = 15, [3] = 11, [4] = 14, [5] = 12, [6] = 9, [7] = 12 } })[R[35]][R[26]] })
    if R[26] == 5 or R[26] == 6 or R[26] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [5] = 48, [6] = 57, [7] = 48 }, [1] = { [5] = 34, [6] = 43, [7] = 34 }, [2] = { [5] = 209, [6] = 218, [7] = 209 }, [3] = { [5] = 168, [6] = 177, [7] = 168 } })[R[35]][R[26]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [5] = 56, [6] = 48, [7] = 56 }, [1] = { [5] = 42, [6] = 34, [7] = 42 }, [2] = { [5] = 217, [6] = 209, [7] = 217 }, [3] = { [5] = 176, [6] = 168, [7] = 176 } })[R[35]][R[26]], ({ [0] = { [5] = 24, [6] = 29, [7] = 29 }, [1] = { [5] = 109, [6] = 114, [7] = 114 }, [2] = { [5] = 113, [6] = 118, [7] = 118 }, [3] = { [5] = 13, [6] = 18, [7] = 18 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 5 or R[26] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [5] = 56, [7] = 49 }, [1] = { [5] = 42, [7] = 35 }, [2] = { [5] = 217, [7] = 210 }, [3] = { [5] = 176, [7] = 169 } })[R[35]][R[26]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        if R[26] == 5 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[26] == 7 then
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
          unseen("R[26]", R[26])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [5] = 51, [7] = 53 }, [1] = { [5] = 37, [7] = 39 }, [2] = { [5] = 212, [7] = 214 }, [3] = { [5] = 171, [7] = 173 } })[R[35]][R[26]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        if R[26] == 5 then
        elseif R[26] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[35]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[26]", R[26])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = { [5] = 26, [7] = 23 }, [1] = { [5] = 111, [7] = 108 }, [2] = { [5] = 115, [7] = 112 }, [3] = { [5] = 15, [7] = 12 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = { [5] = 25, [7] = 24 }, [1] = { [5] = 110, [7] = 109 }, [2] = { [5] = 114, [7] = 113 }, [3] = { [5] = 14, [7] = 13 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [5] = 52, [7] = 57 }, [1] = { [5] = 38, [7] = 43 }, [2] = { [5] = 213, [7] = 218 }, [3] = { [5] = 172, [7] = 177 } })[R[35]][R[26]], ({ [0] = { [5] = 27, [7] = 24 }, [1] = { [5] = 112, [7] = 109 }, [2] = { [5] = 116, [7] = 113 }, [3] = { [5] = 16, [7] = 13 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[26] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[26]", R[26])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [5] = 58, [6] = 55, [7] = 51 }, [1] = { [5] = 44, [6] = 41, [7] = 37 }, [2] = { [5] = 219, [6] = 216, [7] = 212 }, [3] = { [5] = 178, [6] = 175, [7] = 171 } })[R[35]][R[26]], ({ [0] = { [5] = 22, [6] = 23, [7] = 21 }, [1] = { [5] = 107, [6] = 108, [7] = 106 }, [2] = { [5] = 111, [6] = 112, [7] = 110 }, [3] = { [5] = 11, [6] = 12, [7] = 10 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[35]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[26]", R[26])
      end
    elseif R[26] == 1 or R[26] == 2 or R[26] == 3 or R[26] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 56, [2] = 49, [3] = 53, [4] = 49 }, [1] = { [1] = 42, [2] = 35, [3] = 39, [4] = 35 }, [2] = { [1] = 217, [2] = 210, [3] = 214, [4] = 210 }, [3] = { [1] = 176, [2] = 169, [3] = 173, [4] = 169 } })[R[35]][R[26]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[35]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[35]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 1 or R[26] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [1] = 47, [2] = 48 }, [1] = { [1] = 33, [2] = 34 }, [2] = { [1] = 208, [2] = 209 }, [3] = { [1] = 167, [2] = 168 } })[R[35]][R[26]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[35]], ({ [0] = { [1] = 25, [2] = 29 }, [1] = { [1] = 110, [2] = 114 }, [2] = { [1] = 114, [2] = 118 }, [3] = { [1] = 14, [2] = 18 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [1] = 51, [2] = 52 }, [1] = { [1] = 37, [2] = 38 }, [2] = { [1] = 212, [2] = 213 }, [3] = { [1] = 171, [2] = 172 } })[R[35]][R[26]], ({ [0] = { [1] = 30, [2] = 26 }, [1] = { [1] = 115, [2] = 111 }, [2] = { [1] = 119, [2] = 115 }, [3] = { [1] = 19, [2] = 15 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [1] = 51, [2] = 56 }, [1] = { [1] = 37, [2] = 42 }, [2] = { [1] = 212, [2] = 217 }, [3] = { [1] = 171, [2] = 176 } })[R[35]][R[26]], ({ [0] = { [1] = 26, [2] = 23 }, [1] = { [1] = 111, [2] = 108 }, [2] = { [1] = 115, [2] = 112 }, [3] = { [1] = 15, [2] = 12 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 57, [2] = 55 }, [1] = { [1] = 43, [2] = 41 }, [2] = { [1] = 218, [2] = 216 }, [3] = { [1] = 177, [2] = 175 } })[R[35]][R[26]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 58, [2] = 57 }, [1] = { [1] = 44, [2] = 43 }, [2] = { [1] = 219, [2] = 218 }, [3] = { [1] = 178, [2] = 177 } })[R[35]][R[26]], ({ [0] = { [1] = 30, [2] = 31 }, [1] = { [1] = 115, [2] = 116 }, [2] = { [1] = 119, [2] = 120 }, [3] = { [1] = 19, [2] = 20 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[35]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[35]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 19, [1] = 104, [2] = 108, [3] = 8 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[26]", R[26])
      end
      U[#U]:set_lights(true)
      if R[26] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 46, [1] = 32, [2] = 207, [3] = 166 })[R[35]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[26]", R[26])
      end
      U[#U]:set_lights(true)
      if R[26] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[35]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[35]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[35]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 46, [1] = 32, [2] = 207, [3] = 166 })[R[35]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[26]", R[26])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [1] = 58, [2] = 50, [3] = 50, [4] = 50 }, [1] = { [1] = 44, [2] = 36, [3] = 36, [4] = 36 }, [2] = { [1] = 219, [2] = 211, [3] = 211, [4] = 211 }, [3] = { [1] = 178, [2] = 170, [3] = 170, [4] = 170 } })[R[35]][R[26]], ({ [0] = { [1] = 27, [2] = 31, [3] = 27, [4] = 23 }, [1] = { [1] = 112, [2] = 116, [3] = 112, [4] = 108 }, [2] = { [1] = 116, [2] = 120, [3] = 116, [4] = 112 }, [3] = { [1] = 16, [2] = 20, [3] = 16, [4] = 12 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[35]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[35]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[35]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[26]", R[26])
    end
    U[#U]:set_lights(true)
    if R[26] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[35]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[35]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[35]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[35]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[35]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[35]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 24, [1] = 109, [2] = 113, [3] = 13 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 24, [1] = 109, [2] = 113, [3] = 13 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[26]", R[26])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 48, [1] = 47, [2] = 53, [3] = 52, [4] = 50, [5] = 57, [6] = 52, [7] = 57 }, [1] = { [0] = 34, [1] = 33, [2] = 39, [3] = 38, [4] = 36, [5] = 43, [6] = 38, [7] = 43 }, [2] = { [0] = 209, [1] = 208, [2] = 214, [3] = 213, [4] = 211, [5] = 218, [6] = 213, [7] = 218 }, [3] = { [0] = 168, [1] = 167, [2] = 173, [3] = 172, [4] = 170, [5] = 177, [6] = 172, [7] = 177 } })[R[35]][R[26]], ({ [0] = { [0] = 23, [1] = 25, [2] = 21, [3] = 22, [4] = 31, [5] = 26, [6] = 25, [7] = 31 }, [1] = { [0] = 108, [1] = 110, [2] = 106, [3] = 107, [4] = 116, [5] = 111, [6] = 110, [7] = 116 }, [2] = { [0] = 112, [1] = 114, [2] = 110, [3] = 111, [4] = 120, [5] = 115, [6] = 114, [7] = 120 }, [3] = { [0] = 12, [1] = 14, [2] = 10, [3] = 11, [4] = 20, [5] = 15, [6] = 14, [7] = 20 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 49, [1] = 49, [2] = 52, [3] = 51, [4] = 51, [5] = 58, [6] = 53, [7] = 58 }, [1] = { [0] = 35, [1] = 35, [2] = 38, [3] = 37, [4] = 37, [5] = 44, [6] = 39, [7] = 44 }, [2] = { [0] = 210, [1] = 210, [2] = 213, [3] = 212, [4] = 212, [5] = 219, [6] = 214, [7] = 219 }, [3] = { [0] = 169, [1] = 169, [2] = 172, [3] = 171, [4] = 171, [5] = 178, [6] = 173, [7] = 178 } })[R[35]][R[26]], ({ [0] = { [0] = 23, [1] = 24, [2] = 20, [3] = 21, [4] = 30, [5] = 25, [6] = 24, [7] = 31 }, [1] = { [0] = 108, [1] = 109, [2] = 105, [3] = 106, [4] = 115, [5] = 110, [6] = 109, [7] = 116 }, [2] = { [0] = 112, [1] = 113, [2] = 109, [3] = 110, [4] = 119, [5] = 114, [6] = 113, [7] = 120 }, [3] = { [0] = 12, [1] = 13, [2] = 9, [3] = 10, [4] = 19, [5] = 14, [6] = 13, [7] = 20 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[26] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[71] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [1] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[71]][R[35]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 28, [1] = 113, [2] = 117, [3] = 17 } })[R[71]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] })
        for i = 1, game.initial_units() do
          R[72] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[72]][R[35]], ({ [0] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [1] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [2] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 } })[R[72]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] })
        for i = 1, game.initial_units() do
          R[73] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [1] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 } })[R[73]][R[35]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[73]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[35]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[35]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[35]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[35]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[35]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[35]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[35]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[35]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[35]] })
        for i = 1, game.initial_units() do
          R[74] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [1] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [2] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[74]][R[35]], ({ [0] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 } })[R[74]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[35]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[35]] })
        for i = 1, game.initial_units() do
          R[75] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [1] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[75]][R[35]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[75]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 } })[R[76]][R[35]], ({ [0] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[76]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[77]][R[35]], ({ [0] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [1] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [2] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 } })[R[77]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[78]][R[35]], ({ [0] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[78]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[26]", R[26])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 55, [1] = 62, [2] = 165, [3] = 145 })[R[36]], ({ [0] = 40, [1] = 71, [2] = 122, [3] = 29 })[R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 49, [1] = 36, [2] = 180, [3] = 211 })[R[36]], ({ [0] = 41, [1] = 66, [2] = 98, [3] = 37 })[R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[53] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [3] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [4] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [5] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[53]][R[36]], ({ [0] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [5] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [6] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [3] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [4] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [5] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[53]][R[36]], ({ [0] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [5] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [6] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[53]][R[36]] })
    if R[53] == 1 or R[53] == 2 or R[53] == 3 or R[53] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [3] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [4] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[53]][R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[36]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[36]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[36]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[36]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 19, [1] = 104, [2] = 108, [3] = 8 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 1 or R[53] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 } })[R[53]][R[36]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[36]], ({ [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 } })[R[53]][R[36]], ({ [1] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 } })[R[53]][R[36]], ({ [1] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [2] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [2] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 } })[R[53]][R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[53]", R[53])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[53]], player = players[3], at = { ({ [1] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [3] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 }, [4] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 } })[R[53]][R[36]], ({ [1] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [2] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [3] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [4] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[53]], player = players[3], at = { ({ [1] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [3] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [4] = { [0] = 46, [1] = 32, [2] = 207, [3] = 166 } })[R[53]][R[36]], ({ [1] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [2] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [3] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [4] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [2] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [3] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [4] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 } })[R[53]][R[36]], ({ [1] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [2] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [3] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [4] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[36]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[36]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[36]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[53]", R[53])
      end
    elseif R[53] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[36]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[36]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[36]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[53] == 5 or R[53] == 6 or R[53] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [6] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [7] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 } })[R[53]][R[36]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 } })[R[53]][R[36]], ({ [5] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [6] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [7] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[53] == 5 or R[53] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [5] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [7] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[53]][R[36]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        if R[53] == 5 then
          if LEVEL_OF[players[1].difficulty] == 2 then
          elseif LEVEL_OF[players[1].difficulty] == 0 then
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
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[53] == 7 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[53]", R[53])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [5] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 }, [7] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[53]][R[36]], ({ [5] = { [0] = 28, [1] = 113, [2] = 117, [3] = 17 }, [7] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
        if R[53] == 7 then
        elseif R[53] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[53]", R[53])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [5] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [5] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [7] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [5] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [7] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[53]][R[36]], ({ [5] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [7] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[53]", R[53])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [6] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 }, [7] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 } })[R[53]][R[36]], ({ [5] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [6] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [7] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[36]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[53]", R[53])
      end
    else
      unseen("R[53]", R[53])
    end
    U[#U]:set_lights(true)
    if R[53] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[36]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[36]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[36]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[36]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[36]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[53] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[36]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[53] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 24, [1] = 109, [2] = 113, [3] = 13 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 24, [1] = 109, [2] = 113, [3] = 13 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[53]", R[53])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [3] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [4] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [5] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [6] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [7] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[53]][R[36]], ({ [0] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [5] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [6] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [7] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [1] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [3] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [4] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [5] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [6] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [7] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 } })[R[53]][R[36]], ({ [0] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [3] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 }, [4] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [5] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [6] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [7] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[53] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[79] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [1] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[79]][R[36]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 28, [1] = 113, [2] = 117, [3] = 17 } })[R[79]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] })
        for i = 1, game.initial_units() do
          R[80] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[80]][R[36]], ({ [0] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [1] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [2] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 } })[R[80]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] })
        for i = 1, game.initial_units() do
          R[81] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [1] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 } })[R[81]][R[36]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[81]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[36]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[36]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[36]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[36]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[36]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[36]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[36]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[36]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[36]] })
        for i = 1, game.initial_units() do
          R[82] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [1] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [2] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[82]][R[36]], ({ [0] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 } })[R[82]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[36]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[36]] })
        for i = 1, game.initial_units() do
          R[83] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [1] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[83]][R[36]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[83]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 } })[R[84]][R[36]], ({ [0] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[84]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[85]][R[36]], ({ [0] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [1] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [2] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 } })[R[85]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[86]][R[36]], ({ [0] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[86]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[53]", R[53])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [0] = 55, [1] = 62, [2] = 165, [3] = 145 })[R[62]], ({ [0] = 40, [1] = 71, [2] = 122, [3] = 29 })[R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [0] = 49, [1] = 36, [2] = 180, [3] = 211 })[R[62]], ({ [0] = 41, [1] = 66, [2] = 98, [3] = 37 })[R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[87] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [3] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [4] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [5] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[87]][R[62]], ({ [0] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [5] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [6] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    players[4]:center_view({ ({ [0] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [3] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [4] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [5] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[87]][R[62]], ({ [0] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [5] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [6] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[87]][R[62]] })
    if R[87] == 1 or R[87] == 2 or R[87] == 3 or R[87] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [3] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [4] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[87]][R[62]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      if R[87] == 1 or R[87] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 } })[R[87]][R[62]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[62]], ({ [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 } })[R[87]][R[62]], ({ [1] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [2] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 } })[R[87]][R[62]], ({ [1] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [2] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [1] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [2] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 } })[R[87]][R[62]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [1] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[87]][R[62]], ({ [1] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [2] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[87] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[62]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[62]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[62]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[62]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[62]], ({ [0] = 19, [1] = 104, [2] = 108, [3] = 8 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[62]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[87] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[62]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[62]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[62]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[62]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[62]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[62]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[87]", R[87])
      end
      U[#U]:set_lights(true)
      if R[87] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[62]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[87] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[62]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[87] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[62]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[87] == 4 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 46, [1] = 32, [2] = 207, [3] = 166 })[R[62]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[62]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[87]", R[87])
      end
      U[#U]:set_lights(true)
      if R[87] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[62]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[87] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[62]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[87] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[62]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[87] == 4 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[62]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 46, [1] = 32, [2] = 207, [3] = 166 })[R[62]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[87]", R[87])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [1] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [2] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [3] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [4] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 } })[R[87]][R[62]], ({ [1] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [2] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [3] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [4] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[87] == 5 or R[87] == 6 or R[87] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [5] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [6] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [7] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 } })[R[87]][R[62]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [5] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [6] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [7] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 } })[R[87]][R[62]], ({ [5] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [6] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [7] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      if R[87] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[62]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[62]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[62]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[87] == 5 or R[87] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [5] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [7] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[87]][R[62]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        if R[87] == 5 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[62]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[62]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[62]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif R[87] == 7 then
          if LEVEL_OF[players[1].difficulty] == 1 then
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
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[87]", R[87])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [5] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [7] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[87]][R[62]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        if R[87] == 5 then
        elseif R[87] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[62]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[87]", R[87])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[62]], ({ [5] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [7] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[62]], ({ [5] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [7] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [5] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [7] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[87]][R[62]], ({ [5] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 }, [7] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[87]", R[87])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [5] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [6] = { [0] = 55, [1] = 41, [2] = 216, [3] = 175 }, [7] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 } })[R[87]][R[62]], ({ [5] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [6] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [7] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      if R[87] == 5 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[62]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[87] == 6 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[62]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[62]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[62]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[62]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[87] == 7 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[62]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[87]", R[87])
      end
    elseif R[87] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[62]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 54, [1] = 40, [2] = 215, [3] = 174 })[R[62]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[62]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[62]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 57, [1] = 43, [2] = 218, [3] = 177 })[R[62]], ({ [0] = 20, [1] = 105, [2] = 109, [3] = 9 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[62]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 56, [1] = 42, [2] = 217, [3] = 176 })[R[62]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[62]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[62]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[62]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[87]", R[87])
    end
    U[#U]:set_lights(true)
    if R[87] == 0 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[62]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[62]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[62]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[87] == 1 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[62]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[62]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[62]], ({ [0] = 26, [1] = 111, [2] = 115, [3] = 15 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[87] == 2 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[62]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[62]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[62]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[87] == 3 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[62]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[62]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[62]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[87] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[62]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 47, [1] = 33, [2] = 208, [3] = 167 })[R[62]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[87] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[62]], ({ [0] = 22, [1] = 107, [2] = 111, [3] = 11 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[62]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[87] == 6 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[62]], ({ [0] = 23, [1] = 108, [2] = 112, [3] = 12 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 50, [1] = 36, [2] = 211, [3] = 170 })[R[62]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[62]], ({ [0] = 30, [1] = 115, [2] = 119, [3] = 19 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[62]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[62]], ({ [0] = 24, [1] = 109, [2] = 113, [3] = 13 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[62]], ({ [0] = 31, [1] = 116, [2] = 120, [3] = 20 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[62]], ({ [0] = 24, [1] = 109, [2] = 113, [3] = 13 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[87] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[62]], ({ [0] = 21, [1] = 106, [2] = 110, [3] = 10 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 58, [1] = 44, [2] = 219, [3] = 178 })[R[62]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[87]", R[87])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [3] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [4] = { [0] = 50, [1] = 36, [2] = 211, [3] = 170 }, [5] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [6] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [7] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[87]][R[62]], ({ [0] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 }, [3] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [4] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 }, [5] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [6] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [7] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [1] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [3] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [4] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [5] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 }, [6] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [7] = { [0] = 58, [1] = 44, [2] = 219, [3] = 178 } })[R[87]][R[62]], ({ [0] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [3] = { [0] = 21, [1] = 106, [2] = 110, [3] = 10 }, [4] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [5] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [6] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [7] = { [0] = 31, [1] = 116, [2] = 120, [3] = 20 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[87] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[88] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [1] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[88]][R[62]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 22, [1] = 107, [2] = 111, [3] = 11 }, [2] = { [0] = 28, [1] = 113, [2] = 117, [3] = 17 } })[R[88]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[62]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[62]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 51, [1] = 37, [2] = 212, [3] = 171 })[R[62]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[62]] })
        for i = 1, game.initial_units() do
          R[89] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [1] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [2] = { [0] = 54, [1] = 40, [2] = 215, [3] = 174 } })[R[89]][R[62]], ({ [0] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [1] = { [0] = 23, [1] = 108, [2] = 112, [3] = 12 }, [2] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 } })[R[89]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[62]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[62]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[62]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[62]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[62]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[62]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[62]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[62]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[62]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[62]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[62]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[62]] })
        for i = 1, game.initial_units() do
          R[90] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [1] = { [0] = 48, [1] = 34, [2] = 209, [3] = 168 }, [2] = { [0] = 52, [1] = 38, [2] = 213, [3] = 172 } })[R[90]][R[62]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[90]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[62]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[62]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[62]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[62]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[62]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[62]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[62]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[62]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[62]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[62]] })
        for i = 1, game.initial_units() do
          R[91] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [1] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [2] = { [0] = 49, [1] = 35, [2] = 210, [3] = 169 } })[R[91]][R[62]], ({ [0] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [1] = { [0] = 24, [1] = 109, [2] = 113, [3] = 13 }, [2] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 } })[R[91]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 49, [1] = 35, [2] = 210, [3] = 169 })[R[62]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[62]] })
        game.create_tube({ ({ [0] = 52, [1] = 38, [2] = 213, [3] = 172 })[R[62]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[62]] })
        game.create_tube({ ({ [0] = 53, [1] = 39, [2] = 214, [3] = 173 })[R[62]], ({ [0] = 25, [1] = 110, [2] = 114, [3] = 14 })[R[62]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[62]], ({ [0] = 28, [1] = 113, [2] = 117, [3] = 17 })[R[62]] })
        game.create_tube({ ({ [0] = 55, [1] = 41, [2] = 216, [3] = 175 })[R[62]], ({ [0] = 29, [1] = 114, [2] = 118, [3] = 18 })[R[62]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[62]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[62]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 48, [1] = 34, [2] = 209, [3] = 168 })[R[62]], ({ [0] = 27, [1] = 112, [2] = 116, [3] = 16 })[R[62]] })
        for i = 1, game.initial_units() do
          R[92] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [1] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[92]][R[62]], ({ [0] = { [0] = 19, [1] = 104, [2] = 108, [3] = 8 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 } })[R[92]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 } })[R[93]][R[62]], ({ [0] = { [0] = 30, [1] = 115, [2] = 119, [3] = 19 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[93]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 }, [1] = { [0] = 56, [1] = 42, [2] = 217, [3] = 176 }, [2] = { [0] = 53, [1] = 39, [2] = 214, [3] = 173 } })[R[94]][R[62]], ({ [0] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 }, [1] = { [0] = 26, [1] = 111, [2] = 115, [3] = 15 }, [2] = { [0] = 27, [1] = 112, [2] = 116, [3] = 16 } })[R[94]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 51, [1] = 37, [2] = 212, [3] = 171 }, [1] = { [0] = 47, [1] = 33, [2] = 208, [3] = 167 }, [2] = { [0] = 57, [1] = 43, [2] = 218, [3] = 177 } })[R[95]][R[62]], ({ [0] = { [0] = 29, [1] = 114, [2] = 118, [3] = 18 }, [1] = { [0] = 25, [1] = 110, [2] = 114, [3] = 14 }, [2] = { [0] = 20, [1] = 105, [2] = 109, [3] = 9 } })[R[95]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Tornados}  -- after 60 to 120 marks
    trigger.research{tech = 5110, one_shot = true, on = Lava}
  end
  return true
end
