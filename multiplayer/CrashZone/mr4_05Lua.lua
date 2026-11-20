-- mr4_05Lua.lua  -  4 Player, ResourceRace, 'Crash Zone' map. (Lua)
--
-- Converted by op2dll from mr4_05.dll ("4 Player, ResourceRace, 'Crash Zone' map."): its setup replayed. `on_init` makes the original's
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
    R[17] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 24, [1] = 86, [2] = 101, [3] = 11 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 24, [1] = 86, [2] = 101, [3] = 11 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[17]][R[16]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 29, [1] = 32, [2] = 188, [3] = 165 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 21, [1] = 83, [2] = 98, [3] = 7 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 36, [1] = 103, [2] = 118, [3] = 28 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    if R[17] == 0 or R[17] == 1 or R[17] == 2 or R[17] == 5 or R[17] == 6 or R[17] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 54, [1] = 54, [2] = 207, [3] = 192 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 32, [1] = 35, [2] = 191, [3] = 168 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 43, [1] = 48, [2] = 205, [3] = 189 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 28, [1] = 90, [2] = 105, [3] = 14 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [5] = { [0] = 33, [1] = 101, [2] = 117, [3] = 22 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 0 then
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
      elseif R[17] == 1 then
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
      elseif R[17] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 31, [1] = 31, [2] = 184, [3] = 169 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 34, [1] = 39, [2] = 196, [3] = 180 }, [7] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 38, [1] = 100, [2] = 115, [3] = 24 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 35, [1] = 103, [2] = 119, [3] = 28 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 2 or R[17] == 5 or R[17] == 6 or R[17] == 7 then
      elseif R[17] == 0 or R[17] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 } })[R[17]][R[16]], ({ [0] = { [0] = 38, [1] = 103, [2] = 125, [3] = 28 }, [1] = { [0] = 46, [1] = 108, [2] = 123, [3] = 32 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[17]", R[17])
      end
    elseif R[17] == 3 or R[17] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 } })[R[17]][R[16]], ({ [3] = { [0] = 36, [1] = 103, [2] = 118, [3] = 28 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 3 then
      else
        unseen("R[17]", R[17])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [3] = { [0] = 30, [1] = 38, [2] = 194, [3] = 175 }, [4] = { [0] = 45, [1] = 50, [2] = 209, [3] = 191 } })[R[17]][R[16]], ({ [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 3 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 4 then
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
        unseen("R[17]", R[17])
      end
    else
      unseen("R[17]", R[17])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 31, [1] = 31, [2] = 184, [3] = 169 }, [1] = { [0] = 28, [1] = 31, [2] = 187, [3] = 169 }, [2] = { [0] = 49, [1] = 52, [2] = 208, [3] = 185 }, [3] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [4] = { [0] = 26, [1] = 31, [2] = 190, [3] = 172 }, [5] = { [0] = 20, [1] = 25, [2] = 182, [3] = 165 }, [6] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 }, [7] = { [0] = 32, [1] = 37, [2] = 194, [3] = 178 } })[R[17]][R[16]], ({ [0] = { [0] = 40, [1] = 105, [2] = 127, [3] = 30 }, [1] = { [0] = 43, [1] = 105, [2] = 120, [3] = 29 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 19, [1] = 86, [2] = 101, [3] = 11 }, [4] = { [0] = 24, [1] = 92, [2] = 107, [3] = 17 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 39, [1] = 107, [2] = 123, [3] = 32 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 38, [1] = 38, [2] = 191, [3] = 176 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 44, [1] = 49, [2] = 208, [3] = 190 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 33, [1] = 95, [2] = 110, [3] = 20 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 19, [1] = 87, [2] = 103, [3] = 8 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 28, [1] = 36, [2] = 192, [3] = 173 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 27, [1] = 89, [2] = 104, [3] = 13 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 45, [1] = 53, [2] = 209, [3] = 190 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[17]][R[16]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[17]][R[16]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[17]][R[16]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 25, [1] = 30, [2] = 187, [3] = 170 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 37, [1] = 99, [2] = 114, [3] = 24 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 18, [1] = 86, [2] = 102, [3] = 7 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 41, [1] = 46, [2] = 205, [3] = 187 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 21, [1] = 26, [2] = 183, [3] = 167 } })[R[17]][R[16]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 82, [2] = 97, [3] = 6 }, [2] = { [0] = 38, [1] = 100, [2] = 115, [3] = 25 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 22, [1] = 90, [2] = 111, [3] = 14 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 45, [1] = 53, [2] = 209, [3] = 190 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[17]][R[16]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[17]][R[16]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 25, [1] = 30, [2] = 187, [3] = 170 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 37, [1] = 99, [2] = 114, [3] = 24 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 18, [1] = 86, [2] = 102, [3] = 7 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 41, [1] = 46, [2] = 205, [3] = 187 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 21, [1] = 26, [2] = 183, [3] = 167 } })[R[17]][R[16]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 82, [2] = 97, [3] = 6 }, [2] = { [0] = 38, [1] = 100, [2] = 115, [3] = 25 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 22, [1] = 90, [2] = 111, [3] = 14 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 45, [1] = 53, [2] = 209, [3] = 190 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[17]][R[16]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[17]][R[16]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[17]][R[16]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 25, [1] = 30, [2] = 187, [3] = 170 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 37, [1] = 99, [2] = 114, [3] = 24 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 18, [1] = 86, [2] = 102, [3] = 7 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[17]], player = players[1], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 41, [1] = 46, [2] = 205, [3] = 187 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 21, [1] = 26, [2] = 183, [3] = 167 } })[R[17]][R[16]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 82, [2] = 97, [3] = 6 }, [2] = { [0] = 38, [1] = 100, [2] = 115, [3] = 25 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 22, [1] = 90, [2] = 111, [3] = 14 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 54, [1] = 54, [2] = 207, [3] = 192 }, [1] = { [0] = 36, [1] = 39, [2] = 195, [3] = 177 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 47, [1] = 52, [2] = 211, [3] = 193 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 35, [1] = 40, [2] = 197, [3] = 181 } })[R[17]][R[16]], ({ [0] = { [0] = 35, [1] = 100, [2] = 122, [3] = 25 }, [1] = { [0] = 33, [1] = 95, [2] = 110, [3] = 19 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 23, [1] = 90, [2] = 105, [3] = 15 }, [4] = { [0] = 19, [1] = 87, [2] = 102, [3] = 12 }, [5] = { [0] = 35, [1] = 103, [2] = 119, [3] = 24 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 29, [1] = 97, [2] = 113, [3] = 22 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 34, [1] = 34, [2] = 187, [3] = 172 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 32, [1] = 35, [2] = 191, [3] = 168 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 22, [1] = 90, [2] = 105, [3] = 15 }, [5] = { [0] = 24, [1] = 92, [2] = 108, [3] = 13 }, [6] = { [0] = 17, [1] = 85, [2] = 106, [3] = 9 }, [7] = { [0] = 26, [1] = 94, [2] = 110, [3] = 19 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 35, [2] = 188, [3] = 173 }, [1] = { [0] = 31, [1] = 34, [2] = 190, [3] = 172 }, [2] = { [0] = 33, [1] = 36, [2] = 192, [3] = 169 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 33, [1] = 100, [2] = 115, [3] = 25 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 25, [1] = 93, [2] = 109, [3] = 14 }, [6] = { [0] = 18, [1] = 86, [2] = 107, [3] = 10 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 32, [1] = 35, [2] = 191, [3] = 173 }, [2] = { [0] = 34, [1] = 37, [2] = 193, [3] = 170 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 34, [1] = 101, [2] = 116, [3] = 26 }, [4] = { [0] = 24, [1] = 92, [2] = 107, [3] = 17 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 19, [1] = 87, [2] = 108, [3] = 11 }, [7] = { [0] = 28, [1] = 96, [2] = 112, [3] = 21 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 37, [2] = 190, [3] = 175 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 28, [1] = 36, [2] = 192, [3] = 173 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 26, [1] = 88, [2] = 103, [3] = 13 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 25, [1] = 93, [2] = 108, [3] = 18 }, [5] = { [0] = 30, [1] = 98, [2] = 114, [3] = 19 }, [6] = { [0] = 20, [1] = 88, [2] = 109, [3] = 12 }, [7] = { [0] = 29, [1] = 97, [2] = 113, [3] = 22 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 38, [2] = 191, [3] = 176 }, [1] = { [0] = 34, [1] = 37, [2] = 193, [3] = 175 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 27, [1] = 89, [2] = 104, [3] = 14 }, [3] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [4] = { [0] = 26, [1] = 94, [2] = 109, [3] = 19 }, [5] = { [0] = 31, [1] = 99, [2] = 115, [3] = 20 }, [6] = { [0] = 21, [1] = 89, [2] = 110, [3] = 13 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 39, [2] = 192, [3] = 177 }, [1] = { [0] = 35, [1] = 38, [2] = 194, [3] = 176 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 36, [1] = 41, [2] = 198, [3] = 182 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 28, [1] = 90, [2] = 105, [3] = 15 }, [3] = { [0] = 29, [1] = 96, [2] = 111, [3] = 21 }, [4] = { [0] = 30, [1] = 98, [2] = 113, [3] = 23 }, [5] = { [0] = 32, [1] = 100, [2] = 116, [3] = 21 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 31, [1] = 99, [2] = 115, [3] = 24 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 40, [1] = 40, [2] = 193, [3] = 178 }, [1] = { [0] = 36, [1] = 39, [2] = 195, [3] = 177 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 33, [1] = 38, [2] = 195, [3] = 178 }, [6] = { [0] = 37, [1] = 42, [2] = 199, [3] = 183 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 30, [1] = 97, [2] = 112, [3] = 22 }, [4] = { [0] = 31, [1] = 99, [2] = 114, [3] = 24 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 33, [1] = 38, [2] = 195, [3] = 178 }, [6] = { [0] = 37, [1] = 42, [2] = 199, [3] = 183 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 91, [2] = 113, [3] = 16 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 30, [1] = 92, [2] = 107, [3] = 17 }, [3] = { [0] = 31, [1] = 98, [2] = 113, [3] = 23 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 33, [1] = 101, [2] = 117, [3] = 26 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 24, [1] = 86, [2] = 101, [3] = 10 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 33, [1] = 101, [2] = 116, [3] = 26 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 34, [1] = 102, [2] = 118, [3] = 27 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 30, [1] = 38, [2] = 194, [3] = 175 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 27, [1] = 32, [2] = 189, [3] = 173 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 93, [2] = 115, [3] = 18 }, [1] = { [0] = 25, [1] = 87, [2] = 102, [3] = 11 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 19 }, [3] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [4] = { [0] = 34, [1] = 102, [2] = 117, [3] = 27 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 30, [1] = 38, [2] = 194, [3] = 175 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 35, [1] = 40, [2] = 197, [3] = 180 }, [6] = { [0] = 39, [1] = 44, [2] = 201, [3] = 185 }, [7] = { [0] = 27, [1] = 32, [2] = 189, [3] = 173 } })[R[17]][R[16]], ({ [0] = { [0] = 29, [1] = 94, [2] = 116, [3] = 19 }, [1] = { [0] = 26, [1] = 88, [2] = 103, [3] = 12 }, [2] = { [0] = 33, [1] = 95, [2] = 110, [3] = 20 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 35, [1] = 40, [2] = 197, [3] = 180 }, [6] = { [0] = 39, [1] = 44, [2] = 201, [3] = 185 }, [7] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 } })[R[17]][R[16]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 32, [1] = 40, [2] = 196, [3] = 177 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [6] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 }, [7] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 } })[R[17]][R[16]], ({ [0] = { [0] = 34, [1] = 99, [2] = 121, [3] = 24 }, [1] = { [0] = 31, [1] = 93, [2] = 108, [3] = 17 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 36, [1] = 39, [2] = 195, [3] = 172 }, [3] = { [0] = 33, [1] = 41, [2] = 197, [3] = 178 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [6] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 }, [7] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 } })[R[17]][R[16]], ({ [0] = { [0] = 35, [1] = 100, [2] = 122, [3] = 25 }, [1] = { [0] = 32, [1] = 94, [2] = 109, [3] = 18 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 36, [1] = 39, [2] = 195, [3] = 172 }, [3] = { [0] = 33, [1] = 41, [2] = 197, [3] = 178 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 37, [1] = 42, [2] = 199, [3] = 182 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 } })[R[17]][R[16]], ({ [0] = { [0] = 36, [1] = 101, [2] = 123, [3] = 26 }, [1] = { [0] = 33, [1] = 95, [2] = 110, [3] = 19 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 17, [1] = 85, [2] = 106, [3] = 9 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 45, [2] = 198, [3] = 183 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 34, [1] = 42, [2] = 198, [3] = 179 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 37, [1] = 42, [2] = 199, [3] = 182 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 30, [1] = 35, [2] = 192, [3] = 176 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 18, [1] = 86, [2] = 107, [3] = 10 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 46, [2] = 199, [3] = 184 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 30, [1] = 35, [2] = 192, [3] = 176 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 35, [1] = 97, [2] = 112, [3] = 21 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 19, [1] = 87, [2] = 108, [3] = 11 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 38, [1] = 41, [2] = 197, [3] = 174 }, [3] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 39, [1] = 44, [2] = 201, [3] = 184 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 36, [1] = 98, [2] = 113, [3] = 22 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 21, [1] = 89, [2] = 104, [3] = 14 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 20, [1] = 88, [2] = 109, [3] = 12 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 48, [2] = 201, [3] = 186 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 38, [1] = 41, [2] = 197, [3] = 174 }, [3] = { [0] = 37, [1] = 45, [2] = 201, [3] = 182 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 41, [1] = 103, [2] = 118, [3] = 27 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 21, [1] = 89, [2] = 110, [3] = 13 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 49, [1] = 49, [2] = 202, [3] = 187 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 39, [1] = 42, [2] = 198, [3] = 175 }, [3] = { [0] = 38, [1] = 46, [2] = 202, [3] = 183 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 42, [1] = 104, [2] = 119, [3] = 28 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 25, [1] = 93, [2] = 109, [3] = 18 } })[R[17]][R[16]] })
    if R[17] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 50, [1] = 50, [2] = 203, [3] = 188 })[R[16]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 51, [1] = 51, [2] = 204, [3] = 189 })[R[16]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 50, [1] = 50, [2] = 203, [3] = 188 })[R[16]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 51, [1] = 51, [2] = 204, [3] = 189 })[R[16]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[16]] })
        for i = 1, game.initial_units() do
          R[18] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 48, [1] = 48, [2] = 201, [3] = 186 }, [1] = { [0] = 35, [1] = 35, [2] = 188, [3] = 173 }, [2] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 } })[R[18]][R[16]], ({ [0] = { [0] = 25, [1] = 90, [2] = 112, [3] = 15 }, [1] = { [0] = 34, [1] = 99, [2] = 121, [3] = 24 }, [2] = { [0] = 37, [1] = 102, [2] = 124, [3] = 27 } })[R[18]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 44, [1] = 106, [2] = 121, [3] = 30 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 44, [1] = 106, [2] = 121, [3] = 30 })[R[16]] })
        for i = 1, game.initial_units() do
          R[19] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 188, [3] = 170 }, [1] = { [0] = 31, [1] = 34, [2] = 190, [3] = 172 }, [2] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 } })[R[19]][R[16]], ({ [0] = { [0] = 38, [1] = 100, [2] = 115, [3] = 24 }, [1] = { [0] = 40, [1] = 102, [2] = 117, [3] = 26 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 18 } })[R[19]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[20] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 30, [1] = 33, [2] = 189, [3] = 166 }, [1] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [2] = { [0] = 48, [1] = 51, [2] = 207, [3] = 184 } })[R[20]][R[16]], ({ [0] = { [0] = 23, [1] = 85, [2] = 100, [3] = 10 }, [1] = { [0] = 39, [1] = 101, [2] = 116, [3] = 26 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 19 } })[R[20]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 46, [2] = 202, [3] = 183 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 47, [2] = 203, [3] = 184 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 48, [2] = 204, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 29, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 30, [1] = 97, [2] = 112, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 31, [1] = 98, [2] = 113, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 33, [1] = 100, [2] = 115, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 34, [1] = 101, [2] = 116, [3] = 26 })[R[16]] })
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [1] = { [0] = 37, [1] = 45, [2] = 201, [3] = 182 }, [2] = { [0] = 24, [1] = 32, [2] = 188, [3] = 169 } })[R[21]][R[16]], ({ [0] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [1] = { [0] = 35, [1] = 102, [2] = 117, [3] = 27 }, [2] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 } })[R[21]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 46, [2] = 202, [3] = 183 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 47, [2] = 203, [3] = 184 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 48, [2] = 204, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 29, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 30, [1] = 97, [2] = 112, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 31, [1] = 98, [2] = 113, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 33, [1] = 100, [2] = 115, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 34, [1] = 101, [2] = 116, [3] = 26 })[R[16]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 21, [1] = 89, [2] = 104, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 29, [1] = 97, [2] = 112, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 113, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 108, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 109, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 21, [1] = 89, [2] = 104, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 29, [1] = 97, [2] = 112, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 113, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 108, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 109, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [1] = { [0] = 29, [1] = 34, [2] = 193, [3] = 175 }, [2] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 } })[R[22]][R[16]], ({ [0] = { [0] = 19, [1] = 87, [2] = 102, [3] = 12 }, [1] = { [0] = 27, [1] = 95, [2] = 110, [3] = 20 }, [2] = { [0] = 22, [1] = 90, [2] = 105, [3] = 15 } })[R[22]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 20 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 20 })[R[16]] })
        for i = 1, game.initial_units() do
          R[23] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [1] = { [0] = 19, [1] = 24, [2] = 181, [3] = 164 }, [2] = { [0] = 41, [1] = 46, [2] = 203, [3] = 186 } })[R[23]][R[16]], ({ [0] = { [0] = 37, [1] = 105, [2] = 121, [3] = 26 }, [1] = { [0] = 24, [1] = 92, [2] = 108, [3] = 13 }, [2] = { [0] = 37, [1] = 105, [2] = 121, [3] = 26 } })[R[23]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 48, [1] = 53, [2] = 210, [3] = 194 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 49, [1] = 54, [2] = 211, [3] = 195 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 48, [1] = 53, [2] = 210, [3] = 194 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 49, [1] = 54, [2] = 211, [3] = 195 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
        for i = 1, game.initial_units() do
          R[24] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 }, [1] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [2] = { [0] = 54, [1] = 59, [2] = 216, [3] = 200 } })[R[24]][R[16]], ({ [0] = { [0] = 13, [1] = 81, [2] = 102, [3] = 5 }, [1] = { [0] = 11, [1] = 79, [2] = 100, [3] = 3 }, [2] = { [0] = 26, [1] = 94, [2] = 115, [3] = 18 } })[R[24]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 34, [1] = 102, [2] = 118, [3] = 27 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 119, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 109, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 34, [1] = 102, [2] = 118, [3] = 27 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 119, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 109, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[16]] })
        for i = 1, game.initial_units() do
          R[25] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 }, [1] = { [0] = 35, [1] = 40, [2] = 197, [3] = 181 }, [2] = { [0] = 23, [1] = 28, [2] = 185, [3] = 169 } })[R[25]][R[16]], ({ [0] = { [0] = 19, [1] = 87, [2] = 103, [3] = 12 }, [1] = { [0] = 19, [1] = 87, [2] = 103, [3] = 12 }, [2] = { [0] = 40, [1] = 108, [2] = 124, [3] = 33 } })[R[25]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[17]", R[17])
    end
    R[26] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 180, [1] = 195, [2] = 42, [3] = 42 }, [1] = { [0] = 168, [1] = 186, [2] = 30, [3] = 27 }, [2] = { [0] = 171, [1] = 194, [2] = 38, [3] = 35 }, [3] = { [0] = 180, [1] = 199, [2] = 43, [3] = 35 }, [4] = { [0] = 180, [1] = 198, [2] = 39, [3] = 34 }, [5] = { [0] = 175, [1] = 192, [2] = 35, [3] = 30 }, [6] = { [0] = 179, [1] = 195, [2] = 38, [3] = 33 }, [7] = { [0] = 177, [1] = 193, [2] = 36, [3] = 31 } })[R[26]][R[16]], ({ [0] = { [0] = 21, [1] = 118, [2] = 96, [3] = 31 }, [1] = { [0] = 20, [1] = 111, [2] = 96, [3] = 34 }, [2] = { [0] = 11, [1] = 101, [2] = 86, [3] = 24 }, [3] = { [0] = 24, [1] = 114, [2] = 99, [3] = 32 }, [4] = { [0] = 21, [1] = 111, [2] = 96, [3] = 28 }, [5] = { [0] = 17, [1] = 112, [2] = 96, [3] = 28 }, [6] = { [0] = 7, [1] = 104, [2] = 83, [3] = 15 }, [7] = { [0] = 23, [1] = 114, [2] = 98, [3] = 30 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 180, [1] = 195, [2] = 42, [3] = 42 }, [1] = { [0] = 168, [1] = 186, [2] = 30, [3] = 27 }, [2] = { [0] = 171, [1] = 194, [2] = 38, [3] = 35 }, [3] = { [0] = 180, [1] = 199, [2] = 43, [3] = 35 }, [4] = { [0] = 180, [1] = 198, [2] = 39, [3] = 34 }, [5] = { [0] = 175, [1] = 192, [2] = 35, [3] = 30 }, [6] = { [0] = 179, [1] = 195, [2] = 38, [3] = 33 }, [7] = { [0] = 177, [1] = 193, [2] = 36, [3] = 31 } })[R[26]][R[16]], ({ [0] = { [0] = 21, [1] = 118, [2] = 96, [3] = 31 }, [1] = { [0] = 20, [1] = 111, [2] = 96, [3] = 34 }, [2] = { [0] = 11, [1] = 101, [2] = 86, [3] = 24 }, [3] = { [0] = 24, [1] = 114, [2] = 99, [3] = 32 }, [4] = { [0] = 21, [1] = 111, [2] = 96, [3] = 28 }, [5] = { [0] = 17, [1] = 112, [2] = 96, [3] = 28 }, [6] = { [0] = 7, [1] = 104, [2] = 83, [3] = 15 }, [7] = { [0] = 23, [1] = 114, [2] = 98, [3] = 30 } })[R[26]][R[16]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 180, [1] = 195, [2] = 42, [3] = 42 }, [1] = { [0] = 178, [1] = 196, [2] = 40, [3] = 37 }, [2] = { [0] = 165, [1] = 188, [2] = 32, [3] = 29 }, [3] = { [0] = 188, [1] = 207, [2] = 51, [3] = 43 }, [4] = { [0] = 180, [1] = 198, [2] = 39, [3] = 34 }, [5] = { [0] = 175, [1] = 192, [2] = 35, [3] = 30 }, [6] = { [0] = 188, [1] = 204, [2] = 47, [3] = 42 }, [7] = { [0] = 170, [1] = 186, [2] = 29, [3] = 24 } })[R[26]][R[16]], ({ [0] = { [0] = 14, [1] = 111, [2] = 89, [3] = 24 }, [1] = { [0] = 7, [1] = 98, [2] = 83, [3] = 21 }, [2] = { [0] = 16, [1] = 106, [2] = 91, [3] = 29 }, [3] = { [0] = 28, [1] = 118, [2] = 103, [3] = 36 }, [4] = { [0] = 29, [1] = 119, [2] = 104, [3] = 36 }, [5] = { [0] = 23, [1] = 118, [2] = 102, [3] = 34 }, [6] = { [0] = 7, [1] = 104, [2] = 83, [3] = 15 }, [7] = { [0] = 29, [1] = 120, [2] = 104, [3] = 36 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    if R[26] == 3 or R[26] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [3] = { [0] = 172, [1] = 191, [2] = 35, [3] = 27 }, [4] = { [0] = 180, [1] = 198, [2] = 39, [3] = 34 } })[R[26]][R[16]], ({ [3] = { [0] = 28, [1] = 118, [2] = 103, [3] = 36 }, [4] = { [0] = 13, [1] = 103, [2] = 88, [3] = 20 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 191, [1] = 209, [2] = 50, [3] = 45 })[R[16]], ({ [0] = 15, [1] = 105, [2] = 90, [3] = 22 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 3 then
      else
        unseen("R[26]", R[26])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [3] = { [0] = 175, [1] = 194, [2] = 38, [3] = 30 }, [4] = { [0] = 191, [1] = 209, [2] = 50, [3] = 45 } })[R[26]][R[16]], ({ [3] = { [0] = 17, [1] = 107, [2] = 92, [3] = 25 }, [4] = { [0] = 25, [1] = 115, [2] = 100, [3] = 32 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 3 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 186, [1] = 205, [2] = 49, [3] = 41 })[R[16]], ({ [0] = 17, [1] = 107, [2] = 92, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 186, [1] = 205, [2] = 49, [3] = 41 })[R[16]], ({ [0] = 17, [1] = 107, [2] = 92, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 186, [1] = 205, [2] = 49, [3] = 41 })[R[16]], ({ [0] = 17, [1] = 107, [2] = 92, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 4 then
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
        unseen("R[26]", R[26])
      end
    elseif R[26] == 0 or R[26] == 1 or R[26] == 2 or R[26] == 5 or R[26] == 6 or R[26] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 192, [1] = 207, [2] = 54, [3] = 54 }, [1] = { [0] = 179, [1] = 197, [2] = 41, [3] = 38 }, [2] = { [0] = 168, [1] = 191, [2] = 35, [3] = 32 }, [5] = { [0] = 185, [1] = 202, [2] = 45, [3] = 40 }, [6] = { [0] = 189, [1] = 205, [2] = 48, [3] = 43 }, [7] = { [0] = 170, [1] = 186, [2] = 29, [3] = 24 } })[R[26]][R[16]], ({ [0] = { [0] = 21, [1] = 118, [2] = 96, [3] = 31 }, [1] = { [0] = 14, [1] = 105, [2] = 90, [3] = 28 }, [2] = { [0] = 22, [1] = 112, [2] = 97, [3] = 35 }, [5] = { [0] = 22, [1] = 117, [2] = 101, [3] = 33 }, [6] = { [0] = 15, [1] = 112, [2] = 91, [3] = 23 }, [7] = { [0] = 16, [1] = 107, [2] = 91, [3] = 23 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 0 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 169, [1] = 184, [2] = 31, [3] = 31 })[R[16]], ({ [0] = 21, [1] = 118, [2] = 96, [3] = 31 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 169, [1] = 184, [2] = 31, [3] = 31 })[R[16]], ({ [0] = 21, [1] = 118, [2] = 96, [3] = 31 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 169, [1] = 184, [2] = 31, [3] = 31 })[R[16]], ({ [0] = 21, [1] = 118, [2] = 96, [3] = 31 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 1 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 179, [1] = 197, [2] = 41, [3] = 38 })[R[16]], ({ [0] = 24, [1] = 115, [2] = 100, [3] = 38 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 179, [1] = 197, [2] = 41, [3] = 38 })[R[16]], ({ [0] = 24, [1] = 115, [2] = 100, [3] = 38 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 179, [1] = 197, [2] = 41, [3] = 38 })[R[16]], ({ [0] = 24, [1] = 115, [2] = 100, [3] = 38 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 2 then
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
      elseif R[26] == 5 then
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
      elseif R[26] == 6 then
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 180, [1] = 195, [2] = 42, [3] = 42 }, [1] = { [0] = 178, [1] = 196, [2] = 40, [3] = 37 }, [2] = { [0] = 177, [1] = 200, [2] = 44, [3] = 41 }, [5] = { [0] = 185, [1] = 202, [2] = 45, [3] = 40 }, [6] = { [0] = 197, [1] = 213, [2] = 56, [3] = 51 }, [7] = { [0] = 185, [1] = 201, [2] = 44, [3] = 39 } })[R[26]][R[16]], ({ [0] = { [0] = 28, [1] = 125, [2] = 103, [3] = 38 }, [1] = { [0] = 32, [1] = 123, [2] = 108, [3] = 46 }, [2] = { [0] = 16, [1] = 106, [2] = 91, [3] = 29 }, [5] = { [0] = 15, [1] = 110, [2] = 94, [3] = 26 }, [6] = { [0] = 15, [1] = 112, [2] = 91, [3] = 23 }, [7] = { [0] = 16, [1] = 107, [2] = 91, [3] = 23 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 2 or R[26] == 5 or R[26] == 6 or R[26] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [2] = { [0] = 177, [1] = 200, [2] = 44, [3] = 41 }, [5] = { [0] = 175, [1] = 192, [2] = 35, [3] = 30 }, [6] = { [0] = 180, [1] = 196, [2] = 39, [3] = 34 }, [7] = { [0] = 186, [1] = 202, [2] = 45, [3] = 40 } })[R[26]][R[16]], ({ [2] = { [0] = 22, [1] = 112, [2] = 97, [3] = 35 }, [5] = { [0] = 10, [1] = 105, [2] = 89, [3] = 21 }, [6] = { [0] = 15, [1] = 112, [2] = 91, [3] = 23 }, [7] = { [0] = 28, [1] = 119, [2] = 103, [3] = 35 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 0 or R[26] == 1 then
      else
        unseen("R[26]", R[26])
      end
    else
      unseen("R[26]", R[26])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 169, [1] = 184, [2] = 31, [3] = 31 }, [1] = { [0] = 169, [1] = 187, [2] = 31, [3] = 28 }, [2] = { [0] = 185, [1] = 208, [2] = 52, [3] = 49 }, [3] = { [0] = 181, [1] = 200, [2] = 44, [3] = 36 }, [4] = { [0] = 172, [1] = 190, [2] = 31, [3] = 26 }, [5] = { [0] = 165, [1] = 182, [2] = 25, [3] = 20 }, [6] = { [0] = 172, [1] = 188, [2] = 31, [3] = 26 }, [7] = { [0] = 178, [1] = 194, [2] = 37, [3] = 32 } })[R[26]][R[16]], ({ [0] = { [0] = 30, [1] = 127, [2] = 105, [3] = 40 }, [1] = { [0] = 29, [1] = 120, [2] = 105, [3] = 43 }, [2] = { [0] = 16, [1] = 106, [2] = 91, [3] = 29 }, [3] = { [0] = 11, [1] = 101, [2] = 86, [3] = 19 }, [4] = { [0] = 17, [1] = 107, [2] = 92, [3] = 24 }, [5] = { [0] = 17, [1] = 112, [2] = 96, [3] = 28 }, [6] = { [0] = 15, [1] = 112, [2] = 91, [3] = 23 }, [7] = { [0] = 32, [1] = 123, [2] = 107, [3] = 39 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 176, [1] = 191, [2] = 38, [3] = 38 }, [1] = { [0] = 168, [1] = 186, [2] = 30, [3] = 27 }, [2] = { [0] = 181, [1] = 204, [2] = 48, [3] = 45 }, [3] = { [0] = 170, [1] = 189, [2] = 33, [3] = 25 }, [4] = { [0] = 190, [1] = 208, [2] = 49, [3] = 44 }, [5] = { [0] = 183, [1] = 200, [2] = 43, [3] = 38 }, [6] = { [0] = 179, [1] = 195, [2] = 38, [3] = 33 }, [7] = { [0] = 188, [1] = 204, [2] = 47, [3] = 42 } })[R[26]][R[16]], ({ [0] = { [0] = 17, [1] = 114, [2] = 92, [3] = 27 }, [1] = { [0] = 15, [1] = 106, [2] = 91, [3] = 29 }, [2] = { [0] = 20, [1] = 110, [2] = 95, [3] = 33 }, [3] = { [0] = 18, [1] = 108, [2] = 93, [3] = 26 }, [4] = { [0] = 21, [1] = 111, [2] = 96, [3] = 28 }, [5] = { [0] = 8, [1] = 103, [2] = 87, [3] = 19 }, [6] = { [0] = 20, [1] = 117, [2] = 96, [3] = 28 }, [7] = { [0] = 23, [1] = 114, [2] = 98, [3] = 30 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 174, [1] = 189, [2] = 36, [3] = 36 }, [1] = { [0] = 168, [1] = 186, [2] = 30, [3] = 27 }, [2] = { [0] = 181, [1] = 204, [2] = 48, [3] = 45 }, [3] = { [0] = 173, [1] = 192, [2] = 36, [3] = 28 }, [4] = { [0] = 192, [1] = 210, [2] = 51, [3] = 46 }, [5] = { [0] = 183, [1] = 200, [2] = 43, [3] = 38 }, [6] = { [0] = 177, [1] = 193, [2] = 36, [3] = 31 }, [7] = { [0] = 188, [1] = 204, [2] = 47, [3] = 42 } })[R[26]][R[16]], ({ [0] = { [0] = 17, [1] = 114, [2] = 92, [3] = 27 }, [1] = { [0] = 13, [1] = 104, [2] = 89, [3] = 27 }, [2] = { [0] = 18, [1] = 108, [2] = 93, [3] = 31 }, [3] = { [0] = 14, [1] = 104, [2] = 89, [3] = 22 }, [4] = { [0] = 21, [1] = 111, [2] = 96, [3] = 28 }, [5] = { [0] = 10, [1] = 105, [2] = 89, [3] = 21 }, [6] = { [0] = 20, [1] = 117, [2] = 96, [3] = 28 }, [7] = { [0] = 25, [1] = 116, [2] = 100, [3] = 32 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 185, [1] = 200, [2] = 47, [3] = 47 }, [1] = { [0] = 171, [1] = 189, [2] = 33, [3] = 30 }, [2] = { [0] = 163, [1] = 186, [2] = 30, [3] = 27 }, [3] = { [0] = 190, [1] = 209, [2] = 53, [3] = 45 }, [4] = { [0] = 184, [1] = 202, [2] = 43, [3] = 38 }, [5] = { [0] = 171, [1] = 188, [2] = 31, [3] = 26 }, [6] = { [0] = 192, [1] = 208, [2] = 51, [3] = 46 }, [7] = { [0] = 187, [1] = 203, [2] = 46, [3] = 41 } })[R[26]][R[16]], ({ [0] = { [0] = 23, [1] = 120, [2] = 98, [3] = 33 }, [1] = { [0] = 15, [1] = 106, [2] = 91, [3] = 29 }, [2] = { [0] = 21, [1] = 111, [2] = 96, [3] = 34 }, [3] = { [0] = 18, [1] = 108, [2] = 93, [3] = 26 }, [4] = { [0] = 29, [1] = 119, [2] = 104, [3] = 36 }, [5] = { [0] = 18, [1] = 113, [2] = 97, [3] = 29 }, [6] = { [0] = 7, [1] = 104, [2] = 83, [3] = 15 }, [7] = { [0] = 17, [1] = 108, [2] = 92, [3] = 24 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 185, [1] = 200, [2] = 47, [3] = 47 }, [1] = { [0] = 171, [1] = 189, [2] = 33, [3] = 30 }, [2] = { [0] = 163, [1] = 186, [2] = 30, [3] = 27 }, [3] = { [0] = 188, [1] = 207, [2] = 51, [3] = 43 }, [4] = { [0] = 184, [1] = 202, [2] = 43, [3] = 38 }, [5] = { [0] = 171, [1] = 188, [2] = 31, [3] = 26 }, [6] = { [0] = 192, [1] = 208, [2] = 51, [3] = 46 }, [7] = { [0] = 187, [1] = 203, [2] = 46, [3] = 41 } })[R[26]][R[16]], ({ [0] = { [0] = 23, [1] = 120, [2] = 98, [3] = 33 }, [1] = { [0] = 15, [1] = 106, [2] = 91, [3] = 29 }, [2] = { [0] = 21, [1] = 111, [2] = 96, [3] = 34 }, [3] = { [0] = 14, [1] = 104, [2] = 89, [3] = 22 }, [4] = { [0] = 29, [1] = 119, [2] = 104, [3] = 36 }, [5] = { [0] = 18, [1] = 113, [2] = 97, [3] = 29 }, [6] = { [0] = 7, [1] = 104, [2] = 83, [3] = 15 }, [7] = { [0] = 17, [1] = 108, [2] = 92, [3] = 24 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 174, [1] = 189, [2] = 36, [3] = 36 }, [1] = { [0] = 168, [1] = 186, [2] = 30, [3] = 27 }, [2] = { [0] = 181, [1] = 204, [2] = 48, [3] = 45 }, [3] = { [0] = 176, [1] = 195, [2] = 39, [3] = 31 }, [4] = { [0] = 192, [1] = 210, [2] = 51, [3] = 46 }, [5] = { [0] = 183, [1] = 200, [2] = 43, [3] = 38 }, [6] = { [0] = 177, [1] = 193, [2] = 36, [3] = 31 }, [7] = { [0] = 188, [1] = 204, [2] = 47, [3] = 42 } })[R[26]][R[16]], ({ [0] = { [0] = 17, [1] = 114, [2] = 92, [3] = 27 }, [1] = { [0] = 15, [1] = 106, [2] = 91, [3] = 29 }, [2] = { [0] = 18, [1] = 108, [2] = 93, [3] = 31 }, [3] = { [0] = 29, [1] = 119, [2] = 104, [3] = 37 }, [4] = { [0] = 21, [1] = 111, [2] = 96, [3] = 28 }, [5] = { [0] = 10, [1] = 105, [2] = 89, [3] = 21 }, [6] = { [0] = 20, [1] = 117, [2] = 96, [3] = 28 }, [7] = { [0] = 25, [1] = 116, [2] = 100, [3] = 32 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 174, [1] = 189, [2] = 36, [3] = 36 }, [1] = { [0] = 171, [1] = 189, [2] = 33, [3] = 30 }, [2] = { [0] = 181, [1] = 204, [2] = 48, [3] = 45 }, [3] = { [0] = 176, [1] = 195, [2] = 39, [3] = 31 }, [4] = { [0] = 192, [1] = 210, [2] = 51, [3] = 46 }, [5] = { [0] = 183, [1] = 200, [2] = 43, [3] = 38 }, [6] = { [0] = 177, [1] = 193, [2] = 36, [3] = 31 }, [7] = { [0] = 188, [1] = 204, [2] = 47, [3] = 42 } })[R[26]][R[16]], ({ [0] = { [0] = 17, [1] = 114, [2] = 92, [3] = 27 }, [1] = { [0] = 15, [1] = 106, [2] = 91, [3] = 29 }, [2] = { [0] = 18, [1] = 108, [2] = 93, [3] = 31 }, [3] = { [0] = 29, [1] = 119, [2] = 104, [3] = 37 }, [4] = { [0] = 21, [1] = 111, [2] = 96, [3] = 28 }, [5] = { [0] = 10, [1] = 105, [2] = 89, [3] = 21 }, [6] = { [0] = 20, [1] = 117, [2] = 96, [3] = 28 }, [7] = { [0] = 25, [1] = 116, [2] = 100, [3] = 32 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 185, [1] = 200, [2] = 47, [3] = 47 }, [1] = { [0] = 168, [1] = 186, [2] = 30, [3] = 27 }, [2] = { [0] = 163, [1] = 186, [2] = 30, [3] = 27 }, [3] = { [0] = 170, [1] = 189, [2] = 33, [3] = 25 }, [4] = { [0] = 184, [1] = 202, [2] = 43, [3] = 38 }, [5] = { [0] = 171, [1] = 188, [2] = 31, [3] = 26 }, [6] = { [0] = 192, [1] = 208, [2] = 51, [3] = 46 }, [7] = { [0] = 187, [1] = 203, [2] = 46, [3] = 41 } })[R[26]][R[16]], ({ [0] = { [0] = 23, [1] = 120, [2] = 98, [3] = 33 }, [1] = { [0] = 15, [1] = 106, [2] = 91, [3] = 29 }, [2] = { [0] = 21, [1] = 111, [2] = 96, [3] = 34 }, [3] = { [0] = 18, [1] = 108, [2] = 93, [3] = 26 }, [4] = { [0] = 29, [1] = 119, [2] = 104, [3] = 36 }, [5] = { [0] = 18, [1] = 113, [2] = 97, [3] = 29 }, [6] = { [0] = 7, [1] = 104, [2] = 83, [3] = 15 }, [7] = { [0] = 17, [1] = 108, [2] = 92, [3] = 24 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 171, [1] = 186, [2] = 33, [3] = 33 }, [1] = { [0] = 171, [1] = 189, [2] = 33, [3] = 30 }, [2] = { [0] = 181, [1] = 204, [2] = 48, [3] = 45 }, [3] = { [0] = 170, [1] = 189, [2] = 33, [3] = 25 }, [4] = { [0] = 185, [1] = 203, [2] = 44, [3] = 39 }, [5] = { [0] = 170, [1] = 187, [2] = 30, [3] = 25 }, [6] = { [0] = 184, [1] = 200, [2] = 43, [3] = 38 }, [7] = { [0] = 172, [1] = 188, [2] = 31, [3] = 26 } })[R[26]][R[16]], ({ [0] = { [0] = 17, [1] = 114, [2] = 92, [3] = 27 }, [1] = { [0] = 9, [1] = 100, [2] = 85, [3] = 23 }, [2] = { [0] = 24, [1] = 114, [2] = 99, [3] = 37 }, [3] = { [0] = 18, [1] = 108, [2] = 93, [3] = 26 }, [4] = { [0] = 25, [1] = 115, [2] = 100, [3] = 32 }, [5] = { [0] = 7, [1] = 102, [2] = 86, [3] = 18 }, [6] = { [0] = 17, [1] = 114, [2] = 93, [3] = 25 }, [7] = { [0] = 23, [1] = 114, [2] = 98, [3] = 30 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 171, [1] = 186, [2] = 33, [3] = 33 }, [1] = { [0] = 174, [1] = 192, [2] = 36, [3] = 33 }, [2] = { [0] = 177, [1] = 200, [2] = 44, [3] = 41 }, [3] = { [0] = 176, [1] = 195, [2] = 39, [3] = 31 }, [4] = { [0] = 187, [1] = 205, [2] = 46, [3] = 41 }, [5] = { [0] = 179, [1] = 196, [2] = 39, [3] = 34 }, [6] = { [0] = 193, [1] = 209, [2] = 52, [3] = 47 }, [7] = { [0] = 167, [1] = 183, [2] = 26, [3] = 21 } })[R[26]][R[16]], ({ [0] = { [0] = 14, [1] = 111, [2] = 89, [3] = 24 }, [1] = { [0] = 6, [1] = 97, [2] = 82, [3] = 20 }, [2] = { [0] = 25, [1] = 115, [2] = 100, [3] = 38 }, [3] = { [0] = 29, [1] = 119, [2] = 104, [3] = 37 }, [4] = { [0] = 16, [1] = 106, [2] = 91, [3] = 23 }, [5] = { [0] = 15, [1] = 110, [2] = 94, [3] = 26 }, [6] = { [0] = 14, [1] = 111, [2] = 90, [3] = 22 }, [7] = { [0] = 20, [1] = 111, [2] = 95, [3] = 27 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 185, [1] = 200, [2] = 47, [3] = 47 }, [1] = { [0] = 171, [1] = 189, [2] = 33, [3] = 30 }, [2] = { [0] = 163, [1] = 186, [2] = 30, [3] = 27 }, [3] = { [0] = 190, [1] = 209, [2] = 53, [3] = 45 }, [4] = { [0] = 184, [1] = 202, [2] = 43, [3] = 38 }, [5] = { [0] = 171, [1] = 188, [2] = 31, [3] = 26 }, [6] = { [0] = 192, [1] = 208, [2] = 51, [3] = 46 }, [7] = { [0] = 187, [1] = 203, [2] = 46, [3] = 41 } })[R[26]][R[16]], ({ [0] = { [0] = 23, [1] = 120, [2] = 98, [3] = 33 }, [1] = { [0] = 15, [1] = 106, [2] = 91, [3] = 29 }, [2] = { [0] = 21, [1] = 111, [2] = 96, [3] = 34 }, [3] = { [0] = 18, [1] = 108, [2] = 93, [3] = 26 }, [4] = { [0] = 29, [1] = 119, [2] = 104, [3] = 36 }, [5] = { [0] = 18, [1] = 113, [2] = 97, [3] = 29 }, [6] = { [0] = 7, [1] = 104, [2] = 83, [3] = 15 }, [7] = { [0] = 17, [1] = 108, [2] = 92, [3] = 24 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 185, [1] = 200, [2] = 47, [3] = 47 }, [1] = { [0] = 171, [1] = 189, [2] = 33, [3] = 30 }, [2] = { [0] = 163, [1] = 186, [2] = 30, [3] = 27 }, [3] = { [0] = 188, [1] = 207, [2] = 51, [3] = 43 }, [4] = { [0] = 184, [1] = 202, [2] = 43, [3] = 38 }, [5] = { [0] = 171, [1] = 188, [2] = 31, [3] = 26 }, [6] = { [0] = 192, [1] = 208, [2] = 51, [3] = 46 }, [7] = { [0] = 187, [1] = 203, [2] = 46, [3] = 41 } })[R[26]][R[16]], ({ [0] = { [0] = 23, [1] = 120, [2] = 98, [3] = 33 }, [1] = { [0] = 15, [1] = 106, [2] = 91, [3] = 29 }, [2] = { [0] = 21, [1] = 111, [2] = 96, [3] = 34 }, [3] = { [0] = 14, [1] = 104, [2] = 89, [3] = 22 }, [4] = { [0] = 29, [1] = 119, [2] = 104, [3] = 36 }, [5] = { [0] = 18, [1] = 113, [2] = 97, [3] = 29 }, [6] = { [0] = 7, [1] = 104, [2] = 83, [3] = 15 }, [7] = { [0] = 17, [1] = 108, [2] = 92, [3] = 24 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 171, [1] = 186, [2] = 33, [3] = 33 }, [1] = { [0] = 171, [1] = 189, [2] = 33, [3] = 30 }, [2] = { [0] = 181, [1] = 204, [2] = 48, [3] = 45 }, [3] = { [0] = 176, [1] = 195, [2] = 39, [3] = 31 }, [4] = { [0] = 185, [1] = 203, [2] = 44, [3] = 39 }, [5] = { [0] = 170, [1] = 187, [2] = 30, [3] = 25 }, [6] = { [0] = 184, [1] = 200, [2] = 43, [3] = 38 }, [7] = { [0] = 172, [1] = 188, [2] = 31, [3] = 26 } })[R[26]][R[16]], ({ [0] = { [0] = 17, [1] = 114, [2] = 92, [3] = 27 }, [1] = { [0] = 9, [1] = 100, [2] = 85, [3] = 23 }, [2] = { [0] = 24, [1] = 114, [2] = 99, [3] = 37 }, [3] = { [0] = 29, [1] = 119, [2] = 104, [3] = 37 }, [4] = { [0] = 25, [1] = 115, [2] = 100, [3] = 32 }, [5] = { [0] = 7, [1] = 102, [2] = 86, [3] = 18 }, [6] = { [0] = 17, [1] = 114, [2] = 93, [3] = 25 }, [7] = { [0] = 23, [1] = 114, [2] = 98, [3] = 30 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 171, [1] = 186, [2] = 33, [3] = 33 }, [1] = { [0] = 174, [1] = 192, [2] = 36, [3] = 33 }, [2] = { [0] = 177, [1] = 200, [2] = 44, [3] = 41 }, [3] = { [0] = 176, [1] = 195, [2] = 39, [3] = 31 }, [4] = { [0] = 187, [1] = 205, [2] = 46, [3] = 41 }, [5] = { [0] = 179, [1] = 196, [2] = 39, [3] = 34 }, [6] = { [0] = 193, [1] = 209, [2] = 52, [3] = 47 }, [7] = { [0] = 167, [1] = 183, [2] = 26, [3] = 21 } })[R[26]][R[16]], ({ [0] = { [0] = 14, [1] = 111, [2] = 89, [3] = 24 }, [1] = { [0] = 6, [1] = 97, [2] = 82, [3] = 20 }, [2] = { [0] = 25, [1] = 115, [2] = 100, [3] = 38 }, [3] = { [0] = 29, [1] = 119, [2] = 104, [3] = 37 }, [4] = { [0] = 16, [1] = 106, [2] = 91, [3] = 23 }, [5] = { [0] = 15, [1] = 110, [2] = 94, [3] = 26 }, [6] = { [0] = 14, [1] = 111, [2] = 90, [3] = 22 }, [7] = { [0] = 20, [1] = 111, [2] = 95, [3] = 27 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 185, [1] = 200, [2] = 47, [3] = 47 }, [1] = { [0] = 171, [1] = 189, [2] = 33, [3] = 30 }, [2] = { [0] = 163, [1] = 186, [2] = 30, [3] = 27 }, [3] = { [0] = 190, [1] = 209, [2] = 53, [3] = 45 }, [4] = { [0] = 184, [1] = 202, [2] = 43, [3] = 38 }, [5] = { [0] = 171, [1] = 188, [2] = 31, [3] = 26 }, [6] = { [0] = 192, [1] = 208, [2] = 51, [3] = 46 }, [7] = { [0] = 187, [1] = 203, [2] = 46, [3] = 41 } })[R[26]][R[16]], ({ [0] = { [0] = 23, [1] = 120, [2] = 98, [3] = 33 }, [1] = { [0] = 15, [1] = 106, [2] = 91, [3] = 29 }, [2] = { [0] = 21, [1] = 111, [2] = 96, [3] = 34 }, [3] = { [0] = 18, [1] = 108, [2] = 93, [3] = 26 }, [4] = { [0] = 29, [1] = 119, [2] = 104, [3] = 36 }, [5] = { [0] = 18, [1] = 113, [2] = 97, [3] = 29 }, [6] = { [0] = 7, [1] = 104, [2] = 83, [3] = 15 }, [7] = { [0] = 17, [1] = 108, [2] = 92, [3] = 24 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 185, [1] = 200, [2] = 47, [3] = 47 }, [1] = { [0] = 171, [1] = 189, [2] = 33, [3] = 30 }, [2] = { [0] = 163, [1] = 186, [2] = 30, [3] = 27 }, [3] = { [0] = 188, [1] = 207, [2] = 51, [3] = 43 }, [4] = { [0] = 184, [1] = 202, [2] = 43, [3] = 38 }, [5] = { [0] = 171, [1] = 188, [2] = 31, [3] = 26 }, [6] = { [0] = 192, [1] = 208, [2] = 51, [3] = 46 }, [7] = { [0] = 187, [1] = 203, [2] = 46, [3] = 41 } })[R[26]][R[16]], ({ [0] = { [0] = 23, [1] = 120, [2] = 98, [3] = 33 }, [1] = { [0] = 15, [1] = 106, [2] = 91, [3] = 29 }, [2] = { [0] = 21, [1] = 111, [2] = 96, [3] = 34 }, [3] = { [0] = 14, [1] = 104, [2] = 89, [3] = 22 }, [4] = { [0] = 29, [1] = 119, [2] = 104, [3] = 36 }, [5] = { [0] = 18, [1] = 113, [2] = 97, [3] = 29 }, [6] = { [0] = 7, [1] = 104, [2] = 83, [3] = 15 }, [7] = { [0] = 17, [1] = 108, [2] = 92, [3] = 24 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 174, [1] = 189, [2] = 36, [3] = 36 }, [1] = { [0] = 168, [1] = 186, [2] = 30, [3] = 27 }, [2] = { [0] = 181, [1] = 204, [2] = 48, [3] = 45 }, [3] = { [0] = 176, [1] = 195, [2] = 39, [3] = 31 }, [4] = { [0] = 192, [1] = 210, [2] = 51, [3] = 46 }, [5] = { [0] = 183, [1] = 200, [2] = 43, [3] = 38 }, [6] = { [0] = 177, [1] = 193, [2] = 36, [3] = 31 }, [7] = { [0] = 188, [1] = 204, [2] = 47, [3] = 42 } })[R[26]][R[16]], ({ [0] = { [0] = 17, [1] = 114, [2] = 92, [3] = 27 }, [1] = { [0] = 15, [1] = 106, [2] = 91, [3] = 29 }, [2] = { [0] = 18, [1] = 108, [2] = 93, [3] = 31 }, [3] = { [0] = 29, [1] = 119, [2] = 104, [3] = 37 }, [4] = { [0] = 21, [1] = 111, [2] = 96, [3] = 28 }, [5] = { [0] = 10, [1] = 105, [2] = 89, [3] = 21 }, [6] = { [0] = 20, [1] = 117, [2] = 96, [3] = 28 }, [7] = { [0] = 25, [1] = 116, [2] = 100, [3] = 32 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 185, [1] = 200, [2] = 47, [3] = 47 }, [1] = { [0] = 171, [1] = 189, [2] = 33, [3] = 30 }, [2] = { [0] = 163, [1] = 186, [2] = 30, [3] = 27 }, [3] = { [0] = 176, [1] = 195, [2] = 39, [3] = 31 }, [4] = { [0] = 184, [1] = 202, [2] = 43, [3] = 38 }, [5] = { [0] = 171, [1] = 188, [2] = 31, [3] = 26 }, [6] = { [0] = 192, [1] = 208, [2] = 51, [3] = 46 }, [7] = { [0] = 187, [1] = 203, [2] = 46, [3] = 41 } })[R[26]][R[16]], ({ [0] = { [0] = 23, [1] = 120, [2] = 98, [3] = 33 }, [1] = { [0] = 15, [1] = 106, [2] = 91, [3] = 29 }, [2] = { [0] = 21, [1] = 111, [2] = 96, [3] = 34 }, [3] = { [0] = 29, [1] = 119, [2] = 104, [3] = 37 }, [4] = { [0] = 29, [1] = 119, [2] = 104, [3] = 36 }, [5] = { [0] = 18, [1] = 113, [2] = 97, [3] = 29 }, [6] = { [0] = 7, [1] = 104, [2] = 83, [3] = 15 }, [7] = { [0] = 17, [1] = 108, [2] = 92, [3] = 24 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 171, [1] = 186, [2] = 33, [3] = 33 }, [1] = { [0] = 171, [1] = 189, [2] = 33, [3] = 30 }, [2] = { [0] = 181, [1] = 204, [2] = 48, [3] = 45 }, [3] = { [0] = 170, [1] = 189, [2] = 33, [3] = 25 }, [4] = { [0] = 185, [1] = 203, [2] = 44, [3] = 39 }, [5] = { [0] = 170, [1] = 187, [2] = 30, [3] = 25 }, [6] = { [0] = 184, [1] = 200, [2] = 43, [3] = 38 }, [7] = { [0] = 172, [1] = 188, [2] = 31, [3] = 26 } })[R[26]][R[16]], ({ [0] = { [0] = 17, [1] = 114, [2] = 92, [3] = 27 }, [1] = { [0] = 9, [1] = 100, [2] = 85, [3] = 23 }, [2] = { [0] = 24, [1] = 114, [2] = 99, [3] = 37 }, [3] = { [0] = 18, [1] = 108, [2] = 93, [3] = 26 }, [4] = { [0] = 25, [1] = 115, [2] = 100, [3] = 32 }, [5] = { [0] = 7, [1] = 102, [2] = 86, [3] = 18 }, [6] = { [0] = 17, [1] = 114, [2] = 93, [3] = 25 }, [7] = { [0] = 23, [1] = 114, [2] = 98, [3] = 30 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 171, [1] = 186, [2] = 33, [3] = 33 }, [1] = { [0] = 174, [1] = 192, [2] = 36, [3] = 33 }, [2] = { [0] = 177, [1] = 200, [2] = 44, [3] = 41 }, [3] = { [0] = 176, [1] = 195, [2] = 39, [3] = 31 }, [4] = { [0] = 187, [1] = 205, [2] = 46, [3] = 41 }, [5] = { [0] = 179, [1] = 196, [2] = 39, [3] = 34 }, [6] = { [0] = 193, [1] = 209, [2] = 52, [3] = 47 }, [7] = { [0] = 167, [1] = 183, [2] = 26, [3] = 21 } })[R[26]][R[16]], ({ [0] = { [0] = 14, [1] = 111, [2] = 89, [3] = 24 }, [1] = { [0] = 6, [1] = 97, [2] = 82, [3] = 20 }, [2] = { [0] = 25, [1] = 115, [2] = 100, [3] = 38 }, [3] = { [0] = 29, [1] = 119, [2] = 104, [3] = 37 }, [4] = { [0] = 16, [1] = 106, [2] = 91, [3] = 23 }, [5] = { [0] = 15, [1] = 110, [2] = 94, [3] = 26 }, [6] = { [0] = 14, [1] = 111, [2] = 90, [3] = 22 }, [7] = { [0] = 20, [1] = 111, [2] = 95, [3] = 27 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 192, [1] = 207, [2] = 54, [3] = 54 }, [1] = { [0] = 177, [1] = 195, [2] = 39, [3] = 36 }, [2] = { [0] = 173, [1] = 196, [2] = 40, [3] = 37 }, [3] = { [0] = 180, [1] = 199, [2] = 43, [3] = 35 }, [4] = { [0] = 193, [1] = 211, [2] = 52, [3] = 47 }, [5] = { [0] = 171, [1] = 188, [2] = 31, [3] = 26 }, [6] = { [0] = 193, [1] = 209, [2] = 52, [3] = 47 }, [7] = { [0] = 181, [1] = 197, [2] = 40, [3] = 35 } })[R[26]][R[16]], ({ [0] = { [0] = 25, [1] = 122, [2] = 100, [3] = 35 }, [1] = { [0] = 19, [1] = 110, [2] = 95, [3] = 33 }, [2] = { [0] = 18, [1] = 108, [2] = 93, [3] = 31 }, [3] = { [0] = 15, [1] = 105, [2] = 90, [3] = 23 }, [4] = { [0] = 12, [1] = 102, [2] = 87, [3] = 19 }, [5] = { [0] = 24, [1] = 119, [2] = 103, [3] = 35 }, [6] = { [0] = 17, [1] = 114, [2] = 93, [3] = 25 }, [7] = { [0] = 22, [1] = 113, [2] = 97, [3] = 29 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 172, [1] = 187, [2] = 34, [3] = 34 }, [1] = { [0] = 171, [1] = 189, [2] = 33, [3] = 30 }, [2] = { [0] = 168, [1] = 191, [2] = 35, [3] = 32 }, [3] = { [0] = 172, [1] = 191, [2] = 35, [3] = 27 }, [4] = { [0] = 180, [1] = 198, [2] = 39, [3] = 34 }, [5] = { [0] = 175, [1] = 192, [2] = 35, [3] = 30 }, [6] = { [0] = 179, [1] = 195, [2] = 38, [3] = 33 }, [7] = { [0] = 170, [1] = 186, [2] = 29, [3] = 24 } })[R[26]][R[16]], ({ [0] = { [0] = 21, [1] = 118, [2] = 96, [3] = 31 }, [1] = { [0] = 20, [1] = 111, [2] = 96, [3] = 34 }, [2] = { [0] = 16, [1] = 106, [2] = 91, [3] = 29 }, [3] = { [0] = 24, [1] = 114, [2] = 99, [3] = 32 }, [4] = { [0] = 15, [1] = 105, [2] = 90, [3] = 22 }, [5] = { [0] = 13, [1] = 108, [2] = 92, [3] = 24 }, [6] = { [0] = 9, [1] = 106, [2] = 85, [3] = 17 }, [7] = { [0] = 19, [1] = 110, [2] = 94, [3] = 26 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 173, [1] = 188, [2] = 35, [3] = 35 }, [1] = { [0] = 172, [1] = 190, [2] = 34, [3] = 31 }, [2] = { [0] = 169, [1] = 192, [2] = 36, [3] = 33 }, [3] = { [0] = 172, [1] = 191, [2] = 35, [3] = 27 }, [4] = { [0] = 180, [1] = 198, [2] = 39, [3] = 34 }, [5] = { [0] = 175, [1] = 192, [2] = 35, [3] = 30 }, [6] = { [0] = 179, [1] = 195, [2] = 38, [3] = 33 }, [7] = { [0] = 170, [1] = 186, [2] = 29, [3] = 24 } })[R[26]][R[16]], ({ [0] = { [0] = 21, [1] = 118, [2] = 96, [3] = 31 }, [1] = { [0] = 20, [1] = 111, [2] = 96, [3] = 34 }, [2] = { [0] = 16, [1] = 106, [2] = 91, [3] = 29 }, [3] = { [0] = 25, [1] = 115, [2] = 100, [3] = 33 }, [4] = { [0] = 16, [1] = 106, [2] = 91, [3] = 23 }, [5] = { [0] = 14, [1] = 109, [2] = 93, [3] = 25 }, [6] = { [0] = 10, [1] = 107, [2] = 86, [3] = 18 }, [7] = { [0] = 20, [1] = 111, [2] = 95, [3] = 27 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 174, [1] = 189, [2] = 36, [3] = 36 }, [1] = { [0] = 173, [1] = 191, [2] = 35, [3] = 32 }, [2] = { [0] = 170, [1] = 193, [2] = 37, [3] = 34 }, [3] = { [0] = 172, [1] = 191, [2] = 35, [3] = 27 }, [4] = { [0] = 180, [1] = 198, [2] = 39, [3] = 34 }, [5] = { [0] = 175, [1] = 192, [2] = 35, [3] = 30 }, [6] = { [0] = 179, [1] = 195, [2] = 38, [3] = 33 }, [7] = { [0] = 170, [1] = 186, [2] = 29, [3] = 24 } })[R[26]][R[16]], ({ [0] = { [0] = 21, [1] = 118, [2] = 96, [3] = 31 }, [1] = { [0] = 20, [1] = 111, [2] = 96, [3] = 34 }, [2] = { [0] = 16, [1] = 106, [2] = 91, [3] = 29 }, [3] = { [0] = 26, [1] = 116, [2] = 101, [3] = 34 }, [4] = { [0] = 17, [1] = 107, [2] = 92, [3] = 24 }, [5] = { [0] = 15, [1] = 110, [2] = 94, [3] = 26 }, [6] = { [0] = 11, [1] = 108, [2] = 87, [3] = 19 }, [7] = { [0] = 21, [1] = 112, [2] = 96, [3] = 28 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 175, [1] = 190, [2] = 37, [3] = 37 }, [1] = { [0] = 174, [1] = 192, [2] = 36, [3] = 33 }, [2] = { [0] = 171, [1] = 194, [2] = 38, [3] = 35 }, [3] = { [0] = 173, [1] = 192, [2] = 36, [3] = 28 }, [4] = { [0] = 180, [1] = 198, [2] = 39, [3] = 34 }, [5] = { [0] = 175, [1] = 192, [2] = 35, [3] = 30 }, [6] = { [0] = 179, [1] = 195, [2] = 38, [3] = 33 }, [7] = { [0] = 170, [1] = 186, [2] = 29, [3] = 24 } })[R[26]][R[16]], ({ [0] = { [0] = 21, [1] = 118, [2] = 96, [3] = 31 }, [1] = { [0] = 20, [1] = 111, [2] = 96, [3] = 34 }, [2] = { [0] = 13, [1] = 103, [2] = 88, [3] = 26 }, [3] = { [0] = 24, [1] = 114, [2] = 99, [3] = 32 }, [4] = { [0] = 18, [1] = 108, [2] = 93, [3] = 25 }, [5] = { [0] = 19, [1] = 114, [2] = 98, [3] = 30 }, [6] = { [0] = 12, [1] = 109, [2] = 88, [3] = 20 }, [7] = { [0] = 22, [1] = 113, [2] = 97, [3] = 29 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 176, [1] = 191, [2] = 38, [3] = 38 }, [1] = { [0] = 175, [1] = 193, [2] = 37, [3] = 34 }, [2] = { [0] = 171, [1] = 194, [2] = 38, [3] = 35 }, [3] = { [0] = 174, [1] = 193, [2] = 37, [3] = 29 }, [4] = { [0] = 180, [1] = 198, [2] = 39, [3] = 34 }, [5] = { [0] = 175, [1] = 192, [2] = 35, [3] = 30 }, [6] = { [0] = 179, [1] = 195, [2] = 38, [3] = 33 }, [7] = { [0] = 170, [1] = 186, [2] = 29, [3] = 24 } })[R[26]][R[16]], ({ [0] = { [0] = 21, [1] = 118, [2] = 96, [3] = 31 }, [1] = { [0] = 20, [1] = 111, [2] = 96, [3] = 34 }, [2] = { [0] = 14, [1] = 104, [2] = 89, [3] = 27 }, [3] = { [0] = 20, [1] = 110, [2] = 95, [3] = 28 }, [4] = { [0] = 19, [1] = 109, [2] = 94, [3] = 26 }, [5] = { [0] = 20, [1] = 115, [2] = 99, [3] = 31 }, [6] = { [0] = 13, [1] = 110, [2] = 89, [3] = 21 }, [7] = { [0] = 23, [1] = 114, [2] = 98, [3] = 30 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 177, [1] = 192, [2] = 39, [3] = 39 }, [1] = { [0] = 176, [1] = 194, [2] = 38, [3] = 35 }, [2] = { [0] = 171, [1] = 194, [2] = 38, [3] = 35 }, [3] = { [0] = 174, [1] = 193, [2] = 37, [3] = 29 }, [4] = { [0] = 180, [1] = 198, [2] = 39, [3] = 34 }, [5] = { [0] = 175, [1] = 192, [2] = 35, [3] = 30 }, [6] = { [0] = 182, [1] = 198, [2] = 41, [3] = 36 }, [7] = { [0] = 170, [1] = 186, [2] = 29, [3] = 24 } })[R[26]][R[16]], ({ [0] = { [0] = 21, [1] = 118, [2] = 96, [3] = 31 }, [1] = { [0] = 20, [1] = 111, [2] = 96, [3] = 34 }, [2] = { [0] = 15, [1] = 105, [2] = 90, [3] = 28 }, [3] = { [0] = 21, [1] = 111, [2] = 96, [3] = 29 }, [4] = { [0] = 23, [1] = 113, [2] = 98, [3] = 30 }, [5] = { [0] = 21, [1] = 116, [2] = 100, [3] = 32 }, [6] = { [0] = 7, [1] = 104, [2] = 83, [3] = 15 }, [7] = { [0] = 24, [1] = 115, [2] = 99, [3] = 31 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 178, [1] = 193, [2] = 40, [3] = 40 }, [1] = { [0] = 177, [1] = 195, [2] = 39, [3] = 36 }, [2] = { [0] = 171, [1] = 194, [2] = 38, [3] = 35 }, [3] = { [0] = 174, [1] = 193, [2] = 37, [3] = 29 }, [4] = { [0] = 180, [1] = 198, [2] = 39, [3] = 34 }, [5] = { [0] = 178, [1] = 195, [2] = 38, [3] = 33 }, [6] = { [0] = 183, [1] = 199, [2] = 42, [3] = 37 }, [7] = { [0] = 170, [1] = 186, [2] = 29, [3] = 24 } })[R[26]][R[16]], ({ [0] = { [0] = 21, [1] = 118, [2] = 96, [3] = 31 }, [1] = { [0] = 20, [1] = 111, [2] = 96, [3] = 34 }, [2] = { [0] = 16, [1] = 106, [2] = 91, [3] = 29 }, [3] = { [0] = 22, [1] = 112, [2] = 97, [3] = 30 }, [4] = { [0] = 24, [1] = 114, [2] = 99, [3] = 31 }, [5] = { [0] = 17, [1] = 112, [2] = 96, [3] = 28 }, [6] = { [0] = 7, [1] = 104, [2] = 83, [3] = 15 }, [7] = { [0] = 25, [1] = 116, [2] = 100, [3] = 32 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 180, [1] = 195, [2] = 42, [3] = 42 }, [1] = { [0] = 178, [1] = 196, [2] = 40, [3] = 37 }, [2] = { [0] = 171, [1] = 194, [2] = 38, [3] = 35 }, [3] = { [0] = 174, [1] = 193, [2] = 37, [3] = 29 }, [4] = { [0] = 180, [1] = 198, [2] = 39, [3] = 34 }, [5] = { [0] = 178, [1] = 195, [2] = 38, [3] = 33 }, [6] = { [0] = 183, [1] = 199, [2] = 42, [3] = 37 }, [7] = { [0] = 170, [1] = 186, [2] = 29, [3] = 24 } })[R[26]][R[16]], ({ [0] = { [0] = 16, [1] = 113, [2] = 91, [3] = 26 }, [1] = { [0] = 9, [1] = 100, [2] = 85, [3] = 23 }, [2] = { [0] = 17, [1] = 107, [2] = 92, [3] = 30 }, [3] = { [0] = 23, [1] = 113, [2] = 98, [3] = 31 }, [4] = { [0] = 25, [1] = 115, [2] = 100, [3] = 32 }, [5] = { [0] = 23, [1] = 118, [2] = 102, [3] = 34 }, [6] = { [0] = 15, [1] = 112, [2] = 91, [3] = 23 }, [7] = { [0] = 26, [1] = 117, [2] = 101, [3] = 33 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 180, [1] = 195, [2] = 42, [3] = 42 }, [1] = { [0] = 178, [1] = 196, [2] = 40, [3] = 37 }, [2] = { [0] = 171, [1] = 194, [2] = 38, [3] = 35 }, [3] = { [0] = 174, [1] = 193, [2] = 37, [3] = 29 }, [4] = { [0] = 180, [1] = 198, [2] = 39, [3] = 34 }, [5] = { [0] = 179, [1] = 196, [2] = 39, [3] = 34 }, [6] = { [0] = 184, [1] = 200, [2] = 43, [3] = 38 }, [7] = { [0] = 170, [1] = 186, [2] = 29, [3] = 24 } })[R[26]][R[16]], ({ [0] = { [0] = 17, [1] = 114, [2] = 92, [3] = 27 }, [1] = { [0] = 10, [1] = 101, [2] = 86, [3] = 24 }, [2] = { [0] = 18, [1] = 108, [2] = 93, [3] = 31 }, [3] = { [0] = 24, [1] = 114, [2] = 99, [3] = 32 }, [4] = { [0] = 26, [1] = 116, [2] = 101, [3] = 33 }, [5] = { [0] = 17, [1] = 112, [2] = 96, [3] = 28 }, [6] = { [0] = 7, [1] = 104, [2] = 83, [3] = 15 }, [7] = { [0] = 27, [1] = 118, [2] = 102, [3] = 34 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 180, [1] = 195, [2] = 42, [3] = 42 }, [1] = { [0] = 178, [1] = 196, [2] = 40, [3] = 37 }, [2] = { [0] = 171, [1] = 194, [2] = 38, [3] = 35 }, [3] = { [0] = 175, [1] = 194, [2] = 38, [3] = 30 }, [4] = { [0] = 180, [1] = 198, [2] = 39, [3] = 34 }, [5] = { [0] = 179, [1] = 196, [2] = 39, [3] = 34 }, [6] = { [0] = 184, [1] = 200, [2] = 43, [3] = 38 }, [7] = { [0] = 173, [1] = 189, [2] = 32, [3] = 27 } })[R[26]][R[16]], ({ [0] = { [0] = 18, [1] = 115, [2] = 93, [3] = 28 }, [1] = { [0] = 11, [1] = 102, [2] = 87, [3] = 25 }, [2] = { [0] = 19, [1] = 109, [2] = 94, [3] = 32 }, [3] = { [0] = 20, [1] = 110, [2] = 95, [3] = 28 }, [4] = { [0] = 27, [1] = 117, [2] = 102, [3] = 34 }, [5] = { [0] = 23, [1] = 118, [2] = 102, [3] = 34 }, [6] = { [0] = 15, [1] = 112, [2] = 91, [3] = 23 }, [7] = { [0] = 16, [1] = 107, [2] = 91, [3] = 23 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 180, [1] = 195, [2] = 42, [3] = 42 }, [1] = { [0] = 178, [1] = 196, [2] = 40, [3] = 37 }, [2] = { [0] = 171, [1] = 194, [2] = 38, [3] = 35 }, [3] = { [0] = 175, [1] = 194, [2] = 38, [3] = 30 }, [4] = { [0] = 183, [1] = 201, [2] = 42, [3] = 37 }, [5] = { [0] = 180, [1] = 197, [2] = 40, [3] = 35 }, [6] = { [0] = 185, [1] = 201, [2] = 44, [3] = 39 }, [7] = { [0] = 173, [1] = 189, [2] = 32, [3] = 27 } })[R[26]][R[16]], ({ [0] = { [0] = 19, [1] = 116, [2] = 94, [3] = 29 }, [1] = { [0] = 12, [1] = 103, [2] = 88, [3] = 26 }, [2] = { [0] = 20, [1] = 110, [2] = 95, [3] = 33 }, [3] = { [0] = 24, [1] = 114, [2] = 99, [3] = 32 }, [4] = { [0] = 13, [1] = 103, [2] = 88, [3] = 20 }, [5] = { [0] = 17, [1] = 112, [2] = 96, [3] = 28 }, [6] = { [0] = 7, [1] = 104, [2] = 83, [3] = 15 }, [7] = { [0] = 29, [1] = 120, [2] = 104, [3] = 36 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 180, [1] = 195, [2] = 42, [3] = 42 }, [1] = { [0] = 178, [1] = 196, [2] = 40, [3] = 37 }, [2] = { [0] = 171, [1] = 194, [2] = 38, [3] = 35 }, [3] = { [0] = 176, [1] = 195, [2] = 39, [3] = 31 }, [4] = { [0] = 183, [1] = 201, [2] = 42, [3] = 37 }, [5] = { [0] = 180, [1] = 197, [2] = 40, [3] = 35 }, [6] = { [0] = 185, [1] = 201, [2] = 44, [3] = 39 }, [7] = { [0] = 174, [1] = 190, [2] = 33, [3] = 28 } })[R[26]][R[16]], ({ [0] = { [0] = 23, [1] = 120, [2] = 98, [3] = 33 }, [1] = { [0] = 20, [1] = 111, [2] = 96, [3] = 34 }, [2] = { [0] = 21, [1] = 111, [2] = 96, [3] = 34 }, [3] = { [0] = 24, [1] = 114, [2] = 99, [3] = 32 }, [4] = { [0] = 21, [1] = 111, [2] = 96, [3] = 28 }, [5] = { [0] = 23, [1] = 118, [2] = 102, [3] = 34 }, [6] = { [0] = 15, [1] = 112, [2] = 91, [3] = 23 }, [7] = { [0] = 16, [1] = 107, [2] = 91, [3] = 23 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 180, [1] = 195, [2] = 42, [3] = 42 }, [1] = { [0] = 179, [1] = 197, [2] = 41, [3] = 38 }, [2] = { [0] = 171, [1] = 194, [2] = 38, [3] = 35 }, [3] = { [0] = 177, [1] = 196, [2] = 40, [3] = 32 }, [4] = { [0] = 183, [1] = 201, [2] = 42, [3] = 37 }, [5] = { [0] = 181, [1] = 198, [2] = 41, [3] = 36 }, [6] = { [0] = 186, [1] = 202, [2] = 45, [3] = 40 }, [7] = { [0] = 174, [1] = 190, [2] = 33, [3] = 28 } })[R[26]][R[16]], ({ [0] = { [0] = 24, [1] = 121, [2] = 99, [3] = 34 }, [1] = { [0] = 17, [1] = 108, [2] = 93, [3] = 31 }, [2] = { [0] = 22, [1] = 112, [2] = 97, [3] = 35 }, [3] = { [0] = 24, [1] = 114, [2] = 99, [3] = 32 }, [4] = { [0] = 29, [1] = 119, [2] = 104, [3] = 36 }, [5] = { [0] = 17, [1] = 112, [2] = 96, [3] = 28 }, [6] = { [0] = 7, [1] = 104, [2] = 83, [3] = 15 }, [7] = { [0] = 29, [1] = 120, [2] = 104, [3] = 36 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 180, [1] = 195, [2] = 42, [3] = 42 }, [1] = { [0] = 179, [1] = 197, [2] = 41, [3] = 38 }, [2] = { [0] = 172, [1] = 195, [2] = 39, [3] = 36 }, [3] = { [0] = 178, [1] = 197, [2] = 41, [3] = 33 }, [4] = { [0] = 184, [1] = 202, [2] = 43, [3] = 38 }, [5] = { [0] = 181, [1] = 198, [2] = 41, [3] = 36 }, [6] = { [0] = 186, [1] = 202, [2] = 45, [3] = 40 }, [7] = { [0] = 175, [1] = 191, [2] = 34, [3] = 29 } })[R[26]][R[16]], ({ [0] = { [0] = 25, [1] = 122, [2] = 100, [3] = 35 }, [1] = { [0] = 18, [1] = 109, [2] = 94, [3] = 32 }, [2] = { [0] = 16, [1] = 106, [2] = 91, [3] = 29 }, [3] = { [0] = 17, [1] = 107, [2] = 92, [3] = 25 }, [4] = { [0] = 13, [1] = 103, [2] = 88, [3] = 20 }, [5] = { [0] = 23, [1] = 118, [2] = 102, [3] = 34 }, [6] = { [0] = 15, [1] = 112, [2] = 91, [3] = 23 }, [7] = { [0] = 16, [1] = 107, [2] = 91, [3] = 23 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 180, [1] = 195, [2] = 42, [3] = 42 }, [1] = { [0] = 179, [1] = 197, [2] = 41, [3] = 38 }, [2] = { [0] = 172, [1] = 195, [2] = 39, [3] = 36 }, [3] = { [0] = 178, [1] = 197, [2] = 41, [3] = 33 }, [4] = { [0] = 184, [1] = 202, [2] = 43, [3] = 38 }, [5] = { [0] = 182, [1] = 199, [2] = 42, [3] = 37 }, [6] = { [0] = 188, [1] = 204, [2] = 47, [3] = 42 }, [7] = { [0] = 175, [1] = 191, [2] = 34, [3] = 29 } })[R[26]][R[16]], ({ [0] = { [0] = 26, [1] = 123, [2] = 101, [3] = 36 }, [1] = { [0] = 19, [1] = 110, [2] = 95, [3] = 33 }, [2] = { [0] = 22, [1] = 112, [2] = 97, [3] = 35 }, [3] = { [0] = 24, [1] = 114, [2] = 99, [3] = 32 }, [4] = { [0] = 21, [1] = 111, [2] = 96, [3] = 28 }, [5] = { [0] = 17, [1] = 112, [2] = 96, [3] = 28 }, [6] = { [0] = 9, [1] = 106, [2] = 85, [3] = 17 }, [7] = { [0] = 29, [1] = 120, [2] = 104, [3] = 36 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 183, [1] = 198, [2] = 45, [3] = 45 }, [1] = { [0] = 179, [1] = 197, [2] = 41, [3] = 38 }, [2] = { [0] = 173, [1] = 196, [2] = 40, [3] = 37 }, [3] = { [0] = 179, [1] = 198, [2] = 42, [3] = 34 }, [4] = { [0] = 184, [1] = 202, [2] = 43, [3] = 38 }, [5] = { [0] = 182, [1] = 199, [2] = 42, [3] = 37 }, [6] = { [0] = 188, [1] = 204, [2] = 47, [3] = 42 }, [7] = { [0] = 176, [1] = 192, [2] = 35, [3] = 30 } })[R[26]][R[16]], ({ [0] = { [0] = 21, [1] = 118, [2] = 96, [3] = 31 }, [1] = { [0] = 20, [1] = 111, [2] = 96, [3] = 34 }, [2] = { [0] = 16, [1] = 106, [2] = 91, [3] = 29 }, [3] = { [0] = 17, [1] = 107, [2] = 92, [3] = 25 }, [4] = { [0] = 29, [1] = 119, [2] = 104, [3] = 36 }, [5] = { [0] = 23, [1] = 118, [2] = 102, [3] = 34 }, [6] = { [0] = 10, [1] = 107, [2] = 86, [3] = 18 }, [7] = { [0] = 16, [1] = 107, [2] = 91, [3] = 23 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 184, [1] = 199, [2] = 46, [3] = 46 }, [1] = { [0] = 179, [1] = 197, [2] = 41, [3] = 38 }, [2] = { [0] = 173, [1] = 196, [2] = 40, [3] = 37 }, [3] = { [0] = 180, [1] = 199, [2] = 43, [3] = 35 }, [4] = { [0] = 185, [1] = 203, [2] = 44, [3] = 39 }, [5] = { [0] = 183, [1] = 200, [2] = 43, [3] = 38 }, [6] = { [0] = 188, [1] = 204, [2] = 47, [3] = 42 }, [7] = { [0] = 176, [1] = 192, [2] = 35, [3] = 30 } })[R[26]][R[16]], ({ [0] = { [0] = 21, [1] = 118, [2] = 96, [3] = 31 }, [1] = { [0] = 21, [1] = 112, [2] = 97, [3] = 35 }, [2] = { [0] = 22, [1] = 112, [2] = 97, [3] = 35 }, [3] = { [0] = 17, [1] = 107, [2] = 92, [3] = 25 }, [4] = { [0] = 13, [1] = 103, [2] = 88, [3] = 20 }, [5] = { [0] = 17, [1] = 112, [2] = 96, [3] = 28 }, [6] = { [0] = 11, [1] = 108, [2] = 87, [3] = 19 }, [7] = { [0] = 29, [1] = 120, [2] = 104, [3] = 36 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 185, [1] = 200, [2] = 47, [3] = 47 }, [1] = { [0] = 179, [1] = 197, [2] = 41, [3] = 38 }, [2] = { [0] = 174, [1] = 197, [2] = 41, [3] = 38 }, [3] = { [0] = 181, [1] = 200, [2] = 44, [3] = 36 }, [4] = { [0] = 185, [1] = 203, [2] = 44, [3] = 39 }, [5] = { [0] = 184, [1] = 201, [2] = 44, [3] = 39 }, [6] = { [0] = 188, [1] = 204, [2] = 47, [3] = 42 }, [7] = { [0] = 177, [1] = 193, [2] = 36, [3] = 31 } })[R[26]][R[16]], ({ [0] = { [0] = 21, [1] = 118, [2] = 96, [3] = 31 }, [1] = { [0] = 22, [1] = 113, [2] = 98, [3] = 36 }, [2] = { [0] = 16, [1] = 106, [2] = 91, [3] = 29 }, [3] = { [0] = 17, [1] = 107, [2] = 92, [3] = 25 }, [4] = { [0] = 14, [1] = 104, [2] = 89, [3] = 21 }, [5] = { [0] = 17, [1] = 112, [2] = 96, [3] = 28 }, [6] = { [0] = 12, [1] = 109, [2] = 88, [3] = 20 }, [7] = { [0] = 16, [1] = 107, [2] = 91, [3] = 23 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 186, [1] = 201, [2] = 48, [3] = 48 }, [1] = { [0] = 179, [1] = 197, [2] = 41, [3] = 38 }, [2] = { [0] = 174, [1] = 197, [2] = 41, [3] = 38 }, [3] = { [0] = 182, [1] = 201, [2] = 45, [3] = 37 }, [4] = { [0] = 185, [1] = 203, [2] = 44, [3] = 39 }, [5] = { [0] = 185, [1] = 202, [2] = 45, [3] = 40 }, [6] = { [0] = 188, [1] = 204, [2] = 47, [3] = 42 }, [7] = { [0] = 177, [1] = 193, [2] = 36, [3] = 31 } })[R[26]][R[16]], ({ [0] = { [0] = 21, [1] = 118, [2] = 96, [3] = 31 }, [1] = { [0] = 27, [1] = 118, [2] = 103, [3] = 41 }, [2] = { [0] = 22, [1] = 112, [2] = 97, [3] = 35 }, [3] = { [0] = 17, [1] = 107, [2] = 92, [3] = 25 }, [4] = { [0] = 21, [1] = 111, [2] = 96, [3] = 28 }, [5] = { [0] = 17, [1] = 112, [2] = 96, [3] = 28 }, [6] = { [0] = 13, [1] = 110, [2] = 89, [3] = 21 }, [7] = { [0] = 17, [1] = 108, [2] = 92, [3] = 24 } })[R[26]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 187, [1] = 202, [2] = 49, [3] = 49 }, [1] = { [0] = 179, [1] = 197, [2] = 41, [3] = 38 }, [2] = { [0] = 175, [1] = 198, [2] = 42, [3] = 39 }, [3] = { [0] = 183, [1] = 202, [2] = 46, [3] = 38 }, [4] = { [0] = 185, [1] = 203, [2] = 44, [3] = 39 }, [5] = { [0] = 185, [1] = 202, [2] = 45, [3] = 40 }, [6] = { [0] = 192, [1] = 208, [2] = 51, [3] = 46 }, [7] = { [0] = 177, [1] = 193, [2] = 36, [3] = 31 } })[R[26]][R[16]], ({ [0] = { [0] = 21, [1] = 118, [2] = 96, [3] = 31 }, [1] = { [0] = 28, [1] = 119, [2] = 104, [3] = 42 }, [2] = { [0] = 16, [1] = 106, [2] = 91, [3] = 29 }, [3] = { [0] = 17, [1] = 107, [2] = 92, [3] = 25 }, [4] = { [0] = 29, [1] = 119, [2] = 104, [3] = 36 }, [5] = { [0] = 18, [1] = 113, [2] = 97, [3] = 29 }, [6] = { [0] = 15, [1] = 112, [2] = 91, [3] = 23 }, [7] = { [0] = 18, [1] = 109, [2] = 93, [3] = 25 } })[R[26]][R[16]] })
    if R[26] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 188, [1] = 203, [2] = 50, [3] = 50 })[R[16]], ({ [0] = 21, [1] = 118, [2] = 96, [3] = 31 })[R[16]] })
        game.create_tube({ ({ [0] = 189, [1] = 204, [2] = 51, [3] = 51 })[R[16]], ({ [0] = 21, [1] = 118, [2] = 96, [3] = 31 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 188, [1] = 203, [2] = 50, [3] = 50 })[R[16]], ({ [0] = 21, [1] = 118, [2] = 96, [3] = 31 })[R[16]] })
        game.create_tube({ ({ [0] = 189, [1] = 204, [2] = 51, [3] = 51 })[R[16]], ({ [0] = 21, [1] = 118, [2] = 96, [3] = 31 })[R[16]] })
        for i = 1, game.initial_units() do
          R[27] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 186, [1] = 201, [2] = 48, [3] = 48 }, [1] = { [0] = 173, [1] = 188, [2] = 35, [3] = 35 }, [2] = { [0] = 185, [1] = 200, [2] = 47, [3] = 47 } })[R[27]][R[16]], ({ [0] = { [0] = 15, [1] = 112, [2] = 90, [3] = 25 }, [1] = { [0] = 24, [1] = 121, [2] = 99, [3] = 34 }, [2] = { [0] = 27, [1] = 124, [2] = 102, [3] = 37 } })[R[27]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 179, [1] = 197, [2] = 41, [3] = 38 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 105, [3] = 43 })[R[16]] })
        game.create_tube({ ({ [0] = 179, [1] = 197, [2] = 41, [3] = 38 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 105, [3] = 43 })[R[16]] })
        game.create_tube({ ({ [0] = 179, [1] = 197, [2] = 41, [3] = 38 })[R[16]], ({ [0] = 30, [1] = 121, [2] = 106, [3] = 44 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 179, [1] = 197, [2] = 41, [3] = 38 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 105, [3] = 43 })[R[16]] })
        game.create_tube({ ({ [0] = 179, [1] = 197, [2] = 41, [3] = 38 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 105, [3] = 43 })[R[16]] })
        game.create_tube({ ({ [0] = 179, [1] = 197, [2] = 41, [3] = 38 })[R[16]], ({ [0] = 30, [1] = 121, [2] = 106, [3] = 44 })[R[16]] })
        for i = 1, game.initial_units() do
          R[28] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 170, [1] = 188, [2] = 32, [3] = 29 }, [1] = { [0] = 172, [1] = 190, [2] = 34, [3] = 31 }, [2] = { [0] = 174, [1] = 192, [2] = 36, [3] = 33 } })[R[28]][R[16]], ({ [0] = { [0] = 24, [1] = 115, [2] = 100, [3] = 38 }, [1] = { [0] = 26, [1] = 117, [2] = 102, [3] = 40 }, [2] = { [0] = 18, [1] = 109, [2] = 94, [3] = 32 } })[R[28]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 166, [1] = 189, [2] = 33, [3] = 30 }, [1] = { [0] = 171, [1] = 194, [2] = 38, [3] = 35 }, [2] = { [0] = 184, [1] = 207, [2] = 51, [3] = 48 } })[R[29]][R[16]], ({ [0] = { [0] = 10, [1] = 100, [2] = 85, [3] = 23 }, [1] = { [0] = 26, [1] = 116, [2] = 101, [3] = 39 }, [2] = { [0] = 19, [1] = 109, [2] = 94, [3] = 32 } })[R[29]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 183, [1] = 202, [2] = 46, [3] = 38 })[R[16]], ({ [0] = 24, [1] = 114, [2] = 99, [3] = 32 })[R[16]] })
        game.create_tube({ ({ [0] = 184, [1] = 203, [2] = 47, [3] = 39 })[R[16]], ({ [0] = 24, [1] = 114, [2] = 99, [3] = 32 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 204, [2] = 48, [3] = 40 })[R[16]], ({ [0] = 24, [1] = 114, [2] = 99, [3] = 32 })[R[16]] })
        game.create_tube({ ({ [0] = 186, [1] = 205, [2] = 49, [3] = 41 })[R[16]], ({ [0] = 20, [1] = 110, [2] = 95, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 186, [1] = 205, [2] = 49, [3] = 41 })[R[16]], ({ [0] = 24, [1] = 114, [2] = 99, [3] = 32 })[R[16]] })
        game.create_tube({ ({ [0] = 187, [1] = 206, [2] = 50, [3] = 42 })[R[16]], ({ [0] = 20, [1] = 110, [2] = 95, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 187, [1] = 206, [2] = 50, [3] = 42 })[R[16]], ({ [0] = 21, [1] = 111, [2] = 96, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 187, [1] = 206, [2] = 50, [3] = 42 })[R[16]], ({ [0] = 22, [1] = 112, [2] = 97, [3] = 30 })[R[16]] })
        game.create_tube({ ({ [0] = 187, [1] = 206, [2] = 50, [3] = 42 })[R[16]], ({ [0] = 23, [1] = 113, [2] = 98, [3] = 31 })[R[16]] })
        game.create_tube({ ({ [0] = 187, [1] = 206, [2] = 50, [3] = 42 })[R[16]], ({ [0] = 24, [1] = 114, [2] = 99, [3] = 32 })[R[16]] })
        game.create_tube({ ({ [0] = 188, [1] = 207, [2] = 51, [3] = 43 })[R[16]], ({ [0] = 24, [1] = 114, [2] = 99, [3] = 32 })[R[16]] })
        game.create_tube({ ({ [0] = 188, [1] = 207, [2] = 51, [3] = 43 })[R[16]], ({ [0] = 25, [1] = 115, [2] = 100, [3] = 33 })[R[16]] })
        game.create_tube({ ({ [0] = 188, [1] = 207, [2] = 51, [3] = 43 })[R[16]], ({ [0] = 26, [1] = 116, [2] = 101, [3] = 34 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 183, [1] = 202, [2] = 46, [3] = 38 })[R[16]], ({ [0] = 24, [1] = 114, [2] = 99, [3] = 32 })[R[16]] })
        game.create_tube({ ({ [0] = 184, [1] = 203, [2] = 47, [3] = 39 })[R[16]], ({ [0] = 24, [1] = 114, [2] = 99, [3] = 32 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 204, [2] = 48, [3] = 40 })[R[16]], ({ [0] = 24, [1] = 114, [2] = 99, [3] = 32 })[R[16]] })
        game.create_tube({ ({ [0] = 186, [1] = 205, [2] = 49, [3] = 41 })[R[16]], ({ [0] = 20, [1] = 110, [2] = 95, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 186, [1] = 205, [2] = 49, [3] = 41 })[R[16]], ({ [0] = 24, [1] = 114, [2] = 99, [3] = 32 })[R[16]] })
        game.create_tube({ ({ [0] = 187, [1] = 206, [2] = 50, [3] = 42 })[R[16]], ({ [0] = 20, [1] = 110, [2] = 95, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 187, [1] = 206, [2] = 50, [3] = 42 })[R[16]], ({ [0] = 21, [1] = 111, [2] = 96, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 187, [1] = 206, [2] = 50, [3] = 42 })[R[16]], ({ [0] = 22, [1] = 112, [2] = 97, [3] = 30 })[R[16]] })
        game.create_tube({ ({ [0] = 187, [1] = 206, [2] = 50, [3] = 42 })[R[16]], ({ [0] = 23, [1] = 113, [2] = 98, [3] = 31 })[R[16]] })
        game.create_tube({ ({ [0] = 187, [1] = 206, [2] = 50, [3] = 42 })[R[16]], ({ [0] = 24, [1] = 114, [2] = 99, [3] = 32 })[R[16]] })
        game.create_tube({ ({ [0] = 188, [1] = 207, [2] = 51, [3] = 43 })[R[16]], ({ [0] = 24, [1] = 114, [2] = 99, [3] = 32 })[R[16]] })
        game.create_tube({ ({ [0] = 188, [1] = 207, [2] = 51, [3] = 43 })[R[16]], ({ [0] = 25, [1] = 115, [2] = 100, [3] = 33 })[R[16]] })
        game.create_tube({ ({ [0] = 188, [1] = 207, [2] = 51, [3] = 43 })[R[16]], ({ [0] = 26, [1] = 116, [2] = 101, [3] = 34 })[R[16]] })
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 181, [1] = 200, [2] = 44, [3] = 36 }, [1] = { [0] = 182, [1] = 201, [2] = 45, [3] = 37 }, [2] = { [0] = 169, [1] = 188, [2] = 32, [3] = 24 } })[R[30]][R[16]], ({ [0] = { [0] = 20, [1] = 110, [2] = 95, [3] = 28 }, [1] = { [0] = 27, [1] = 117, [2] = 102, [3] = 35 }, [2] = { [0] = 24, [1] = 114, [2] = 99, [3] = 32 } })[R[30]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 186, [1] = 204, [2] = 45, [3] = 40 })[R[16]], ({ [0] = 14, [1] = 104, [2] = 89, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 186, [1] = 204, [2] = 45, [3] = 40 })[R[16]], ({ [0] = 15, [1] = 105, [2] = 90, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 186, [1] = 204, [2] = 45, [3] = 40 })[R[16]], ({ [0] = 21, [1] = 111, [2] = 96, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 186, [1] = 204, [2] = 45, [3] = 40 })[R[16]], ({ [0] = 29, [1] = 119, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 187, [1] = 205, [2] = 46, [3] = 41 })[R[16]], ({ [0] = 15, [1] = 105, [2] = 90, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 187, [1] = 205, [2] = 46, [3] = 41 })[R[16]], ({ [0] = 21, [1] = 111, [2] = 96, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 187, [1] = 205, [2] = 46, [3] = 41 })[R[16]], ({ [0] = 29, [1] = 119, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 188, [1] = 206, [2] = 47, [3] = 42 })[R[16]], ({ [0] = 15, [1] = 105, [2] = 90, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 188, [1] = 206, [2] = 47, [3] = 42 })[R[16]], ({ [0] = 21, [1] = 111, [2] = 96, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 188, [1] = 206, [2] = 47, [3] = 42 })[R[16]], ({ [0] = 29, [1] = 119, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 189, [1] = 207, [2] = 48, [3] = 43 })[R[16]], ({ [0] = 20, [1] = 110, [2] = 95, [3] = 27 })[R[16]] })
        game.create_tube({ ({ [0] = 189, [1] = 207, [2] = 48, [3] = 43 })[R[16]], ({ [0] = 21, [1] = 111, [2] = 96, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 189, [1] = 207, [2] = 48, [3] = 43 })[R[16]], ({ [0] = 22, [1] = 112, [2] = 97, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 189, [1] = 207, [2] = 48, [3] = 43 })[R[16]], ({ [0] = 23, [1] = 113, [2] = 98, [3] = 30 })[R[16]] })
        game.create_tube({ ({ [0] = 189, [1] = 207, [2] = 48, [3] = 43 })[R[16]], ({ [0] = 28, [1] = 118, [2] = 103, [3] = 35 })[R[16]] })
        game.create_tube({ ({ [0] = 189, [1] = 207, [2] = 48, [3] = 43 })[R[16]], ({ [0] = 29, [1] = 119, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 190, [1] = 208, [2] = 49, [3] = 44 })[R[16]], ({ [0] = 20, [1] = 110, [2] = 95, [3] = 27 })[R[16]] })
        game.create_tube({ ({ [0] = 190, [1] = 208, [2] = 49, [3] = 44 })[R[16]], ({ [0] = 28, [1] = 118, [2] = 103, [3] = 35 })[R[16]] })
        game.create_tube({ ({ [0] = 191, [1] = 209, [2] = 50, [3] = 45 })[R[16]], ({ [0] = 18, [1] = 108, [2] = 93, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 191, [1] = 209, [2] = 50, [3] = 45 })[R[16]], ({ [0] = 19, [1] = 109, [2] = 94, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 191, [1] = 209, [2] = 50, [3] = 45 })[R[16]], ({ [0] = 20, [1] = 110, [2] = 95, [3] = 27 })[R[16]] })
        game.create_tube({ ({ [0] = 191, [1] = 209, [2] = 50, [3] = 45 })[R[16]], ({ [0] = 28, [1] = 118, [2] = 103, [3] = 35 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 186, [1] = 204, [2] = 45, [3] = 40 })[R[16]], ({ [0] = 14, [1] = 104, [2] = 89, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 186, [1] = 204, [2] = 45, [3] = 40 })[R[16]], ({ [0] = 15, [1] = 105, [2] = 90, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 186, [1] = 204, [2] = 45, [3] = 40 })[R[16]], ({ [0] = 21, [1] = 111, [2] = 96, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 186, [1] = 204, [2] = 45, [3] = 40 })[R[16]], ({ [0] = 29, [1] = 119, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 187, [1] = 205, [2] = 46, [3] = 41 })[R[16]], ({ [0] = 15, [1] = 105, [2] = 90, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 187, [1] = 205, [2] = 46, [3] = 41 })[R[16]], ({ [0] = 21, [1] = 111, [2] = 96, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 187, [1] = 205, [2] = 46, [3] = 41 })[R[16]], ({ [0] = 29, [1] = 119, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 188, [1] = 206, [2] = 47, [3] = 42 })[R[16]], ({ [0] = 15, [1] = 105, [2] = 90, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 188, [1] = 206, [2] = 47, [3] = 42 })[R[16]], ({ [0] = 21, [1] = 111, [2] = 96, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 188, [1] = 206, [2] = 47, [3] = 42 })[R[16]], ({ [0] = 29, [1] = 119, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 189, [1] = 207, [2] = 48, [3] = 43 })[R[16]], ({ [0] = 20, [1] = 110, [2] = 95, [3] = 27 })[R[16]] })
        game.create_tube({ ({ [0] = 189, [1] = 207, [2] = 48, [3] = 43 })[R[16]], ({ [0] = 21, [1] = 111, [2] = 96, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 189, [1] = 207, [2] = 48, [3] = 43 })[R[16]], ({ [0] = 22, [1] = 112, [2] = 97, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 189, [1] = 207, [2] = 48, [3] = 43 })[R[16]], ({ [0] = 23, [1] = 113, [2] = 98, [3] = 30 })[R[16]] })
        game.create_tube({ ({ [0] = 189, [1] = 207, [2] = 48, [3] = 43 })[R[16]], ({ [0] = 28, [1] = 118, [2] = 103, [3] = 35 })[R[16]] })
        game.create_tube({ ({ [0] = 189, [1] = 207, [2] = 48, [3] = 43 })[R[16]], ({ [0] = 29, [1] = 119, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 190, [1] = 208, [2] = 49, [3] = 44 })[R[16]], ({ [0] = 20, [1] = 110, [2] = 95, [3] = 27 })[R[16]] })
        game.create_tube({ ({ [0] = 190, [1] = 208, [2] = 49, [3] = 44 })[R[16]], ({ [0] = 28, [1] = 118, [2] = 103, [3] = 35 })[R[16]] })
        game.create_tube({ ({ [0] = 191, [1] = 209, [2] = 50, [3] = 45 })[R[16]], ({ [0] = 18, [1] = 108, [2] = 93, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 191, [1] = 209, [2] = 50, [3] = 45 })[R[16]], ({ [0] = 19, [1] = 109, [2] = 94, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 191, [1] = 209, [2] = 50, [3] = 45 })[R[16]], ({ [0] = 20, [1] = 110, [2] = 95, [3] = 27 })[R[16]] })
        game.create_tube({ ({ [0] = 191, [1] = 209, [2] = 50, [3] = 45 })[R[16]], ({ [0] = 28, [1] = 118, [2] = 103, [3] = 35 })[R[16]] })
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 184, [1] = 202, [2] = 43, [3] = 38 }, [1] = { [0] = 175, [1] = 193, [2] = 34, [3] = 29 }, [2] = { [0] = 183, [1] = 201, [2] = 42, [3] = 37 } })[R[31]][R[16]], ({ [0] = { [0] = 12, [1] = 102, [2] = 87, [3] = 19 }, [1] = { [0] = 20, [1] = 110, [2] = 95, [3] = 27 }, [2] = { [0] = 15, [1] = 105, [2] = 90, [3] = 22 } })[R[31]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 185, [1] = 202, [2] = 45, [3] = 40 })[R[16]], ({ [0] = 19, [1] = 114, [2] = 98, [3] = 30 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 202, [2] = 45, [3] = 40 })[R[16]], ({ [0] = 20, [1] = 115, [2] = 99, [3] = 31 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 185, [1] = 202, [2] = 45, [3] = 40 })[R[16]], ({ [0] = 19, [1] = 114, [2] = 98, [3] = 30 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 202, [2] = 45, [3] = 40 })[R[16]], ({ [0] = 20, [1] = 115, [2] = 99, [3] = 31 })[R[16]] })
        for i = 1, game.initial_units() do
          R[32] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 181, [1] = 198, [2] = 41, [3] = 36 }, [1] = { [0] = 164, [1] = 181, [2] = 24, [3] = 19 }, [2] = { [0] = 186, [1] = 203, [2] = 46, [3] = 41 } })[R[32]][R[16]], ({ [0] = { [0] = 26, [1] = 121, [2] = 105, [3] = 37 }, [1] = { [0] = 13, [1] = 108, [2] = 92, [3] = 24 }, [2] = { [0] = 26, [1] = 121, [2] = 105, [3] = 37 } })[R[32]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 193, [1] = 209, [2] = 52, [3] = 47 })[R[16]], ({ [0] = 15, [1] = 112, [2] = 91, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 194, [1] = 210, [2] = 53, [3] = 48 })[R[16]], ({ [0] = 15, [1] = 112, [2] = 91, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 195, [1] = 211, [2] = 54, [3] = 49 })[R[16]], ({ [0] = 15, [1] = 112, [2] = 91, [3] = 23 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 193, [1] = 209, [2] = 52, [3] = 47 })[R[16]], ({ [0] = 15, [1] = 112, [2] = 91, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 194, [1] = 210, [2] = 53, [3] = 48 })[R[16]], ({ [0] = 15, [1] = 112, [2] = 91, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 195, [1] = 211, [2] = 54, [3] = 49 })[R[16]], ({ [0] = 15, [1] = 112, [2] = 91, [3] = 23 })[R[16]] })
        for i = 1, game.initial_units() do
          R[33] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 174, [1] = 190, [2] = 33, [3] = 28 }, [1] = { [0] = 179, [1] = 195, [2] = 38, [3] = 33 }, [2] = { [0] = 200, [1] = 216, [2] = 59, [3] = 54 } })[R[33]][R[16]], ({ [0] = { [0] = 5, [1] = 102, [2] = 81, [3] = 13 }, [1] = { [0] = 3, [1] = 100, [2] = 79, [3] = 11 }, [2] = { [0] = 18, [1] = 115, [2] = 94, [3] = 26 } })[R[33]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 177, [1] = 193, [2] = 36, [3] = 31 })[R[16]], ({ [0] = 19, [1] = 110, [2] = 94, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 177, [1] = 193, [2] = 36, [3] = 31 })[R[16]], ({ [0] = 20, [1] = 111, [2] = 95, [3] = 27 })[R[16]] })
        game.create_tube({ ({ [0] = 177, [1] = 193, [2] = 36, [3] = 31 })[R[16]], ({ [0] = 21, [1] = 112, [2] = 96, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 177, [1] = 193, [2] = 36, [3] = 31 })[R[16]], ({ [0] = 25, [1] = 116, [2] = 100, [3] = 32 })[R[16]] })
        game.create_tube({ ({ [0] = 177, [1] = 193, [2] = 36, [3] = 31 })[R[16]], ({ [0] = 26, [1] = 117, [2] = 101, [3] = 33 })[R[16]] })
        game.create_tube({ ({ [0] = 177, [1] = 193, [2] = 36, [3] = 31 })[R[16]], ({ [0] = 27, [1] = 118, [2] = 102, [3] = 34 })[R[16]] })
        game.create_tube({ ({ [0] = 177, [1] = 193, [2] = 36, [3] = 31 })[R[16]], ({ [0] = 28, [1] = 119, [2] = 103, [3] = 35 })[R[16]] })
        game.create_tube({ ({ [0] = 177, [1] = 193, [2] = 36, [3] = 31 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 178, [1] = 194, [2] = 37, [3] = 32 })[R[16]], ({ [0] = 16, [1] = 107, [2] = 91, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 178, [1] = 194, [2] = 37, [3] = 32 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 179, [1] = 195, [2] = 38, [3] = 33 })[R[16]], ({ [0] = 16, [1] = 107, [2] = 91, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 179, [1] = 195, [2] = 38, [3] = 33 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 180, [1] = 196, [2] = 39, [3] = 34 })[R[16]], ({ [0] = 16, [1] = 107, [2] = 91, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 180, [1] = 196, [2] = 39, [3] = 34 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 181, [1] = 197, [2] = 40, [3] = 35 })[R[16]], ({ [0] = 16, [1] = 107, [2] = 91, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 181, [1] = 197, [2] = 40, [3] = 35 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 182, [1] = 198, [2] = 41, [3] = 36 })[R[16]], ({ [0] = 16, [1] = 107, [2] = 91, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 182, [1] = 198, [2] = 41, [3] = 36 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 183, [1] = 199, [2] = 42, [3] = 37 })[R[16]], ({ [0] = 16, [1] = 107, [2] = 91, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 183, [1] = 199, [2] = 42, [3] = 37 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 18, [1] = 109, [2] = 93, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 19, [1] = 110, [2] = 94, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 20, [1] = 111, [2] = 95, [3] = 27 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 21, [1] = 112, [2] = 96, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 22, [1] = 113, [2] = 97, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 23, [1] = 114, [2] = 98, [3] = 30 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 24, [1] = 115, [2] = 99, [3] = 31 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 25, [1] = 116, [2] = 100, [3] = 32 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 26, [1] = 117, [2] = 101, [3] = 33 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 177, [1] = 193, [2] = 36, [3] = 31 })[R[16]], ({ [0] = 19, [1] = 110, [2] = 94, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 177, [1] = 193, [2] = 36, [3] = 31 })[R[16]], ({ [0] = 20, [1] = 111, [2] = 95, [3] = 27 })[R[16]] })
        game.create_tube({ ({ [0] = 177, [1] = 193, [2] = 36, [3] = 31 })[R[16]], ({ [0] = 21, [1] = 112, [2] = 96, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 177, [1] = 193, [2] = 36, [3] = 31 })[R[16]], ({ [0] = 25, [1] = 116, [2] = 100, [3] = 32 })[R[16]] })
        game.create_tube({ ({ [0] = 177, [1] = 193, [2] = 36, [3] = 31 })[R[16]], ({ [0] = 26, [1] = 117, [2] = 101, [3] = 33 })[R[16]] })
        game.create_tube({ ({ [0] = 177, [1] = 193, [2] = 36, [3] = 31 })[R[16]], ({ [0] = 27, [1] = 118, [2] = 102, [3] = 34 })[R[16]] })
        game.create_tube({ ({ [0] = 177, [1] = 193, [2] = 36, [3] = 31 })[R[16]], ({ [0] = 28, [1] = 119, [2] = 103, [3] = 35 })[R[16]] })
        game.create_tube({ ({ [0] = 177, [1] = 193, [2] = 36, [3] = 31 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 178, [1] = 194, [2] = 37, [3] = 32 })[R[16]], ({ [0] = 16, [1] = 107, [2] = 91, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 178, [1] = 194, [2] = 37, [3] = 32 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 179, [1] = 195, [2] = 38, [3] = 33 })[R[16]], ({ [0] = 16, [1] = 107, [2] = 91, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 179, [1] = 195, [2] = 38, [3] = 33 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 180, [1] = 196, [2] = 39, [3] = 34 })[R[16]], ({ [0] = 16, [1] = 107, [2] = 91, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 180, [1] = 196, [2] = 39, [3] = 34 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 181, [1] = 197, [2] = 40, [3] = 35 })[R[16]], ({ [0] = 16, [1] = 107, [2] = 91, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 181, [1] = 197, [2] = 40, [3] = 35 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 182, [1] = 198, [2] = 41, [3] = 36 })[R[16]], ({ [0] = 16, [1] = 107, [2] = 91, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 182, [1] = 198, [2] = 41, [3] = 36 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 183, [1] = 199, [2] = 42, [3] = 37 })[R[16]], ({ [0] = 16, [1] = 107, [2] = 91, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 183, [1] = 199, [2] = 42, [3] = 37 })[R[16]], ({ [0] = 29, [1] = 120, [2] = 104, [3] = 36 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 18, [1] = 109, [2] = 93, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 19, [1] = 110, [2] = 94, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 20, [1] = 111, [2] = 95, [3] = 27 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 21, [1] = 112, [2] = 96, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 22, [1] = 113, [2] = 97, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 23, [1] = 114, [2] = 98, [3] = 30 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 24, [1] = 115, [2] = 99, [3] = 31 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 25, [1] = 116, [2] = 100, [3] = 32 })[R[16]] })
        game.create_tube({ ({ [0] = 185, [1] = 201, [2] = 44, [3] = 39 })[R[16]], ({ [0] = 26, [1] = 117, [2] = 101, [3] = 33 })[R[16]] })
        for i = 1, game.initial_units() do
          R[34] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 175, [1] = 191, [2] = 34, [3] = 29 }, [1] = { [0] = 181, [1] = 197, [2] = 40, [3] = 35 }, [2] = { [0] = 169, [1] = 185, [2] = 28, [3] = 23 } })[R[34]][R[16]], ({ [0] = { [0] = 12, [1] = 103, [2] = 87, [3] = 19 }, [1] = { [0] = 12, [1] = 103, [2] = 87, [3] = 19 }, [2] = { [0] = 33, [1] = 124, [2] = 108, [3] = 40 } })[R[34]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[26]", R[26])
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
    R[17] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 24, [1] = 86, [2] = 101, [3] = 11 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 24, [1] = 86, [2] = 101, [3] = 11 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[17]][R[16]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 29, [1] = 32, [2] = 188, [3] = 165 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 21, [1] = 83, [2] = 98, [3] = 7 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 36, [1] = 103, [2] = 118, [3] = 28 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    if R[17] == 0 or R[17] == 1 or R[17] == 2 or R[17] == 5 or R[17] == 6 or R[17] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 54, [1] = 54, [2] = 207, [3] = 192 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 32, [1] = 35, [2] = 191, [3] = 168 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 43, [1] = 48, [2] = 205, [3] = 189 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 28, [1] = 90, [2] = 105, [3] = 14 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [5] = { [0] = 33, [1] = 101, [2] = 117, [3] = 22 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 0 then
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
      elseif R[17] == 1 then
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
      elseif R[17] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 31, [1] = 31, [2] = 184, [3] = 169 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 34, [1] = 39, [2] = 196, [3] = 180 }, [7] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 38, [1] = 100, [2] = 115, [3] = 24 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 35, [1] = 103, [2] = 119, [3] = 28 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 2 or R[17] == 5 or R[17] == 6 or R[17] == 7 then
      elseif R[17] == 0 or R[17] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 } })[R[17]][R[16]], ({ [0] = { [0] = 38, [1] = 103, [2] = 125, [3] = 28 }, [1] = { [0] = 46, [1] = 108, [2] = 123, [3] = 32 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[17]", R[17])
      end
    elseif R[17] == 3 or R[17] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 } })[R[17]][R[16]], ({ [3] = { [0] = 36, [1] = 103, [2] = 118, [3] = 28 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 115, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[17] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 30, [1] = 38, [2] = 194, [3] = 175 })[R[16]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[17]", R[17])
      end
    else
      unseen("R[17]", R[17])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 31, [1] = 31, [2] = 184, [3] = 169 }, [1] = { [0] = 28, [1] = 31, [2] = 187, [3] = 169 }, [2] = { [0] = 49, [1] = 52, [2] = 208, [3] = 185 }, [3] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [4] = { [0] = 26, [1] = 31, [2] = 190, [3] = 172 }, [5] = { [0] = 20, [1] = 25, [2] = 182, [3] = 165 }, [6] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 }, [7] = { [0] = 32, [1] = 37, [2] = 194, [3] = 178 } })[R[17]][R[16]], ({ [0] = { [0] = 40, [1] = 105, [2] = 127, [3] = 30 }, [1] = { [0] = 43, [1] = 105, [2] = 120, [3] = 29 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 19, [1] = 86, [2] = 101, [3] = 11 }, [4] = { [0] = 24, [1] = 92, [2] = 107, [3] = 17 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 39, [1] = 107, [2] = 123, [3] = 32 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 38, [1] = 38, [2] = 191, [3] = 176 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 44, [1] = 49, [2] = 208, [3] = 190 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 33, [1] = 95, [2] = 110, [3] = 20 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 19, [1] = 87, [2] = 103, [3] = 8 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 28, [1] = 36, [2] = 192, [3] = 173 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 27, [1] = 89, [2] = 104, [3] = 13 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[17] == 0 or R[17] == 1 or R[17] == 2 or R[17] == 4 or R[17] == 5 or R[17] == 6 or R[17] == 7 then
    elseif R[17] == 3 then
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 45, [1] = 53, [2] = 209, [3] = 190 })[R[16]], ({ [0] = 26, [1] = 93, [2] = 108, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 22, [1] = 89, [2] = 104, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    else
      unseen("R[17]", R[17])
    end
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[17]][R[16]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[17]][R[16]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[17] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 36, [1] = 36, [2] = 189, [3] = 174 })[R[16]], ({ [0] = 27, [1] = 92, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 36, [1] = 36, [2] = 189, [3] = 174 })[R[16]], ({ [0] = 27, [1] = 92, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 47, [1] = 47, [2] = 200, [3] = 185 })[R[16]], ({ [0] = 33, [1] = 98, [2] = 120, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 33, [1] = 33, [2] = 186, [3] = 171 })[R[16]], ({ [0] = 27, [1] = 92, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 33, [1] = 33, [2] = 186, [3] = 171 })[R[16]], ({ [0] = 24, [1] = 89, [2] = 111, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 36, [1] = 36, [2] = 189, [3] = 174 })[R[16]], ({ [0] = 27, [1] = 92, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 47, [1] = 47, [2] = 200, [3] = 185 })[R[16]], ({ [0] = 33, [1] = 98, [2] = 120, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 33, [1] = 33, [2] = 186, [3] = 171 })[R[16]], ({ [0] = 27, [1] = 92, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 33, [1] = 33, [2] = 186, [3] = 171 })[R[16]], ({ [0] = 24, [1] = 89, [2] = 111, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 33, [1] = 33, [2] = 186, [3] = 171 })[R[16]], ({ [0] = 27, [1] = 92, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 33, [1] = 33, [2] = 186, [3] = 171 })[R[16]], ({ [0] = 24, [1] = 89, [2] = 111, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 27, [1] = 30, [2] = 186, [3] = 168 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 30, [1] = 33, [2] = 189, [3] = 171 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 27, [1] = 30, [2] = 186, [3] = 168 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 33, [2] = 189, [3] = 171 })[R[16]], ({ [0] = 23, [1] = 85, [2] = 100, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 33, [1] = 36, [2] = 192, [3] = 174 })[R[16]], ({ [0] = 20, [1] = 82, [2] = 97, [3] = 6 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 27, [1] = 30, [2] = 186, [3] = 168 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 30, [1] = 33, [2] = 189, [3] = 171 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 33, [2] = 189, [3] = 171 })[R[16]], ({ [0] = 23, [1] = 85, [2] = 100, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 33, [1] = 36, [2] = 192, [3] = 174 })[R[16]], ({ [0] = 20, [1] = 82, [2] = 97, [3] = 6 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 33, [2] = 189, [3] = 171 })[R[16]], ({ [0] = 23, [1] = 85, [2] = 100, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 33, [1] = 36, [2] = 192, [3] = 174 })[R[16]], ({ [0] = 20, [1] = 82, [2] = 97, [3] = 6 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 45, [1] = 48, [2] = 204, [3] = 181 })[R[16]], ({ [0] = 31, [1] = 93, [2] = 108, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 45, [1] = 48, [2] = 204, [3] = 181 })[R[16]], ({ [0] = 31, [1] = 93, [2] = 108, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 27, [1] = 30, [2] = 186, [3] = 163 })[R[16]], ({ [0] = 34, [1] = 96, [2] = 111, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 45, [1] = 48, [2] = 204, [3] = 181 })[R[16]], ({ [0] = 37, [1] = 99, [2] = 114, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[16]], ({ [0] = 38, [1] = 100, [2] = 115, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 45, [1] = 48, [2] = 204, [3] = 181 })[R[16]], ({ [0] = 31, [1] = 93, [2] = 108, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 27, [1] = 30, [2] = 186, [3] = 163 })[R[16]], ({ [0] = 34, [1] = 96, [2] = 111, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 45, [1] = 48, [2] = 204, [3] = 181 })[R[16]], ({ [0] = 37, [1] = 99, [2] = 114, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[16]], ({ [0] = 38, [1] = 100, [2] = 115, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 45, [1] = 48, [2] = 204, [3] = 181 })[R[16]], ({ [0] = 37, [1] = 99, [2] = 114, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[16]], ({ [0] = 38, [1] = 100, [2] = 115, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 3 then
      if LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 33, [2] = 189, [3] = 170 })[R[16]], ({ [0] = 26, [1] = 93, [2] = 108, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 39, [2] = 195, [3] = 176 })[R[16]], ({ [0] = 37, [1] = 104, [2] = 119, [3] = 29 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 33, [2] = 189, [3] = 170 })[R[16]], ({ [0] = 26, [1] = 93, [2] = 108, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 33, [2] = 189, [3] = 170 })[R[16]], ({ [0] = 26, [1] = 93, [2] = 108, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 39, [2] = 195, [3] = 176 })[R[16]], ({ [0] = 37, [1] = 104, [2] = 119, [3] = 29 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 46, [1] = 51, [2] = 210, [3] = 192 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 46, [1] = 51, [2] = 210, [3] = 192 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 38, [1] = 43, [2] = 202, [3] = 184 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 39, [1] = 44, [2] = 203, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 115, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 106, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 46, [1] = 51, [2] = 210, [3] = 192 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 38, [1] = 43, [2] = 202, [3] = 184 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 39, [1] = 44, [2] = 203, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 115, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 106, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 39, [1] = 44, [2] = 203, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 115, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 106, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 5 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 38, [1] = 43, [2] = 200, [3] = 183 })[R[16]], ({ [0] = 21, [1] = 89, [2] = 105, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 38, [1] = 43, [2] = 200, [3] = 183 })[R[16]], ({ [0] = 21, [1] = 89, [2] = 105, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 26, [1] = 31, [2] = 188, [3] = 171 })[R[16]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 25, [1] = 30, [2] = 187, [3] = 170 })[R[16]], ({ [0] = 18, [1] = 86, [2] = 102, [3] = 7 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 34, [1] = 39, [2] = 196, [3] = 179 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 38, [1] = 43, [2] = 200, [3] = 183 })[R[16]], ({ [0] = 21, [1] = 89, [2] = 105, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 26, [1] = 31, [2] = 188, [3] = 171 })[R[16]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 25, [1] = 30, [2] = 187, [3] = 170 })[R[16]], ({ [0] = 18, [1] = 86, [2] = 102, [3] = 7 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 34, [1] = 39, [2] = 196, [3] = 179 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 25, [1] = 30, [2] = 187, [3] = 170 })[R[16]], ({ [0] = 18, [1] = 86, [2] = 102, [3] = 7 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 34, [1] = 39, [2] = 196, [3] = 179 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 117, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 117, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 46, [1] = 51, [2] = 208, [3] = 192 })[R[16]], ({ [0] = 15, [1] = 83, [2] = 104, [3] = 7 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 38, [1] = 43, [2] = 200, [3] = 184 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 111, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 117, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 46, [1] = 51, [2] = 208, [3] = 192 })[R[16]], ({ [0] = 15, [1] = 83, [2] = 104, [3] = 7 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 38, [1] = 43, [2] = 200, [3] = 184 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 111, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 38, [1] = 43, [2] = 200, [3] = 184 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 111, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 7 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 42, [1] = 47, [2] = 204, [3] = 188 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 42, [1] = 47, [2] = 204, [3] = 188 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 41, [1] = 46, [2] = 203, [3] = 187 })[R[16]], ({ [0] = 24, [1] = 92, [2] = 108, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 26, [1] = 31, [2] = 188, [3] = 172 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 183, [3] = 167 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 42, [1] = 47, [2] = 204, [3] = 188 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 41, [1] = 46, [2] = 203, [3] = 187 })[R[16]], ({ [0] = 24, [1] = 92, [2] = 108, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 26, [1] = 31, [2] = 188, [3] = 172 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 183, [3] = 167 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 26, [1] = 31, [2] = 188, [3] = 172 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 183, [3] = 167 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[17]", R[17])
    end
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 54, [1] = 54, [2] = 207, [3] = 192 }, [1] = { [0] = 36, [1] = 39, [2] = 195, [3] = 177 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 47, [1] = 52, [2] = 211, [3] = 193 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 35, [1] = 40, [2] = 197, [3] = 181 } })[R[17]][R[16]], ({ [0] = { [0] = 35, [1] = 100, [2] = 122, [3] = 25 }, [1] = { [0] = 33, [1] = 95, [2] = 110, [3] = 19 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 23, [1] = 90, [2] = 105, [3] = 15 }, [4] = { [0] = 19, [1] = 87, [2] = 102, [3] = 12 }, [5] = { [0] = 35, [1] = 103, [2] = 119, [3] = 24 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 29, [1] = 97, [2] = 113, [3] = 22 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 34, [1] = 34, [2] = 187, [3] = 172 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 32, [1] = 35, [2] = 191, [3] = 168 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 22, [1] = 90, [2] = 105, [3] = 15 }, [5] = { [0] = 24, [1] = 92, [2] = 108, [3] = 13 }, [6] = { [0] = 17, [1] = 85, [2] = 106, [3] = 9 }, [7] = { [0] = 26, [1] = 94, [2] = 110, [3] = 19 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 35, [2] = 188, [3] = 173 }, [1] = { [0] = 31, [1] = 34, [2] = 190, [3] = 172 }, [2] = { [0] = 33, [1] = 36, [2] = 192, [3] = 169 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 33, [1] = 100, [2] = 115, [3] = 25 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 25, [1] = 93, [2] = 109, [3] = 14 }, [6] = { [0] = 18, [1] = 86, [2] = 107, [3] = 10 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 32, [1] = 35, [2] = 191, [3] = 173 }, [2] = { [0] = 34, [1] = 37, [2] = 193, [3] = 170 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 34, [1] = 101, [2] = 116, [3] = 26 }, [4] = { [0] = 24, [1] = 92, [2] = 107, [3] = 17 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 19, [1] = 87, [2] = 108, [3] = 11 }, [7] = { [0] = 28, [1] = 96, [2] = 112, [3] = 21 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 37, [2] = 190, [3] = 175 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 28, [1] = 36, [2] = 192, [3] = 173 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 26, [1] = 88, [2] = 103, [3] = 13 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 25, [1] = 93, [2] = 108, [3] = 18 }, [5] = { [0] = 30, [1] = 98, [2] = 114, [3] = 19 }, [6] = { [0] = 20, [1] = 88, [2] = 109, [3] = 12 }, [7] = { [0] = 29, [1] = 97, [2] = 113, [3] = 22 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 38, [2] = 191, [3] = 176 }, [1] = { [0] = 34, [1] = 37, [2] = 193, [3] = 175 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 27, [1] = 89, [2] = 104, [3] = 14 }, [3] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [4] = { [0] = 26, [1] = 94, [2] = 109, [3] = 19 }, [5] = { [0] = 31, [1] = 99, [2] = 115, [3] = 20 }, [6] = { [0] = 21, [1] = 89, [2] = 110, [3] = 13 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 39, [2] = 192, [3] = 177 }, [1] = { [0] = 35, [1] = 38, [2] = 194, [3] = 176 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 36, [1] = 41, [2] = 198, [3] = 182 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 28, [1] = 90, [2] = 105, [3] = 15 }, [3] = { [0] = 29, [1] = 96, [2] = 111, [3] = 21 }, [4] = { [0] = 30, [1] = 98, [2] = 113, [3] = 23 }, [5] = { [0] = 32, [1] = 100, [2] = 116, [3] = 21 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 31, [1] = 99, [2] = 115, [3] = 24 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 40, [1] = 40, [2] = 193, [3] = 178 }, [1] = { [0] = 36, [1] = 39, [2] = 195, [3] = 177 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 33, [1] = 38, [2] = 195, [3] = 178 }, [6] = { [0] = 37, [1] = 42, [2] = 199, [3] = 183 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 30, [1] = 97, [2] = 112, [3] = 22 }, [4] = { [0] = 31, [1] = 99, [2] = 114, [3] = 24 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 33, [1] = 38, [2] = 195, [3] = 178 }, [6] = { [0] = 37, [1] = 42, [2] = 199, [3] = 183 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 91, [2] = 113, [3] = 16 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 30, [1] = 92, [2] = 107, [3] = 17 }, [3] = { [0] = 31, [1] = 98, [2] = 113, [3] = 23 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 33, [1] = 101, [2] = 117, [3] = 26 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 24, [1] = 86, [2] = 101, [3] = 10 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 33, [1] = 101, [2] = 116, [3] = 26 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 34, [1] = 102, [2] = 118, [3] = 27 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 30, [1] = 38, [2] = 194, [3] = 175 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 27, [1] = 32, [2] = 189, [3] = 173 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 93, [2] = 115, [3] = 18 }, [1] = { [0] = 25, [1] = 87, [2] = 102, [3] = 11 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 19 }, [3] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [4] = { [0] = 34, [1] = 102, [2] = 117, [3] = 27 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 30, [1] = 38, [2] = 194, [3] = 175 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 35, [1] = 40, [2] = 197, [3] = 180 }, [6] = { [0] = 39, [1] = 44, [2] = 201, [3] = 185 }, [7] = { [0] = 27, [1] = 32, [2] = 189, [3] = 173 } })[R[17]][R[16]], ({ [0] = { [0] = 29, [1] = 94, [2] = 116, [3] = 19 }, [1] = { [0] = 26, [1] = 88, [2] = 103, [3] = 12 }, [2] = { [0] = 33, [1] = 95, [2] = 110, [3] = 20 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 35, [1] = 40, [2] = 197, [3] = 180 }, [6] = { [0] = 39, [1] = 44, [2] = 201, [3] = 185 }, [7] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 } })[R[17]][R[16]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 32, [1] = 40, [2] = 196, [3] = 177 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [6] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 }, [7] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 } })[R[17]][R[16]], ({ [0] = { [0] = 34, [1] = 99, [2] = 121, [3] = 24 }, [1] = { [0] = 31, [1] = 93, [2] = 108, [3] = 17 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 36, [1] = 39, [2] = 195, [3] = 172 }, [3] = { [0] = 33, [1] = 41, [2] = 197, [3] = 178 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [6] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 }, [7] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 } })[R[17]][R[16]], ({ [0] = { [0] = 35, [1] = 100, [2] = 122, [3] = 25 }, [1] = { [0] = 32, [1] = 94, [2] = 109, [3] = 18 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 36, [1] = 39, [2] = 195, [3] = 172 }, [3] = { [0] = 33, [1] = 41, [2] = 197, [3] = 178 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 37, [1] = 42, [2] = 199, [3] = 182 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 } })[R[17]][R[16]], ({ [0] = { [0] = 36, [1] = 101, [2] = 123, [3] = 26 }, [1] = { [0] = 33, [1] = 95, [2] = 110, [3] = 19 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 17, [1] = 85, [2] = 106, [3] = 9 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 45, [2] = 198, [3] = 183 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 34, [1] = 42, [2] = 198, [3] = 179 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 37, [1] = 42, [2] = 199, [3] = 182 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 30, [1] = 35, [2] = 192, [3] = 176 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 18, [1] = 86, [2] = 107, [3] = 10 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 46, [2] = 199, [3] = 184 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 30, [1] = 35, [2] = 192, [3] = 176 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 35, [1] = 97, [2] = 112, [3] = 21 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 19, [1] = 87, [2] = 108, [3] = 11 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 38, [1] = 41, [2] = 197, [3] = 174 }, [3] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 39, [1] = 44, [2] = 201, [3] = 184 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 36, [1] = 98, [2] = 113, [3] = 22 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 21, [1] = 89, [2] = 104, [3] = 14 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 20, [1] = 88, [2] = 109, [3] = 12 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 48, [2] = 201, [3] = 186 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 38, [1] = 41, [2] = 197, [3] = 174 }, [3] = { [0] = 37, [1] = 45, [2] = 201, [3] = 182 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 41, [1] = 103, [2] = 118, [3] = 27 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 21, [1] = 89, [2] = 110, [3] = 13 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 49, [1] = 49, [2] = 202, [3] = 187 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 39, [1] = 42, [2] = 198, [3] = 175 }, [3] = { [0] = 38, [1] = 46, [2] = 202, [3] = 183 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 42, [1] = 104, [2] = 119, [3] = 28 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 25, [1] = 93, [2] = 109, [3] = 18 } })[R[17]][R[16]] })
    if R[17] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 50, [1] = 50, [2] = 203, [3] = 188 })[R[16]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 51, [1] = 51, [2] = 204, [3] = 189 })[R[16]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 50, [1] = 50, [2] = 203, [3] = 188 })[R[16]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 51, [1] = 51, [2] = 204, [3] = 189 })[R[16]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[16]] })
        for i = 1, game.initial_units() do
          R[37] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 48, [1] = 48, [2] = 201, [3] = 186 }, [1] = { [0] = 35, [1] = 35, [2] = 188, [3] = 173 }, [2] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 } })[R[37]][R[16]], ({ [0] = { [0] = 25, [1] = 90, [2] = 112, [3] = 15 }, [1] = { [0] = 34, [1] = 99, [2] = 121, [3] = 24 }, [2] = { [0] = 37, [1] = 102, [2] = 124, [3] = 27 } })[R[37]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 44, [1] = 106, [2] = 121, [3] = 30 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 44, [1] = 106, [2] = 121, [3] = 30 })[R[16]] })
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 188, [3] = 170 }, [1] = { [0] = 31, [1] = 34, [2] = 190, [3] = 172 }, [2] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 } })[R[38]][R[16]], ({ [0] = { [0] = 38, [1] = 100, [2] = 115, [3] = 24 }, [1] = { [0] = 40, [1] = 102, [2] = 117, [3] = 26 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 18 } })[R[38]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 30, [1] = 33, [2] = 189, [3] = 166 }, [1] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [2] = { [0] = 48, [1] = 51, [2] = 207, [3] = 184 } })[R[39]][R[16]], ({ [0] = { [0] = 23, [1] = 85, [2] = 100, [3] = 10 }, [1] = { [0] = 39, [1] = 101, [2] = 116, [3] = 26 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 19 } })[R[39]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 46, [2] = 202, [3] = 183 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 47, [2] = 203, [3] = 184 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 48, [2] = 204, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 29, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 30, [1] = 97, [2] = 112, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 31, [1] = 98, [2] = 113, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 33, [1] = 100, [2] = 115, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 34, [1] = 101, [2] = 116, [3] = 26 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 46, [2] = 202, [3] = 183 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 47, [2] = 203, [3] = 184 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 48, [2] = 204, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 29, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 30, [1] = 97, [2] = 112, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 31, [1] = 98, [2] = 113, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 33, [1] = 100, [2] = 115, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 34, [1] = 101, [2] = 116, [3] = 26 })[R[16]] })
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [1] = { [0] = 37, [1] = 45, [2] = 201, [3] = 182 }, [2] = { [0] = 24, [1] = 32, [2] = 188, [3] = 169 } })[R[40]][R[16]], ({ [0] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [1] = { [0] = 35, [1] = 102, [2] = 117, [3] = 27 }, [2] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 } })[R[40]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 21, [1] = 89, [2] = 104, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 29, [1] = 97, [2] = 112, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 113, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 108, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 109, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 21, [1] = 89, [2] = 104, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 29, [1] = 97, [2] = 112, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 113, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 108, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 109, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
        for i = 1, game.initial_units() do
          R[41] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [1] = { [0] = 29, [1] = 34, [2] = 193, [3] = 175 }, [2] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 } })[R[41]][R[16]], ({ [0] = { [0] = 19, [1] = 87, [2] = 102, [3] = 12 }, [1] = { [0] = 27, [1] = 95, [2] = 110, [3] = 20 }, [2] = { [0] = 22, [1] = 90, [2] = 105, [3] = 15 } })[R[41]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 20 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 20 })[R[16]] })
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [1] = { [0] = 19, [1] = 24, [2] = 181, [3] = 164 }, [2] = { [0] = 41, [1] = 46, [2] = 203, [3] = 186 } })[R[42]][R[16]], ({ [0] = { [0] = 37, [1] = 105, [2] = 121, [3] = 26 }, [1] = { [0] = 24, [1] = 92, [2] = 108, [3] = 13 }, [2] = { [0] = 37, [1] = 105, [2] = 121, [3] = 26 } })[R[42]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 48, [1] = 53, [2] = 210, [3] = 194 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 49, [1] = 54, [2] = 211, [3] = 195 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 48, [1] = 53, [2] = 210, [3] = 194 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 49, [1] = 54, [2] = 211, [3] = 195 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
        for i = 1, game.initial_units() do
          R[43] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 }, [1] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [2] = { [0] = 54, [1] = 59, [2] = 216, [3] = 200 } })[R[43]][R[16]], ({ [0] = { [0] = 13, [1] = 81, [2] = 102, [3] = 5 }, [1] = { [0] = 11, [1] = 79, [2] = 100, [3] = 3 }, [2] = { [0] = 26, [1] = 94, [2] = 115, [3] = 18 } })[R[43]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 34, [1] = 102, [2] = 118, [3] = 27 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 119, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 109, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 34, [1] = 102, [2] = 118, [3] = 27 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 119, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 109, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[16]] })
        for i = 1, game.initial_units() do
          R[44] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 }, [1] = { [0] = 35, [1] = 40, [2] = 197, [3] = 181 }, [2] = { [0] = 23, [1] = 28, [2] = 185, [3] = 169 } })[R[44]][R[16]], ({ [0] = { [0] = 19, [1] = 87, [2] = 103, [3] = 12 }, [1] = { [0] = 19, [1] = 87, [2] = 103, [3] = 12 }, [2] = { [0] = 40, [1] = 108, [2] = 124, [3] = 33 } })[R[44]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[17]", R[17])
    end
    R[26] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 27, [2] = 35, [3] = 35, [4] = 34, [5] = 30, [6] = 33, [7] = 31 }, [1] = { [0] = 42, [1] = 30, [2] = 38, [3] = 43, [4] = 39, [5] = 35, [6] = 38, [7] = 36 }, [2] = { [0] = 195, [1] = 186, [2] = 194, [3] = 199, [4] = 198, [5] = 192, [6] = 195, [7] = 193 }, [3] = { [0] = 180, [1] = 168, [2] = 171, [3] = 180, [4] = 180, [5] = 175, [6] = 179, [7] = 177 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 24, [3] = 32, [4] = 28, [5] = 28, [6] = 15, [7] = 30 }, [1] = { [0] = 96, [1] = 96, [2] = 86, [3] = 99, [4] = 96, [5] = 96, [6] = 83, [7] = 98 }, [2] = { [0] = 118, [1] = 111, [2] = 101, [3] = 114, [4] = 111, [5] = 112, [6] = 104, [7] = 114 }, [3] = { [0] = 21, [1] = 20, [2] = 11, [3] = 24, [4] = 21, [5] = 17, [6] = 7, [7] = 23 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 42, [1] = 27, [2] = 35, [3] = 35, [4] = 34, [5] = 30, [6] = 33, [7] = 31 }, [1] = { [0] = 42, [1] = 30, [2] = 38, [3] = 43, [4] = 39, [5] = 35, [6] = 38, [7] = 36 }, [2] = { [0] = 195, [1] = 186, [2] = 194, [3] = 199, [4] = 198, [5] = 192, [6] = 195, [7] = 193 }, [3] = { [0] = 180, [1] = 168, [2] = 171, [3] = 180, [4] = 180, [5] = 175, [6] = 179, [7] = 177 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 24, [3] = 32, [4] = 28, [5] = 28, [6] = 15, [7] = 30 }, [1] = { [0] = 96, [1] = 96, [2] = 86, [3] = 99, [4] = 96, [5] = 96, [6] = 83, [7] = 98 }, [2] = { [0] = 118, [1] = 111, [2] = 101, [3] = 114, [4] = 111, [5] = 112, [6] = 104, [7] = 114 }, [3] = { [0] = 21, [1] = 20, [2] = 11, [3] = 24, [4] = 21, [5] = 17, [6] = 7, [7] = 23 } })[R[35]][R[26]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 37, [2] = 29, [3] = 43, [4] = 34, [5] = 30, [6] = 42, [7] = 24 }, [1] = { [0] = 42, [1] = 40, [2] = 32, [3] = 51, [4] = 39, [5] = 35, [6] = 47, [7] = 29 }, [2] = { [0] = 195, [1] = 196, [2] = 188, [3] = 207, [4] = 198, [5] = 192, [6] = 204, [7] = 186 }, [3] = { [0] = 180, [1] = 178, [2] = 165, [3] = 188, [4] = 180, [5] = 175, [6] = 188, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 24, [1] = 21, [2] = 29, [3] = 36, [4] = 36, [5] = 34, [6] = 15, [7] = 36 }, [1] = { [0] = 89, [1] = 83, [2] = 91, [3] = 103, [4] = 104, [5] = 102, [6] = 83, [7] = 104 }, [2] = { [0] = 111, [1] = 98, [2] = 106, [3] = 118, [4] = 119, [5] = 118, [6] = 104, [7] = 120 }, [3] = { [0] = 14, [1] = 7, [2] = 16, [3] = 28, [4] = 29, [5] = 23, [6] = 7, [7] = 29 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    if R[26] == 0 or R[26] == 1 or R[26] == 2 or R[26] == 5 or R[26] == 6 or R[26] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 54, [1] = 38, [2] = 32, [5] = 40, [6] = 43, [7] = 24 }, [1] = { [0] = 54, [1] = 41, [2] = 35, [5] = 45, [6] = 48, [7] = 29 }, [2] = { [0] = 207, [1] = 197, [2] = 191, [5] = 202, [6] = 205, [7] = 186 }, [3] = { [0] = 192, [1] = 179, [2] = 168, [5] = 185, [6] = 189, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 28, [2] = 35, [5] = 33, [6] = 23, [7] = 23 }, [1] = { [0] = 96, [1] = 90, [2] = 97, [5] = 101, [6] = 91, [7] = 91 }, [2] = { [0] = 118, [1] = 105, [2] = 112, [5] = 117, [6] = 112, [7] = 107 }, [3] = { [0] = 21, [1] = 14, [2] = 22, [5] = 22, [6] = 15, [7] = 16 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 0 then
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
      elseif R[26] == 1 then
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
      elseif R[26] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[35]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[35]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[35]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[26]", R[26])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 38, [2] = 41, [5] = 30, [6] = 34, [7] = 40 }, [1] = { [0] = 31, [1] = 41, [2] = 44, [5] = 35, [6] = 39, [7] = 45 }, [2] = { [0] = 184, [1] = 197, [2] = 200, [5] = 192, [6] = 196, [7] = 202 }, [3] = { [0] = 169, [1] = 179, [2] = 177, [5] = 175, [6] = 180, [7] = 186 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 38, [2] = 35, [5] = 21, [6] = 23, [7] = 35 }, [1] = { [0] = 96, [1] = 100, [2] = 97, [5] = 89, [6] = 91, [7] = 103 }, [2] = { [0] = 118, [1] = 115, [2] = 112, [5] = 105, [6] = 112, [7] = 119 }, [3] = { [0] = 21, [1] = 24, [2] = 22, [5] = 10, [6] = 15, [7] = 28 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 2 or R[26] == 5 or R[26] == 6 or R[26] == 7 then
      elseif R[26] == 0 or R[26] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 37 }, [1] = { [0] = 42, [1] = 40 }, [2] = { [0] = 195, [1] = 196 }, [3] = { [0] = 180, [1] = 178 } })[R[35]][R[26]], ({ [0] = { [0] = 38, [1] = 46 }, [1] = { [0] = 103, [1] = 108 }, [2] = { [0] = 125, [1] = 123 }, [3] = { [0] = 28, [1] = 32 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[26]", R[26])
      end
    elseif R[26] == 3 or R[26] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [3] = 27, [4] = 34 }, [1] = { [3] = 35, [4] = 39 }, [2] = { [3] = 191, [4] = 198 }, [3] = { [3] = 172, [4] = 180 } })[R[35]][R[26]], ({ [0] = { [3] = 36, [4] = 20 }, [1] = { [3] = 103, [4] = 88 }, [2] = { [3] = 118, [4] = 103 }, [3] = { [3] = 28, [4] = 13 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 3 then
      else
        unseen("R[26]", R[26])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [3] = 30, [4] = 45 }, [1] = { [3] = 38, [4] = 50 }, [2] = { [3] = 194, [4] = 209 }, [3] = { [3] = 175, [4] = 191 } })[R[35]][R[26]], ({ [0] = { [3] = 25, [4] = 32 }, [1] = { [3] = 92, [4] = 100 }, [2] = { [3] = 107, [4] = 115 }, [3] = { [3] = 17, [4] = 25 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 3 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[35]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[35]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[35]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 4 then
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
        unseen("R[26]", R[26])
      end
    else
      unseen("R[26]", R[26])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 28, [2] = 49, [3] = 36, [4] = 26, [5] = 20, [6] = 26, [7] = 32 }, [1] = { [0] = 31, [1] = 31, [2] = 52, [3] = 44, [4] = 31, [5] = 25, [6] = 31, [7] = 37 }, [2] = { [0] = 184, [1] = 187, [2] = 208, [3] = 200, [4] = 190, [5] = 182, [6] = 188, [7] = 194 }, [3] = { [0] = 169, [1] = 169, [2] = 185, [3] = 181, [4] = 172, [5] = 165, [6] = 172, [7] = 178 } })[R[35]][R[26]], ({ [0] = { [0] = 40, [1] = 43, [2] = 29, [3] = 19, [4] = 24, [5] = 28, [6] = 23, [7] = 39 }, [1] = { [0] = 105, [1] = 105, [2] = 91, [3] = 86, [4] = 92, [5] = 96, [6] = 91, [7] = 107 }, [2] = { [0] = 127, [1] = 120, [2] = 106, [3] = 101, [4] = 107, [5] = 112, [6] = 112, [7] = 123 }, [3] = { [0] = 30, [1] = 29, [2] = 16, [3] = 11, [4] = 17, [5] = 17, [6] = 15, [7] = 32 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 38, [1] = 27, [2] = 45, [3] = 25, [4] = 44, [5] = 38, [6] = 33, [7] = 42 }, [1] = { [0] = 38, [1] = 30, [2] = 48, [3] = 33, [4] = 49, [5] = 43, [6] = 38, [7] = 47 }, [2] = { [0] = 191, [1] = 186, [2] = 204, [3] = 189, [4] = 208, [5] = 200, [6] = 195, [7] = 204 }, [3] = { [0] = 176, [1] = 168, [2] = 181, [3] = 170, [4] = 190, [5] = 183, [6] = 179, [7] = 188 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 29, [2] = 33, [3] = 26, [4] = 28, [5] = 19, [6] = 28, [7] = 30 }, [1] = { [0] = 92, [1] = 91, [2] = 95, [3] = 93, [4] = 96, [5] = 87, [6] = 96, [7] = 98 }, [2] = { [0] = 114, [1] = 106, [2] = 110, [3] = 108, [4] = 111, [5] = 103, [6] = 117, [7] = 114 }, [3] = { [0] = 17, [1] = 15, [2] = 20, [3] = 18, [4] = 21, [5] = 8, [6] = 20, [7] = 23 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 27, [2] = 45, [3] = 28, [4] = 46, [5] = 38, [6] = 31, [7] = 42 }, [1] = { [0] = 36, [1] = 30, [2] = 48, [3] = 36, [4] = 51, [5] = 43, [6] = 36, [7] = 47 }, [2] = { [0] = 189, [1] = 186, [2] = 204, [3] = 192, [4] = 210, [5] = 200, [6] = 193, [7] = 204 }, [3] = { [0] = 174, [1] = 168, [2] = 181, [3] = 173, [4] = 192, [5] = 183, [6] = 177, [7] = 188 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 27, [2] = 31, [3] = 22, [4] = 28, [5] = 21, [6] = 28, [7] = 32 }, [1] = { [0] = 92, [1] = 89, [2] = 93, [3] = 89, [4] = 96, [5] = 89, [6] = 96, [7] = 100 }, [2] = { [0] = 114, [1] = 104, [2] = 108, [3] = 104, [4] = 111, [5] = 105, [6] = 117, [7] = 116 }, [3] = { [0] = 17, [1] = 13, [2] = 18, [3] = 14, [4] = 21, [5] = 10, [6] = 20, [7] = 25 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 30, [2] = 27, [3] = 45, [4] = 38, [5] = 26, [6] = 46, [7] = 41 }, [1] = { [0] = 47, [1] = 33, [2] = 30, [3] = 53, [4] = 43, [5] = 31, [6] = 51, [7] = 46 }, [2] = { [0] = 200, [1] = 189, [2] = 186, [3] = 209, [4] = 202, [5] = 188, [6] = 208, [7] = 203 }, [3] = { [0] = 185, [1] = 171, [2] = 163, [3] = 190, [4] = 184, [5] = 171, [6] = 192, [7] = 187 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 29, [2] = 34, [3] = 26, [4] = 36, [5] = 29, [6] = 15, [7] = 24 }, [1] = { [0] = 98, [1] = 91, [2] = 96, [3] = 93, [4] = 104, [5] = 97, [6] = 83, [7] = 92 }, [2] = { [0] = 120, [1] = 106, [2] = 111, [3] = 108, [4] = 119, [5] = 113, [6] = 104, [7] = 108 }, [3] = { [0] = 23, [1] = 15, [2] = 21, [3] = 18, [4] = 29, [5] = 18, [6] = 7, [7] = 17 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 30, [2] = 27, [3] = 43, [4] = 38, [5] = 26, [6] = 46, [7] = 41 }, [1] = { [0] = 47, [1] = 33, [2] = 30, [3] = 51, [4] = 43, [5] = 31, [6] = 51, [7] = 46 }, [2] = { [0] = 200, [1] = 189, [2] = 186, [3] = 207, [4] = 202, [5] = 188, [6] = 208, [7] = 203 }, [3] = { [0] = 185, [1] = 171, [2] = 163, [3] = 188, [4] = 184, [5] = 171, [6] = 192, [7] = 187 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 29, [2] = 34, [3] = 22, [4] = 36, [5] = 29, [6] = 15, [7] = 24 }, [1] = { [0] = 98, [1] = 91, [2] = 96, [3] = 89, [4] = 104, [5] = 97, [6] = 83, [7] = 92 }, [2] = { [0] = 120, [1] = 106, [2] = 111, [3] = 104, [4] = 119, [5] = 113, [6] = 104, [7] = 108 }, [3] = { [0] = 23, [1] = 15, [2] = 21, [3] = 14, [4] = 29, [5] = 18, [6] = 7, [7] = 17 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 36, [1] = 27, [2] = 45, [3] = 31, [4] = 46, [5] = 38, [6] = 31, [7] = 42 }, [1] = { [0] = 36, [1] = 30, [2] = 48, [3] = 39, [4] = 51, [5] = 43, [6] = 36, [7] = 47 }, [2] = { [0] = 189, [1] = 186, [2] = 204, [3] = 195, [4] = 210, [5] = 200, [6] = 193, [7] = 204 }, [3] = { [0] = 174, [1] = 168, [2] = 181, [3] = 176, [4] = 192, [5] = 183, [6] = 177, [7] = 188 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 29, [2] = 31, [3] = 37, [4] = 28, [5] = 21, [6] = 28, [7] = 32 }, [1] = { [0] = 92, [1] = 91, [2] = 93, [3] = 104, [4] = 96, [5] = 89, [6] = 96, [7] = 100 }, [2] = { [0] = 114, [1] = 106, [2] = 108, [3] = 119, [4] = 111, [5] = 105, [6] = 117, [7] = 116 }, [3] = { [0] = 17, [1] = 15, [2] = 18, [3] = 29, [4] = 21, [5] = 10, [6] = 20, [7] = 25 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 36, [1] = 30, [2] = 45, [3] = 31, [4] = 46, [5] = 38, [6] = 31, [7] = 42 }, [1] = { [0] = 36, [1] = 33, [2] = 48, [3] = 39, [4] = 51, [5] = 43, [6] = 36, [7] = 47 }, [2] = { [0] = 189, [1] = 189, [2] = 204, [3] = 195, [4] = 210, [5] = 200, [6] = 193, [7] = 204 }, [3] = { [0] = 174, [1] = 171, [2] = 181, [3] = 176, [4] = 192, [5] = 183, [6] = 177, [7] = 188 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 29, [2] = 31, [3] = 37, [4] = 28, [5] = 21, [6] = 28, [7] = 32 }, [1] = { [0] = 92, [1] = 91, [2] = 93, [3] = 104, [4] = 96, [5] = 89, [6] = 96, [7] = 100 }, [2] = { [0] = 114, [1] = 106, [2] = 108, [3] = 119, [4] = 111, [5] = 105, [6] = 117, [7] = 116 }, [3] = { [0] = 17, [1] = 15, [2] = 18, [3] = 29, [4] = 21, [5] = 10, [6] = 20, [7] = 25 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 27, [2] = 27, [3] = 25, [4] = 38, [5] = 26, [6] = 46, [7] = 41 }, [1] = { [0] = 47, [1] = 30, [2] = 30, [3] = 33, [4] = 43, [5] = 31, [6] = 51, [7] = 46 }, [2] = { [0] = 200, [1] = 186, [2] = 186, [3] = 189, [4] = 202, [5] = 188, [6] = 208, [7] = 203 }, [3] = { [0] = 185, [1] = 168, [2] = 163, [3] = 170, [4] = 184, [5] = 171, [6] = 192, [7] = 187 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 29, [2] = 34, [3] = 26, [4] = 36, [5] = 29, [6] = 15, [7] = 24 }, [1] = { [0] = 98, [1] = 91, [2] = 96, [3] = 93, [4] = 104, [5] = 97, [6] = 83, [7] = 92 }, [2] = { [0] = 120, [1] = 106, [2] = 111, [3] = 108, [4] = 119, [5] = 113, [6] = 104, [7] = 108 }, [3] = { [0] = 23, [1] = 15, [2] = 21, [3] = 18, [4] = 29, [5] = 18, [6] = 7, [7] = 17 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 30, [2] = 45, [3] = 25, [4] = 39, [5] = 25, [6] = 38, [7] = 26 }, [1] = { [0] = 33, [1] = 33, [2] = 48, [3] = 33, [4] = 44, [5] = 30, [6] = 43, [7] = 31 }, [2] = { [0] = 186, [1] = 189, [2] = 204, [3] = 189, [4] = 203, [5] = 187, [6] = 200, [7] = 188 }, [3] = { [0] = 171, [1] = 171, [2] = 181, [3] = 170, [4] = 185, [5] = 170, [6] = 184, [7] = 172 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 23, [2] = 37, [3] = 26, [4] = 32, [5] = 18, [6] = 25, [7] = 30 }, [1] = { [0] = 92, [1] = 85, [2] = 99, [3] = 93, [4] = 100, [5] = 86, [6] = 93, [7] = 98 }, [2] = { [0] = 114, [1] = 100, [2] = 114, [3] = 108, [4] = 115, [5] = 102, [6] = 114, [7] = 114 }, [3] = { [0] = 17, [1] = 9, [2] = 24, [3] = 18, [4] = 25, [5] = 7, [6] = 17, [7] = 23 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 41, [3] = 31, [4] = 41, [5] = 34, [6] = 47, [7] = 21 }, [1] = { [0] = 33, [1] = 36, [2] = 44, [3] = 39, [4] = 46, [5] = 39, [6] = 52, [7] = 26 }, [2] = { [0] = 186, [1] = 192, [2] = 200, [3] = 195, [4] = 205, [5] = 196, [6] = 209, [7] = 183 }, [3] = { [0] = 171, [1] = 174, [2] = 177, [3] = 176, [4] = 187, [5] = 179, [6] = 193, [7] = 167 } })[R[35]][R[26]], ({ [0] = { [0] = 24, [1] = 20, [2] = 38, [3] = 37, [4] = 23, [5] = 26, [6] = 22, [7] = 27 }, [1] = { [0] = 89, [1] = 82, [2] = 100, [3] = 104, [4] = 91, [5] = 94, [6] = 90, [7] = 95 }, [2] = { [0] = 111, [1] = 97, [2] = 115, [3] = 119, [4] = 106, [5] = 110, [6] = 111, [7] = 111 }, [3] = { [0] = 14, [1] = 6, [2] = 25, [3] = 29, [4] = 16, [5] = 15, [6] = 14, [7] = 20 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 30, [2] = 27, [3] = 45, [4] = 38, [5] = 26, [6] = 46, [7] = 41 }, [1] = { [0] = 47, [1] = 33, [2] = 30, [3] = 53, [4] = 43, [5] = 31, [6] = 51, [7] = 46 }, [2] = { [0] = 200, [1] = 189, [2] = 186, [3] = 209, [4] = 202, [5] = 188, [6] = 208, [7] = 203 }, [3] = { [0] = 185, [1] = 171, [2] = 163, [3] = 190, [4] = 184, [5] = 171, [6] = 192, [7] = 187 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 29, [2] = 34, [3] = 26, [4] = 36, [5] = 29, [6] = 15, [7] = 24 }, [1] = { [0] = 98, [1] = 91, [2] = 96, [3] = 93, [4] = 104, [5] = 97, [6] = 83, [7] = 92 }, [2] = { [0] = 120, [1] = 106, [2] = 111, [3] = 108, [4] = 119, [5] = 113, [6] = 104, [7] = 108 }, [3] = { [0] = 23, [1] = 15, [2] = 21, [3] = 18, [4] = 29, [5] = 18, [6] = 7, [7] = 17 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 30, [2] = 27, [3] = 43, [4] = 38, [5] = 26, [6] = 46, [7] = 41 }, [1] = { [0] = 47, [1] = 33, [2] = 30, [3] = 51, [4] = 43, [5] = 31, [6] = 51, [7] = 46 }, [2] = { [0] = 200, [1] = 189, [2] = 186, [3] = 207, [4] = 202, [5] = 188, [6] = 208, [7] = 203 }, [3] = { [0] = 185, [1] = 171, [2] = 163, [3] = 188, [4] = 184, [5] = 171, [6] = 192, [7] = 187 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 29, [2] = 34, [3] = 22, [4] = 36, [5] = 29, [6] = 15, [7] = 24 }, [1] = { [0] = 98, [1] = 91, [2] = 96, [3] = 89, [4] = 104, [5] = 97, [6] = 83, [7] = 92 }, [2] = { [0] = 120, [1] = 106, [2] = 111, [3] = 104, [4] = 119, [5] = 113, [6] = 104, [7] = 108 }, [3] = { [0] = 23, [1] = 15, [2] = 21, [3] = 14, [4] = 29, [5] = 18, [6] = 7, [7] = 17 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 36, [1] = 27, [2] = 45, [3] = 31, [4] = 46, [5] = 38, [6] = 31, [7] = 42 }, [1] = { [0] = 36, [1] = 30, [2] = 48, [3] = 39, [4] = 51, [5] = 43, [6] = 36, [7] = 47 }, [2] = { [0] = 189, [1] = 186, [2] = 204, [3] = 195, [4] = 210, [5] = 200, [6] = 193, [7] = 204 }, [3] = { [0] = 174, [1] = 168, [2] = 181, [3] = 176, [4] = 192, [5] = 183, [6] = 177, [7] = 188 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 29, [2] = 31, [3] = 37, [4] = 28, [5] = 21, [6] = 28, [7] = 32 }, [1] = { [0] = 92, [1] = 91, [2] = 93, [3] = 104, [4] = 96, [5] = 89, [6] = 96, [7] = 100 }, [2] = { [0] = 114, [1] = 106, [2] = 108, [3] = 119, [4] = 111, [5] = 105, [6] = 117, [7] = 116 }, [3] = { [0] = 17, [1] = 15, [2] = 18, [3] = 29, [4] = 21, [5] = 10, [6] = 20, [7] = 25 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 47, [1] = 30, [2] = 27, [3] = 31, [4] = 38, [5] = 26, [6] = 46, [7] = 41 }, [1] = { [0] = 47, [1] = 33, [2] = 30, [3] = 39, [4] = 43, [5] = 31, [6] = 51, [7] = 46 }, [2] = { [0] = 200, [1] = 189, [2] = 186, [3] = 195, [4] = 202, [5] = 188, [6] = 208, [7] = 203 }, [3] = { [0] = 185, [1] = 171, [2] = 163, [3] = 176, [4] = 184, [5] = 171, [6] = 192, [7] = 187 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 29, [2] = 34, [3] = 37, [4] = 36, [5] = 29, [6] = 15, [7] = 24 }, [1] = { [0] = 98, [1] = 91, [2] = 96, [3] = 104, [4] = 104, [5] = 97, [6] = 83, [7] = 92 }, [2] = { [0] = 120, [1] = 106, [2] = 111, [3] = 119, [4] = 119, [5] = 113, [6] = 104, [7] = 108 }, [3] = { [0] = 23, [1] = 15, [2] = 21, [3] = 29, [4] = 29, [5] = 18, [6] = 7, [7] = 17 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 30, [2] = 45, [3] = 25, [4] = 39, [5] = 25, [6] = 38, [7] = 26 }, [1] = { [0] = 33, [1] = 33, [2] = 48, [3] = 33, [4] = 44, [5] = 30, [6] = 43, [7] = 31 }, [2] = { [0] = 186, [1] = 189, [2] = 204, [3] = 189, [4] = 203, [5] = 187, [6] = 200, [7] = 188 }, [3] = { [0] = 171, [1] = 171, [2] = 181, [3] = 170, [4] = 185, [5] = 170, [6] = 184, [7] = 172 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 23, [2] = 37, [3] = 26, [4] = 32, [5] = 18, [6] = 25, [7] = 30 }, [1] = { [0] = 92, [1] = 85, [2] = 99, [3] = 93, [4] = 100, [5] = 86, [6] = 93, [7] = 98 }, [2] = { [0] = 114, [1] = 100, [2] = 114, [3] = 108, [4] = 115, [5] = 102, [6] = 114, [7] = 114 }, [3] = { [0] = 17, [1] = 9, [2] = 24, [3] = 18, [4] = 25, [5] = 7, [6] = 17, [7] = 23 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 41, [3] = 31, [4] = 41, [5] = 34, [6] = 47, [7] = 21 }, [1] = { [0] = 33, [1] = 36, [2] = 44, [3] = 39, [4] = 46, [5] = 39, [6] = 52, [7] = 26 }, [2] = { [0] = 186, [1] = 192, [2] = 200, [3] = 195, [4] = 205, [5] = 196, [6] = 209, [7] = 183 }, [3] = { [0] = 171, [1] = 174, [2] = 177, [3] = 176, [4] = 187, [5] = 179, [6] = 193, [7] = 167 } })[R[35]][R[26]], ({ [0] = { [0] = 24, [1] = 20, [2] = 38, [3] = 37, [4] = 23, [5] = 26, [6] = 22, [7] = 27 }, [1] = { [0] = 89, [1] = 82, [2] = 100, [3] = 104, [4] = 91, [5] = 94, [6] = 90, [7] = 95 }, [2] = { [0] = 111, [1] = 97, [2] = 115, [3] = 119, [4] = 106, [5] = 110, [6] = 111, [7] = 111 }, [3] = { [0] = 14, [1] = 6, [2] = 25, [3] = 29, [4] = 16, [5] = 15, [6] = 14, [7] = 20 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 30, [2] = 27, [3] = 45, [4] = 38, [5] = 26, [6] = 46, [7] = 41 }, [1] = { [0] = 47, [1] = 33, [2] = 30, [3] = 53, [4] = 43, [5] = 31, [6] = 51, [7] = 46 }, [2] = { [0] = 200, [1] = 189, [2] = 186, [3] = 209, [4] = 202, [5] = 188, [6] = 208, [7] = 203 }, [3] = { [0] = 185, [1] = 171, [2] = 163, [3] = 190, [4] = 184, [5] = 171, [6] = 192, [7] = 187 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 29, [2] = 34, [3] = 26, [4] = 36, [5] = 29, [6] = 15, [7] = 24 }, [1] = { [0] = 98, [1] = 91, [2] = 96, [3] = 93, [4] = 104, [5] = 97, [6] = 83, [7] = 92 }, [2] = { [0] = 120, [1] = 106, [2] = 111, [3] = 108, [4] = 119, [5] = 113, [6] = 104, [7] = 108 }, [3] = { [0] = 23, [1] = 15, [2] = 21, [3] = 18, [4] = 29, [5] = 18, [6] = 7, [7] = 17 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 30, [2] = 27, [3] = 43, [4] = 38, [5] = 26, [6] = 46, [7] = 41 }, [1] = { [0] = 47, [1] = 33, [2] = 30, [3] = 51, [4] = 43, [5] = 31, [6] = 51, [7] = 46 }, [2] = { [0] = 200, [1] = 189, [2] = 186, [3] = 207, [4] = 202, [5] = 188, [6] = 208, [7] = 203 }, [3] = { [0] = 185, [1] = 171, [2] = 163, [3] = 188, [4] = 184, [5] = 171, [6] = 192, [7] = 187 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 29, [2] = 34, [3] = 22, [4] = 36, [5] = 29, [6] = 15, [7] = 24 }, [1] = { [0] = 98, [1] = 91, [2] = 96, [3] = 89, [4] = 104, [5] = 97, [6] = 83, [7] = 92 }, [2] = { [0] = 120, [1] = 106, [2] = 111, [3] = 104, [4] = 119, [5] = 113, [6] = 104, [7] = 108 }, [3] = { [0] = 23, [1] = 15, [2] = 21, [3] = 14, [4] = 29, [5] = 18, [6] = 7, [7] = 17 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 30, [2] = 45, [3] = 31, [4] = 39, [5] = 25, [6] = 38, [7] = 26 }, [1] = { [0] = 33, [1] = 33, [2] = 48, [3] = 39, [4] = 44, [5] = 30, [6] = 43, [7] = 31 }, [2] = { [0] = 186, [1] = 189, [2] = 204, [3] = 195, [4] = 203, [5] = 187, [6] = 200, [7] = 188 }, [3] = { [0] = 171, [1] = 171, [2] = 181, [3] = 176, [4] = 185, [5] = 170, [6] = 184, [7] = 172 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 23, [2] = 37, [3] = 37, [4] = 32, [5] = 18, [6] = 25, [7] = 30 }, [1] = { [0] = 92, [1] = 85, [2] = 99, [3] = 104, [4] = 100, [5] = 86, [6] = 93, [7] = 98 }, [2] = { [0] = 114, [1] = 100, [2] = 114, [3] = 119, [4] = 115, [5] = 102, [6] = 114, [7] = 114 }, [3] = { [0] = 17, [1] = 9, [2] = 24, [3] = 29, [4] = 25, [5] = 7, [6] = 17, [7] = 23 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 41, [3] = 31, [4] = 41, [5] = 34, [6] = 47, [7] = 21 }, [1] = { [0] = 33, [1] = 36, [2] = 44, [3] = 39, [4] = 46, [5] = 39, [6] = 52, [7] = 26 }, [2] = { [0] = 186, [1] = 192, [2] = 200, [3] = 195, [4] = 205, [5] = 196, [6] = 209, [7] = 183 }, [3] = { [0] = 171, [1] = 174, [2] = 177, [3] = 176, [4] = 187, [5] = 179, [6] = 193, [7] = 167 } })[R[35]][R[26]], ({ [0] = { [0] = 24, [1] = 20, [2] = 38, [3] = 37, [4] = 23, [5] = 26, [6] = 22, [7] = 27 }, [1] = { [0] = 89, [1] = 82, [2] = 100, [3] = 104, [4] = 91, [5] = 94, [6] = 90, [7] = 95 }, [2] = { [0] = 111, [1] = 97, [2] = 115, [3] = 119, [4] = 106, [5] = 110, [6] = 111, [7] = 111 }, [3] = { [0] = 14, [1] = 6, [2] = 25, [3] = 29, [4] = 16, [5] = 15, [6] = 14, [7] = 20 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 54, [1] = 36, [2] = 37, [3] = 35, [4] = 47, [5] = 26, [6] = 47, [7] = 35 }, [1] = { [0] = 54, [1] = 39, [2] = 40, [3] = 43, [4] = 52, [5] = 31, [6] = 52, [7] = 40 }, [2] = { [0] = 207, [1] = 195, [2] = 196, [3] = 199, [4] = 211, [5] = 188, [6] = 209, [7] = 197 }, [3] = { [0] = 192, [1] = 177, [2] = 173, [3] = 180, [4] = 193, [5] = 171, [6] = 193, [7] = 181 } })[R[35]][R[26]], ({ [0] = { [0] = 35, [1] = 33, [2] = 31, [3] = 23, [4] = 19, [5] = 35, [6] = 25, [7] = 29 }, [1] = { [0] = 100, [1] = 95, [2] = 93, [3] = 90, [4] = 87, [5] = 103, [6] = 93, [7] = 97 }, [2] = { [0] = 122, [1] = 110, [2] = 108, [3] = 105, [4] = 102, [5] = 119, [6] = 114, [7] = 113 }, [3] = { [0] = 25, [1] = 19, [2] = 18, [3] = 15, [4] = 12, [5] = 24, [6] = 17, [7] = 22 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 34, [1] = 30, [2] = 32, [3] = 27, [4] = 34, [5] = 30, [6] = 33, [7] = 24 }, [1] = { [0] = 34, [1] = 33, [2] = 35, [3] = 35, [4] = 39, [5] = 35, [6] = 38, [7] = 29 }, [2] = { [0] = 187, [1] = 189, [2] = 191, [3] = 191, [4] = 198, [5] = 192, [6] = 195, [7] = 186 }, [3] = { [0] = 172, [1] = 171, [2] = 168, [3] = 172, [4] = 180, [5] = 175, [6] = 179, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 29, [3] = 32, [4] = 22, [5] = 24, [6] = 17, [7] = 26 }, [1] = { [0] = 96, [1] = 96, [2] = 91, [3] = 99, [4] = 90, [5] = 92, [6] = 85, [7] = 94 }, [2] = { [0] = 118, [1] = 111, [2] = 106, [3] = 114, [4] = 105, [5] = 108, [6] = 106, [7] = 110 }, [3] = { [0] = 21, [1] = 20, [2] = 16, [3] = 24, [4] = 15, [5] = 13, [6] = 9, [7] = 19 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 31, [2] = 33, [3] = 27, [4] = 34, [5] = 30, [6] = 33, [7] = 24 }, [1] = { [0] = 35, [1] = 34, [2] = 36, [3] = 35, [4] = 39, [5] = 35, [6] = 38, [7] = 29 }, [2] = { [0] = 188, [1] = 190, [2] = 192, [3] = 191, [4] = 198, [5] = 192, [6] = 195, [7] = 186 }, [3] = { [0] = 173, [1] = 172, [2] = 169, [3] = 172, [4] = 180, [5] = 175, [6] = 179, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 29, [3] = 33, [4] = 23, [5] = 25, [6] = 18, [7] = 27 }, [1] = { [0] = 96, [1] = 96, [2] = 91, [3] = 100, [4] = 91, [5] = 93, [6] = 86, [7] = 95 }, [2] = { [0] = 118, [1] = 111, [2] = 106, [3] = 115, [4] = 106, [5] = 109, [6] = 107, [7] = 111 }, [3] = { [0] = 21, [1] = 20, [2] = 16, [3] = 25, [4] = 16, [5] = 14, [6] = 10, [7] = 20 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 32, [2] = 34, [3] = 27, [4] = 34, [5] = 30, [6] = 33, [7] = 24 }, [1] = { [0] = 36, [1] = 35, [2] = 37, [3] = 35, [4] = 39, [5] = 35, [6] = 38, [7] = 29 }, [2] = { [0] = 189, [1] = 191, [2] = 193, [3] = 191, [4] = 198, [5] = 192, [6] = 195, [7] = 186 }, [3] = { [0] = 174, [1] = 173, [2] = 170, [3] = 172, [4] = 180, [5] = 175, [6] = 179, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 29, [3] = 34, [4] = 24, [5] = 26, [6] = 19, [7] = 28 }, [1] = { [0] = 96, [1] = 96, [2] = 91, [3] = 101, [4] = 92, [5] = 94, [6] = 87, [7] = 96 }, [2] = { [0] = 118, [1] = 111, [2] = 106, [3] = 116, [4] = 107, [5] = 110, [6] = 108, [7] = 112 }, [3] = { [0] = 21, [1] = 20, [2] = 16, [3] = 26, [4] = 17, [5] = 15, [6] = 11, [7] = 21 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 33, [2] = 35, [3] = 28, [4] = 34, [5] = 30, [6] = 33, [7] = 24 }, [1] = { [0] = 37, [1] = 36, [2] = 38, [3] = 36, [4] = 39, [5] = 35, [6] = 38, [7] = 29 }, [2] = { [0] = 190, [1] = 192, [2] = 194, [3] = 192, [4] = 198, [5] = 192, [6] = 195, [7] = 186 }, [3] = { [0] = 175, [1] = 174, [2] = 171, [3] = 173, [4] = 180, [5] = 175, [6] = 179, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 26, [3] = 32, [4] = 25, [5] = 30, [6] = 20, [7] = 29 }, [1] = { [0] = 96, [1] = 96, [2] = 88, [3] = 99, [4] = 93, [5] = 98, [6] = 88, [7] = 97 }, [2] = { [0] = 118, [1] = 111, [2] = 103, [3] = 114, [4] = 108, [5] = 114, [6] = 109, [7] = 113 }, [3] = { [0] = 21, [1] = 20, [2] = 13, [3] = 24, [4] = 18, [5] = 19, [6] = 12, [7] = 22 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 34, [2] = 35, [3] = 29, [4] = 34, [5] = 30, [6] = 33, [7] = 24 }, [1] = { [0] = 38, [1] = 37, [2] = 38, [3] = 37, [4] = 39, [5] = 35, [6] = 38, [7] = 29 }, [2] = { [0] = 191, [1] = 193, [2] = 194, [3] = 193, [4] = 198, [5] = 192, [6] = 195, [7] = 186 }, [3] = { [0] = 176, [1] = 175, [2] = 171, [3] = 174, [4] = 180, [5] = 175, [6] = 179, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 27, [3] = 28, [4] = 26, [5] = 31, [6] = 21, [7] = 30 }, [1] = { [0] = 96, [1] = 96, [2] = 89, [3] = 95, [4] = 94, [5] = 99, [6] = 89, [7] = 98 }, [2] = { [0] = 118, [1] = 111, [2] = 104, [3] = 110, [4] = 109, [5] = 115, [6] = 110, [7] = 114 }, [3] = { [0] = 21, [1] = 20, [2] = 14, [3] = 20, [4] = 19, [5] = 20, [6] = 13, [7] = 23 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 35, [2] = 35, [3] = 29, [4] = 34, [5] = 30, [6] = 36, [7] = 24 }, [1] = { [0] = 39, [1] = 38, [2] = 38, [3] = 37, [4] = 39, [5] = 35, [6] = 41, [7] = 29 }, [2] = { [0] = 192, [1] = 194, [2] = 194, [3] = 193, [4] = 198, [5] = 192, [6] = 198, [7] = 186 }, [3] = { [0] = 177, [1] = 176, [2] = 171, [3] = 174, [4] = 180, [5] = 175, [6] = 182, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 28, [3] = 29, [4] = 30, [5] = 32, [6] = 15, [7] = 31 }, [1] = { [0] = 96, [1] = 96, [2] = 90, [3] = 96, [4] = 98, [5] = 100, [6] = 83, [7] = 99 }, [2] = { [0] = 118, [1] = 111, [2] = 105, [3] = 111, [4] = 113, [5] = 116, [6] = 104, [7] = 115 }, [3] = { [0] = 21, [1] = 20, [2] = 15, [3] = 21, [4] = 23, [5] = 21, [6] = 7, [7] = 24 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 40, [1] = 36, [2] = 35, [3] = 29, [4] = 34, [5] = 33, [6] = 37, [7] = 24 }, [1] = { [0] = 40, [1] = 39, [2] = 38, [3] = 37, [4] = 39, [5] = 38, [6] = 42, [7] = 29 }, [2] = { [0] = 193, [1] = 195, [2] = 194, [3] = 193, [4] = 198, [5] = 195, [6] = 199, [7] = 186 }, [3] = { [0] = 178, [1] = 177, [2] = 171, [3] = 174, [4] = 180, [5] = 178, [6] = 183, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 29, [3] = 30, [4] = 31, [5] = 28, [6] = 15, [7] = 32 }, [1] = { [0] = 96, [1] = 96, [2] = 91, [3] = 97, [4] = 99, [5] = 96, [6] = 83, [7] = 100 }, [2] = { [0] = 118, [1] = 111, [2] = 106, [3] = 112, [4] = 114, [5] = 112, [6] = 104, [7] = 116 }, [3] = { [0] = 21, [1] = 20, [2] = 16, [3] = 22, [4] = 24, [5] = 17, [6] = 7, [7] = 25 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 37, [2] = 35, [3] = 29, [4] = 34, [5] = 33, [6] = 37, [7] = 24 }, [1] = { [0] = 42, [1] = 40, [2] = 38, [3] = 37, [4] = 39, [5] = 38, [6] = 42, [7] = 29 }, [2] = { [0] = 195, [1] = 196, [2] = 194, [3] = 193, [4] = 198, [5] = 195, [6] = 199, [7] = 186 }, [3] = { [0] = 180, [1] = 178, [2] = 171, [3] = 174, [4] = 180, [5] = 178, [6] = 183, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 26, [1] = 23, [2] = 30, [3] = 31, [4] = 32, [5] = 34, [6] = 23, [7] = 33 }, [1] = { [0] = 91, [1] = 85, [2] = 92, [3] = 98, [4] = 100, [5] = 102, [6] = 91, [7] = 101 }, [2] = { [0] = 113, [1] = 100, [2] = 107, [3] = 113, [4] = 115, [5] = 118, [6] = 112, [7] = 117 }, [3] = { [0] = 16, [1] = 9, [2] = 17, [3] = 23, [4] = 25, [5] = 23, [6] = 15, [7] = 26 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 37, [2] = 35, [3] = 29, [4] = 34, [5] = 34, [6] = 38, [7] = 24 }, [1] = { [0] = 42, [1] = 40, [2] = 38, [3] = 37, [4] = 39, [5] = 39, [6] = 43, [7] = 29 }, [2] = { [0] = 195, [1] = 196, [2] = 194, [3] = 193, [4] = 198, [5] = 196, [6] = 200, [7] = 186 }, [3] = { [0] = 180, [1] = 178, [2] = 171, [3] = 174, [4] = 180, [5] = 179, [6] = 184, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 24, [2] = 31, [3] = 32, [4] = 33, [5] = 28, [6] = 15, [7] = 34 }, [1] = { [0] = 92, [1] = 86, [2] = 93, [3] = 99, [4] = 101, [5] = 96, [6] = 83, [7] = 102 }, [2] = { [0] = 114, [1] = 101, [2] = 108, [3] = 114, [4] = 116, [5] = 112, [6] = 104, [7] = 118 }, [3] = { [0] = 17, [1] = 10, [2] = 18, [3] = 24, [4] = 26, [5] = 17, [6] = 7, [7] = 27 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 37, [2] = 35, [3] = 30, [4] = 34, [5] = 34, [6] = 38, [7] = 27 }, [1] = { [0] = 42, [1] = 40, [2] = 38, [3] = 38, [4] = 39, [5] = 39, [6] = 43, [7] = 32 }, [2] = { [0] = 195, [1] = 196, [2] = 194, [3] = 194, [4] = 198, [5] = 196, [6] = 200, [7] = 189 }, [3] = { [0] = 180, [1] = 178, [2] = 171, [3] = 175, [4] = 180, [5] = 179, [6] = 184, [7] = 173 } })[R[35]][R[26]], ({ [0] = { [0] = 28, [1] = 25, [2] = 32, [3] = 28, [4] = 34, [5] = 34, [6] = 23, [7] = 23 }, [1] = { [0] = 93, [1] = 87, [2] = 94, [3] = 95, [4] = 102, [5] = 102, [6] = 91, [7] = 91 }, [2] = { [0] = 115, [1] = 102, [2] = 109, [3] = 110, [4] = 117, [5] = 118, [6] = 112, [7] = 107 }, [3] = { [0] = 18, [1] = 11, [2] = 19, [3] = 20, [4] = 27, [5] = 23, [6] = 15, [7] = 16 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 37, [2] = 35, [3] = 30, [4] = 37, [5] = 35, [6] = 39, [7] = 27 }, [1] = { [0] = 42, [1] = 40, [2] = 38, [3] = 38, [4] = 42, [5] = 40, [6] = 44, [7] = 32 }, [2] = { [0] = 195, [1] = 196, [2] = 194, [3] = 194, [4] = 201, [5] = 197, [6] = 201, [7] = 189 }, [3] = { [0] = 180, [1] = 178, [2] = 171, [3] = 175, [4] = 183, [5] = 180, [6] = 185, [7] = 173 } })[R[35]][R[26]], ({ [0] = { [0] = 29, [1] = 26, [2] = 33, [3] = 32, [4] = 20, [5] = 28, [6] = 15, [7] = 36 }, [1] = { [0] = 94, [1] = 88, [2] = 95, [3] = 99, [4] = 88, [5] = 96, [6] = 83, [7] = 104 }, [2] = { [0] = 116, [1] = 103, [2] = 110, [3] = 114, [4] = 103, [5] = 112, [6] = 104, [7] = 120 }, [3] = { [0] = 19, [1] = 12, [2] = 20, [3] = 24, [4] = 13, [5] = 17, [6] = 7, [7] = 29 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 37, [2] = 35, [3] = 31, [4] = 37, [5] = 35, [6] = 39, [7] = 28 }, [1] = { [0] = 42, [1] = 40, [2] = 38, [3] = 39, [4] = 42, [5] = 40, [6] = 44, [7] = 33 }, [2] = { [0] = 195, [1] = 196, [2] = 194, [3] = 195, [4] = 201, [5] = 197, [6] = 201, [7] = 190 }, [3] = { [0] = 180, [1] = 178, [2] = 171, [3] = 176, [4] = 183, [5] = 180, [6] = 185, [7] = 174 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 34, [2] = 34, [3] = 32, [4] = 28, [5] = 34, [6] = 23, [7] = 23 }, [1] = { [0] = 98, [1] = 96, [2] = 96, [3] = 99, [4] = 96, [5] = 102, [6] = 91, [7] = 91 }, [2] = { [0] = 120, [1] = 111, [2] = 111, [3] = 114, [4] = 111, [5] = 118, [6] = 112, [7] = 107 }, [3] = { [0] = 23, [1] = 20, [2] = 21, [3] = 24, [4] = 21, [5] = 23, [6] = 15, [7] = 16 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 38, [2] = 35, [3] = 32, [4] = 37, [5] = 36, [6] = 40, [7] = 28 }, [1] = { [0] = 42, [1] = 41, [2] = 38, [3] = 40, [4] = 42, [5] = 41, [6] = 45, [7] = 33 }, [2] = { [0] = 195, [1] = 197, [2] = 194, [3] = 196, [4] = 201, [5] = 198, [6] = 202, [7] = 190 }, [3] = { [0] = 180, [1] = 179, [2] = 171, [3] = 177, [4] = 183, [5] = 181, [6] = 186, [7] = 174 } })[R[35]][R[26]], ({ [0] = { [0] = 34, [1] = 31, [2] = 35, [3] = 32, [4] = 36, [5] = 28, [6] = 15, [7] = 36 }, [1] = { [0] = 99, [1] = 93, [2] = 97, [3] = 99, [4] = 104, [5] = 96, [6] = 83, [7] = 104 }, [2] = { [0] = 121, [1] = 108, [2] = 112, [3] = 114, [4] = 119, [5] = 112, [6] = 104, [7] = 120 }, [3] = { [0] = 24, [1] = 17, [2] = 22, [3] = 24, [4] = 29, [5] = 17, [6] = 7, [7] = 29 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 38, [2] = 36, [3] = 33, [4] = 38, [5] = 36, [6] = 40, [7] = 29 }, [1] = { [0] = 42, [1] = 41, [2] = 39, [3] = 41, [4] = 43, [5] = 41, [6] = 45, [7] = 34 }, [2] = { [0] = 195, [1] = 197, [2] = 195, [3] = 197, [4] = 202, [5] = 198, [6] = 202, [7] = 191 }, [3] = { [0] = 180, [1] = 179, [2] = 172, [3] = 178, [4] = 184, [5] = 181, [6] = 186, [7] = 175 } })[R[35]][R[26]], ({ [0] = { [0] = 35, [1] = 32, [2] = 29, [3] = 25, [4] = 20, [5] = 34, [6] = 23, [7] = 23 }, [1] = { [0] = 100, [1] = 94, [2] = 91, [3] = 92, [4] = 88, [5] = 102, [6] = 91, [7] = 91 }, [2] = { [0] = 122, [1] = 109, [2] = 106, [3] = 107, [4] = 103, [5] = 118, [6] = 112, [7] = 107 }, [3] = { [0] = 25, [1] = 18, [2] = 16, [3] = 17, [4] = 13, [5] = 23, [6] = 15, [7] = 16 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 38, [2] = 36, [3] = 33, [4] = 38, [5] = 37, [6] = 42, [7] = 29 }, [1] = { [0] = 42, [1] = 41, [2] = 39, [3] = 41, [4] = 43, [5] = 42, [6] = 47, [7] = 34 }, [2] = { [0] = 195, [1] = 197, [2] = 195, [3] = 197, [4] = 202, [5] = 199, [6] = 204, [7] = 191 }, [3] = { [0] = 180, [1] = 179, [2] = 172, [3] = 178, [4] = 184, [5] = 182, [6] = 188, [7] = 175 } })[R[35]][R[26]], ({ [0] = { [0] = 36, [1] = 33, [2] = 35, [3] = 32, [4] = 28, [5] = 28, [6] = 17, [7] = 36 }, [1] = { [0] = 101, [1] = 95, [2] = 97, [3] = 99, [4] = 96, [5] = 96, [6] = 85, [7] = 104 }, [2] = { [0] = 123, [1] = 110, [2] = 112, [3] = 114, [4] = 111, [5] = 112, [6] = 106, [7] = 120 }, [3] = { [0] = 26, [1] = 19, [2] = 22, [3] = 24, [4] = 21, [5] = 17, [6] = 9, [7] = 29 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 38, [2] = 37, [3] = 34, [4] = 38, [5] = 37, [6] = 42, [7] = 30 }, [1] = { [0] = 45, [1] = 41, [2] = 40, [3] = 42, [4] = 43, [5] = 42, [6] = 47, [7] = 35 }, [2] = { [0] = 198, [1] = 197, [2] = 196, [3] = 198, [4] = 202, [5] = 199, [6] = 204, [7] = 192 }, [3] = { [0] = 183, [1] = 179, [2] = 173, [3] = 179, [4] = 184, [5] = 182, [6] = 188, [7] = 176 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 29, [3] = 25, [4] = 36, [5] = 34, [6] = 18, [7] = 23 }, [1] = { [0] = 96, [1] = 96, [2] = 91, [3] = 92, [4] = 104, [5] = 102, [6] = 86, [7] = 91 }, [2] = { [0] = 118, [1] = 111, [2] = 106, [3] = 107, [4] = 119, [5] = 118, [6] = 107, [7] = 107 }, [3] = { [0] = 21, [1] = 20, [2] = 16, [3] = 17, [4] = 29, [5] = 23, [6] = 10, [7] = 16 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 38, [2] = 37, [3] = 35, [4] = 39, [5] = 38, [6] = 42, [7] = 30 }, [1] = { [0] = 46, [1] = 41, [2] = 40, [3] = 43, [4] = 44, [5] = 43, [6] = 47, [7] = 35 }, [2] = { [0] = 199, [1] = 197, [2] = 196, [3] = 199, [4] = 203, [5] = 200, [6] = 204, [7] = 192 }, [3] = { [0] = 184, [1] = 179, [2] = 173, [3] = 180, [4] = 185, [5] = 183, [6] = 188, [7] = 176 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 35, [2] = 35, [3] = 25, [4] = 20, [5] = 28, [6] = 19, [7] = 36 }, [1] = { [0] = 96, [1] = 97, [2] = 97, [3] = 92, [4] = 88, [5] = 96, [6] = 87, [7] = 104 }, [2] = { [0] = 118, [1] = 112, [2] = 112, [3] = 107, [4] = 103, [5] = 112, [6] = 108, [7] = 120 }, [3] = { [0] = 21, [1] = 21, [2] = 22, [3] = 17, [4] = 13, [5] = 17, [6] = 11, [7] = 29 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 38, [2] = 38, [3] = 36, [4] = 39, [5] = 39, [6] = 42, [7] = 31 }, [1] = { [0] = 47, [1] = 41, [2] = 41, [3] = 44, [4] = 44, [5] = 44, [6] = 47, [7] = 36 }, [2] = { [0] = 200, [1] = 197, [2] = 197, [3] = 200, [4] = 203, [5] = 201, [6] = 204, [7] = 193 }, [3] = { [0] = 185, [1] = 179, [2] = 174, [3] = 181, [4] = 185, [5] = 184, [6] = 188, [7] = 177 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 36, [2] = 29, [3] = 25, [4] = 21, [5] = 28, [6] = 20, [7] = 23 }, [1] = { [0] = 96, [1] = 98, [2] = 91, [3] = 92, [4] = 89, [5] = 96, [6] = 88, [7] = 91 }, [2] = { [0] = 118, [1] = 113, [2] = 106, [3] = 107, [4] = 104, [5] = 112, [6] = 109, [7] = 107 }, [3] = { [0] = 21, [1] = 22, [2] = 16, [3] = 17, [4] = 14, [5] = 17, [6] = 12, [7] = 16 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 38, [2] = 38, [3] = 37, [4] = 39, [5] = 40, [6] = 42, [7] = 31 }, [1] = { [0] = 48, [1] = 41, [2] = 41, [3] = 45, [4] = 44, [5] = 45, [6] = 47, [7] = 36 }, [2] = { [0] = 201, [1] = 197, [2] = 197, [3] = 201, [4] = 203, [5] = 202, [6] = 204, [7] = 193 }, [3] = { [0] = 186, [1] = 179, [2] = 174, [3] = 182, [4] = 185, [5] = 185, [6] = 188, [7] = 177 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 41, [2] = 35, [3] = 25, [4] = 28, [5] = 28, [6] = 21, [7] = 24 }, [1] = { [0] = 96, [1] = 103, [2] = 97, [3] = 92, [4] = 96, [5] = 96, [6] = 89, [7] = 92 }, [2] = { [0] = 118, [1] = 118, [2] = 112, [3] = 107, [4] = 111, [5] = 112, [6] = 110, [7] = 108 }, [3] = { [0] = 21, [1] = 27, [2] = 22, [3] = 17, [4] = 21, [5] = 17, [6] = 13, [7] = 17 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 49, [1] = 38, [2] = 39, [3] = 38, [4] = 39, [5] = 40, [6] = 46, [7] = 31 }, [1] = { [0] = 49, [1] = 41, [2] = 42, [3] = 46, [4] = 44, [5] = 45, [6] = 51, [7] = 36 }, [2] = { [0] = 202, [1] = 197, [2] = 198, [3] = 202, [4] = 203, [5] = 202, [6] = 208, [7] = 193 }, [3] = { [0] = 187, [1] = 179, [2] = 175, [3] = 183, [4] = 185, [5] = 185, [6] = 192, [7] = 177 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 42, [2] = 29, [3] = 25, [4] = 36, [5] = 29, [6] = 23, [7] = 25 }, [1] = { [0] = 96, [1] = 104, [2] = 91, [3] = 92, [4] = 104, [5] = 97, [6] = 91, [7] = 93 }, [2] = { [0] = 118, [1] = 119, [2] = 106, [3] = 107, [4] = 119, [5] = 113, [6] = 112, [7] = 109 }, [3] = { [0] = 21, [1] = 28, [2] = 16, [3] = 17, [4] = 29, [5] = 18, [6] = 15, [7] = 18 } })[R[35]][R[26]] })
    if R[26] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 50, [1] = 50, [2] = 203, [3] = 188 })[R[35]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 51, [1] = 51, [2] = 204, [3] = 189 })[R[35]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 50, [1] = 50, [2] = 203, [3] = 188 })[R[35]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 51, [1] = 51, [2] = 204, [3] = 189 })[R[35]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[35]] })
        for i = 1, game.initial_units() do
          R[45] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 48, [1] = 48, [2] = 201, [3] = 186 }, [1] = { [0] = 35, [1] = 35, [2] = 188, [3] = 173 }, [2] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 } })[R[45]][R[35]], ({ [0] = { [0] = 25, [1] = 90, [2] = 112, [3] = 15 }, [1] = { [0] = 34, [1] = 99, [2] = 121, [3] = 24 }, [2] = { [0] = 37, [1] = 102, [2] = 124, [3] = 27 } })[R[45]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[35]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[35]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[35]], ({ [0] = 44, [1] = 106, [2] = 121, [3] = 30 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[35]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[35]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[35]], ({ [0] = 44, [1] = 106, [2] = 121, [3] = 30 })[R[35]] })
        for i = 1, game.initial_units() do
          R[46] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 188, [3] = 170 }, [1] = { [0] = 31, [1] = 34, [2] = 190, [3] = 172 }, [2] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 } })[R[46]][R[35]], ({ [0] = { [0] = 38, [1] = 100, [2] = 115, [3] = 24 }, [1] = { [0] = 40, [1] = 102, [2] = 117, [3] = 26 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 18 } })[R[46]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[47] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 30, [1] = 33, [2] = 189, [3] = 166 }, [1] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [2] = { [0] = 48, [1] = 51, [2] = 207, [3] = 184 } })[R[47]][R[35]], ({ [0] = { [0] = 23, [1] = 85, [2] = 100, [3] = 10 }, [1] = { [0] = 39, [1] = 101, [2] = 116, [3] = 26 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 19 } })[R[47]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 46, [2] = 202, [3] = 183 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 47, [2] = 203, [3] = 184 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 48, [2] = 204, [3] = 185 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[35]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 29, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 30, [1] = 97, [2] = 112, [3] = 22 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 31, [1] = 98, [2] = 113, [3] = 23 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[35]], ({ [0] = 33, [1] = 100, [2] = 115, [3] = 25 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[35]], ({ [0] = 34, [1] = 101, [2] = 116, [3] = 26 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 46, [2] = 202, [3] = 183 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 47, [2] = 203, [3] = 184 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 48, [2] = 204, [3] = 185 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[35]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 29, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 30, [1] = 97, [2] = 112, [3] = 22 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 31, [1] = 98, [2] = 113, [3] = 23 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[35]], ({ [0] = 33, [1] = 100, [2] = 115, [3] = 25 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[35]], ({ [0] = 34, [1] = 101, [2] = 116, [3] = 26 })[R[35]] })
        for i = 1, game.initial_units() do
          R[48] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [1] = { [0] = 37, [1] = 45, [2] = 201, [3] = 182 }, [2] = { [0] = 24, [1] = 32, [2] = 188, [3] = 169 } })[R[48]][R[35]], ({ [0] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [1] = { [0] = 35, [1] = 102, [2] = 117, [3] = 27 }, [2] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 } })[R[48]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 4 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[35]], ({ [0] = 21, [1] = 89, [2] = 104, [3] = 14 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[35]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[35]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[35]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 29, [1] = 97, [2] = 112, [3] = 22 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 30, [1] = 98, [2] = 113, [3] = 23 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[35]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[35]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 25, [1] = 93, [2] = 108, [3] = 18 })[R[35]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 109, [3] = 19 })[R[35]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[35]] })
        for i = 1, game.initial_units() do
          R[49] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [1] = { [0] = 29, [1] = 34, [2] = 193, [3] = 175 }, [2] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 } })[R[49]][R[35]], ({ [0] = { [0] = 19, [1] = 87, [2] = 102, [3] = 12 }, [1] = { [0] = 27, [1] = 95, [2] = 110, [3] = 20 }, [2] = { [0] = 22, [1] = 90, [2] = 105, [3] = 15 } })[R[49]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[35]], ({ [0] = 21, [1] = 89, [2] = 104, [3] = 14 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[35]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[35]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[35]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 29, [1] = 97, [2] = 112, [3] = 22 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 30, [1] = 98, [2] = 113, [3] = 23 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[35]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[35]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 25, [1] = 93, [2] = 108, [3] = 18 })[R[35]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 109, [3] = 19 })[R[35]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[35]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[35]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 19 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[35]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 20 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[35]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 19 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[35]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 20 })[R[35]] })
        for i = 1, game.initial_units() do
          R[50] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [1] = { [0] = 19, [1] = 24, [2] = 181, [3] = 164 }, [2] = { [0] = 41, [1] = 46, [2] = 203, [3] = 186 } })[R[50]][R[35]], ({ [0] = { [0] = 37, [1] = 105, [2] = 121, [3] = 26 }, [1] = { [0] = 24, [1] = 92, [2] = 108, [3] = 13 }, [2] = { [0] = 37, [1] = 105, [2] = 121, [3] = 26 } })[R[50]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 48, [1] = 53, [2] = 210, [3] = 194 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 49, [1] = 54, [2] = 211, [3] = 195 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 48, [1] = 53, [2] = 210, [3] = 194 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 49, [1] = 54, [2] = 211, [3] = 195 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] })
        for i = 1, game.initial_units() do
          R[51] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 }, [1] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [2] = { [0] = 54, [1] = 59, [2] = 216, [3] = 200 } })[R[51]][R[35]], ({ [0] = { [0] = 13, [1] = 81, [2] = 102, [3] = 5 }, [1] = { [0] = 11, [1] = 79, [2] = 100, [3] = 3 }, [2] = { [0] = 26, [1] = 94, [2] = 115, [3] = 18 } })[R[51]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 34, [1] = 102, [2] = 118, [3] = 27 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 35, [1] = 103, [2] = 119, [3] = 28 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 25, [1] = 93, [2] = 109, [3] = 18 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 22 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 34, [1] = 102, [2] = 118, [3] = 27 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 35, [1] = 103, [2] = 119, [3] = 28 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 25, [1] = 93, [2] = 109, [3] = 18 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 22 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[35]] })
        for i = 1, game.initial_units() do
          R[52] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 }, [1] = { [0] = 35, [1] = 40, [2] = 197, [3] = 181 }, [2] = { [0] = 23, [1] = 28, [2] = 185, [3] = 169 } })[R[52]][R[35]], ({ [0] = { [0] = 19, [1] = 87, [2] = 103, [3] = 12 }, [1] = { [0] = 19, [1] = 87, [2] = 103, [3] = 12 }, [2] = { [0] = 40, [1] = 108, [2] = 124, [3] = 33 } })[R[52]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[26]", R[26])
    end
    R[53] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 24, [1] = 86, [2] = 101, [3] = 11 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 24, [1] = 86, [2] = 101, [3] = 11 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[53]][R[36]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 29, [1] = 32, [2] = 188, [3] = 165 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 21, [1] = 83, [2] = 98, [3] = 7 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 36, [1] = 103, [2] = 118, [3] = 28 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    if R[53] == 0 or R[53] == 1 or R[53] == 2 or R[53] == 5 or R[53] == 6 or R[53] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = { [0] = 54, [1] = 54, [2] = 207, [3] = 192 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 32, [1] = 35, [2] = 191, [3] = 168 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 43, [1] = 48, [2] = 205, [3] = 189 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 28, [1] = 90, [2] = 105, [3] = 14 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [5] = { [0] = 33, [1] = 101, [2] = 117, [3] = 22 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 0 then
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
      elseif R[53] == 1 then
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
      elseif R[53] == 2 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[36]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[36]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[36]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[53]", R[53])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = { [0] = 31, [1] = 31, [2] = 184, [3] = 169 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 34, [1] = 39, [2] = 196, [3] = 180 }, [7] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 38, [1] = 100, [2] = 115, [3] = 24 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 35, [1] = 103, [2] = 119, [3] = 28 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 2 or R[53] == 5 or R[53] == 6 or R[53] == 7 then
      elseif R[53] == 0 or R[53] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 } })[R[53]][R[36]], ({ [0] = { [0] = 38, [1] = 103, [2] = 125, [3] = 28 }, [1] = { [0] = 46, [1] = 108, [2] = 123, [3] = 32 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[53]", R[53])
      end
    elseif R[53] == 3 or R[53] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 } })[R[53]][R[36]], ({ [3] = { [0] = 36, [1] = 103, [2] = 118, [3] = 28 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 30, [1] = 38, [2] = 194, [3] = 175 })[R[36]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[36]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 32, [1] = 100, [2] = 115, [3] = 25 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[53]", R[53])
      end
    else
      unseen("R[53]", R[53])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = { [0] = 31, [1] = 31, [2] = 184, [3] = 169 }, [1] = { [0] = 28, [1] = 31, [2] = 187, [3] = 169 }, [2] = { [0] = 49, [1] = 52, [2] = 208, [3] = 185 }, [3] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [4] = { [0] = 26, [1] = 31, [2] = 190, [3] = 172 }, [5] = { [0] = 20, [1] = 25, [2] = 182, [3] = 165 }, [6] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 }, [7] = { [0] = 32, [1] = 37, [2] = 194, [3] = 178 } })[R[53]][R[36]], ({ [0] = { [0] = 40, [1] = 105, [2] = 127, [3] = 30 }, [1] = { [0] = 43, [1] = 105, [2] = 120, [3] = 29 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 19, [1] = 86, [2] = 101, [3] = 11 }, [4] = { [0] = 24, [1] = 92, [2] = 107, [3] = 17 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 39, [1] = 107, [2] = 123, [3] = 32 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 38, [1] = 38, [2] = 191, [3] = 176 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 44, [1] = 49, [2] = 208, [3] = 190 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 33, [1] = 95, [2] = 110, [3] = 20 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 19, [1] = 87, [2] = 103, [3] = 8 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 28, [1] = 36, [2] = 192, [3] = 173 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 27, [1] = 89, [2] = 104, [3] = 13 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[3].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 45, [1] = 53, [2] = 209, [3] = 190 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 25, [1] = 30, [2] = 187, [3] = 170 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 37, [1] = 99, [2] = 114, [3] = 24 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 18, [1] = 86, [2] = 102, [3] = 7 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 41, [1] = 46, [2] = 205, [3] = 187 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 21, [1] = 26, [2] = 183, [3] = 167 } })[R[53]][R[36]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 82, [2] = 97, [3] = 6 }, [2] = { [0] = 38, [1] = 100, [2] = 115, [3] = 25 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 22, [1] = 90, [2] = 111, [3] = 14 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 45, [1] = 53, [2] = 209, [3] = 190 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 25, [1] = 30, [2] = 187, [3] = 170 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 37, [1] = 99, [2] = 114, [3] = 24 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 18, [1] = 86, [2] = 102, [3] = 7 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 41, [1] = 46, [2] = 205, [3] = 187 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 21, [1] = 26, [2] = 183, [3] = 167 } })[R[53]][R[36]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 82, [2] = 97, [3] = 6 }, [2] = { [0] = 38, [1] = 100, [2] = 115, [3] = 25 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 22, [1] = 90, [2] = 111, [3] = 14 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 45, [1] = 53, [2] = 209, [3] = 190 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 25, [1] = 30, [2] = 187, [3] = 170 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 37, [1] = 99, [2] = 114, [3] = 24 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 18, [1] = 86, [2] = 102, [3] = 7 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 41, [1] = 46, [2] = 205, [3] = 187 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 21, [1] = 26, [2] = 183, [3] = 167 } })[R[53]][R[36]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 82, [2] = 97, [3] = 6 }, [2] = { [0] = 38, [1] = 100, [2] = 115, [3] = 25 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 22, [1] = 90, [2] = 111, [3] = 14 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 54, [1] = 54, [2] = 207, [3] = 192 }, [1] = { [0] = 36, [1] = 39, [2] = 195, [3] = 177 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 47, [1] = 52, [2] = 211, [3] = 193 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 35, [1] = 40, [2] = 197, [3] = 181 } })[R[53]][R[36]], ({ [0] = { [0] = 35, [1] = 100, [2] = 122, [3] = 25 }, [1] = { [0] = 33, [1] = 95, [2] = 110, [3] = 19 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 23, [1] = 90, [2] = 105, [3] = 15 }, [4] = { [0] = 19, [1] = 87, [2] = 102, [3] = 12 }, [5] = { [0] = 35, [1] = 103, [2] = 119, [3] = 24 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 29, [1] = 97, [2] = 113, [3] = 22 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 34, [1] = 34, [2] = 187, [3] = 172 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 32, [1] = 35, [2] = 191, [3] = 168 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 22, [1] = 90, [2] = 105, [3] = 15 }, [5] = { [0] = 24, [1] = 92, [2] = 108, [3] = 13 }, [6] = { [0] = 17, [1] = 85, [2] = 106, [3] = 9 }, [7] = { [0] = 26, [1] = 94, [2] = 110, [3] = 19 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 35, [2] = 188, [3] = 173 }, [1] = { [0] = 31, [1] = 34, [2] = 190, [3] = 172 }, [2] = { [0] = 33, [1] = 36, [2] = 192, [3] = 169 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 33, [1] = 100, [2] = 115, [3] = 25 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 25, [1] = 93, [2] = 109, [3] = 14 }, [6] = { [0] = 18, [1] = 86, [2] = 107, [3] = 10 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 32, [1] = 35, [2] = 191, [3] = 173 }, [2] = { [0] = 34, [1] = 37, [2] = 193, [3] = 170 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 34, [1] = 101, [2] = 116, [3] = 26 }, [4] = { [0] = 24, [1] = 92, [2] = 107, [3] = 17 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 19, [1] = 87, [2] = 108, [3] = 11 }, [7] = { [0] = 28, [1] = 96, [2] = 112, [3] = 21 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 37, [2] = 190, [3] = 175 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 28, [1] = 36, [2] = 192, [3] = 173 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 26, [1] = 88, [2] = 103, [3] = 13 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 25, [1] = 93, [2] = 108, [3] = 18 }, [5] = { [0] = 30, [1] = 98, [2] = 114, [3] = 19 }, [6] = { [0] = 20, [1] = 88, [2] = 109, [3] = 12 }, [7] = { [0] = 29, [1] = 97, [2] = 113, [3] = 22 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 38, [2] = 191, [3] = 176 }, [1] = { [0] = 34, [1] = 37, [2] = 193, [3] = 175 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 27, [1] = 89, [2] = 104, [3] = 14 }, [3] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [4] = { [0] = 26, [1] = 94, [2] = 109, [3] = 19 }, [5] = { [0] = 31, [1] = 99, [2] = 115, [3] = 20 }, [6] = { [0] = 21, [1] = 89, [2] = 110, [3] = 13 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 39, [2] = 192, [3] = 177 }, [1] = { [0] = 35, [1] = 38, [2] = 194, [3] = 176 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 36, [1] = 41, [2] = 198, [3] = 182 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 28, [1] = 90, [2] = 105, [3] = 15 }, [3] = { [0] = 29, [1] = 96, [2] = 111, [3] = 21 }, [4] = { [0] = 30, [1] = 98, [2] = 113, [3] = 23 }, [5] = { [0] = 32, [1] = 100, [2] = 116, [3] = 21 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 31, [1] = 99, [2] = 115, [3] = 24 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 40, [1] = 40, [2] = 193, [3] = 178 }, [1] = { [0] = 36, [1] = 39, [2] = 195, [3] = 177 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 33, [1] = 38, [2] = 195, [3] = 178 }, [6] = { [0] = 37, [1] = 42, [2] = 199, [3] = 183 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 30, [1] = 97, [2] = 112, [3] = 22 }, [4] = { [0] = 31, [1] = 99, [2] = 114, [3] = 24 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 33, [1] = 38, [2] = 195, [3] = 178 }, [6] = { [0] = 37, [1] = 42, [2] = 199, [3] = 183 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 26, [1] = 91, [2] = 113, [3] = 16 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 30, [1] = 92, [2] = 107, [3] = 17 }, [3] = { [0] = 31, [1] = 98, [2] = 113, [3] = 23 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 33, [1] = 101, [2] = 117, [3] = 26 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 24, [1] = 86, [2] = 101, [3] = 10 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 33, [1] = 101, [2] = 116, [3] = 26 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 34, [1] = 102, [2] = 118, [3] = 27 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 30, [1] = 38, [2] = 194, [3] = 175 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 27, [1] = 32, [2] = 189, [3] = 173 } })[R[53]][R[36]], ({ [0] = { [0] = 28, [1] = 93, [2] = 115, [3] = 18 }, [1] = { [0] = 25, [1] = 87, [2] = 102, [3] = 11 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 19 }, [3] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [4] = { [0] = 34, [1] = 102, [2] = 117, [3] = 27 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 30, [1] = 38, [2] = 194, [3] = 175 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 35, [1] = 40, [2] = 197, [3] = 180 }, [6] = { [0] = 39, [1] = 44, [2] = 201, [3] = 185 }, [7] = { [0] = 27, [1] = 32, [2] = 189, [3] = 173 } })[R[53]][R[36]], ({ [0] = { [0] = 29, [1] = 94, [2] = 116, [3] = 19 }, [1] = { [0] = 26, [1] = 88, [2] = 103, [3] = 12 }, [2] = { [0] = 33, [1] = 95, [2] = 110, [3] = 20 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 35, [1] = 40, [2] = 197, [3] = 180 }, [6] = { [0] = 39, [1] = 44, [2] = 201, [3] = 185 }, [7] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 32, [1] = 40, [2] = 196, [3] = 177 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [6] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 }, [7] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 } })[R[53]][R[36]], ({ [0] = { [0] = 34, [1] = 99, [2] = 121, [3] = 24 }, [1] = { [0] = 31, [1] = 93, [2] = 108, [3] = 17 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 36, [1] = 39, [2] = 195, [3] = 172 }, [3] = { [0] = 33, [1] = 41, [2] = 197, [3] = 178 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [6] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 }, [7] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 } })[R[53]][R[36]], ({ [0] = { [0] = 35, [1] = 100, [2] = 122, [3] = 25 }, [1] = { [0] = 32, [1] = 94, [2] = 109, [3] = 18 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 36, [1] = 39, [2] = 195, [3] = 172 }, [3] = { [0] = 33, [1] = 41, [2] = 197, [3] = 178 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 37, [1] = 42, [2] = 199, [3] = 182 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 } })[R[53]][R[36]], ({ [0] = { [0] = 36, [1] = 101, [2] = 123, [3] = 26 }, [1] = { [0] = 33, [1] = 95, [2] = 110, [3] = 19 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 17, [1] = 85, [2] = 106, [3] = 9 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 45, [2] = 198, [3] = 183 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 34, [1] = 42, [2] = 198, [3] = 179 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 37, [1] = 42, [2] = 199, [3] = 182 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 30, [1] = 35, [2] = 192, [3] = 176 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 18, [1] = 86, [2] = 107, [3] = 10 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 46, [2] = 199, [3] = 184 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 30, [1] = 35, [2] = 192, [3] = 176 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 35, [1] = 97, [2] = 112, [3] = 21 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 19, [1] = 87, [2] = 108, [3] = 11 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 38, [1] = 41, [2] = 197, [3] = 174 }, [3] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 39, [1] = 44, [2] = 201, [3] = 184 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 36, [1] = 98, [2] = 113, [3] = 22 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 21, [1] = 89, [2] = 104, [3] = 14 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 20, [1] = 88, [2] = 109, [3] = 12 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 48, [2] = 201, [3] = 186 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 38, [1] = 41, [2] = 197, [3] = 174 }, [3] = { [0] = 37, [1] = 45, [2] = 201, [3] = 182 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 41, [1] = 103, [2] = 118, [3] = 27 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 21, [1] = 89, [2] = 110, [3] = 13 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 49, [1] = 49, [2] = 202, [3] = 187 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 39, [1] = 42, [2] = 198, [3] = 175 }, [3] = { [0] = 38, [1] = 46, [2] = 202, [3] = 183 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 42, [1] = 104, [2] = 119, [3] = 28 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 25, [1] = 93, [2] = 109, [3] = 18 } })[R[53]][R[36]] })
    if R[53] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 50, [1] = 50, [2] = 203, [3] = 188 })[R[36]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 51, [1] = 51, [2] = 204, [3] = 189 })[R[36]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 50, [1] = 50, [2] = 203, [3] = 188 })[R[36]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 51, [1] = 51, [2] = 204, [3] = 189 })[R[36]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[36]] })
        for i = 1, game.initial_units() do
          R[54] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 48, [1] = 48, [2] = 201, [3] = 186 }, [1] = { [0] = 35, [1] = 35, [2] = 188, [3] = 173 }, [2] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 } })[R[54]][R[36]], ({ [0] = { [0] = 25, [1] = 90, [2] = 112, [3] = 15 }, [1] = { [0] = 34, [1] = 99, [2] = 121, [3] = 24 }, [2] = { [0] = 37, [1] = 102, [2] = 124, [3] = 27 } })[R[54]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[36]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[36]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[36]], ({ [0] = 44, [1] = 106, [2] = 121, [3] = 30 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[36]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[36]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[36]], ({ [0] = 44, [1] = 106, [2] = 121, [3] = 30 })[R[36]] })
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 188, [3] = 170 }, [1] = { [0] = 31, [1] = 34, [2] = 190, [3] = 172 }, [2] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 } })[R[55]][R[36]], ({ [0] = { [0] = 38, [1] = 100, [2] = 115, [3] = 24 }, [1] = { [0] = 40, [1] = 102, [2] = 117, [3] = 26 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 18 } })[R[55]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[56] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 30, [1] = 33, [2] = 189, [3] = 166 }, [1] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [2] = { [0] = 48, [1] = 51, [2] = 207, [3] = 184 } })[R[56]][R[36]], ({ [0] = { [0] = 23, [1] = 85, [2] = 100, [3] = 10 }, [1] = { [0] = 39, [1] = 101, [2] = 116, [3] = 26 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 19 } })[R[56]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 46, [2] = 202, [3] = 183 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 47, [2] = 203, [3] = 184 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 48, [2] = 204, [3] = 185 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[36]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 29, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 30, [1] = 97, [2] = 112, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 31, [1] = 98, [2] = 113, [3] = 23 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[36]], ({ [0] = 33, [1] = 100, [2] = 115, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[36]], ({ [0] = 34, [1] = 101, [2] = 116, [3] = 26 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 46, [2] = 202, [3] = 183 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 47, [2] = 203, [3] = 184 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 48, [2] = 204, [3] = 185 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[36]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 29, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 30, [1] = 97, [2] = 112, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 31, [1] = 98, [2] = 113, [3] = 23 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[36]], ({ [0] = 33, [1] = 100, [2] = 115, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[36]], ({ [0] = 34, [1] = 101, [2] = 116, [3] = 26 })[R[36]] })
        for i = 1, game.initial_units() do
          R[57] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [1] = { [0] = 37, [1] = 45, [2] = 201, [3] = 182 }, [2] = { [0] = 24, [1] = 32, [2] = 188, [3] = 169 } })[R[57]][R[36]], ({ [0] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [1] = { [0] = 35, [1] = 102, [2] = 117, [3] = 27 }, [2] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 } })[R[57]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 4 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[36]], ({ [0] = 21, [1] = 89, [2] = 104, [3] = 14 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[36]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[36]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[36]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 29, [1] = 97, [2] = 112, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 30, [1] = 98, [2] = 113, [3] = 23 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[36]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[36]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 25, [1] = 93, [2] = 108, [3] = 18 })[R[36]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 109, [3] = 19 })[R[36]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[36]] })
        for i = 1, game.initial_units() do
          R[58] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [1] = { [0] = 29, [1] = 34, [2] = 193, [3] = 175 }, [2] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 } })[R[58]][R[36]], ({ [0] = { [0] = 19, [1] = 87, [2] = 102, [3] = 12 }, [1] = { [0] = 27, [1] = 95, [2] = 110, [3] = 20 }, [2] = { [0] = 22, [1] = 90, [2] = 105, [3] = 15 } })[R[58]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[36]], ({ [0] = 21, [1] = 89, [2] = 104, [3] = 14 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[36]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[36]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[36]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 29, [1] = 97, [2] = 112, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 30, [1] = 98, [2] = 113, [3] = 23 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[36]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[36]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 25, [1] = 93, [2] = 108, [3] = 18 })[R[36]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 109, [3] = 19 })[R[36]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[36]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[36]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 19 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[36]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 20 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[36]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 19 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[36]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 20 })[R[36]] })
        for i = 1, game.initial_units() do
          R[59] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [1] = { [0] = 19, [1] = 24, [2] = 181, [3] = 164 }, [2] = { [0] = 41, [1] = 46, [2] = 203, [3] = 186 } })[R[59]][R[36]], ({ [0] = { [0] = 37, [1] = 105, [2] = 121, [3] = 26 }, [1] = { [0] = 24, [1] = 92, [2] = 108, [3] = 13 }, [2] = { [0] = 37, [1] = 105, [2] = 121, [3] = 26 } })[R[59]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 48, [1] = 53, [2] = 210, [3] = 194 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 49, [1] = 54, [2] = 211, [3] = 195 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 48, [1] = 53, [2] = 210, [3] = 194 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 49, [1] = 54, [2] = 211, [3] = 195 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] })
        for i = 1, game.initial_units() do
          R[60] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 }, [1] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [2] = { [0] = 54, [1] = 59, [2] = 216, [3] = 200 } })[R[60]][R[36]], ({ [0] = { [0] = 13, [1] = 81, [2] = 102, [3] = 5 }, [1] = { [0] = 11, [1] = 79, [2] = 100, [3] = 3 }, [2] = { [0] = 26, [1] = 94, [2] = 115, [3] = 18 } })[R[60]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 34, [1] = 102, [2] = 118, [3] = 27 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 35, [1] = 103, [2] = 119, [3] = 28 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 25, [1] = 93, [2] = 109, [3] = 18 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 34, [1] = 102, [2] = 118, [3] = 27 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 35, [1] = 103, [2] = 119, [3] = 28 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 25, [1] = 93, [2] = 109, [3] = 18 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[36]] })
        for i = 1, game.initial_units() do
          R[61] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 }, [1] = { [0] = 35, [1] = 40, [2] = 197, [3] = 181 }, [2] = { [0] = 23, [1] = 28, [2] = 185, [3] = 169 } })[R[61]][R[36]], ({ [0] = { [0] = 19, [1] = 87, [2] = 103, [3] = 12 }, [1] = { [0] = 19, [1] = 87, [2] = 103, [3] = 12 }, [2] = { [0] = 40, [1] = 108, [2] = 124, [3] = 33 } })[R[61]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[53]", R[53])
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
    R[17] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 24, [1] = 86, [2] = 101, [3] = 11 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 24, [1] = 86, [2] = 101, [3] = 11 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[17]][R[16]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 29, [1] = 32, [2] = 188, [3] = 165 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 21, [1] = 83, [2] = 98, [3] = 7 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 36, [1] = 103, [2] = 118, [3] = 28 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    if R[17] == 0 or R[17] == 1 or R[17] == 2 or R[17] == 5 or R[17] == 6 or R[17] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 54, [1] = 54, [2] = 207, [3] = 192 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 32, [1] = 35, [2] = 191, [3] = 168 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 43, [1] = 48, [2] = 205, [3] = 189 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 28, [1] = 90, [2] = 105, [3] = 14 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [5] = { [0] = 33, [1] = 101, [2] = 117, [3] = 22 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 0 then
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
      elseif R[17] == 1 then
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
      elseif R[17] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 31, [1] = 31, [2] = 184, [3] = 169 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 34, [1] = 39, [2] = 196, [3] = 180 }, [7] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 38, [1] = 100, [2] = 115, [3] = 24 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 35, [1] = 103, [2] = 119, [3] = 28 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 2 or R[17] == 5 or R[17] == 6 or R[17] == 7 then
      elseif R[17] == 0 or R[17] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 } })[R[17]][R[16]], ({ [0] = { [0] = 38, [1] = 103, [2] = 125, [3] = 28 }, [1] = { [0] = 46, [1] = 108, [2] = 123, [3] = 32 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[17]", R[17])
      end
    elseif R[17] == 3 or R[17] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 } })[R[17]][R[16]], ({ [3] = { [0] = 36, [1] = 103, [2] = 118, [3] = 28 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 30, [1] = 38, [2] = 194, [3] = 175 })[R[16]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 115, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
    else
      unseen("R[17]", R[17])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 31, [1] = 31, [2] = 184, [3] = 169 }, [1] = { [0] = 28, [1] = 31, [2] = 187, [3] = 169 }, [2] = { [0] = 49, [1] = 52, [2] = 208, [3] = 185 }, [3] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [4] = { [0] = 26, [1] = 31, [2] = 190, [3] = 172 }, [5] = { [0] = 20, [1] = 25, [2] = 182, [3] = 165 }, [6] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 }, [7] = { [0] = 32, [1] = 37, [2] = 194, [3] = 178 } })[R[17]][R[16]], ({ [0] = { [0] = 40, [1] = 105, [2] = 127, [3] = 30 }, [1] = { [0] = 43, [1] = 105, [2] = 120, [3] = 29 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 19, [1] = 86, [2] = 101, [3] = 11 }, [4] = { [0] = 24, [1] = 92, [2] = 107, [3] = 17 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 39, [1] = 107, [2] = 123, [3] = 32 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 38, [1] = 38, [2] = 191, [3] = 176 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 44, [1] = 49, [2] = 208, [3] = 190 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 33, [1] = 95, [2] = 110, [3] = 20 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 19, [1] = 87, [2] = 103, [3] = 8 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 28, [1] = 36, [2] = 192, [3] = 173 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 27, [1] = 89, [2] = 104, [3] = 13 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[17] == 0 or R[17] == 1 or R[17] == 2 or R[17] == 4 or R[17] == 5 or R[17] == 6 or R[17] == 7 then
    elseif R[17] == 3 then
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 45, [1] = 53, [2] = 209, [3] = 190 })[R[16]], ({ [0] = 26, [1] = 93, [2] = 108, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 22, [1] = 89, [2] = 104, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    else
      unseen("R[17]", R[17])
    end
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[17]][R[16]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[17]][R[16]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[17] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 36, [1] = 36, [2] = 189, [3] = 174 })[R[16]], ({ [0] = 27, [1] = 92, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 36, [1] = 36, [2] = 189, [3] = 174 })[R[16]], ({ [0] = 27, [1] = 92, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 47, [1] = 47, [2] = 200, [3] = 185 })[R[16]], ({ [0] = 33, [1] = 98, [2] = 120, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 33, [1] = 33, [2] = 186, [3] = 171 })[R[16]], ({ [0] = 27, [1] = 92, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 33, [1] = 33, [2] = 186, [3] = 171 })[R[16]], ({ [0] = 24, [1] = 89, [2] = 111, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 36, [1] = 36, [2] = 189, [3] = 174 })[R[16]], ({ [0] = 27, [1] = 92, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 47, [1] = 47, [2] = 200, [3] = 185 })[R[16]], ({ [0] = 33, [1] = 98, [2] = 120, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 33, [1] = 33, [2] = 186, [3] = 171 })[R[16]], ({ [0] = 27, [1] = 92, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 33, [1] = 33, [2] = 186, [3] = 171 })[R[16]], ({ [0] = 24, [1] = 89, [2] = 111, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 33, [1] = 33, [2] = 186, [3] = 171 })[R[16]], ({ [0] = 27, [1] = 92, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 33, [1] = 33, [2] = 186, [3] = 171 })[R[16]], ({ [0] = 24, [1] = 89, [2] = 111, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 27, [1] = 30, [2] = 186, [3] = 168 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 30, [1] = 33, [2] = 189, [3] = 171 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 27, [1] = 30, [2] = 186, [3] = 168 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 33, [2] = 189, [3] = 171 })[R[16]], ({ [0] = 23, [1] = 85, [2] = 100, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 33, [1] = 36, [2] = 192, [3] = 174 })[R[16]], ({ [0] = 20, [1] = 82, [2] = 97, [3] = 6 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 27, [1] = 30, [2] = 186, [3] = 168 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 30, [1] = 33, [2] = 189, [3] = 171 })[R[16]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 33, [2] = 189, [3] = 171 })[R[16]], ({ [0] = 23, [1] = 85, [2] = 100, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 33, [1] = 36, [2] = 192, [3] = 174 })[R[16]], ({ [0] = 20, [1] = 82, [2] = 97, [3] = 6 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 33, [2] = 189, [3] = 171 })[R[16]], ({ [0] = 23, [1] = 85, [2] = 100, [3] = 9 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 33, [1] = 36, [2] = 192, [3] = 174 })[R[16]], ({ [0] = 20, [1] = 82, [2] = 97, [3] = 6 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 45, [1] = 48, [2] = 204, [3] = 181 })[R[16]], ({ [0] = 31, [1] = 93, [2] = 108, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 45, [1] = 48, [2] = 204, [3] = 181 })[R[16]], ({ [0] = 31, [1] = 93, [2] = 108, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 27, [1] = 30, [2] = 186, [3] = 163 })[R[16]], ({ [0] = 34, [1] = 96, [2] = 111, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 45, [1] = 48, [2] = 204, [3] = 181 })[R[16]], ({ [0] = 37, [1] = 99, [2] = 114, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[16]], ({ [0] = 38, [1] = 100, [2] = 115, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 45, [1] = 48, [2] = 204, [3] = 181 })[R[16]], ({ [0] = 31, [1] = 93, [2] = 108, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 27, [1] = 30, [2] = 186, [3] = 163 })[R[16]], ({ [0] = 34, [1] = 96, [2] = 111, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 45, [1] = 48, [2] = 204, [3] = 181 })[R[16]], ({ [0] = 37, [1] = 99, [2] = 114, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[16]], ({ [0] = 38, [1] = 100, [2] = 115, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 45, [1] = 48, [2] = 204, [3] = 181 })[R[16]], ({ [0] = 37, [1] = 99, [2] = 114, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[16]], ({ [0] = 38, [1] = 100, [2] = 115, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 3 then
      if LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 33, [2] = 189, [3] = 170 })[R[16]], ({ [0] = 26, [1] = 93, [2] = 108, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 39, [2] = 195, [3] = 176 })[R[16]], ({ [0] = 37, [1] = 104, [2] = 119, [3] = 29 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 33, [2] = 189, [3] = 170 })[R[16]], ({ [0] = 26, [1] = 93, [2] = 108, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 33, [2] = 189, [3] = 170 })[R[16]], ({ [0] = 26, [1] = 93, [2] = 108, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 39, [2] = 195, [3] = 176 })[R[16]], ({ [0] = 37, [1] = 104, [2] = 119, [3] = 29 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 46, [1] = 51, [2] = 210, [3] = 192 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 46, [1] = 51, [2] = 210, [3] = 192 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 38, [1] = 43, [2] = 202, [3] = 184 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 39, [1] = 44, [2] = 203, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 115, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 106, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 46, [1] = 51, [2] = 210, [3] = 192 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 38, [1] = 43, [2] = 202, [3] = 184 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 39, [1] = 44, [2] = 203, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 115, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 106, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 39, [1] = 44, [2] = 203, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 115, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 106, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 5 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 38, [1] = 43, [2] = 200, [3] = 183 })[R[16]], ({ [0] = 21, [1] = 89, [2] = 105, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 38, [1] = 43, [2] = 200, [3] = 183 })[R[16]], ({ [0] = 21, [1] = 89, [2] = 105, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 26, [1] = 31, [2] = 188, [3] = 171 })[R[16]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 25, [1] = 30, [2] = 187, [3] = 170 })[R[16]], ({ [0] = 18, [1] = 86, [2] = 102, [3] = 7 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 34, [1] = 39, [2] = 196, [3] = 179 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 38, [1] = 43, [2] = 200, [3] = 183 })[R[16]], ({ [0] = 21, [1] = 89, [2] = 105, [3] = 10 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 26, [1] = 31, [2] = 188, [3] = 171 })[R[16]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 25, [1] = 30, [2] = 187, [3] = 170 })[R[16]], ({ [0] = 18, [1] = 86, [2] = 102, [3] = 7 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 34, [1] = 39, [2] = 196, [3] = 179 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 25, [1] = 30, [2] = 187, [3] = 170 })[R[16]], ({ [0] = 18, [1] = 86, [2] = 102, [3] = 7 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 34, [1] = 39, [2] = 196, [3] = 179 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 117, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 117, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 46, [1] = 51, [2] = 208, [3] = 192 })[R[16]], ({ [0] = 15, [1] = 83, [2] = 104, [3] = 7 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 38, [1] = 43, [2] = 200, [3] = 184 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 111, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 117, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 46, [1] = 51, [2] = 208, [3] = 192 })[R[16]], ({ [0] = 15, [1] = 83, [2] = 104, [3] = 7 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 38, [1] = 43, [2] = 200, [3] = 184 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 111, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 38, [1] = 43, [2] = 200, [3] = 184 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 114, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 111, [3] = 14 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 7 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 42, [1] = 47, [2] = 204, [3] = 188 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 42, [1] = 47, [2] = 204, [3] = 188 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 41, [1] = 46, [2] = 203, [3] = 187 })[R[16]], ({ [0] = 24, [1] = 92, [2] = 108, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 26, [1] = 31, [2] = 188, [3] = 172 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 183, [3] = 167 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 42, [1] = 47, [2] = 204, [3] = 188 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 41, [1] = 46, [2] = 203, [3] = 187 })[R[16]], ({ [0] = 24, [1] = 92, [2] = 108, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 26, [1] = 31, [2] = 188, [3] = 172 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 183, [3] = 167 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 26, [1] = 31, [2] = 188, [3] = 172 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 183, [3] = 167 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[17]", R[17])
    end
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 54, [1] = 54, [2] = 207, [3] = 192 }, [1] = { [0] = 36, [1] = 39, [2] = 195, [3] = 177 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 47, [1] = 52, [2] = 211, [3] = 193 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 35, [1] = 40, [2] = 197, [3] = 181 } })[R[17]][R[16]], ({ [0] = { [0] = 35, [1] = 100, [2] = 122, [3] = 25 }, [1] = { [0] = 33, [1] = 95, [2] = 110, [3] = 19 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 23, [1] = 90, [2] = 105, [3] = 15 }, [4] = { [0] = 19, [1] = 87, [2] = 102, [3] = 12 }, [5] = { [0] = 35, [1] = 103, [2] = 119, [3] = 24 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 29, [1] = 97, [2] = 113, [3] = 22 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 34, [1] = 34, [2] = 187, [3] = 172 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 32, [1] = 35, [2] = 191, [3] = 168 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 22, [1] = 90, [2] = 105, [3] = 15 }, [5] = { [0] = 24, [1] = 92, [2] = 108, [3] = 13 }, [6] = { [0] = 17, [1] = 85, [2] = 106, [3] = 9 }, [7] = { [0] = 26, [1] = 94, [2] = 110, [3] = 19 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 35, [2] = 188, [3] = 173 }, [1] = { [0] = 31, [1] = 34, [2] = 190, [3] = 172 }, [2] = { [0] = 33, [1] = 36, [2] = 192, [3] = 169 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 33, [1] = 100, [2] = 115, [3] = 25 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 25, [1] = 93, [2] = 109, [3] = 14 }, [6] = { [0] = 18, [1] = 86, [2] = 107, [3] = 10 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 32, [1] = 35, [2] = 191, [3] = 173 }, [2] = { [0] = 34, [1] = 37, [2] = 193, [3] = 170 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 34, [1] = 101, [2] = 116, [3] = 26 }, [4] = { [0] = 24, [1] = 92, [2] = 107, [3] = 17 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 19, [1] = 87, [2] = 108, [3] = 11 }, [7] = { [0] = 28, [1] = 96, [2] = 112, [3] = 21 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 37, [2] = 190, [3] = 175 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 28, [1] = 36, [2] = 192, [3] = 173 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 26, [1] = 88, [2] = 103, [3] = 13 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 25, [1] = 93, [2] = 108, [3] = 18 }, [5] = { [0] = 30, [1] = 98, [2] = 114, [3] = 19 }, [6] = { [0] = 20, [1] = 88, [2] = 109, [3] = 12 }, [7] = { [0] = 29, [1] = 97, [2] = 113, [3] = 22 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 38, [2] = 191, [3] = 176 }, [1] = { [0] = 34, [1] = 37, [2] = 193, [3] = 175 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 27, [1] = 89, [2] = 104, [3] = 14 }, [3] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [4] = { [0] = 26, [1] = 94, [2] = 109, [3] = 19 }, [5] = { [0] = 31, [1] = 99, [2] = 115, [3] = 20 }, [6] = { [0] = 21, [1] = 89, [2] = 110, [3] = 13 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 39, [2] = 192, [3] = 177 }, [1] = { [0] = 35, [1] = 38, [2] = 194, [3] = 176 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 36, [1] = 41, [2] = 198, [3] = 182 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 28, [1] = 90, [2] = 105, [3] = 15 }, [3] = { [0] = 29, [1] = 96, [2] = 111, [3] = 21 }, [4] = { [0] = 30, [1] = 98, [2] = 113, [3] = 23 }, [5] = { [0] = 32, [1] = 100, [2] = 116, [3] = 21 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 31, [1] = 99, [2] = 115, [3] = 24 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 40, [1] = 40, [2] = 193, [3] = 178 }, [1] = { [0] = 36, [1] = 39, [2] = 195, [3] = 177 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 33, [1] = 38, [2] = 195, [3] = 178 }, [6] = { [0] = 37, [1] = 42, [2] = 199, [3] = 183 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 30, [1] = 97, [2] = 112, [3] = 22 }, [4] = { [0] = 31, [1] = 99, [2] = 114, [3] = 24 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 33, [1] = 38, [2] = 195, [3] = 178 }, [6] = { [0] = 37, [1] = 42, [2] = 199, [3] = 183 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 91, [2] = 113, [3] = 16 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 30, [1] = 92, [2] = 107, [3] = 17 }, [3] = { [0] = 31, [1] = 98, [2] = 113, [3] = 23 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 33, [1] = 101, [2] = 117, [3] = 26 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 24, [1] = 86, [2] = 101, [3] = 10 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 33, [1] = 101, [2] = 116, [3] = 26 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 34, [1] = 102, [2] = 118, [3] = 27 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 30, [1] = 38, [2] = 194, [3] = 175 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 27, [1] = 32, [2] = 189, [3] = 173 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 93, [2] = 115, [3] = 18 }, [1] = { [0] = 25, [1] = 87, [2] = 102, [3] = 11 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 19 }, [3] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [4] = { [0] = 34, [1] = 102, [2] = 117, [3] = 27 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 30, [1] = 38, [2] = 194, [3] = 175 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 35, [1] = 40, [2] = 197, [3] = 180 }, [6] = { [0] = 39, [1] = 44, [2] = 201, [3] = 185 }, [7] = { [0] = 27, [1] = 32, [2] = 189, [3] = 173 } })[R[17]][R[16]], ({ [0] = { [0] = 29, [1] = 94, [2] = 116, [3] = 19 }, [1] = { [0] = 26, [1] = 88, [2] = 103, [3] = 12 }, [2] = { [0] = 33, [1] = 95, [2] = 110, [3] = 20 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 35, [1] = 40, [2] = 197, [3] = 180 }, [6] = { [0] = 39, [1] = 44, [2] = 201, [3] = 185 }, [7] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 } })[R[17]][R[16]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 32, [1] = 40, [2] = 196, [3] = 177 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [6] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 }, [7] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 } })[R[17]][R[16]], ({ [0] = { [0] = 34, [1] = 99, [2] = 121, [3] = 24 }, [1] = { [0] = 31, [1] = 93, [2] = 108, [3] = 17 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 36, [1] = 39, [2] = 195, [3] = 172 }, [3] = { [0] = 33, [1] = 41, [2] = 197, [3] = 178 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [6] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 }, [7] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 } })[R[17]][R[16]], ({ [0] = { [0] = 35, [1] = 100, [2] = 122, [3] = 25 }, [1] = { [0] = 32, [1] = 94, [2] = 109, [3] = 18 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 36, [1] = 39, [2] = 195, [3] = 172 }, [3] = { [0] = 33, [1] = 41, [2] = 197, [3] = 178 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 37, [1] = 42, [2] = 199, [3] = 182 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 } })[R[17]][R[16]], ({ [0] = { [0] = 36, [1] = 101, [2] = 123, [3] = 26 }, [1] = { [0] = 33, [1] = 95, [2] = 110, [3] = 19 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 17, [1] = 85, [2] = 106, [3] = 9 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 45, [2] = 198, [3] = 183 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 34, [1] = 42, [2] = 198, [3] = 179 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 37, [1] = 42, [2] = 199, [3] = 182 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 30, [1] = 35, [2] = 192, [3] = 176 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 18, [1] = 86, [2] = 107, [3] = 10 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 46, [2] = 199, [3] = 184 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 30, [1] = 35, [2] = 192, [3] = 176 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 35, [1] = 97, [2] = 112, [3] = 21 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 19, [1] = 87, [2] = 108, [3] = 11 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 38, [1] = 41, [2] = 197, [3] = 174 }, [3] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 39, [1] = 44, [2] = 201, [3] = 184 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 36, [1] = 98, [2] = 113, [3] = 22 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 21, [1] = 89, [2] = 104, [3] = 14 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 20, [1] = 88, [2] = 109, [3] = 12 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 48, [2] = 201, [3] = 186 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 38, [1] = 41, [2] = 197, [3] = 174 }, [3] = { [0] = 37, [1] = 45, [2] = 201, [3] = 182 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 41, [1] = 103, [2] = 118, [3] = 27 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 21, [1] = 89, [2] = 110, [3] = 13 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[17]][R[16]] })
    game.create_tube({ ({ [0] = { [0] = 49, [1] = 49, [2] = 202, [3] = 187 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 39, [1] = 42, [2] = 198, [3] = 175 }, [3] = { [0] = 38, [1] = 46, [2] = 202, [3] = 183 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[17]][R[16]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 42, [1] = 104, [2] = 119, [3] = 28 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 25, [1] = 93, [2] = 109, [3] = 18 } })[R[17]][R[16]] })
    if R[17] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 50, [1] = 50, [2] = 203, [3] = 188 })[R[16]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 51, [1] = 51, [2] = 204, [3] = 189 })[R[16]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 50, [1] = 50, [2] = 203, [3] = 188 })[R[16]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 51, [1] = 51, [2] = 204, [3] = 189 })[R[16]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[16]] })
        for i = 1, game.initial_units() do
          R[63] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 48, [1] = 48, [2] = 201, [3] = 186 }, [1] = { [0] = 35, [1] = 35, [2] = 188, [3] = 173 }, [2] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 } })[R[63]][R[16]], ({ [0] = { [0] = 25, [1] = 90, [2] = 112, [3] = 15 }, [1] = { [0] = 34, [1] = 99, [2] = 121, [3] = 24 }, [2] = { [0] = 37, [1] = 102, [2] = 124, [3] = 27 } })[R[63]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 44, [1] = 106, [2] = 121, [3] = 30 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[16]], ({ [0] = 44, [1] = 106, [2] = 121, [3] = 30 })[R[16]] })
        for i = 1, game.initial_units() do
          R[64] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 188, [3] = 170 }, [1] = { [0] = 31, [1] = 34, [2] = 190, [3] = 172 }, [2] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 } })[R[64]][R[16]], ({ [0] = { [0] = 38, [1] = 100, [2] = 115, [3] = 24 }, [1] = { [0] = 40, [1] = 102, [2] = 117, [3] = 26 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 18 } })[R[64]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[65] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 30, [1] = 33, [2] = 189, [3] = 166 }, [1] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [2] = { [0] = 48, [1] = 51, [2] = 207, [3] = 184 } })[R[65]][R[16]], ({ [0] = { [0] = 23, [1] = 85, [2] = 100, [3] = 10 }, [1] = { [0] = 39, [1] = 101, [2] = 116, [3] = 26 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 19 } })[R[65]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 46, [2] = 202, [3] = 183 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 47, [2] = 203, [3] = 184 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 48, [2] = 204, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 29, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 30, [1] = 97, [2] = 112, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 31, [1] = 98, [2] = 113, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 33, [1] = 100, [2] = 115, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 34, [1] = 101, [2] = 116, [3] = 26 })[R[16]] })
        for i = 1, game.initial_units() do
          R[66] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [1] = { [0] = 37, [1] = 45, [2] = 201, [3] = 182 }, [2] = { [0] = 24, [1] = 32, [2] = 188, [3] = 169 } })[R[66]][R[16]], ({ [0] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [1] = { [0] = 35, [1] = 102, [2] = 117, [3] = 27 }, [2] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 } })[R[66]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 46, [2] = 202, [3] = 183 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 47, [2] = 203, [3] = 184 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 48, [2] = 204, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 29, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 30, [1] = 97, [2] = 112, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 31, [1] = 98, [2] = 113, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 33, [1] = 100, [2] = 115, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[16]], ({ [0] = 34, [1] = 101, [2] = 116, [3] = 26 })[R[16]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 4 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 21, [1] = 89, [2] = 104, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 29, [1] = 97, [2] = 112, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 113, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 108, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 109, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
        for i = 1, game.initial_units() do
          R[67] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [1] = { [0] = 29, [1] = 34, [2] = 193, [3] = 175 }, [2] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 } })[R[67]][R[16]], ({ [0] = { [0] = 19, [1] = 87, [2] = 102, [3] = 12 }, [1] = { [0] = 27, [1] = 95, [2] = 110, [3] = 20 }, [2] = { [0] = 22, [1] = 90, [2] = 105, [3] = 15 } })[R[67]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 21, [1] = 89, [2] = 104, [3] = 14 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 29, [1] = 97, [2] = 112, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 113, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 108, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 109, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[16]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 20 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[16]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 20 })[R[16]] })
        for i = 1, game.initial_units() do
          R[68] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [1] = { [0] = 19, [1] = 24, [2] = 181, [3] = 164 }, [2] = { [0] = 41, [1] = 46, [2] = 203, [3] = 186 } })[R[68]][R[16]], ({ [0] = { [0] = 37, [1] = 105, [2] = 121, [3] = 26 }, [1] = { [0] = 24, [1] = 92, [2] = 108, [3] = 13 }, [2] = { [0] = 37, [1] = 105, [2] = 121, [3] = 26 } })[R[68]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 48, [1] = 53, [2] = 210, [3] = 194 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 49, [1] = 54, [2] = 211, [3] = 195 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 48, [1] = 53, [2] = 210, [3] = 194 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
        game.create_tube({ ({ [0] = 49, [1] = 54, [2] = 211, [3] = 195 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[16]] })
        for i = 1, game.initial_units() do
          R[69] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 }, [1] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [2] = { [0] = 54, [1] = 59, [2] = 216, [3] = 200 } })[R[69]][R[16]], ({ [0] = { [0] = 13, [1] = 81, [2] = 102, [3] = 5 }, [1] = { [0] = 11, [1] = 79, [2] = 100, [3] = 3 }, [2] = { [0] = 26, [1] = 94, [2] = 115, [3] = 18 } })[R[69]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 34, [1] = 102, [2] = 118, [3] = 27 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 119, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 109, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 34, [1] = 102, [2] = 118, [3] = 27 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 35, [1] = 103, [2] = 119, [3] = 28 })[R[16]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[16]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[16]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[16]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 25, [1] = 93, [2] = 109, [3] = 18 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 24 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[16]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[16]] })
        for i = 1, game.initial_units() do
          R[70] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 }, [1] = { [0] = 35, [1] = 40, [2] = 197, [3] = 181 }, [2] = { [0] = 23, [1] = 28, [2] = 185, [3] = 169 } })[R[70]][R[16]], ({ [0] = { [0] = 19, [1] = 87, [2] = 103, [3] = 12 }, [1] = { [0] = 19, [1] = 87, [2] = 103, [3] = 12 }, [2] = { [0] = 40, [1] = 108, [2] = 124, [3] = 33 } })[R[70]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[17]", R[17])
    end
    R[26] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 27, [2] = 35, [3] = 35, [4] = 34, [5] = 30, [6] = 33, [7] = 31 }, [1] = { [0] = 42, [1] = 30, [2] = 38, [3] = 43, [4] = 39, [5] = 35, [6] = 38, [7] = 36 }, [2] = { [0] = 195, [1] = 186, [2] = 194, [3] = 199, [4] = 198, [5] = 192, [6] = 195, [7] = 193 }, [3] = { [0] = 180, [1] = 168, [2] = 171, [3] = 180, [4] = 180, [5] = 175, [6] = 179, [7] = 177 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 24, [3] = 32, [4] = 28, [5] = 28, [6] = 15, [7] = 30 }, [1] = { [0] = 96, [1] = 96, [2] = 86, [3] = 99, [4] = 96, [5] = 96, [6] = 83, [7] = 98 }, [2] = { [0] = 118, [1] = 111, [2] = 101, [3] = 114, [4] = 111, [5] = 112, [6] = 104, [7] = 114 }, [3] = { [0] = 21, [1] = 20, [2] = 11, [3] = 24, [4] = 21, [5] = 17, [6] = 7, [7] = 23 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 42, [1] = 27, [2] = 35, [3] = 35, [4] = 34, [5] = 30, [6] = 33, [7] = 31 }, [1] = { [0] = 42, [1] = 30, [2] = 38, [3] = 43, [4] = 39, [5] = 35, [6] = 38, [7] = 36 }, [2] = { [0] = 195, [1] = 186, [2] = 194, [3] = 199, [4] = 198, [5] = 192, [6] = 195, [7] = 193 }, [3] = { [0] = 180, [1] = 168, [2] = 171, [3] = 180, [4] = 180, [5] = 175, [6] = 179, [7] = 177 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 24, [3] = 32, [4] = 28, [5] = 28, [6] = 15, [7] = 30 }, [1] = { [0] = 96, [1] = 96, [2] = 86, [3] = 99, [4] = 96, [5] = 96, [6] = 83, [7] = 98 }, [2] = { [0] = 118, [1] = 111, [2] = 101, [3] = 114, [4] = 111, [5] = 112, [6] = 104, [7] = 114 }, [3] = { [0] = 21, [1] = 20, [2] = 11, [3] = 24, [4] = 21, [5] = 17, [6] = 7, [7] = 23 } })[R[35]][R[26]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 37, [2] = 29, [3] = 43, [4] = 34, [5] = 30, [6] = 42, [7] = 24 }, [1] = { [0] = 42, [1] = 40, [2] = 32, [3] = 51, [4] = 39, [5] = 35, [6] = 47, [7] = 29 }, [2] = { [0] = 195, [1] = 196, [2] = 188, [3] = 207, [4] = 198, [5] = 192, [6] = 204, [7] = 186 }, [3] = { [0] = 180, [1] = 178, [2] = 165, [3] = 188, [4] = 180, [5] = 175, [6] = 188, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 24, [1] = 21, [2] = 29, [3] = 36, [4] = 36, [5] = 34, [6] = 15, [7] = 36 }, [1] = { [0] = 89, [1] = 83, [2] = 91, [3] = 103, [4] = 104, [5] = 102, [6] = 83, [7] = 104 }, [2] = { [0] = 111, [1] = 98, [2] = 106, [3] = 118, [4] = 119, [5] = 118, [6] = 104, [7] = 120 }, [3] = { [0] = 14, [1] = 7, [2] = 16, [3] = 28, [4] = 29, [5] = 23, [6] = 7, [7] = 29 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    if R[26] == 0 or R[26] == 1 or R[26] == 2 or R[26] == 5 or R[26] == 6 or R[26] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 54, [1] = 38, [2] = 32, [5] = 40, [6] = 43, [7] = 24 }, [1] = { [0] = 54, [1] = 41, [2] = 35, [5] = 45, [6] = 48, [7] = 29 }, [2] = { [0] = 207, [1] = 197, [2] = 191, [5] = 202, [6] = 205, [7] = 186 }, [3] = { [0] = 192, [1] = 179, [2] = 168, [5] = 185, [6] = 189, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 28, [2] = 35, [5] = 33, [6] = 23, [7] = 23 }, [1] = { [0] = 96, [1] = 90, [2] = 97, [5] = 101, [6] = 91, [7] = 91 }, [2] = { [0] = 118, [1] = 105, [2] = 112, [5] = 117, [6] = 112, [7] = 107 }, [3] = { [0] = 21, [1] = 14, [2] = 22, [5] = 22, [6] = 15, [7] = 16 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 0 then
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
      elseif R[26] == 1 then
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
      elseif R[26] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[35]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[35]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[35]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[26]", R[26])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 38, [2] = 41, [5] = 30, [6] = 34, [7] = 40 }, [1] = { [0] = 31, [1] = 41, [2] = 44, [5] = 35, [6] = 39, [7] = 45 }, [2] = { [0] = 184, [1] = 197, [2] = 200, [5] = 192, [6] = 196, [7] = 202 }, [3] = { [0] = 169, [1] = 179, [2] = 177, [5] = 175, [6] = 180, [7] = 186 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 38, [2] = 35, [5] = 21, [6] = 23, [7] = 35 }, [1] = { [0] = 96, [1] = 100, [2] = 97, [5] = 89, [6] = 91, [7] = 103 }, [2] = { [0] = 118, [1] = 115, [2] = 112, [5] = 105, [6] = 112, [7] = 119 }, [3] = { [0] = 21, [1] = 24, [2] = 22, [5] = 10, [6] = 15, [7] = 28 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 2 or R[26] == 5 or R[26] == 6 or R[26] == 7 then
      elseif R[26] == 0 or R[26] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 37 }, [1] = { [0] = 42, [1] = 40 }, [2] = { [0] = 195, [1] = 196 }, [3] = { [0] = 180, [1] = 178 } })[R[35]][R[26]], ({ [0] = { [0] = 38, [1] = 46 }, [1] = { [0] = 103, [1] = 108 }, [2] = { [0] = 125, [1] = 123 }, [3] = { [0] = 28, [1] = 32 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[26]", R[26])
      end
    elseif R[26] == 3 or R[26] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [3] = 27, [4] = 34 }, [1] = { [3] = 35, [4] = 39 }, [2] = { [3] = 191, [4] = 198 }, [3] = { [3] = 172, [4] = 180 } })[R[35]][R[26]], ({ [0] = { [3] = 36, [4] = 20 }, [1] = { [3] = 103, [4] = 88 }, [2] = { [3] = 118, [4] = 103 }, [3] = { [3] = 28, [4] = 13 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 3 then
      elseif R[26] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[26]", R[26])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [3] = 30, [4] = 45 }, [1] = { [3] = 38, [4] = 50 }, [2] = { [3] = 194, [4] = 209 }, [3] = { [3] = 175, [4] = 191 } })[R[35]][R[26]], ({ [0] = { [3] = 25, [4] = 32 }, [1] = { [3] = 92, [4] = 100 }, [2] = { [3] = 107, [4] = 115 }, [3] = { [3] = 17, [4] = 25 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 3 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[35]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[35]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[35]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 4 then
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
        unseen("R[26]", R[26])
      end
    else
      unseen("R[26]", R[26])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 28, [2] = 49, [3] = 36, [4] = 26, [5] = 20, [6] = 26, [7] = 32 }, [1] = { [0] = 31, [1] = 31, [2] = 52, [3] = 44, [4] = 31, [5] = 25, [6] = 31, [7] = 37 }, [2] = { [0] = 184, [1] = 187, [2] = 208, [3] = 200, [4] = 190, [5] = 182, [6] = 188, [7] = 194 }, [3] = { [0] = 169, [1] = 169, [2] = 185, [3] = 181, [4] = 172, [5] = 165, [6] = 172, [7] = 178 } })[R[35]][R[26]], ({ [0] = { [0] = 40, [1] = 43, [2] = 29, [3] = 19, [4] = 24, [5] = 28, [6] = 23, [7] = 39 }, [1] = { [0] = 105, [1] = 105, [2] = 91, [3] = 86, [4] = 92, [5] = 96, [6] = 91, [7] = 107 }, [2] = { [0] = 127, [1] = 120, [2] = 106, [3] = 101, [4] = 107, [5] = 112, [6] = 112, [7] = 123 }, [3] = { [0] = 30, [1] = 29, [2] = 16, [3] = 11, [4] = 17, [5] = 17, [6] = 15, [7] = 32 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 38, [1] = 27, [2] = 45, [3] = 25, [4] = 44, [5] = 38, [6] = 33, [7] = 42 }, [1] = { [0] = 38, [1] = 30, [2] = 48, [3] = 33, [4] = 49, [5] = 43, [6] = 38, [7] = 47 }, [2] = { [0] = 191, [1] = 186, [2] = 204, [3] = 189, [4] = 208, [5] = 200, [6] = 195, [7] = 204 }, [3] = { [0] = 176, [1] = 168, [2] = 181, [3] = 170, [4] = 190, [5] = 183, [6] = 179, [7] = 188 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 29, [2] = 33, [3] = 26, [4] = 28, [5] = 19, [6] = 28, [7] = 30 }, [1] = { [0] = 92, [1] = 91, [2] = 95, [3] = 93, [4] = 96, [5] = 87, [6] = 96, [7] = 98 }, [2] = { [0] = 114, [1] = 106, [2] = 110, [3] = 108, [4] = 111, [5] = 103, [6] = 117, [7] = 114 }, [3] = { [0] = 17, [1] = 15, [2] = 20, [3] = 18, [4] = 21, [5] = 8, [6] = 20, [7] = 23 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 27, [2] = 45, [3] = 28, [4] = 46, [5] = 38, [6] = 31, [7] = 42 }, [1] = { [0] = 36, [1] = 30, [2] = 48, [3] = 36, [4] = 51, [5] = 43, [6] = 36, [7] = 47 }, [2] = { [0] = 189, [1] = 186, [2] = 204, [3] = 192, [4] = 210, [5] = 200, [6] = 193, [7] = 204 }, [3] = { [0] = 174, [1] = 168, [2] = 181, [3] = 173, [4] = 192, [5] = 183, [6] = 177, [7] = 188 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 27, [2] = 31, [3] = 22, [4] = 28, [5] = 21, [6] = 28, [7] = 32 }, [1] = { [0] = 92, [1] = 89, [2] = 93, [3] = 89, [4] = 96, [5] = 89, [6] = 96, [7] = 100 }, [2] = { [0] = 114, [1] = 104, [2] = 108, [3] = 104, [4] = 111, [5] = 105, [6] = 117, [7] = 116 }, [3] = { [0] = 17, [1] = 13, [2] = 18, [3] = 14, [4] = 21, [5] = 10, [6] = 20, [7] = 25 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 30, [2] = 27, [3] = 45, [4] = 38, [5] = 26, [6] = 46, [7] = 41 }, [1] = { [0] = 47, [1] = 33, [2] = 30, [3] = 53, [4] = 43, [5] = 31, [6] = 51, [7] = 46 }, [2] = { [0] = 200, [1] = 189, [2] = 186, [3] = 209, [4] = 202, [5] = 188, [6] = 208, [7] = 203 }, [3] = { [0] = 185, [1] = 171, [2] = 163, [3] = 190, [4] = 184, [5] = 171, [6] = 192, [7] = 187 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 29, [2] = 34, [3] = 26, [4] = 36, [5] = 29, [6] = 15, [7] = 24 }, [1] = { [0] = 98, [1] = 91, [2] = 96, [3] = 93, [4] = 104, [5] = 97, [6] = 83, [7] = 92 }, [2] = { [0] = 120, [1] = 106, [2] = 111, [3] = 108, [4] = 119, [5] = 113, [6] = 104, [7] = 108 }, [3] = { [0] = 23, [1] = 15, [2] = 21, [3] = 18, [4] = 29, [5] = 18, [6] = 7, [7] = 17 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 30, [2] = 27, [3] = 43, [4] = 38, [5] = 26, [6] = 46, [7] = 41 }, [1] = { [0] = 47, [1] = 33, [2] = 30, [3] = 51, [4] = 43, [5] = 31, [6] = 51, [7] = 46 }, [2] = { [0] = 200, [1] = 189, [2] = 186, [3] = 207, [4] = 202, [5] = 188, [6] = 208, [7] = 203 }, [3] = { [0] = 185, [1] = 171, [2] = 163, [3] = 188, [4] = 184, [5] = 171, [6] = 192, [7] = 187 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 29, [2] = 34, [3] = 22, [4] = 36, [5] = 29, [6] = 15, [7] = 24 }, [1] = { [0] = 98, [1] = 91, [2] = 96, [3] = 89, [4] = 104, [5] = 97, [6] = 83, [7] = 92 }, [2] = { [0] = 120, [1] = 106, [2] = 111, [3] = 104, [4] = 119, [5] = 113, [6] = 104, [7] = 108 }, [3] = { [0] = 23, [1] = 15, [2] = 21, [3] = 14, [4] = 29, [5] = 18, [6] = 7, [7] = 17 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 36, [1] = 27, [2] = 45, [3] = 31, [4] = 46, [5] = 38, [6] = 31, [7] = 42 }, [1] = { [0] = 36, [1] = 30, [2] = 48, [3] = 39, [4] = 51, [5] = 43, [6] = 36, [7] = 47 }, [2] = { [0] = 189, [1] = 186, [2] = 204, [3] = 195, [4] = 210, [5] = 200, [6] = 193, [7] = 204 }, [3] = { [0] = 174, [1] = 168, [2] = 181, [3] = 176, [4] = 192, [5] = 183, [6] = 177, [7] = 188 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 29, [2] = 31, [3] = 37, [4] = 28, [5] = 21, [6] = 28, [7] = 32 }, [1] = { [0] = 92, [1] = 91, [2] = 93, [3] = 104, [4] = 96, [5] = 89, [6] = 96, [7] = 100 }, [2] = { [0] = 114, [1] = 106, [2] = 108, [3] = 119, [4] = 111, [5] = 105, [6] = 117, [7] = 116 }, [3] = { [0] = 17, [1] = 15, [2] = 18, [3] = 29, [4] = 21, [5] = 10, [6] = 20, [7] = 25 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 36, [1] = 30, [2] = 45, [3] = 31, [4] = 46, [5] = 38, [6] = 31, [7] = 42 }, [1] = { [0] = 36, [1] = 33, [2] = 48, [3] = 39, [4] = 51, [5] = 43, [6] = 36, [7] = 47 }, [2] = { [0] = 189, [1] = 189, [2] = 204, [3] = 195, [4] = 210, [5] = 200, [6] = 193, [7] = 204 }, [3] = { [0] = 174, [1] = 171, [2] = 181, [3] = 176, [4] = 192, [5] = 183, [6] = 177, [7] = 188 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 29, [2] = 31, [3] = 37, [4] = 28, [5] = 21, [6] = 28, [7] = 32 }, [1] = { [0] = 92, [1] = 91, [2] = 93, [3] = 104, [4] = 96, [5] = 89, [6] = 96, [7] = 100 }, [2] = { [0] = 114, [1] = 106, [2] = 108, [3] = 119, [4] = 111, [5] = 105, [6] = 117, [7] = 116 }, [3] = { [0] = 17, [1] = 15, [2] = 18, [3] = 29, [4] = 21, [5] = 10, [6] = 20, [7] = 25 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 27, [2] = 27, [3] = 25, [4] = 38, [5] = 26, [6] = 46, [7] = 41 }, [1] = { [0] = 47, [1] = 30, [2] = 30, [3] = 33, [4] = 43, [5] = 31, [6] = 51, [7] = 46 }, [2] = { [0] = 200, [1] = 186, [2] = 186, [3] = 189, [4] = 202, [5] = 188, [6] = 208, [7] = 203 }, [3] = { [0] = 185, [1] = 168, [2] = 163, [3] = 170, [4] = 184, [5] = 171, [6] = 192, [7] = 187 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 29, [2] = 34, [3] = 26, [4] = 36, [5] = 29, [6] = 15, [7] = 24 }, [1] = { [0] = 98, [1] = 91, [2] = 96, [3] = 93, [4] = 104, [5] = 97, [6] = 83, [7] = 92 }, [2] = { [0] = 120, [1] = 106, [2] = 111, [3] = 108, [4] = 119, [5] = 113, [6] = 104, [7] = 108 }, [3] = { [0] = 23, [1] = 15, [2] = 21, [3] = 18, [4] = 29, [5] = 18, [6] = 7, [7] = 17 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 30, [2] = 45, [3] = 25, [4] = 39, [5] = 25, [6] = 38, [7] = 26 }, [1] = { [0] = 33, [1] = 33, [2] = 48, [3] = 33, [4] = 44, [5] = 30, [6] = 43, [7] = 31 }, [2] = { [0] = 186, [1] = 189, [2] = 204, [3] = 189, [4] = 203, [5] = 187, [6] = 200, [7] = 188 }, [3] = { [0] = 171, [1] = 171, [2] = 181, [3] = 170, [4] = 185, [5] = 170, [6] = 184, [7] = 172 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 23, [2] = 37, [3] = 26, [4] = 32, [5] = 18, [6] = 25, [7] = 30 }, [1] = { [0] = 92, [1] = 85, [2] = 99, [3] = 93, [4] = 100, [5] = 86, [6] = 93, [7] = 98 }, [2] = { [0] = 114, [1] = 100, [2] = 114, [3] = 108, [4] = 115, [5] = 102, [6] = 114, [7] = 114 }, [3] = { [0] = 17, [1] = 9, [2] = 24, [3] = 18, [4] = 25, [5] = 7, [6] = 17, [7] = 23 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 41, [3] = 31, [4] = 41, [5] = 34, [6] = 47, [7] = 21 }, [1] = { [0] = 33, [1] = 36, [2] = 44, [3] = 39, [4] = 46, [5] = 39, [6] = 52, [7] = 26 }, [2] = { [0] = 186, [1] = 192, [2] = 200, [3] = 195, [4] = 205, [5] = 196, [6] = 209, [7] = 183 }, [3] = { [0] = 171, [1] = 174, [2] = 177, [3] = 176, [4] = 187, [5] = 179, [6] = 193, [7] = 167 } })[R[35]][R[26]], ({ [0] = { [0] = 24, [1] = 20, [2] = 38, [3] = 37, [4] = 23, [5] = 26, [6] = 22, [7] = 27 }, [1] = { [0] = 89, [1] = 82, [2] = 100, [3] = 104, [4] = 91, [5] = 94, [6] = 90, [7] = 95 }, [2] = { [0] = 111, [1] = 97, [2] = 115, [3] = 119, [4] = 106, [5] = 110, [6] = 111, [7] = 111 }, [3] = { [0] = 14, [1] = 6, [2] = 25, [3] = 29, [4] = 16, [5] = 15, [6] = 14, [7] = 20 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 30, [2] = 27, [3] = 45, [4] = 38, [5] = 26, [6] = 46, [7] = 41 }, [1] = { [0] = 47, [1] = 33, [2] = 30, [3] = 53, [4] = 43, [5] = 31, [6] = 51, [7] = 46 }, [2] = { [0] = 200, [1] = 189, [2] = 186, [3] = 209, [4] = 202, [5] = 188, [6] = 208, [7] = 203 }, [3] = { [0] = 185, [1] = 171, [2] = 163, [3] = 190, [4] = 184, [5] = 171, [6] = 192, [7] = 187 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 29, [2] = 34, [3] = 26, [4] = 36, [5] = 29, [6] = 15, [7] = 24 }, [1] = { [0] = 98, [1] = 91, [2] = 96, [3] = 93, [4] = 104, [5] = 97, [6] = 83, [7] = 92 }, [2] = { [0] = 120, [1] = 106, [2] = 111, [3] = 108, [4] = 119, [5] = 113, [6] = 104, [7] = 108 }, [3] = { [0] = 23, [1] = 15, [2] = 21, [3] = 18, [4] = 29, [5] = 18, [6] = 7, [7] = 17 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 30, [2] = 27, [3] = 43, [4] = 38, [5] = 26, [6] = 46, [7] = 41 }, [1] = { [0] = 47, [1] = 33, [2] = 30, [3] = 51, [4] = 43, [5] = 31, [6] = 51, [7] = 46 }, [2] = { [0] = 200, [1] = 189, [2] = 186, [3] = 207, [4] = 202, [5] = 188, [6] = 208, [7] = 203 }, [3] = { [0] = 185, [1] = 171, [2] = 163, [3] = 188, [4] = 184, [5] = 171, [6] = 192, [7] = 187 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 29, [2] = 34, [3] = 22, [4] = 36, [5] = 29, [6] = 15, [7] = 24 }, [1] = { [0] = 98, [1] = 91, [2] = 96, [3] = 89, [4] = 104, [5] = 97, [6] = 83, [7] = 92 }, [2] = { [0] = 120, [1] = 106, [2] = 111, [3] = 104, [4] = 119, [5] = 113, [6] = 104, [7] = 108 }, [3] = { [0] = 23, [1] = 15, [2] = 21, [3] = 14, [4] = 29, [5] = 18, [6] = 7, [7] = 17 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 36, [1] = 27, [2] = 45, [3] = 31, [4] = 46, [5] = 38, [6] = 31, [7] = 42 }, [1] = { [0] = 36, [1] = 30, [2] = 48, [3] = 39, [4] = 51, [5] = 43, [6] = 36, [7] = 47 }, [2] = { [0] = 189, [1] = 186, [2] = 204, [3] = 195, [4] = 210, [5] = 200, [6] = 193, [7] = 204 }, [3] = { [0] = 174, [1] = 168, [2] = 181, [3] = 176, [4] = 192, [5] = 183, [6] = 177, [7] = 188 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 29, [2] = 31, [3] = 37, [4] = 28, [5] = 21, [6] = 28, [7] = 32 }, [1] = { [0] = 92, [1] = 91, [2] = 93, [3] = 104, [4] = 96, [5] = 89, [6] = 96, [7] = 100 }, [2] = { [0] = 114, [1] = 106, [2] = 108, [3] = 119, [4] = 111, [5] = 105, [6] = 117, [7] = 116 }, [3] = { [0] = 17, [1] = 15, [2] = 18, [3] = 29, [4] = 21, [5] = 10, [6] = 20, [7] = 25 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 47, [1] = 30, [2] = 27, [3] = 31, [4] = 38, [5] = 26, [6] = 46, [7] = 41 }, [1] = { [0] = 47, [1] = 33, [2] = 30, [3] = 39, [4] = 43, [5] = 31, [6] = 51, [7] = 46 }, [2] = { [0] = 200, [1] = 189, [2] = 186, [3] = 195, [4] = 202, [5] = 188, [6] = 208, [7] = 203 }, [3] = { [0] = 185, [1] = 171, [2] = 163, [3] = 176, [4] = 184, [5] = 171, [6] = 192, [7] = 187 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 29, [2] = 34, [3] = 37, [4] = 36, [5] = 29, [6] = 15, [7] = 24 }, [1] = { [0] = 98, [1] = 91, [2] = 96, [3] = 104, [4] = 104, [5] = 97, [6] = 83, [7] = 92 }, [2] = { [0] = 120, [1] = 106, [2] = 111, [3] = 119, [4] = 119, [5] = 113, [6] = 104, [7] = 108 }, [3] = { [0] = 23, [1] = 15, [2] = 21, [3] = 29, [4] = 29, [5] = 18, [6] = 7, [7] = 17 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 30, [2] = 45, [3] = 25, [4] = 39, [5] = 25, [6] = 38, [7] = 26 }, [1] = { [0] = 33, [1] = 33, [2] = 48, [3] = 33, [4] = 44, [5] = 30, [6] = 43, [7] = 31 }, [2] = { [0] = 186, [1] = 189, [2] = 204, [3] = 189, [4] = 203, [5] = 187, [6] = 200, [7] = 188 }, [3] = { [0] = 171, [1] = 171, [2] = 181, [3] = 170, [4] = 185, [5] = 170, [6] = 184, [7] = 172 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 23, [2] = 37, [3] = 26, [4] = 32, [5] = 18, [6] = 25, [7] = 30 }, [1] = { [0] = 92, [1] = 85, [2] = 99, [3] = 93, [4] = 100, [5] = 86, [6] = 93, [7] = 98 }, [2] = { [0] = 114, [1] = 100, [2] = 114, [3] = 108, [4] = 115, [5] = 102, [6] = 114, [7] = 114 }, [3] = { [0] = 17, [1] = 9, [2] = 24, [3] = 18, [4] = 25, [5] = 7, [6] = 17, [7] = 23 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 41, [3] = 31, [4] = 41, [5] = 34, [6] = 47, [7] = 21 }, [1] = { [0] = 33, [1] = 36, [2] = 44, [3] = 39, [4] = 46, [5] = 39, [6] = 52, [7] = 26 }, [2] = { [0] = 186, [1] = 192, [2] = 200, [3] = 195, [4] = 205, [5] = 196, [6] = 209, [7] = 183 }, [3] = { [0] = 171, [1] = 174, [2] = 177, [3] = 176, [4] = 187, [5] = 179, [6] = 193, [7] = 167 } })[R[35]][R[26]], ({ [0] = { [0] = 24, [1] = 20, [2] = 38, [3] = 37, [4] = 23, [5] = 26, [6] = 22, [7] = 27 }, [1] = { [0] = 89, [1] = 82, [2] = 100, [3] = 104, [4] = 91, [5] = 94, [6] = 90, [7] = 95 }, [2] = { [0] = 111, [1] = 97, [2] = 115, [3] = 119, [4] = 106, [5] = 110, [6] = 111, [7] = 111 }, [3] = { [0] = 14, [1] = 6, [2] = 25, [3] = 29, [4] = 16, [5] = 15, [6] = 14, [7] = 20 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 30, [2] = 27, [3] = 45, [4] = 38, [5] = 26, [6] = 46, [7] = 41 }, [1] = { [0] = 47, [1] = 33, [2] = 30, [3] = 53, [4] = 43, [5] = 31, [6] = 51, [7] = 46 }, [2] = { [0] = 200, [1] = 189, [2] = 186, [3] = 209, [4] = 202, [5] = 188, [6] = 208, [7] = 203 }, [3] = { [0] = 185, [1] = 171, [2] = 163, [3] = 190, [4] = 184, [5] = 171, [6] = 192, [7] = 187 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 29, [2] = 34, [3] = 26, [4] = 36, [5] = 29, [6] = 15, [7] = 24 }, [1] = { [0] = 98, [1] = 91, [2] = 96, [3] = 93, [4] = 104, [5] = 97, [6] = 83, [7] = 92 }, [2] = { [0] = 120, [1] = 106, [2] = 111, [3] = 108, [4] = 119, [5] = 113, [6] = 104, [7] = 108 }, [3] = { [0] = 23, [1] = 15, [2] = 21, [3] = 18, [4] = 29, [5] = 18, [6] = 7, [7] = 17 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 30, [2] = 27, [3] = 43, [4] = 38, [5] = 26, [6] = 46, [7] = 41 }, [1] = { [0] = 47, [1] = 33, [2] = 30, [3] = 51, [4] = 43, [5] = 31, [6] = 51, [7] = 46 }, [2] = { [0] = 200, [1] = 189, [2] = 186, [3] = 207, [4] = 202, [5] = 188, [6] = 208, [7] = 203 }, [3] = { [0] = 185, [1] = 171, [2] = 163, [3] = 188, [4] = 184, [5] = 171, [6] = 192, [7] = 187 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 29, [2] = 34, [3] = 22, [4] = 36, [5] = 29, [6] = 15, [7] = 24 }, [1] = { [0] = 98, [1] = 91, [2] = 96, [3] = 89, [4] = 104, [5] = 97, [6] = 83, [7] = 92 }, [2] = { [0] = 120, [1] = 106, [2] = 111, [3] = 104, [4] = 119, [5] = 113, [6] = 104, [7] = 108 }, [3] = { [0] = 23, [1] = 15, [2] = 21, [3] = 14, [4] = 29, [5] = 18, [6] = 7, [7] = 17 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 30, [2] = 45, [3] = 31, [4] = 39, [5] = 25, [6] = 38, [7] = 26 }, [1] = { [0] = 33, [1] = 33, [2] = 48, [3] = 39, [4] = 44, [5] = 30, [6] = 43, [7] = 31 }, [2] = { [0] = 186, [1] = 189, [2] = 204, [3] = 195, [4] = 203, [5] = 187, [6] = 200, [7] = 188 }, [3] = { [0] = 171, [1] = 171, [2] = 181, [3] = 176, [4] = 185, [5] = 170, [6] = 184, [7] = 172 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 23, [2] = 37, [3] = 37, [4] = 32, [5] = 18, [6] = 25, [7] = 30 }, [1] = { [0] = 92, [1] = 85, [2] = 99, [3] = 104, [4] = 100, [5] = 86, [6] = 93, [7] = 98 }, [2] = { [0] = 114, [1] = 100, [2] = 114, [3] = 119, [4] = 115, [5] = 102, [6] = 114, [7] = 114 }, [3] = { [0] = 17, [1] = 9, [2] = 24, [3] = 29, [4] = 25, [5] = 7, [6] = 17, [7] = 23 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[26]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 41, [3] = 31, [4] = 41, [5] = 34, [6] = 47, [7] = 21 }, [1] = { [0] = 33, [1] = 36, [2] = 44, [3] = 39, [4] = 46, [5] = 39, [6] = 52, [7] = 26 }, [2] = { [0] = 186, [1] = 192, [2] = 200, [3] = 195, [4] = 205, [5] = 196, [6] = 209, [7] = 183 }, [3] = { [0] = 171, [1] = 174, [2] = 177, [3] = 176, [4] = 187, [5] = 179, [6] = 193, [7] = 167 } })[R[35]][R[26]], ({ [0] = { [0] = 24, [1] = 20, [2] = 38, [3] = 37, [4] = 23, [5] = 26, [6] = 22, [7] = 27 }, [1] = { [0] = 89, [1] = 82, [2] = 100, [3] = 104, [4] = 91, [5] = 94, [6] = 90, [7] = 95 }, [2] = { [0] = 111, [1] = 97, [2] = 115, [3] = 119, [4] = 106, [5] = 110, [6] = 111, [7] = 111 }, [3] = { [0] = 14, [1] = 6, [2] = 25, [3] = 29, [4] = 16, [5] = 15, [6] = 14, [7] = 20 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 54, [1] = 36, [2] = 37, [3] = 35, [4] = 47, [5] = 26, [6] = 47, [7] = 35 }, [1] = { [0] = 54, [1] = 39, [2] = 40, [3] = 43, [4] = 52, [5] = 31, [6] = 52, [7] = 40 }, [2] = { [0] = 207, [1] = 195, [2] = 196, [3] = 199, [4] = 211, [5] = 188, [6] = 209, [7] = 197 }, [3] = { [0] = 192, [1] = 177, [2] = 173, [3] = 180, [4] = 193, [5] = 171, [6] = 193, [7] = 181 } })[R[35]][R[26]], ({ [0] = { [0] = 35, [1] = 33, [2] = 31, [3] = 23, [4] = 19, [5] = 35, [6] = 25, [7] = 29 }, [1] = { [0] = 100, [1] = 95, [2] = 93, [3] = 90, [4] = 87, [5] = 103, [6] = 93, [7] = 97 }, [2] = { [0] = 122, [1] = 110, [2] = 108, [3] = 105, [4] = 102, [5] = 119, [6] = 114, [7] = 113 }, [3] = { [0] = 25, [1] = 19, [2] = 18, [3] = 15, [4] = 12, [5] = 24, [6] = 17, [7] = 22 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 34, [1] = 30, [2] = 32, [3] = 27, [4] = 34, [5] = 30, [6] = 33, [7] = 24 }, [1] = { [0] = 34, [1] = 33, [2] = 35, [3] = 35, [4] = 39, [5] = 35, [6] = 38, [7] = 29 }, [2] = { [0] = 187, [1] = 189, [2] = 191, [3] = 191, [4] = 198, [5] = 192, [6] = 195, [7] = 186 }, [3] = { [0] = 172, [1] = 171, [2] = 168, [3] = 172, [4] = 180, [5] = 175, [6] = 179, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 29, [3] = 32, [4] = 22, [5] = 24, [6] = 17, [7] = 26 }, [1] = { [0] = 96, [1] = 96, [2] = 91, [3] = 99, [4] = 90, [5] = 92, [6] = 85, [7] = 94 }, [2] = { [0] = 118, [1] = 111, [2] = 106, [3] = 114, [4] = 105, [5] = 108, [6] = 106, [7] = 110 }, [3] = { [0] = 21, [1] = 20, [2] = 16, [3] = 24, [4] = 15, [5] = 13, [6] = 9, [7] = 19 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 31, [2] = 33, [3] = 27, [4] = 34, [5] = 30, [6] = 33, [7] = 24 }, [1] = { [0] = 35, [1] = 34, [2] = 36, [3] = 35, [4] = 39, [5] = 35, [6] = 38, [7] = 29 }, [2] = { [0] = 188, [1] = 190, [2] = 192, [3] = 191, [4] = 198, [5] = 192, [6] = 195, [7] = 186 }, [3] = { [0] = 173, [1] = 172, [2] = 169, [3] = 172, [4] = 180, [5] = 175, [6] = 179, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 29, [3] = 33, [4] = 23, [5] = 25, [6] = 18, [7] = 27 }, [1] = { [0] = 96, [1] = 96, [2] = 91, [3] = 100, [4] = 91, [5] = 93, [6] = 86, [7] = 95 }, [2] = { [0] = 118, [1] = 111, [2] = 106, [3] = 115, [4] = 106, [5] = 109, [6] = 107, [7] = 111 }, [3] = { [0] = 21, [1] = 20, [2] = 16, [3] = 25, [4] = 16, [5] = 14, [6] = 10, [7] = 20 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 32, [2] = 34, [3] = 27, [4] = 34, [5] = 30, [6] = 33, [7] = 24 }, [1] = { [0] = 36, [1] = 35, [2] = 37, [3] = 35, [4] = 39, [5] = 35, [6] = 38, [7] = 29 }, [2] = { [0] = 189, [1] = 191, [2] = 193, [3] = 191, [4] = 198, [5] = 192, [6] = 195, [7] = 186 }, [3] = { [0] = 174, [1] = 173, [2] = 170, [3] = 172, [4] = 180, [5] = 175, [6] = 179, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 29, [3] = 34, [4] = 24, [5] = 26, [6] = 19, [7] = 28 }, [1] = { [0] = 96, [1] = 96, [2] = 91, [3] = 101, [4] = 92, [5] = 94, [6] = 87, [7] = 96 }, [2] = { [0] = 118, [1] = 111, [2] = 106, [3] = 116, [4] = 107, [5] = 110, [6] = 108, [7] = 112 }, [3] = { [0] = 21, [1] = 20, [2] = 16, [3] = 26, [4] = 17, [5] = 15, [6] = 11, [7] = 21 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 33, [2] = 35, [3] = 28, [4] = 34, [5] = 30, [6] = 33, [7] = 24 }, [1] = { [0] = 37, [1] = 36, [2] = 38, [3] = 36, [4] = 39, [5] = 35, [6] = 38, [7] = 29 }, [2] = { [0] = 190, [1] = 192, [2] = 194, [3] = 192, [4] = 198, [5] = 192, [6] = 195, [7] = 186 }, [3] = { [0] = 175, [1] = 174, [2] = 171, [3] = 173, [4] = 180, [5] = 175, [6] = 179, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 26, [3] = 32, [4] = 25, [5] = 30, [6] = 20, [7] = 29 }, [1] = { [0] = 96, [1] = 96, [2] = 88, [3] = 99, [4] = 93, [5] = 98, [6] = 88, [7] = 97 }, [2] = { [0] = 118, [1] = 111, [2] = 103, [3] = 114, [4] = 108, [5] = 114, [6] = 109, [7] = 113 }, [3] = { [0] = 21, [1] = 20, [2] = 13, [3] = 24, [4] = 18, [5] = 19, [6] = 12, [7] = 22 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 34, [2] = 35, [3] = 29, [4] = 34, [5] = 30, [6] = 33, [7] = 24 }, [1] = { [0] = 38, [1] = 37, [2] = 38, [3] = 37, [4] = 39, [5] = 35, [6] = 38, [7] = 29 }, [2] = { [0] = 191, [1] = 193, [2] = 194, [3] = 193, [4] = 198, [5] = 192, [6] = 195, [7] = 186 }, [3] = { [0] = 176, [1] = 175, [2] = 171, [3] = 174, [4] = 180, [5] = 175, [6] = 179, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 27, [3] = 28, [4] = 26, [5] = 31, [6] = 21, [7] = 30 }, [1] = { [0] = 96, [1] = 96, [2] = 89, [3] = 95, [4] = 94, [5] = 99, [6] = 89, [7] = 98 }, [2] = { [0] = 118, [1] = 111, [2] = 104, [3] = 110, [4] = 109, [5] = 115, [6] = 110, [7] = 114 }, [3] = { [0] = 21, [1] = 20, [2] = 14, [3] = 20, [4] = 19, [5] = 20, [6] = 13, [7] = 23 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 35, [2] = 35, [3] = 29, [4] = 34, [5] = 30, [6] = 36, [7] = 24 }, [1] = { [0] = 39, [1] = 38, [2] = 38, [3] = 37, [4] = 39, [5] = 35, [6] = 41, [7] = 29 }, [2] = { [0] = 192, [1] = 194, [2] = 194, [3] = 193, [4] = 198, [5] = 192, [6] = 198, [7] = 186 }, [3] = { [0] = 177, [1] = 176, [2] = 171, [3] = 174, [4] = 180, [5] = 175, [6] = 182, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 28, [3] = 29, [4] = 30, [5] = 32, [6] = 15, [7] = 31 }, [1] = { [0] = 96, [1] = 96, [2] = 90, [3] = 96, [4] = 98, [5] = 100, [6] = 83, [7] = 99 }, [2] = { [0] = 118, [1] = 111, [2] = 105, [3] = 111, [4] = 113, [5] = 116, [6] = 104, [7] = 115 }, [3] = { [0] = 21, [1] = 20, [2] = 15, [3] = 21, [4] = 23, [5] = 21, [6] = 7, [7] = 24 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 40, [1] = 36, [2] = 35, [3] = 29, [4] = 34, [5] = 33, [6] = 37, [7] = 24 }, [1] = { [0] = 40, [1] = 39, [2] = 38, [3] = 37, [4] = 39, [5] = 38, [6] = 42, [7] = 29 }, [2] = { [0] = 193, [1] = 195, [2] = 194, [3] = 193, [4] = 198, [5] = 195, [6] = 199, [7] = 186 }, [3] = { [0] = 178, [1] = 177, [2] = 171, [3] = 174, [4] = 180, [5] = 178, [6] = 183, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 29, [3] = 30, [4] = 31, [5] = 28, [6] = 15, [7] = 32 }, [1] = { [0] = 96, [1] = 96, [2] = 91, [3] = 97, [4] = 99, [5] = 96, [6] = 83, [7] = 100 }, [2] = { [0] = 118, [1] = 111, [2] = 106, [3] = 112, [4] = 114, [5] = 112, [6] = 104, [7] = 116 }, [3] = { [0] = 21, [1] = 20, [2] = 16, [3] = 22, [4] = 24, [5] = 17, [6] = 7, [7] = 25 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 37, [2] = 35, [3] = 29, [4] = 34, [5] = 33, [6] = 37, [7] = 24 }, [1] = { [0] = 42, [1] = 40, [2] = 38, [3] = 37, [4] = 39, [5] = 38, [6] = 42, [7] = 29 }, [2] = { [0] = 195, [1] = 196, [2] = 194, [3] = 193, [4] = 198, [5] = 195, [6] = 199, [7] = 186 }, [3] = { [0] = 180, [1] = 178, [2] = 171, [3] = 174, [4] = 180, [5] = 178, [6] = 183, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 26, [1] = 23, [2] = 30, [3] = 31, [4] = 32, [5] = 34, [6] = 23, [7] = 33 }, [1] = { [0] = 91, [1] = 85, [2] = 92, [3] = 98, [4] = 100, [5] = 102, [6] = 91, [7] = 101 }, [2] = { [0] = 113, [1] = 100, [2] = 107, [3] = 113, [4] = 115, [5] = 118, [6] = 112, [7] = 117 }, [3] = { [0] = 16, [1] = 9, [2] = 17, [3] = 23, [4] = 25, [5] = 23, [6] = 15, [7] = 26 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 37, [2] = 35, [3] = 29, [4] = 34, [5] = 34, [6] = 38, [7] = 24 }, [1] = { [0] = 42, [1] = 40, [2] = 38, [3] = 37, [4] = 39, [5] = 39, [6] = 43, [7] = 29 }, [2] = { [0] = 195, [1] = 196, [2] = 194, [3] = 193, [4] = 198, [5] = 196, [6] = 200, [7] = 186 }, [3] = { [0] = 180, [1] = 178, [2] = 171, [3] = 174, [4] = 180, [5] = 179, [6] = 184, [7] = 170 } })[R[35]][R[26]], ({ [0] = { [0] = 27, [1] = 24, [2] = 31, [3] = 32, [4] = 33, [5] = 28, [6] = 15, [7] = 34 }, [1] = { [0] = 92, [1] = 86, [2] = 93, [3] = 99, [4] = 101, [5] = 96, [6] = 83, [7] = 102 }, [2] = { [0] = 114, [1] = 101, [2] = 108, [3] = 114, [4] = 116, [5] = 112, [6] = 104, [7] = 118 }, [3] = { [0] = 17, [1] = 10, [2] = 18, [3] = 24, [4] = 26, [5] = 17, [6] = 7, [7] = 27 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 37, [2] = 35, [3] = 30, [4] = 34, [5] = 34, [6] = 38, [7] = 27 }, [1] = { [0] = 42, [1] = 40, [2] = 38, [3] = 38, [4] = 39, [5] = 39, [6] = 43, [7] = 32 }, [2] = { [0] = 195, [1] = 196, [2] = 194, [3] = 194, [4] = 198, [5] = 196, [6] = 200, [7] = 189 }, [3] = { [0] = 180, [1] = 178, [2] = 171, [3] = 175, [4] = 180, [5] = 179, [6] = 184, [7] = 173 } })[R[35]][R[26]], ({ [0] = { [0] = 28, [1] = 25, [2] = 32, [3] = 28, [4] = 34, [5] = 34, [6] = 23, [7] = 23 }, [1] = { [0] = 93, [1] = 87, [2] = 94, [3] = 95, [4] = 102, [5] = 102, [6] = 91, [7] = 91 }, [2] = { [0] = 115, [1] = 102, [2] = 109, [3] = 110, [4] = 117, [5] = 118, [6] = 112, [7] = 107 }, [3] = { [0] = 18, [1] = 11, [2] = 19, [3] = 20, [4] = 27, [5] = 23, [6] = 15, [7] = 16 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 37, [2] = 35, [3] = 30, [4] = 37, [5] = 35, [6] = 39, [7] = 27 }, [1] = { [0] = 42, [1] = 40, [2] = 38, [3] = 38, [4] = 42, [5] = 40, [6] = 44, [7] = 32 }, [2] = { [0] = 195, [1] = 196, [2] = 194, [3] = 194, [4] = 201, [5] = 197, [6] = 201, [7] = 189 }, [3] = { [0] = 180, [1] = 178, [2] = 171, [3] = 175, [4] = 183, [5] = 180, [6] = 185, [7] = 173 } })[R[35]][R[26]], ({ [0] = { [0] = 29, [1] = 26, [2] = 33, [3] = 32, [4] = 20, [5] = 28, [6] = 15, [7] = 36 }, [1] = { [0] = 94, [1] = 88, [2] = 95, [3] = 99, [4] = 88, [5] = 96, [6] = 83, [7] = 104 }, [2] = { [0] = 116, [1] = 103, [2] = 110, [3] = 114, [4] = 103, [5] = 112, [6] = 104, [7] = 120 }, [3] = { [0] = 19, [1] = 12, [2] = 20, [3] = 24, [4] = 13, [5] = 17, [6] = 7, [7] = 29 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 37, [2] = 35, [3] = 31, [4] = 37, [5] = 35, [6] = 39, [7] = 28 }, [1] = { [0] = 42, [1] = 40, [2] = 38, [3] = 39, [4] = 42, [5] = 40, [6] = 44, [7] = 33 }, [2] = { [0] = 195, [1] = 196, [2] = 194, [3] = 195, [4] = 201, [5] = 197, [6] = 201, [7] = 190 }, [3] = { [0] = 180, [1] = 178, [2] = 171, [3] = 176, [4] = 183, [5] = 180, [6] = 185, [7] = 174 } })[R[35]][R[26]], ({ [0] = { [0] = 33, [1] = 34, [2] = 34, [3] = 32, [4] = 28, [5] = 34, [6] = 23, [7] = 23 }, [1] = { [0] = 98, [1] = 96, [2] = 96, [3] = 99, [4] = 96, [5] = 102, [6] = 91, [7] = 91 }, [2] = { [0] = 120, [1] = 111, [2] = 111, [3] = 114, [4] = 111, [5] = 118, [6] = 112, [7] = 107 }, [3] = { [0] = 23, [1] = 20, [2] = 21, [3] = 24, [4] = 21, [5] = 23, [6] = 15, [7] = 16 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 38, [2] = 35, [3] = 32, [4] = 37, [5] = 36, [6] = 40, [7] = 28 }, [1] = { [0] = 42, [1] = 41, [2] = 38, [3] = 40, [4] = 42, [5] = 41, [6] = 45, [7] = 33 }, [2] = { [0] = 195, [1] = 197, [2] = 194, [3] = 196, [4] = 201, [5] = 198, [6] = 202, [7] = 190 }, [3] = { [0] = 180, [1] = 179, [2] = 171, [3] = 177, [4] = 183, [5] = 181, [6] = 186, [7] = 174 } })[R[35]][R[26]], ({ [0] = { [0] = 34, [1] = 31, [2] = 35, [3] = 32, [4] = 36, [5] = 28, [6] = 15, [7] = 36 }, [1] = { [0] = 99, [1] = 93, [2] = 97, [3] = 99, [4] = 104, [5] = 96, [6] = 83, [7] = 104 }, [2] = { [0] = 121, [1] = 108, [2] = 112, [3] = 114, [4] = 119, [5] = 112, [6] = 104, [7] = 120 }, [3] = { [0] = 24, [1] = 17, [2] = 22, [3] = 24, [4] = 29, [5] = 17, [6] = 7, [7] = 29 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 38, [2] = 36, [3] = 33, [4] = 38, [5] = 36, [6] = 40, [7] = 29 }, [1] = { [0] = 42, [1] = 41, [2] = 39, [3] = 41, [4] = 43, [5] = 41, [6] = 45, [7] = 34 }, [2] = { [0] = 195, [1] = 197, [2] = 195, [3] = 197, [4] = 202, [5] = 198, [6] = 202, [7] = 191 }, [3] = { [0] = 180, [1] = 179, [2] = 172, [3] = 178, [4] = 184, [5] = 181, [6] = 186, [7] = 175 } })[R[35]][R[26]], ({ [0] = { [0] = 35, [1] = 32, [2] = 29, [3] = 25, [4] = 20, [5] = 34, [6] = 23, [7] = 23 }, [1] = { [0] = 100, [1] = 94, [2] = 91, [3] = 92, [4] = 88, [5] = 102, [6] = 91, [7] = 91 }, [2] = { [0] = 122, [1] = 109, [2] = 106, [3] = 107, [4] = 103, [5] = 118, [6] = 112, [7] = 107 }, [3] = { [0] = 25, [1] = 18, [2] = 16, [3] = 17, [4] = 13, [5] = 23, [6] = 15, [7] = 16 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 38, [2] = 36, [3] = 33, [4] = 38, [5] = 37, [6] = 42, [7] = 29 }, [1] = { [0] = 42, [1] = 41, [2] = 39, [3] = 41, [4] = 43, [5] = 42, [6] = 47, [7] = 34 }, [2] = { [0] = 195, [1] = 197, [2] = 195, [3] = 197, [4] = 202, [5] = 199, [6] = 204, [7] = 191 }, [3] = { [0] = 180, [1] = 179, [2] = 172, [3] = 178, [4] = 184, [5] = 182, [6] = 188, [7] = 175 } })[R[35]][R[26]], ({ [0] = { [0] = 36, [1] = 33, [2] = 35, [3] = 32, [4] = 28, [5] = 28, [6] = 17, [7] = 36 }, [1] = { [0] = 101, [1] = 95, [2] = 97, [3] = 99, [4] = 96, [5] = 96, [6] = 85, [7] = 104 }, [2] = { [0] = 123, [1] = 110, [2] = 112, [3] = 114, [4] = 111, [5] = 112, [6] = 106, [7] = 120 }, [3] = { [0] = 26, [1] = 19, [2] = 22, [3] = 24, [4] = 21, [5] = 17, [6] = 9, [7] = 29 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 38, [2] = 37, [3] = 34, [4] = 38, [5] = 37, [6] = 42, [7] = 30 }, [1] = { [0] = 45, [1] = 41, [2] = 40, [3] = 42, [4] = 43, [5] = 42, [6] = 47, [7] = 35 }, [2] = { [0] = 198, [1] = 197, [2] = 196, [3] = 198, [4] = 202, [5] = 199, [6] = 204, [7] = 192 }, [3] = { [0] = 183, [1] = 179, [2] = 173, [3] = 179, [4] = 184, [5] = 182, [6] = 188, [7] = 176 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 34, [2] = 29, [3] = 25, [4] = 36, [5] = 34, [6] = 18, [7] = 23 }, [1] = { [0] = 96, [1] = 96, [2] = 91, [3] = 92, [4] = 104, [5] = 102, [6] = 86, [7] = 91 }, [2] = { [0] = 118, [1] = 111, [2] = 106, [3] = 107, [4] = 119, [5] = 118, [6] = 107, [7] = 107 }, [3] = { [0] = 21, [1] = 20, [2] = 16, [3] = 17, [4] = 29, [5] = 23, [6] = 10, [7] = 16 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 38, [2] = 37, [3] = 35, [4] = 39, [5] = 38, [6] = 42, [7] = 30 }, [1] = { [0] = 46, [1] = 41, [2] = 40, [3] = 43, [4] = 44, [5] = 43, [6] = 47, [7] = 35 }, [2] = { [0] = 199, [1] = 197, [2] = 196, [3] = 199, [4] = 203, [5] = 200, [6] = 204, [7] = 192 }, [3] = { [0] = 184, [1] = 179, [2] = 173, [3] = 180, [4] = 185, [5] = 183, [6] = 188, [7] = 176 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 35, [2] = 35, [3] = 25, [4] = 20, [5] = 28, [6] = 19, [7] = 36 }, [1] = { [0] = 96, [1] = 97, [2] = 97, [3] = 92, [4] = 88, [5] = 96, [6] = 87, [7] = 104 }, [2] = { [0] = 118, [1] = 112, [2] = 112, [3] = 107, [4] = 103, [5] = 112, [6] = 108, [7] = 120 }, [3] = { [0] = 21, [1] = 21, [2] = 22, [3] = 17, [4] = 13, [5] = 17, [6] = 11, [7] = 29 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 38, [2] = 38, [3] = 36, [4] = 39, [5] = 39, [6] = 42, [7] = 31 }, [1] = { [0] = 47, [1] = 41, [2] = 41, [3] = 44, [4] = 44, [5] = 44, [6] = 47, [7] = 36 }, [2] = { [0] = 200, [1] = 197, [2] = 197, [3] = 200, [4] = 203, [5] = 201, [6] = 204, [7] = 193 }, [3] = { [0] = 185, [1] = 179, [2] = 174, [3] = 181, [4] = 185, [5] = 184, [6] = 188, [7] = 177 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 36, [2] = 29, [3] = 25, [4] = 21, [5] = 28, [6] = 20, [7] = 23 }, [1] = { [0] = 96, [1] = 98, [2] = 91, [3] = 92, [4] = 89, [5] = 96, [6] = 88, [7] = 91 }, [2] = { [0] = 118, [1] = 113, [2] = 106, [3] = 107, [4] = 104, [5] = 112, [6] = 109, [7] = 107 }, [3] = { [0] = 21, [1] = 22, [2] = 16, [3] = 17, [4] = 14, [5] = 17, [6] = 12, [7] = 16 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 38, [2] = 38, [3] = 37, [4] = 39, [5] = 40, [6] = 42, [7] = 31 }, [1] = { [0] = 48, [1] = 41, [2] = 41, [3] = 45, [4] = 44, [5] = 45, [6] = 47, [7] = 36 }, [2] = { [0] = 201, [1] = 197, [2] = 197, [3] = 201, [4] = 203, [5] = 202, [6] = 204, [7] = 193 }, [3] = { [0] = 186, [1] = 179, [2] = 174, [3] = 182, [4] = 185, [5] = 185, [6] = 188, [7] = 177 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 41, [2] = 35, [3] = 25, [4] = 28, [5] = 28, [6] = 21, [7] = 24 }, [1] = { [0] = 96, [1] = 103, [2] = 97, [3] = 92, [4] = 96, [5] = 96, [6] = 89, [7] = 92 }, [2] = { [0] = 118, [1] = 118, [2] = 112, [3] = 107, [4] = 111, [5] = 112, [6] = 110, [7] = 108 }, [3] = { [0] = 21, [1] = 27, [2] = 22, [3] = 17, [4] = 21, [5] = 17, [6] = 13, [7] = 17 } })[R[35]][R[26]] })
    game.create_tube({ ({ [0] = { [0] = 49, [1] = 38, [2] = 39, [3] = 38, [4] = 39, [5] = 40, [6] = 46, [7] = 31 }, [1] = { [0] = 49, [1] = 41, [2] = 42, [3] = 46, [4] = 44, [5] = 45, [6] = 51, [7] = 36 }, [2] = { [0] = 202, [1] = 197, [2] = 198, [3] = 202, [4] = 203, [5] = 202, [6] = 208, [7] = 193 }, [3] = { [0] = 187, [1] = 179, [2] = 175, [3] = 183, [4] = 185, [5] = 185, [6] = 192, [7] = 177 } })[R[35]][R[26]], ({ [0] = { [0] = 31, [1] = 42, [2] = 29, [3] = 25, [4] = 36, [5] = 29, [6] = 23, [7] = 25 }, [1] = { [0] = 96, [1] = 104, [2] = 91, [3] = 92, [4] = 104, [5] = 97, [6] = 91, [7] = 93 }, [2] = { [0] = 118, [1] = 119, [2] = 106, [3] = 107, [4] = 119, [5] = 113, [6] = 112, [7] = 109 }, [3] = { [0] = 21, [1] = 28, [2] = 16, [3] = 17, [4] = 29, [5] = 18, [6] = 15, [7] = 18 } })[R[35]][R[26]] })
    if R[26] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 50, [1] = 50, [2] = 203, [3] = 188 })[R[35]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 51, [1] = 51, [2] = 204, [3] = 189 })[R[35]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 50, [1] = 50, [2] = 203, [3] = 188 })[R[35]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 51, [1] = 51, [2] = 204, [3] = 189 })[R[35]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[35]] })
        for i = 1, game.initial_units() do
          R[71] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 48, [1] = 48, [2] = 201, [3] = 186 }, [1] = { [0] = 35, [1] = 35, [2] = 188, [3] = 173 }, [2] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 } })[R[71]][R[35]], ({ [0] = { [0] = 25, [1] = 90, [2] = 112, [3] = 15 }, [1] = { [0] = 34, [1] = 99, [2] = 121, [3] = 24 }, [2] = { [0] = 37, [1] = 102, [2] = 124, [3] = 27 } })[R[71]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[35]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[35]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[35]], ({ [0] = 44, [1] = 106, [2] = 121, [3] = 30 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[35]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[35]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[35]], ({ [0] = 44, [1] = 106, [2] = 121, [3] = 30 })[R[35]] })
        for i = 1, game.initial_units() do
          R[72] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 188, [3] = 170 }, [1] = { [0] = 31, [1] = 34, [2] = 190, [3] = 172 }, [2] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 } })[R[72]][R[35]], ({ [0] = { [0] = 38, [1] = 100, [2] = 115, [3] = 24 }, [1] = { [0] = 40, [1] = 102, [2] = 117, [3] = 26 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 18 } })[R[72]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[73] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 30, [1] = 33, [2] = 189, [3] = 166 }, [1] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [2] = { [0] = 48, [1] = 51, [2] = 207, [3] = 184 } })[R[73]][R[35]], ({ [0] = { [0] = 23, [1] = 85, [2] = 100, [3] = 10 }, [1] = { [0] = 39, [1] = 101, [2] = 116, [3] = 26 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 19 } })[R[73]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 46, [2] = 202, [3] = 183 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 47, [2] = 203, [3] = 184 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 48, [2] = 204, [3] = 185 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[35]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 29, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 30, [1] = 97, [2] = 112, [3] = 22 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 31, [1] = 98, [2] = 113, [3] = 23 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[35]], ({ [0] = 33, [1] = 100, [2] = 115, [3] = 25 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[35]], ({ [0] = 34, [1] = 101, [2] = 116, [3] = 26 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 46, [2] = 202, [3] = 183 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 47, [2] = 203, [3] = 184 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 48, [2] = 204, [3] = 185 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[35]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 29, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 30, [1] = 97, [2] = 112, [3] = 22 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 31, [1] = 98, [2] = 113, [3] = 23 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[35]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[35]], ({ [0] = 33, [1] = 100, [2] = 115, [3] = 25 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[35]], ({ [0] = 34, [1] = 101, [2] = 116, [3] = 26 })[R[35]] })
        for i = 1, game.initial_units() do
          R[74] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [1] = { [0] = 37, [1] = 45, [2] = 201, [3] = 182 }, [2] = { [0] = 24, [1] = 32, [2] = 188, [3] = 169 } })[R[74]][R[35]], ({ [0] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [1] = { [0] = 35, [1] = 102, [2] = 117, [3] = 27 }, [2] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 } })[R[74]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 4 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[35]], ({ [0] = 21, [1] = 89, [2] = 104, [3] = 14 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[35]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[35]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[35]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 29, [1] = 97, [2] = 112, [3] = 22 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 30, [1] = 98, [2] = 113, [3] = 23 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[35]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[35]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 25, [1] = 93, [2] = 108, [3] = 18 })[R[35]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 109, [3] = 19 })[R[35]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[35]] })
        for i = 1, game.initial_units() do
          R[75] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [1] = { [0] = 29, [1] = 34, [2] = 193, [3] = 175 }, [2] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 } })[R[75]][R[35]], ({ [0] = { [0] = 19, [1] = 87, [2] = 102, [3] = 12 }, [1] = { [0] = 27, [1] = 95, [2] = 110, [3] = 20 }, [2] = { [0] = 22, [1] = 90, [2] = 105, [3] = 15 } })[R[75]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[35]], ({ [0] = 21, [1] = 89, [2] = 104, [3] = 14 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[35]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[35]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[35]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 29, [1] = 97, [2] = 112, [3] = 22 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 30, [1] = 98, [2] = 113, [3] = 23 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[35]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[35]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[35]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 25, [1] = 93, [2] = 108, [3] = 18 })[R[35]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 109, [3] = 19 })[R[35]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[35]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[35]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[35]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 19 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[35]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 20 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[35]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 19 })[R[35]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[35]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 20 })[R[35]] })
        for i = 1, game.initial_units() do
          R[76] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [1] = { [0] = 19, [1] = 24, [2] = 181, [3] = 164 }, [2] = { [0] = 41, [1] = 46, [2] = 203, [3] = 186 } })[R[76]][R[35]], ({ [0] = { [0] = 37, [1] = 105, [2] = 121, [3] = 26 }, [1] = { [0] = 24, [1] = 92, [2] = 108, [3] = 13 }, [2] = { [0] = 37, [1] = 105, [2] = 121, [3] = 26 } })[R[76]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 48, [1] = 53, [2] = 210, [3] = 194 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 49, [1] = 54, [2] = 211, [3] = 195 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 48, [1] = 53, [2] = 210, [3] = 194 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] })
        game.create_tube({ ({ [0] = 49, [1] = 54, [2] = 211, [3] = 195 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[35]] })
        for i = 1, game.initial_units() do
          R[77] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 }, [1] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [2] = { [0] = 54, [1] = 59, [2] = 216, [3] = 200 } })[R[77]][R[35]], ({ [0] = { [0] = 13, [1] = 81, [2] = 102, [3] = 5 }, [1] = { [0] = 11, [1] = 79, [2] = 100, [3] = 3 }, [2] = { [0] = 26, [1] = 94, [2] = 115, [3] = 18 } })[R[77]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 34, [1] = 102, [2] = 118, [3] = 27 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 35, [1] = 103, [2] = 119, [3] = 28 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 25, [1] = 93, [2] = 109, [3] = 18 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 22 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 34, [1] = 102, [2] = 118, [3] = 27 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 35, [1] = 103, [2] = 119, [3] = 28 })[R[35]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[35]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[35]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[35]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 25, [1] = 93, [2] = 109, [3] = 18 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 22 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 24 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[35]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[35]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[35]] })
        for i = 1, game.initial_units() do
          R[78] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 }, [1] = { [0] = 35, [1] = 40, [2] = 197, [3] = 181 }, [2] = { [0] = 23, [1] = 28, [2] = 185, [3] = 169 } })[R[78]][R[35]], ({ [0] = { [0] = 19, [1] = 87, [2] = 103, [3] = 12 }, [1] = { [0] = 19, [1] = 87, [2] = 103, [3] = 12 }, [2] = { [0] = 40, [1] = 108, [2] = 124, [3] = 33 } })[R[78]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[26]", R[26])
    end
    R[53] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 24, [1] = 86, [2] = 101, [3] = 11 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 24, [1] = 86, [2] = 101, [3] = 11 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[53]][R[36]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 29, [1] = 32, [2] = 188, [3] = 165 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 21, [1] = 83, [2] = 98, [3] = 7 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 36, [1] = 103, [2] = 118, [3] = 28 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    if R[53] == 3 or R[53] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 } })[R[53]][R[36]], ({ [3] = { [0] = 36, [1] = 103, [2] = 118, [3] = 28 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 3 then
      elseif R[53] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[53]", R[53])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [3] = { [0] = 30, [1] = 38, [2] = 194, [3] = 175 }, [4] = { [0] = 45, [1] = 50, [2] = 209, [3] = 191 } })[R[53]][R[36]], ({ [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 3 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[36]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[36]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[36]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 4 then
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
        unseen("R[53]", R[53])
      end
    elseif R[53] == 0 or R[53] == 1 or R[53] == 2 or R[53] == 5 or R[53] == 6 or R[53] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = { [0] = 54, [1] = 54, [2] = 207, [3] = 192 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 32, [1] = 35, [2] = 191, [3] = 168 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 43, [1] = 48, [2] = 205, [3] = 189 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 28, [1] = 90, [2] = 105, [3] = 14 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [5] = { [0] = 33, [1] = 101, [2] = 117, [3] = 22 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 0 then
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
      elseif R[53] == 1 then
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
      elseif R[53] == 2 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[36]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[36]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[36]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[53]", R[53])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = { [0] = 31, [1] = 31, [2] = 184, [3] = 169 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 34, [1] = 39, [2] = 196, [3] = 180 }, [7] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 38, [1] = 100, [2] = 115, [3] = 24 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 35, [1] = 103, [2] = 119, [3] = 28 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 0 or R[53] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 } })[R[53]][R[36]], ({ [0] = { [0] = 38, [1] = 103, [2] = 125, [3] = 28 }, [1] = { [0] = 46, [1] = 108, [2] = 123, [3] = 32 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 2 or R[53] == 5 or R[53] == 6 or R[53] == 7 then
      else
        unseen("R[53]", R[53])
      end
    else
      unseen("R[53]", R[53])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = { [0] = 31, [1] = 31, [2] = 184, [3] = 169 }, [1] = { [0] = 28, [1] = 31, [2] = 187, [3] = 169 }, [2] = { [0] = 49, [1] = 52, [2] = 208, [3] = 185 }, [3] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [4] = { [0] = 26, [1] = 31, [2] = 190, [3] = 172 }, [5] = { [0] = 20, [1] = 25, [2] = 182, [3] = 165 }, [6] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 }, [7] = { [0] = 32, [1] = 37, [2] = 194, [3] = 178 } })[R[53]][R[36]], ({ [0] = { [0] = 40, [1] = 105, [2] = 127, [3] = 30 }, [1] = { [0] = 43, [1] = 105, [2] = 120, [3] = 29 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 19, [1] = 86, [2] = 101, [3] = 11 }, [4] = { [0] = 24, [1] = 92, [2] = 107, [3] = 17 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 39, [1] = 107, [2] = 123, [3] = 32 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 38, [1] = 38, [2] = 191, [3] = 176 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 44, [1] = 49, [2] = 208, [3] = 190 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 33, [1] = 95, [2] = 110, [3] = 20 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 19, [1] = 87, [2] = 103, [3] = 8 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 28, [1] = 36, [2] = 192, [3] = 173 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 27, [1] = 89, [2] = 104, [3] = 13 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[3].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 45, [1] = 53, [2] = 209, [3] = 190 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 25, [1] = 30, [2] = 187, [3] = 170 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 37, [1] = 99, [2] = 114, [3] = 24 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 18, [1] = 86, [2] = 102, [3] = 7 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 41, [1] = 46, [2] = 205, [3] = 187 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 21, [1] = 26, [2] = 183, [3] = 167 } })[R[53]][R[36]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 82, [2] = 97, [3] = 6 }, [2] = { [0] = 38, [1] = 100, [2] = 115, [3] = 25 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 22, [1] = 90, [2] = 111, [3] = 14 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 45, [1] = 53, [2] = 209, [3] = 190 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 25, [1] = 30, [2] = 187, [3] = 170 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 37, [1] = 99, [2] = 114, [3] = 24 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 18, [1] = 86, [2] = 102, [3] = 7 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 41, [1] = 46, [2] = 205, [3] = 187 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 21, [1] = 26, [2] = 183, [3] = 167 } })[R[53]][R[36]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 82, [2] = 97, [3] = 6 }, [2] = { [0] = 38, [1] = 100, [2] = 115, [3] = 25 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 22, [1] = 90, [2] = 111, [3] = 14 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 45, [1] = 53, [2] = 209, [3] = 190 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 25, [1] = 30, [2] = 187, [3] = 170 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 37, [1] = 99, [2] = 114, [3] = 24 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 18, [1] = 86, [2] = 102, [3] = 7 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[53]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 41, [1] = 46, [2] = 205, [3] = 187 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 21, [1] = 26, [2] = 183, [3] = 167 } })[R[53]][R[36]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 82, [2] = 97, [3] = 6 }, [2] = { [0] = 38, [1] = 100, [2] = 115, [3] = 25 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 22, [1] = 90, [2] = 111, [3] = 14 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 54, [1] = 54, [2] = 207, [3] = 192 }, [1] = { [0] = 36, [1] = 39, [2] = 195, [3] = 177 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 47, [1] = 52, [2] = 211, [3] = 193 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 35, [1] = 40, [2] = 197, [3] = 181 } })[R[53]][R[36]], ({ [0] = { [0] = 35, [1] = 100, [2] = 122, [3] = 25 }, [1] = { [0] = 33, [1] = 95, [2] = 110, [3] = 19 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 23, [1] = 90, [2] = 105, [3] = 15 }, [4] = { [0] = 19, [1] = 87, [2] = 102, [3] = 12 }, [5] = { [0] = 35, [1] = 103, [2] = 119, [3] = 24 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 29, [1] = 97, [2] = 113, [3] = 22 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 34, [1] = 34, [2] = 187, [3] = 172 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 32, [1] = 35, [2] = 191, [3] = 168 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 22, [1] = 90, [2] = 105, [3] = 15 }, [5] = { [0] = 24, [1] = 92, [2] = 108, [3] = 13 }, [6] = { [0] = 17, [1] = 85, [2] = 106, [3] = 9 }, [7] = { [0] = 26, [1] = 94, [2] = 110, [3] = 19 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 35, [2] = 188, [3] = 173 }, [1] = { [0] = 31, [1] = 34, [2] = 190, [3] = 172 }, [2] = { [0] = 33, [1] = 36, [2] = 192, [3] = 169 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 33, [1] = 100, [2] = 115, [3] = 25 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 25, [1] = 93, [2] = 109, [3] = 14 }, [6] = { [0] = 18, [1] = 86, [2] = 107, [3] = 10 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 32, [1] = 35, [2] = 191, [3] = 173 }, [2] = { [0] = 34, [1] = 37, [2] = 193, [3] = 170 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 34, [1] = 101, [2] = 116, [3] = 26 }, [4] = { [0] = 24, [1] = 92, [2] = 107, [3] = 17 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 19, [1] = 87, [2] = 108, [3] = 11 }, [7] = { [0] = 28, [1] = 96, [2] = 112, [3] = 21 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 37, [2] = 190, [3] = 175 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 28, [1] = 36, [2] = 192, [3] = 173 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 26, [1] = 88, [2] = 103, [3] = 13 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 25, [1] = 93, [2] = 108, [3] = 18 }, [5] = { [0] = 30, [1] = 98, [2] = 114, [3] = 19 }, [6] = { [0] = 20, [1] = 88, [2] = 109, [3] = 12 }, [7] = { [0] = 29, [1] = 97, [2] = 113, [3] = 22 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 38, [2] = 191, [3] = 176 }, [1] = { [0] = 34, [1] = 37, [2] = 193, [3] = 175 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 27, [1] = 89, [2] = 104, [3] = 14 }, [3] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [4] = { [0] = 26, [1] = 94, [2] = 109, [3] = 19 }, [5] = { [0] = 31, [1] = 99, [2] = 115, [3] = 20 }, [6] = { [0] = 21, [1] = 89, [2] = 110, [3] = 13 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 39, [2] = 192, [3] = 177 }, [1] = { [0] = 35, [1] = 38, [2] = 194, [3] = 176 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 36, [1] = 41, [2] = 198, [3] = 182 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 28, [1] = 90, [2] = 105, [3] = 15 }, [3] = { [0] = 29, [1] = 96, [2] = 111, [3] = 21 }, [4] = { [0] = 30, [1] = 98, [2] = 113, [3] = 23 }, [5] = { [0] = 32, [1] = 100, [2] = 116, [3] = 21 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 31, [1] = 99, [2] = 115, [3] = 24 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 40, [1] = 40, [2] = 193, [3] = 178 }, [1] = { [0] = 36, [1] = 39, [2] = 195, [3] = 177 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 33, [1] = 38, [2] = 195, [3] = 178 }, [6] = { [0] = 37, [1] = 42, [2] = 199, [3] = 183 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 30, [1] = 97, [2] = 112, [3] = 22 }, [4] = { [0] = 31, [1] = 99, [2] = 114, [3] = 24 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 33, [1] = 38, [2] = 195, [3] = 178 }, [6] = { [0] = 37, [1] = 42, [2] = 199, [3] = 183 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 26, [1] = 91, [2] = 113, [3] = 16 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 30, [1] = 92, [2] = 107, [3] = 17 }, [3] = { [0] = 31, [1] = 98, [2] = 113, [3] = 23 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 33, [1] = 101, [2] = 117, [3] = 26 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[53]][R[36]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 24, [1] = 86, [2] = 101, [3] = 10 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 33, [1] = 101, [2] = 116, [3] = 26 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 34, [1] = 102, [2] = 118, [3] = 27 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 30, [1] = 38, [2] = 194, [3] = 175 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 27, [1] = 32, [2] = 189, [3] = 173 } })[R[53]][R[36]], ({ [0] = { [0] = 28, [1] = 93, [2] = 115, [3] = 18 }, [1] = { [0] = 25, [1] = 87, [2] = 102, [3] = 11 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 19 }, [3] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [4] = { [0] = 34, [1] = 102, [2] = 117, [3] = 27 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 30, [1] = 38, [2] = 194, [3] = 175 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 35, [1] = 40, [2] = 197, [3] = 180 }, [6] = { [0] = 39, [1] = 44, [2] = 201, [3] = 185 }, [7] = { [0] = 27, [1] = 32, [2] = 189, [3] = 173 } })[R[53]][R[36]], ({ [0] = { [0] = 29, [1] = 94, [2] = 116, [3] = 19 }, [1] = { [0] = 26, [1] = 88, [2] = 103, [3] = 12 }, [2] = { [0] = 33, [1] = 95, [2] = 110, [3] = 20 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 35, [1] = 40, [2] = 197, [3] = 180 }, [6] = { [0] = 39, [1] = 44, [2] = 201, [3] = 185 }, [7] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 } })[R[53]][R[36]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 32, [1] = 40, [2] = 196, [3] = 177 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [6] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 }, [7] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 } })[R[53]][R[36]], ({ [0] = { [0] = 34, [1] = 99, [2] = 121, [3] = 24 }, [1] = { [0] = 31, [1] = 93, [2] = 108, [3] = 17 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 36, [1] = 39, [2] = 195, [3] = 172 }, [3] = { [0] = 33, [1] = 41, [2] = 197, [3] = 178 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [6] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 }, [7] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 } })[R[53]][R[36]], ({ [0] = { [0] = 35, [1] = 100, [2] = 122, [3] = 25 }, [1] = { [0] = 32, [1] = 94, [2] = 109, [3] = 18 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 36, [1] = 39, [2] = 195, [3] = 172 }, [3] = { [0] = 33, [1] = 41, [2] = 197, [3] = 178 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 37, [1] = 42, [2] = 199, [3] = 182 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 } })[R[53]][R[36]], ({ [0] = { [0] = 36, [1] = 101, [2] = 123, [3] = 26 }, [1] = { [0] = 33, [1] = 95, [2] = 110, [3] = 19 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 17, [1] = 85, [2] = 106, [3] = 9 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 45, [2] = 198, [3] = 183 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 34, [1] = 42, [2] = 198, [3] = 179 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 37, [1] = 42, [2] = 199, [3] = 182 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 30, [1] = 35, [2] = 192, [3] = 176 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 18, [1] = 86, [2] = 107, [3] = 10 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 46, [2] = 199, [3] = 184 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 30, [1] = 35, [2] = 192, [3] = 176 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 35, [1] = 97, [2] = 112, [3] = 21 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 19, [1] = 87, [2] = 108, [3] = 11 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 38, [1] = 41, [2] = 197, [3] = 174 }, [3] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 39, [1] = 44, [2] = 201, [3] = 184 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 36, [1] = 98, [2] = 113, [3] = 22 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 21, [1] = 89, [2] = 104, [3] = 14 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 20, [1] = 88, [2] = 109, [3] = 12 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 48, [2] = 201, [3] = 186 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 38, [1] = 41, [2] = 197, [3] = 174 }, [3] = { [0] = 37, [1] = 45, [2] = 201, [3] = 182 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 41, [1] = 103, [2] = 118, [3] = 27 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 21, [1] = 89, [2] = 110, [3] = 13 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[53]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 49, [1] = 49, [2] = 202, [3] = 187 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 39, [1] = 42, [2] = 198, [3] = 175 }, [3] = { [0] = 38, [1] = 46, [2] = 202, [3] = 183 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[53]][R[36]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 42, [1] = 104, [2] = 119, [3] = 28 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 25, [1] = 93, [2] = 109, [3] = 18 } })[R[53]][R[36]] })
    if R[53] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 50, [1] = 50, [2] = 203, [3] = 188 })[R[36]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 51, [1] = 51, [2] = 204, [3] = 189 })[R[36]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 50, [1] = 50, [2] = 203, [3] = 188 })[R[36]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 51, [1] = 51, [2] = 204, [3] = 189 })[R[36]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[36]] })
        for i = 1, game.initial_units() do
          R[79] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 48, [1] = 48, [2] = 201, [3] = 186 }, [1] = { [0] = 35, [1] = 35, [2] = 188, [3] = 173 }, [2] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 } })[R[79]][R[36]], ({ [0] = { [0] = 25, [1] = 90, [2] = 112, [3] = 15 }, [1] = { [0] = 34, [1] = 99, [2] = 121, [3] = 24 }, [2] = { [0] = 37, [1] = 102, [2] = 124, [3] = 27 } })[R[79]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[36]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[36]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[36]], ({ [0] = 44, [1] = 106, [2] = 121, [3] = 30 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[36]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[36]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[36]], ({ [0] = 44, [1] = 106, [2] = 121, [3] = 30 })[R[36]] })
        for i = 1, game.initial_units() do
          R[80] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 188, [3] = 170 }, [1] = { [0] = 31, [1] = 34, [2] = 190, [3] = 172 }, [2] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 } })[R[80]][R[36]], ({ [0] = { [0] = 38, [1] = 100, [2] = 115, [3] = 24 }, [1] = { [0] = 40, [1] = 102, [2] = 117, [3] = 26 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 18 } })[R[80]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[81] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 30, [1] = 33, [2] = 189, [3] = 166 }, [1] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [2] = { [0] = 48, [1] = 51, [2] = 207, [3] = 184 } })[R[81]][R[36]], ({ [0] = { [0] = 23, [1] = 85, [2] = 100, [3] = 10 }, [1] = { [0] = 39, [1] = 101, [2] = 116, [3] = 26 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 19 } })[R[81]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 46, [2] = 202, [3] = 183 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 47, [2] = 203, [3] = 184 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 48, [2] = 204, [3] = 185 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[36]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 29, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 30, [1] = 97, [2] = 112, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 31, [1] = 98, [2] = 113, [3] = 23 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[36]], ({ [0] = 33, [1] = 100, [2] = 115, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[36]], ({ [0] = 34, [1] = 101, [2] = 116, [3] = 26 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 46, [2] = 202, [3] = 183 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 47, [2] = 203, [3] = 184 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 48, [2] = 204, [3] = 185 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[36]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 29, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 30, [1] = 97, [2] = 112, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 31, [1] = 98, [2] = 113, [3] = 23 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[36]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[36]], ({ [0] = 33, [1] = 100, [2] = 115, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[36]], ({ [0] = 34, [1] = 101, [2] = 116, [3] = 26 })[R[36]] })
        for i = 1, game.initial_units() do
          R[82] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [1] = { [0] = 37, [1] = 45, [2] = 201, [3] = 182 }, [2] = { [0] = 24, [1] = 32, [2] = 188, [3] = 169 } })[R[82]][R[36]], ({ [0] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [1] = { [0] = 35, [1] = 102, [2] = 117, [3] = 27 }, [2] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 } })[R[82]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[36]], ({ [0] = 21, [1] = 89, [2] = 104, [3] = 14 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[36]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[36]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[36]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 29, [1] = 97, [2] = 112, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 30, [1] = 98, [2] = 113, [3] = 23 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[36]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[36]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 25, [1] = 93, [2] = 108, [3] = 18 })[R[36]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 109, [3] = 19 })[R[36]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[36]], ({ [0] = 21, [1] = 89, [2] = 104, [3] = 14 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[36]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[36]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[36]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 29, [1] = 97, [2] = 112, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 30, [1] = 98, [2] = 113, [3] = 23 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[36]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[36]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[36]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 25, [1] = 93, [2] = 108, [3] = 18 })[R[36]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 109, [3] = 19 })[R[36]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[36]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[36]] })
        for i = 1, game.initial_units() do
          R[83] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [1] = { [0] = 29, [1] = 34, [2] = 193, [3] = 175 }, [2] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 } })[R[83]][R[36]], ({ [0] = { [0] = 19, [1] = 87, [2] = 102, [3] = 12 }, [1] = { [0] = 27, [1] = 95, [2] = 110, [3] = 20 }, [2] = { [0] = 22, [1] = 90, [2] = 105, [3] = 15 } })[R[83]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[36]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 19 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[36]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 20 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[36]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 19 })[R[36]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[36]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 20 })[R[36]] })
        for i = 1, game.initial_units() do
          R[84] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [1] = { [0] = 19, [1] = 24, [2] = 181, [3] = 164 }, [2] = { [0] = 41, [1] = 46, [2] = 203, [3] = 186 } })[R[84]][R[36]], ({ [0] = { [0] = 37, [1] = 105, [2] = 121, [3] = 26 }, [1] = { [0] = 24, [1] = 92, [2] = 108, [3] = 13 }, [2] = { [0] = 37, [1] = 105, [2] = 121, [3] = 26 } })[R[84]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 48, [1] = 53, [2] = 210, [3] = 194 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 49, [1] = 54, [2] = 211, [3] = 195 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 48, [1] = 53, [2] = 210, [3] = 194 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] })
        game.create_tube({ ({ [0] = 49, [1] = 54, [2] = 211, [3] = 195 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[36]] })
        for i = 1, game.initial_units() do
          R[85] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 }, [1] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [2] = { [0] = 54, [1] = 59, [2] = 216, [3] = 200 } })[R[85]][R[36]], ({ [0] = { [0] = 13, [1] = 81, [2] = 102, [3] = 5 }, [1] = { [0] = 11, [1] = 79, [2] = 100, [3] = 3 }, [2] = { [0] = 26, [1] = 94, [2] = 115, [3] = 18 } })[R[85]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 34, [1] = 102, [2] = 118, [3] = 27 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 35, [1] = 103, [2] = 119, [3] = 28 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 25, [1] = 93, [2] = 109, [3] = 18 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 34, [1] = 102, [2] = 118, [3] = 27 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 35, [1] = 103, [2] = 119, [3] = 28 })[R[36]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[36]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[36]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[36]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 25, [1] = 93, [2] = 109, [3] = 18 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 24 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[36]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[36]] })
        for i = 1, game.initial_units() do
          R[86] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 }, [1] = { [0] = 35, [1] = 40, [2] = 197, [3] = 181 }, [2] = { [0] = 23, [1] = 28, [2] = 185, [3] = 169 } })[R[86]][R[36]], ({ [0] = { [0] = 19, [1] = 87, [2] = 103, [3] = 12 }, [1] = { [0] = 19, [1] = 87, [2] = 103, [3] = 12 }, [2] = { [0] = 40, [1] = 108, [2] = 124, [3] = 33 } })[R[86]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[53]", R[53])
    end
    R[87] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[87]][R[62]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 24, [1] = 86, [2] = 101, [3] = 11 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    players[4]:center_view({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[87]][R[62]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 24, [1] = 86, [2] = 101, [3] = 11 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[87]][R[62]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 29, [1] = 32, [2] = 188, [3] = 165 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[87]][R[62]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 21, [1] = 83, [2] = 98, [3] = 7 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 36, [1] = 103, [2] = 118, [3] = 28 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    if R[87] == 0 or R[87] == 1 or R[87] == 2 or R[87] == 5 or R[87] == 6 or R[87] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = { [0] = 54, [1] = 54, [2] = 207, [3] = 192 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 32, [1] = 35, [2] = 191, [3] = 168 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 43, [1] = 48, [2] = 205, [3] = 189 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[87]][R[62]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 28, [1] = 90, [2] = 105, [3] = 14 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [5] = { [0] = 33, [1] = 101, [2] = 117, [3] = 22 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      if R[87] == 0 then
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
      elseif R[87] == 1 then
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
      elseif R[87] == 2 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[62]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[62]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 41, [1] = 44, [2] = 200, [3] = 177 })[R[62]], ({ [0] = 29, [1] = 91, [2] = 106, [3] = 16 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[87] == 5 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[62]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[62]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[62]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 15 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[87] == 6 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 51, [1] = 56, [2] = 213, [3] = 197 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[87] == 7 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[87]", R[87])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = { [0] = 31, [1] = 31, [2] = 184, [3] = 169 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 34, [1] = 39, [2] = 196, [3] = 180 }, [7] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 } })[R[87]][R[62]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 38, [1] = 100, [2] = 115, [3] = 24 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 35, [1] = 103, [2] = 119, [3] = 28 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      if R[87] == 2 or R[87] == 5 or R[87] == 6 or R[87] == 7 then
      elseif R[87] == 0 or R[87] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 } })[R[87]][R[62]], ({ [0] = { [0] = 38, [1] = 103, [2] = 125, [3] = 28 }, [1] = { [0] = 46, [1] = 108, [2] = 123, [3] = 32 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[87]", R[87])
      end
    elseif R[87] == 3 or R[87] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 } })[R[87]][R[62]], ({ [3] = { [0] = 36, [1] = 103, [2] = 118, [3] = 28 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      if R[87] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[62]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[87] == 3 then
      else
        unseen("R[87]", R[87])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [3] = { [0] = 30, [1] = 38, [2] = 194, [3] = 175 }, [4] = { [0] = 45, [1] = 50, [2] = 209, [3] = 191 } })[R[87]][R[62]], ({ [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      if R[87] == 3 then
        if LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[62]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[62]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[62]], ({ [0] = 25, [1] = 92, [2] = 107, [3] = 17 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[87] == 4 then
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
        unseen("R[87]", R[87])
      end
    else
      unseen("R[87]", R[87])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = { [0] = 31, [1] = 31, [2] = 184, [3] = 169 }, [1] = { [0] = 28, [1] = 31, [2] = 187, [3] = 169 }, [2] = { [0] = 49, [1] = 52, [2] = 208, [3] = 185 }, [3] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [4] = { [0] = 26, [1] = 31, [2] = 190, [3] = 172 }, [5] = { [0] = 20, [1] = 25, [2] = 182, [3] = 165 }, [6] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 }, [7] = { [0] = 32, [1] = 37, [2] = 194, [3] = 178 } })[R[87]][R[62]], ({ [0] = { [0] = 40, [1] = 105, [2] = 127, [3] = 30 }, [1] = { [0] = 43, [1] = 105, [2] = 120, [3] = 29 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 19, [1] = 86, [2] = 101, [3] = 11 }, [4] = { [0] = 24, [1] = 92, [2] = 107, [3] = 17 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 39, [1] = 107, [2] = 123, [3] = 32 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 38, [1] = 38, [2] = 191, [3] = 176 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 44, [1] = 49, [2] = 208, [3] = 190 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[87]][R[62]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 33, [1] = 95, [2] = 110, [3] = 20 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 19, [1] = 87, [2] = 103, [3] = 8 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 28, [1] = 36, [2] = 192, [3] = 173 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[87]][R[62]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 27, [1] = 89, [2] = 104, [3] = 13 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[4].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 45, [1] = 53, [2] = 209, [3] = 190 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[87]][R[62]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[87]][R[62]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[87]][R[62]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[87]][R[62]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[87]][R[62]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 25, [1] = 30, [2] = 187, [3] = 170 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 } })[R[87]][R[62]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 37, [1] = 99, [2] = 114, [3] = 24 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 18, [1] = 86, [2] = 102, [3] = 7 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 41, [1] = 46, [2] = 205, [3] = 187 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 21, [1] = 26, [2] = 183, [3] = 167 } })[R[87]][R[62]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 82, [2] = 97, [3] = 6 }, [2] = { [0] = 38, [1] = 100, [2] = 115, [3] = 25 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 22, [1] = 90, [2] = 111, [3] = 14 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[4].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 45, [1] = 53, [2] = 209, [3] = 190 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[87]][R[62]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[87]][R[62]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 27, [1] = 30, [2] = 186, [3] = 168 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 46, [1] = 51, [2] = 210, [3] = 192 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 }, [7] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 } })[R[87]][R[62]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 21, [1] = 89, [2] = 105, [3] = 10 }, [6] = { [0] = 28, [1] = 96, [2] = 117, [3] = 20 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[87]][R[62]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 25, [1] = 33, [2] = 189, [3] = 170 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 25, [1] = 30, [2] = 187, [3] = 170 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 } })[R[87]][R[62]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 37, [1] = 99, [2] = 114, [3] = 24 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 18, [1] = 86, [2] = 102, [3] = 7 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 41, [1] = 46, [2] = 205, [3] = 187 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 21, [1] = 26, [2] = 183, [3] = 167 } })[R[87]][R[62]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 82, [2] = 97, [3] = 6 }, [2] = { [0] = 38, [1] = 100, [2] = 115, [3] = 25 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 22, [1] = 90, [2] = 111, [3] = 14 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[4].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 45, [1] = 53, [2] = 209, [3] = 190 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[87]][R[62]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 26, [1] = 93, [2] = 108, [3] = 18 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 27, [1] = 30, [2] = 186, [3] = 163 }, [3] = { [0] = 43, [1] = 51, [2] = 207, [3] = 188 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 41, [1] = 46, [2] = 203, [3] = 187 } })[R[87]][R[62]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 29, [1] = 91, [2] = 106, [3] = 15 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 22, [1] = 89, [2] = 104, [3] = 14 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 45, [1] = 48, [2] = 204, [3] = 181 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 25, [1] = 30, [2] = 187, [3] = 170 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 26, [1] = 31, [2] = 188, [3] = 172 } })[R[87]][R[62]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 37, [1] = 99, [2] = 114, [3] = 24 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 18, [1] = 86, [2] = 102, [3] = 7 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[87]], player = players[4], at = { ({ [0] = { [0] = 33, [1] = 33, [2] = 186, [3] = 171 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 41, [1] = 44, [2] = 200, [3] = 177 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 41, [1] = 46, [2] = 205, [3] = 187 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 21, [1] = 26, [2] = 183, [3] = 167 } })[R[87]][R[62]], ({ [0] = { [0] = 24, [1] = 89, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 82, [2] = 97, [3] = 6 }, [2] = { [0] = 38, [1] = 100, [2] = 115, [3] = 25 }, [3] = { [0] = 37, [1] = 104, [2] = 119, [3] = 29 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 22, [1] = 90, [2] = 111, [3] = 14 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = { [0] = 54, [1] = 54, [2] = 207, [3] = 192 }, [1] = { [0] = 36, [1] = 39, [2] = 195, [3] = 177 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 47, [1] = 52, [2] = 211, [3] = 193 }, [5] = { [0] = 26, [1] = 31, [2] = 188, [3] = 171 }, [6] = { [0] = 47, [1] = 52, [2] = 209, [3] = 193 }, [7] = { [0] = 35, [1] = 40, [2] = 197, [3] = 181 } })[R[87]][R[62]], ({ [0] = { [0] = 35, [1] = 100, [2] = 122, [3] = 25 }, [1] = { [0] = 33, [1] = 95, [2] = 110, [3] = 19 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 23, [1] = 90, [2] = 105, [3] = 15 }, [4] = { [0] = 19, [1] = 87, [2] = 102, [3] = 12 }, [5] = { [0] = 35, [1] = 103, [2] = 119, [3] = 24 }, [6] = { [0] = 25, [1] = 93, [2] = 114, [3] = 17 }, [7] = { [0] = 29, [1] = 97, [2] = 113, [3] = 22 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 34, [1] = 34, [2] = 187, [3] = 172 }, [1] = { [0] = 30, [1] = 33, [2] = 189, [3] = 171 }, [2] = { [0] = 32, [1] = 35, [2] = 191, [3] = 168 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[87]][R[62]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 22, [1] = 90, [2] = 105, [3] = 15 }, [5] = { [0] = 24, [1] = 92, [2] = 108, [3] = 13 }, [6] = { [0] = 17, [1] = 85, [2] = 106, [3] = 9 }, [7] = { [0] = 26, [1] = 94, [2] = 110, [3] = 19 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 35, [2] = 188, [3] = 173 }, [1] = { [0] = 31, [1] = 34, [2] = 190, [3] = 172 }, [2] = { [0] = 33, [1] = 36, [2] = 192, [3] = 169 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[87]][R[62]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 33, [1] = 100, [2] = 115, [3] = 25 }, [4] = { [0] = 23, [1] = 91, [2] = 106, [3] = 16 }, [5] = { [0] = 25, [1] = 93, [2] = 109, [3] = 14 }, [6] = { [0] = 18, [1] = 86, [2] = 107, [3] = 10 }, [7] = { [0] = 27, [1] = 95, [2] = 111, [3] = 20 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 36, [2] = 189, [3] = 174 }, [1] = { [0] = 32, [1] = 35, [2] = 191, [3] = 173 }, [2] = { [0] = 34, [1] = 37, [2] = 193, [3] = 170 }, [3] = { [0] = 27, [1] = 35, [2] = 191, [3] = 172 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[87]][R[62]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 34, [1] = 101, [2] = 116, [3] = 26 }, [4] = { [0] = 24, [1] = 92, [2] = 107, [3] = 17 }, [5] = { [0] = 26, [1] = 94, [2] = 110, [3] = 15 }, [6] = { [0] = 19, [1] = 87, [2] = 108, [3] = 11 }, [7] = { [0] = 28, [1] = 96, [2] = 112, [3] = 21 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 37, [2] = 190, [3] = 175 }, [1] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 28, [1] = 36, [2] = 192, [3] = 173 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[87]][R[62]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 26, [1] = 88, [2] = 103, [3] = 13 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 25, [1] = 93, [2] = 108, [3] = 18 }, [5] = { [0] = 30, [1] = 98, [2] = 114, [3] = 19 }, [6] = { [0] = 20, [1] = 88, [2] = 109, [3] = 12 }, [7] = { [0] = 29, [1] = 97, [2] = 113, [3] = 22 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 38, [2] = 191, [3] = 176 }, [1] = { [0] = 34, [1] = 37, [2] = 193, [3] = 175 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[87]][R[62]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 27, [1] = 89, [2] = 104, [3] = 14 }, [3] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [4] = { [0] = 26, [1] = 94, [2] = 109, [3] = 19 }, [5] = { [0] = 31, [1] = 99, [2] = 115, [3] = 20 }, [6] = { [0] = 21, [1] = 89, [2] = 110, [3] = 13 }, [7] = { [0] = 30, [1] = 98, [2] = 114, [3] = 23 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 39, [2] = 192, [3] = 177 }, [1] = { [0] = 35, [1] = 38, [2] = 194, [3] = 176 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 30, [1] = 35, [2] = 192, [3] = 175 }, [6] = { [0] = 36, [1] = 41, [2] = 198, [3] = 182 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[87]][R[62]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 28, [1] = 90, [2] = 105, [3] = 15 }, [3] = { [0] = 29, [1] = 96, [2] = 111, [3] = 21 }, [4] = { [0] = 30, [1] = 98, [2] = 113, [3] = 23 }, [5] = { [0] = 32, [1] = 100, [2] = 116, [3] = 21 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 31, [1] = 99, [2] = 115, [3] = 24 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 40, [1] = 40, [2] = 193, [3] = 178 }, [1] = { [0] = 36, [1] = 39, [2] = 195, [3] = 177 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 33, [1] = 38, [2] = 195, [3] = 178 }, [6] = { [0] = 37, [1] = 42, [2] = 199, [3] = 183 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[87]][R[62]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 30, [1] = 97, [2] = 112, [3] = 22 }, [4] = { [0] = 31, [1] = 99, [2] = 114, [3] = 24 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 32, [1] = 100, [2] = 116, [3] = 25 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 33, [1] = 38, [2] = 195, [3] = 178 }, [6] = { [0] = 37, [1] = 42, [2] = 199, [3] = 183 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[87]][R[62]], ({ [0] = { [0] = 26, [1] = 91, [2] = 113, [3] = 16 }, [1] = { [0] = 23, [1] = 85, [2] = 100, [3] = 9 }, [2] = { [0] = 30, [1] = 92, [2] = 107, [3] = 17 }, [3] = { [0] = 31, [1] = 98, [2] = 113, [3] = 23 }, [4] = { [0] = 32, [1] = 100, [2] = 115, [3] = 25 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 33, [1] = 101, [2] = 117, [3] = 26 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 29, [1] = 37, [2] = 193, [3] = 174 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 24, [1] = 29, [2] = 186, [3] = 170 } })[R[87]][R[62]], ({ [0] = { [0] = 27, [1] = 92, [2] = 114, [3] = 17 }, [1] = { [0] = 24, [1] = 86, [2] = 101, [3] = 10 }, [2] = { [0] = 31, [1] = 93, [2] = 108, [3] = 18 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 33, [1] = 101, [2] = 116, [3] = 26 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 34, [1] = 102, [2] = 118, [3] = 27 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 30, [1] = 38, [2] = 194, [3] = 175 }, [4] = { [0] = 34, [1] = 39, [2] = 198, [3] = 180 }, [5] = { [0] = 34, [1] = 39, [2] = 196, [3] = 179 }, [6] = { [0] = 38, [1] = 43, [2] = 200, [3] = 184 }, [7] = { [0] = 27, [1] = 32, [2] = 189, [3] = 173 } })[R[87]][R[62]], ({ [0] = { [0] = 28, [1] = 93, [2] = 115, [3] = 18 }, [1] = { [0] = 25, [1] = 87, [2] = 102, [3] = 11 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 19 }, [3] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [4] = { [0] = 34, [1] = 102, [2] = 117, [3] = 27 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 30, [1] = 38, [2] = 194, [3] = 175 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 35, [1] = 40, [2] = 197, [3] = 180 }, [6] = { [0] = 39, [1] = 44, [2] = 201, [3] = 185 }, [7] = { [0] = 27, [1] = 32, [2] = 189, [3] = 173 } })[R[87]][R[62]], ({ [0] = { [0] = 29, [1] = 94, [2] = 116, [3] = 19 }, [1] = { [0] = 26, [1] = 88, [2] = 103, [3] = 12 }, [2] = { [0] = 33, [1] = 95, [2] = 110, [3] = 20 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 37, [1] = 40, [2] = 196, [3] = 178 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 31, [1] = 39, [2] = 195, [3] = 176 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 35, [1] = 40, [2] = 197, [3] = 180 }, [6] = { [0] = 39, [1] = 44, [2] = 201, [3] = 185 }, [7] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 } })[R[87]][R[62]], ({ [0] = { [0] = 33, [1] = 98, [2] = 120, [3] = 23 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 34, [1] = 96, [2] = 111, [3] = 21 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [3] = { [0] = 32, [1] = 40, [2] = 196, [3] = 177 }, [4] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 }, [5] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [6] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 }, [7] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 } })[R[87]][R[62]], ({ [0] = { [0] = 34, [1] = 99, [2] = 121, [3] = 24 }, [1] = { [0] = 31, [1] = 93, [2] = 108, [3] = 17 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 15, [1] = 83, [2] = 104, [3] = 7 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 36, [1] = 39, [2] = 195, [3] = 172 }, [3] = { [0] = 33, [1] = 41, [2] = 197, [3] = 178 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [6] = { [0] = 40, [1] = 45, [2] = 202, [3] = 186 }, [7] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 } })[R[87]][R[62]], ({ [0] = { [0] = 35, [1] = 100, [2] = 122, [3] = 25 }, [1] = { [0] = 32, [1] = 94, [2] = 109, [3] = 18 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 42, [2] = 195, [3] = 180 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 36, [1] = 39, [2] = 195, [3] = 172 }, [3] = { [0] = 33, [1] = 41, [2] = 197, [3] = 178 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 37, [1] = 42, [2] = 199, [3] = 182 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 } })[R[87]][R[62]], ({ [0] = { [0] = 36, [1] = 101, [2] = 123, [3] = 26 }, [1] = { [0] = 33, [1] = 95, [2] = 110, [3] = 19 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 17, [1] = 85, [2] = 106, [3] = 9 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 45, [2] = 198, [3] = 183 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 34, [1] = 42, [2] = 198, [3] = 179 }, [4] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [5] = { [0] = 37, [1] = 42, [2] = 199, [3] = 182 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 30, [1] = 35, [2] = 192, [3] = 176 } })[R[87]][R[62]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 34, [1] = 96, [2] = 111, [3] = 20 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 34, [1] = 102, [2] = 118, [3] = 23 }, [6] = { [0] = 18, [1] = 86, [2] = 107, [3] = 10 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 46, [2] = 199, [3] = 184 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 37, [1] = 40, [2] = 196, [3] = 173 }, [3] = { [0] = 35, [1] = 43, [2] = 199, [3] = 180 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 38, [1] = 43, [2] = 200, [3] = 183 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 30, [1] = 35, [2] = 192, [3] = 176 } })[R[87]][R[62]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 35, [1] = 97, [2] = 112, [3] = 21 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 20, [1] = 88, [2] = 103, [3] = 13 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 19, [1] = 87, [2] = 108, [3] = 11 }, [7] = { [0] = 36, [1] = 104, [2] = 120, [3] = 29 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 38, [1] = 41, [2] = 197, [3] = 174 }, [3] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 39, [1] = 44, [2] = 201, [3] = 184 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[87]][R[62]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 36, [1] = 98, [2] = 113, [3] = 22 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 21, [1] = 89, [2] = 104, [3] = 14 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 20, [1] = 88, [2] = 109, [3] = 12 }, [7] = { [0] = 23, [1] = 91, [2] = 107, [3] = 16 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 48, [2] = 201, [3] = 186 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 38, [1] = 41, [2] = 197, [3] = 174 }, [3] = { [0] = 37, [1] = 45, [2] = 201, [3] = 182 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 42, [1] = 47, [2] = 204, [3] = 188 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[87]][R[62]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 41, [1] = 103, [2] = 118, [3] = 27 }, [2] = { [0] = 35, [1] = 97, [2] = 112, [3] = 22 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 28, [1] = 96, [2] = 111, [3] = 21 }, [5] = { [0] = 28, [1] = 96, [2] = 112, [3] = 17 }, [6] = { [0] = 21, [1] = 89, [2] = 110, [3] = 13 }, [7] = { [0] = 24, [1] = 92, [2] = 108, [3] = 17 } })[R[87]][R[62]] })
    game.create_tube({ ({ [0] = { [0] = 49, [1] = 49, [2] = 202, [3] = 187 }, [1] = { [0] = 38, [1] = 41, [2] = 197, [3] = 179 }, [2] = { [0] = 39, [1] = 42, [2] = 198, [3] = 175 }, [3] = { [0] = 38, [1] = 46, [2] = 202, [3] = 183 }, [4] = { [0] = 39, [1] = 44, [2] = 203, [3] = 185 }, [5] = { [0] = 40, [1] = 45, [2] = 202, [3] = 185 }, [6] = { [0] = 46, [1] = 51, [2] = 208, [3] = 192 }, [7] = { [0] = 31, [1] = 36, [2] = 193, [3] = 177 } })[R[87]][R[62]], ({ [0] = { [0] = 31, [1] = 96, [2] = 118, [3] = 21 }, [1] = { [0] = 42, [1] = 104, [2] = 119, [3] = 28 }, [2] = { [0] = 29, [1] = 91, [2] = 106, [3] = 16 }, [3] = { [0] = 25, [1] = 92, [2] = 107, [3] = 17 }, [4] = { [0] = 36, [1] = 104, [2] = 119, [3] = 29 }, [5] = { [0] = 29, [1] = 97, [2] = 113, [3] = 18 }, [6] = { [0] = 23, [1] = 91, [2] = 112, [3] = 15 }, [7] = { [0] = 25, [1] = 93, [2] = 109, [3] = 18 } })[R[87]][R[62]] })
    if R[87] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 50, [1] = 50, [2] = 203, [3] = 188 })[R[62]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[62]] })
        game.create_tube({ ({ [0] = 51, [1] = 51, [2] = 204, [3] = 189 })[R[62]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[62]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 50, [1] = 50, [2] = 203, [3] = 188 })[R[62]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[62]] })
        game.create_tube({ ({ [0] = 51, [1] = 51, [2] = 204, [3] = 189 })[R[62]], ({ [0] = 31, [1] = 96, [2] = 118, [3] = 21 })[R[62]] })
        for i = 1, game.initial_units() do
          R[88] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 48, [1] = 48, [2] = 201, [3] = 186 }, [1] = { [0] = 35, [1] = 35, [2] = 188, [3] = 173 }, [2] = { [0] = 47, [1] = 47, [2] = 200, [3] = 185 } })[R[88]][R[62]], ({ [0] = { [0] = 25, [1] = 90, [2] = 112, [3] = 15 }, [1] = { [0] = 34, [1] = 99, [2] = 121, [3] = 24 }, [2] = { [0] = 37, [1] = 102, [2] = 124, [3] = 27 } })[R[88]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[62]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[62]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[62]], ({ [0] = 44, [1] = 106, [2] = 121, [3] = 30 })[R[62]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[62]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[62]], ({ [0] = 43, [1] = 105, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 38, [1] = 41, [2] = 197, [3] = 179 })[R[62]], ({ [0] = 44, [1] = 106, [2] = 121, [3] = 30 })[R[62]] })
        for i = 1, game.initial_units() do
          R[89] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 188, [3] = 170 }, [1] = { [0] = 31, [1] = 34, [2] = 190, [3] = 172 }, [2] = { [0] = 33, [1] = 36, [2] = 192, [3] = 174 } })[R[89]][R[62]], ({ [0] = { [0] = 38, [1] = 100, [2] = 115, [3] = 24 }, [1] = { [0] = 40, [1] = 102, [2] = 117, [3] = 26 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 18 } })[R[89]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[90] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 30, [1] = 33, [2] = 189, [3] = 166 }, [1] = { [0] = 35, [1] = 38, [2] = 194, [3] = 171 }, [2] = { [0] = 48, [1] = 51, [2] = 207, [3] = 184 } })[R[90]][R[62]], ({ [0] = { [0] = 23, [1] = 85, [2] = 100, [3] = 10 }, [1] = { [0] = 39, [1] = 101, [2] = 116, [3] = 26 }, [2] = { [0] = 32, [1] = 94, [2] = 109, [3] = 19 } })[R[90]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 46, [2] = 202, [3] = 183 })[R[62]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 47, [2] = 203, [3] = 184 })[R[62]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[62]] })
        game.create_tube({ ({ [0] = 40, [1] = 48, [2] = 204, [3] = 185 })[R[62]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[62]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[62]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[62]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[62]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[62]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[62]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[62]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[62]], ({ [0] = 29, [1] = 96, [2] = 111, [3] = 21 })[R[62]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[62]], ({ [0] = 30, [1] = 97, [2] = 112, [3] = 22 })[R[62]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[62]], ({ [0] = 31, [1] = 98, [2] = 113, [3] = 23 })[R[62]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[62]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[62]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[62]], ({ [0] = 33, [1] = 100, [2] = 115, [3] = 25 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[62]], ({ [0] = 34, [1] = 101, [2] = 116, [3] = 26 })[R[62]] })
        for i = 1, game.initial_units() do
          R[91] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 36, [1] = 44, [2] = 200, [3] = 181 }, [1] = { [0] = 37, [1] = 45, [2] = 201, [3] = 182 }, [2] = { [0] = 24, [1] = 32, [2] = 188, [3] = 169 } })[R[91]][R[62]], ({ [0] = { [0] = 28, [1] = 95, [2] = 110, [3] = 20 }, [1] = { [0] = 35, [1] = 102, [2] = 117, [3] = 27 }, [2] = { [0] = 32, [1] = 99, [2] = 114, [3] = 24 } })[R[91]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 46, [2] = 202, [3] = 183 })[R[62]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 47, [2] = 203, [3] = 184 })[R[62]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[62]] })
        game.create_tube({ ({ [0] = 40, [1] = 48, [2] = 204, [3] = 185 })[R[62]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[62]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[62]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[62]] })
        game.create_tube({ ({ [0] = 41, [1] = 49, [2] = 205, [3] = 186 })[R[62]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[62]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[62]], ({ [0] = 28, [1] = 95, [2] = 110, [3] = 20 })[R[62]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[62]], ({ [0] = 29, [1] = 96, [2] = 111, [3] = 21 })[R[62]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[62]], ({ [0] = 30, [1] = 97, [2] = 112, [3] = 22 })[R[62]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[62]], ({ [0] = 31, [1] = 98, [2] = 113, [3] = 23 })[R[62]] })
        game.create_tube({ ({ [0] = 42, [1] = 50, [2] = 206, [3] = 187 })[R[62]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[62]], ({ [0] = 32, [1] = 99, [2] = 114, [3] = 24 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[62]], ({ [0] = 33, [1] = 100, [2] = 115, [3] = 25 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 51, [2] = 207, [3] = 188 })[R[62]], ({ [0] = 34, [1] = 101, [2] = 116, [3] = 26 })[R[62]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[62]], ({ [0] = 21, [1] = 89, [2] = 104, [3] = 14 })[R[62]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[62]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[62]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[62]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[62]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[62]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[62]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[62]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[62]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[62]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[62]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[62]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[62]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[62]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[62]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[62]], ({ [0] = 29, [1] = 97, [2] = 112, [3] = 22 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[62]], ({ [0] = 30, [1] = 98, [2] = 113, [3] = 23 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[62]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[62]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[62]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[62]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[62]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[62]], ({ [0] = 25, [1] = 93, [2] = 108, [3] = 18 })[R[62]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[62]], ({ [0] = 26, [1] = 94, [2] = 109, [3] = 19 })[R[62]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[62]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[62]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[62]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[62]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[62]], ({ [0] = 21, [1] = 89, [2] = 104, [3] = 14 })[R[62]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[62]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[62]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[62]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[62]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 204, [3] = 186 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[62]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[62]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[62]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[62]] })
        game.create_tube({ ({ [0] = 41, [1] = 46, [2] = 205, [3] = 187 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[62]], ({ [0] = 22, [1] = 90, [2] = 105, [3] = 15 })[R[62]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[62]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[62]] })
        game.create_tube({ ({ [0] = 42, [1] = 47, [2] = 206, [3] = 188 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[62]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[62]], ({ [0] = 28, [1] = 96, [2] = 111, [3] = 21 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[62]], ({ [0] = 29, [1] = 97, [2] = 112, [3] = 22 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[62]], ({ [0] = 30, [1] = 98, [2] = 113, [3] = 23 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[62]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[62]] })
        game.create_tube({ ({ [0] = 43, [1] = 48, [2] = 207, [3] = 189 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 119, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[62]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[62]] })
        game.create_tube({ ({ [0] = 44, [1] = 49, [2] = 208, [3] = 190 })[R[62]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[62]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[62]], ({ [0] = 25, [1] = 93, [2] = 108, [3] = 18 })[R[62]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[62]], ({ [0] = 26, [1] = 94, [2] = 109, [3] = 19 })[R[62]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[62]], ({ [0] = 27, [1] = 95, [2] = 110, [3] = 20 })[R[62]] })
        game.create_tube({ ({ [0] = 45, [1] = 50, [2] = 209, [3] = 191 })[R[62]], ({ [0] = 35, [1] = 103, [2] = 118, [3] = 28 })[R[62]] })
        for i = 1, game.initial_units() do
          R[92] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 38, [1] = 43, [2] = 202, [3] = 184 }, [1] = { [0] = 29, [1] = 34, [2] = 193, [3] = 175 }, [2] = { [0] = 37, [1] = 42, [2] = 201, [3] = 183 } })[R[92]][R[62]], ({ [0] = { [0] = 19, [1] = 87, [2] = 102, [3] = 12 }, [1] = { [0] = 27, [1] = 95, [2] = 110, [3] = 20 }, [2] = { [0] = 22, [1] = 90, [2] = 105, [3] = 15 } })[R[92]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[62]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 19 })[R[62]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[62]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 20 })[R[62]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[62]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 19 })[R[62]] })
        game.create_tube({ ({ [0] = 40, [1] = 45, [2] = 202, [3] = 185 })[R[62]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 20 })[R[62]] })
        for i = 1, game.initial_units() do
          R[93] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 36, [1] = 41, [2] = 198, [3] = 181 }, [1] = { [0] = 19, [1] = 24, [2] = 181, [3] = 164 }, [2] = { [0] = 41, [1] = 46, [2] = 203, [3] = 186 } })[R[93]][R[62]], ({ [0] = { [0] = 37, [1] = 105, [2] = 121, [3] = 26 }, [1] = { [0] = 24, [1] = 92, [2] = 108, [3] = 13 }, [2] = { [0] = 37, [1] = 105, [2] = 121, [3] = 26 } })[R[93]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[62]] })
        game.create_tube({ ({ [0] = 48, [1] = 53, [2] = 210, [3] = 194 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[62]] })
        game.create_tube({ ({ [0] = 49, [1] = 54, [2] = 211, [3] = 195 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[62]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 47, [1] = 52, [2] = 209, [3] = 193 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[62]] })
        game.create_tube({ ({ [0] = 48, [1] = 53, [2] = 210, [3] = 194 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[62]] })
        game.create_tube({ ({ [0] = 49, [1] = 54, [2] = 211, [3] = 195 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 112, [3] = 15 })[R[62]] })
        for i = 1, game.initial_units() do
          R[94] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 28, [1] = 33, [2] = 190, [3] = 174 }, [1] = { [0] = 33, [1] = 38, [2] = 195, [3] = 179 }, [2] = { [0] = 54, [1] = 59, [2] = 216, [3] = 200 } })[R[94]][R[62]], ({ [0] = { [0] = 13, [1] = 81, [2] = 102, [3] = 5 }, [1] = { [0] = 11, [1] = 79, [2] = 100, [3] = 3 }, [2] = { [0] = 26, [1] = 94, [2] = 115, [3] = 18 } })[R[94]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[62]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[62]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[62]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[62]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[62]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[62]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[62]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[62]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[62]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[62]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[62]], ({ [0] = 34, [1] = 102, [2] = 118, [3] = 27 })[R[62]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[62]], ({ [0] = 35, [1] = 103, [2] = 119, [3] = 28 })[R[62]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[62]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[62]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[62]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[62]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[62]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[62]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 25, [1] = 93, [2] = 109, [3] = 18 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 22 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 24 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[62]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[62]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[62]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[62]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[62]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[62]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[62]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[62]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[62]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[62]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[62]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[62]], ({ [0] = 34, [1] = 102, [2] = 118, [3] = 27 })[R[62]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[62]], ({ [0] = 35, [1] = 103, [2] = 119, [3] = 28 })[R[62]] })
        game.create_tube({ ({ [0] = 31, [1] = 36, [2] = 193, [3] = 177 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[62]] })
        game.create_tube({ ({ [0] = 32, [1] = 37, [2] = 194, [3] = 178 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[62]] })
        game.create_tube({ ({ [0] = 33, [1] = 38, [2] = 195, [3] = 179 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[62]] })
        game.create_tube({ ({ [0] = 34, [1] = 39, [2] = 196, [3] = 180 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[62]] })
        game.create_tube({ ({ [0] = 35, [1] = 40, [2] = 197, [3] = 181 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[62]] })
        game.create_tube({ ({ [0] = 36, [1] = 41, [2] = 198, [3] = 182 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[62]], ({ [0] = 23, [1] = 91, [2] = 107, [3] = 16 })[R[62]] })
        game.create_tube({ ({ [0] = 37, [1] = 42, [2] = 199, [3] = 183 })[R[62]], ({ [0] = 36, [1] = 104, [2] = 120, [3] = 29 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 25, [1] = 93, [2] = 109, [3] = 18 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 26, [1] = 94, [2] = 110, [3] = 19 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 27, [1] = 95, [2] = 111, [3] = 20 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 28, [1] = 96, [2] = 112, [3] = 21 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 29, [1] = 97, [2] = 113, [3] = 22 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 30, [1] = 98, [2] = 114, [3] = 23 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 31, [1] = 99, [2] = 115, [3] = 24 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 32, [1] = 100, [2] = 116, [3] = 25 })[R[62]] })
        game.create_tube({ ({ [0] = 39, [1] = 44, [2] = 201, [3] = 185 })[R[62]], ({ [0] = 33, [1] = 101, [2] = 117, [3] = 26 })[R[62]] })
        for i = 1, game.initial_units() do
          R[95] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 29, [1] = 34, [2] = 191, [3] = 175 }, [1] = { [0] = 35, [1] = 40, [2] = 197, [3] = 181 }, [2] = { [0] = 23, [1] = 28, [2] = 185, [3] = 169 } })[R[95]][R[62]], ({ [0] = { [0] = 19, [1] = 87, [2] = 103, [3] = 12 }, [1] = { [0] = 19, [1] = 87, [2] = 103, [3] = 12 }, [2] = { [0] = 40, [1] = 108, [2] = 124, [3] = 33 } })[R[95]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[87]", R[87])
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
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Tornados}  -- after 60 to 120 marks
    trigger.research{tech = 5110, one_shot = true, on = Lava}
  end
  return true
end
