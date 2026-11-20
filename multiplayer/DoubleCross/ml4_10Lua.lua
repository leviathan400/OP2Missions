-- ml4_10Lua.lua  -  4 Player, LastOne, 'Double Cross' map. (Lua)
--
-- Converted by op2dll from ml4_10.dll ("4 Player, LastOne, 'Double Cross' map."): its setup replayed. `on_init` makes the original's
-- draws of the game's random numbers in its order and, from them and the lobby, the same units,
-- beacons, walls and settings in the same order, as the original's setup did in every game
-- sampled (every player count, the lobby's colonies, resource levels, vehicles, day and night,
-- morale and disasters). Anything not converted is listed at the end. Coordinates are the in-game
-- status-bar ones (map file tile + 1).

-- Where lava may flow from an eruption, as areas { x1, y1, x2, y2 }.
local LAVA_POSSIBLE = {
  { 76, 49, 77, 49 }, { 76, 50, 76, 50 }, { 74, 51, 76, 51 }, { 67, 52, 67, 52 }, { 71, 52, 74, 52 }, { 61, 53, 61, 53 },
  { 63, 53, 73, 53 }, { 60, 54, 72, 54 }, { 60, 55, 71, 55 }, { 61, 56, 71, 56 }, { 61, 57, 70, 57 }, { 58, 58, 69, 58 },
  { 59, 59, 68, 59 }, { 60, 60, 69, 60 }, { 58, 61, 69, 61 }, { 57, 62, 69, 62 }, { 57, 63, 68, 63 }, { 58, 64, 66, 64 },
  { 57, 65, 67, 65 }, { 57, 66, 69, 66 }, { 58, 67, 69, 67 }, { 57, 68, 70, 68 }, { 56, 69, 61, 69 }, { 63, 69, 70, 69 },
  { 56, 70, 60, 70 }, { 65, 70, 70, 70 }, { 57, 71, 59, 71 }, { 66, 71, 70, 71 }, { 56, 72, 59, 73 }, { 66, 72, 69, 72 },
  { 67, 73, 68, 73 }, { 56, 74, 60, 74 }, { 66, 74, 68, 74 }, { 57, 75, 61, 75 }, { 63, 75, 63, 75 }, { 65, 75, 68, 75 },
  { 58, 76, 68, 76 }, { 59, 77, 68, 77 }, { 59, 78, 67, 78 }, { 58, 79, 68, 79 }, { 59, 80, 68, 80 }, { 61, 81, 68, 81 },
  { 61, 82, 67, 82 }, { 59, 83, 59, 83 }, { 61, 83, 64, 83 }, { 61, 84, 65, 87 }, { 61, 88, 62, 88 }, { 61, 89, 63, 89 },
  { 61, 90, 62, 90 }, { 61, 91, 61, 91 },
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
local Lava, Quakes

function Lava(t)
  game.create_eruption({ 63, 76 }, 200)
end

function Quakes(t)
  local r1 = game.rand(4)
  local r2 = game.rand(50)
  local r3 = game.rand(33)
  game.create_meteor({ r3 + 51, r2 + 43 }, r1 + 1)
end

function on_init()
  local n = game.num_players()
  if n == 2 then
    for _, area in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(area) end
    game.initial_set_tile({ 63, 74 }, 1140)
    game.initial_set_tile({ 63, 75 }, 1150)
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 100, 6 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 8, 17 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 36, 109 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 96, 100 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 67, 83 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 58, 60 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 72, 56 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 59, 82 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 65, 89 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 65, 73 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 71, 63 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 77, 49 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 54, 65 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 40, 117 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 94, 124 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 74, 99 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 14, 2 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 22, 28 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 109, 3 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 91, 21 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 53, 78 } }
    R[0] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 50, [1] = 75, [2] = 68, [3] = 76 })[R[0]], ({ [0] = 18, [1] = 8, [2] = 31, [3] = 43 })[R[0]] } }
    R[1] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 36, [2] = 13, [3] = 44 })[R[1]], ({ [0] = 48, [1] = 61, [2] = 70, [3] = 48 })[R[1]] } }
    R[2] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 55, [1] = 78, [2] = 66, [3] = 57 })[R[2]], ({ [0] = 113, [1] = 117, [2] = 120, [3] = 100 })[R[2]] } }
    R[3] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 117, [1] = 123, [2] = 102, [3] = 78 })[R[3]], ({ [0] = 78, [1] = 49, [2] = 57, [3] = 95 })[R[3]] } }
    R[4] = draw_avoid(4, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 50, [1] = 75, [2] = 68, [3] = 76 })[R[4]], ({ [0] = 18, [1] = 8, [2] = 31, [3] = 43 })[R[4]] } }
    R[5] = draw_avoid(4, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 36, [2] = 13, [3] = 44 })[R[5]], ({ [0] = 48, [1] = 61, [2] = 70, [3] = 48 })[R[5]] } }
    R[6] = draw_avoid(4, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 55, [1] = 78, [2] = 66, [3] = 57 })[R[6]], ({ [0] = 113, [1] = 117, [2] = 120, [3] = 100 })[R[6]] } }
    R[7] = draw_avoid(4, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 117, [1] = 123, [2] = 102, [3] = 78 })[R[7]], ({ [0] = 78, [1] = 49, [2] = 57, [3] = 95 })[R[7]] } }
    R[8] = draw_avoid(4, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 50, [1] = 75, [2] = 68, [3] = 76 })[R[8]], ({ [0] = 18, [1] = 8, [2] = 31, [3] = 43 })[R[8]] } }
    R[9] = draw_avoid(4, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 36, [2] = 13, [3] = 44 })[R[9]], ({ [0] = 48, [1] = 61, [2] = 70, [3] = 48 })[R[9]] } }
    R[10] = draw_avoid(4, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 55, [1] = 78, [2] = 66, [3] = 57 })[R[10]], ({ [0] = 113, [1] = 117, [2] = 120, [3] = 100 })[R[10]] } }
    R[11] = draw_avoid(4, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 117, [1] = 123, [2] = 102, [3] = 78 })[R[11]], ({ [0] = 78, [1] = 49, [2] = 57, [3] = 95 })[R[11]] } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 54, 42 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 96, 49 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 95, 88 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 35, 86 } }
    R[12] = game.rand(4)
    R[13] = game.rand(2)
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 29, [1] = 10, [2] = 82, [3] = 95 })[R[12]], ({ [0] = 23, [1] = 105, [2] = 106, [3] = 29 })[R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 17, [1] = 25, [2] = 102, [3] = 83 })[R[12]], ({ [0] = 30, [1] = 110, [2] = 107, [3] = 21 })[R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { ({ [0] = 27, [1] = 7, [2] = 111, [3] = 115 })[R[12]], ({ [0] = 8, [1] = 110, [2] = 119, [3] = 26 })[R[12]] } }
    U[#U + 1] = game.create_unit{ type = "CommonOreMine", player = players[1], at = { ({ [0] = 27, [1] = 7, [2] = 111, [3] = 115 })[R[12]], ({ [0] = 8, [1] = 110, [2] = 119, [3] = 26 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    R[14] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [3] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [4] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [5] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[14]][R[12]], ({ [0] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [5] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [6] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [3] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [4] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [5] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[14]][R[12]], ({ [0] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [5] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [6] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[14]][R[12]] })
    if R[14] == 1 or R[14] == 2 or R[14] == 3 or R[14] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [3] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [4] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[14]][R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 1 or R[14] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 } })[R[14]][R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[12]], ({ [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 } })[R[14]][R[12]], ({ [1] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 } })[R[14]][R[12]], ({ [1] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [2] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [2] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 } })[R[14]][R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[14]][R[12]], ({ [1] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [2] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[12]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 10, [1] = 112, [2] = 110, [3] = 12 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[14]", R[14])
      end
      U[#U]:set_lights(true)
      if R[14] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 4 then
        if LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 9, [1] = 11, [2] = 88, [3] = 94 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[14]", R[14])
      end
      U[#U]:set_lights(true)
      if R[14] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 9, [1] = 11, [2] = 88, [3] = 94 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[14]", R[14])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [2] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [3] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [4] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 } })[R[14]][R[12]], ({ [1] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [2] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [3] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [4] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[14] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[14] == 5 or R[14] == 6 or R[14] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [6] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [7] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 } })[R[14]][R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 } })[R[14]][R[12]], ({ [5] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [6] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [7] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[14] == 5 or R[14] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [7] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[14]][R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        if R[14] == 5 then
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
        elseif R[14] == 7 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[14]", R[14])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [5] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[14]][R[12]], ({ [5] = { [0] = 19, [1] = 121, [2] = 119, [3] = 21 }, [7] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        if R[14] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[14] == 7 then
        else
          unseen("R[14]", R[14])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [5] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [5] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [7] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [7] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[14]][R[12]], ({ [5] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [7] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[14]", R[14])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [6] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 }, [7] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 } })[R[14]][R[12]], ({ [5] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [6] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [7] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[14] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[14] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[14]", R[14])
      end
    else
      unseen("R[14]", R[14])
    end
    U[#U]:set_lights(true)
    if R[14] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[14] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[14] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 15, [1] = 117, [2] = 115, [3] = 17 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 15, [1] = 117, [2] = 115, [3] = 17 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[14]", R[14])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[14]], player = players[1], at = { ({ [0] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [3] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [4] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [5] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [6] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [7] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[14]][R[12]], ({ [0] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [5] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [6] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [7] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[14]], player = players[1], at = { ({ [0] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [1] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [3] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [4] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [5] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [6] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [7] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 } })[R[14]][R[12]], ({ [0] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [3] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 }, [4] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [5] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [6] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [7] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[14] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[15] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [1] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[15]][R[12]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 19, [1] = 121, [2] = 119, [3] = 21 } })[R[15]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        for i = 1, game.initial_units() do
          R[16] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[16]][R[12]], ({ [0] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [1] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [2] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 } })[R[16]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
        for i = 1, game.initial_units() do
          R[17] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [1] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 } })[R[17]][R[12]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[17]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
        for i = 1, game.initial_units() do
          R[18] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [1] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [2] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[18]][R[12]], ({ [0] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 } })[R[18]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] })
        for i = 1, game.initial_units() do
          R[19] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [1] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[19]][R[12]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[19]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[20] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 } })[R[20]][R[12]], ({ [0] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[20]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[21]][R[12]], ({ [0] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [1] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [2] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 } })[R[21]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[22]][R[12]], ({ [0] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[22]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[14]", R[14])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = { [0] = 95, [1] = 95, [2] = 10, [3] = 10 }, [1] = { [0] = 82, [1] = 82, [2] = 29, [3] = 29 } })[R[13]][R[12]], ({ [0] = { [0] = 29, [1] = 29, [2] = 105, [3] = 105 }, [1] = { [0] = 106, [1] = 106, [2] = 23, [3] = 23 } })[R[13]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = { [0] = 83, [1] = 83, [2] = 25, [3] = 25 }, [1] = { [0] = 102, [1] = 102, [2] = 17, [3] = 17 } })[R[13]][R[12]], ({ [0] = { [0] = 21, [1] = 21, [2] = 110, [3] = 110 }, [1] = { [0] = 107, [1] = 107, [2] = 30, [3] = 30 } })[R[13]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { ({ [0] = { [0] = 115, [1] = 115, [2] = 7, [3] = 7 }, [1] = { [0] = 111, [1] = 111, [2] = 27, [3] = 27 } })[R[13]][R[12]], ({ [0] = { [0] = 26, [1] = 26, [2] = 110, [3] = 110 }, [1] = { [0] = 119, [1] = 119, [2] = 8, [3] = 8 } })[R[13]][R[12]] } }
    U[#U + 1] = game.create_unit{ type = "CommonOreMine", player = players[2], at = { ({ [0] = { [0] = 115, [1] = 115, [2] = 7, [3] = 7 }, [1] = { [0] = 111, [1] = 111, [2] = 27, [3] = 27 } })[R[13]][R[12]], ({ [0] = { [0] = 26, [1] = 26, [2] = 110, [3] = 110 }, [1] = { [0] = 119, [1] = 119, [2] = 8, [3] = 8 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    R[23] = game.rand(8)
    if R[23] == 0 then
      if R[13] == 0 then
        if R[12] == 0 or R[12] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 100, 19 }, direction = "East", lights = false, exact = true }[1]
        elseif R[12] == 2 or R[12] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 17, 119 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[12]", R[12])
        end
      elseif R[13] == 1 then
        if R[12] == 0 or R[12] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 94, 117 }, direction = "East", lights = false, exact = true }[1]
        elseif R[12] == 2 or R[12] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 15, 17 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[12]", R[12])
        end
      else
        unseen("R[13]", R[13])
      end
    elseif R[23] == 1 then
      if R[13] == 0 then
        if R[12] == 2 or R[12] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 21, 115 }, direction = "East", lights = false, exact = true }[1]
        elseif R[12] == 0 or R[12] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 104, 15 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[12]", R[12])
        end
      elseif R[13] == 1 then
        if R[12] == 2 or R[12] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 19, 13 }, direction = "East", lights = false, exact = true }[1]
        elseif R[12] == 0 or R[12] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 98, 113 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[12]", R[12])
        end
      else
        unseen("R[13]", R[13])
      end
    elseif R[23] == 2 then
      if R[13] == 0 then
        if R[12] == 0 or R[12] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 104, 19 }, direction = "East", lights = false, exact = true }[1]
        elseif R[12] == 2 or R[12] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 21, 119 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[12]", R[12])
        end
      elseif R[13] == 1 then
        if R[12] == 2 or R[12] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 19, 17 }, direction = "East", lights = false, exact = true }[1]
        elseif R[12] == 0 or R[12] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 98, 117 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[12]", R[12])
        end
      else
        unseen("R[13]", R[13])
      end
    elseif R[23] == 3 then
      if R[13] == 0 then
        if R[12] == 2 or R[12] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 13, 115 }, direction = "East", lights = false, exact = true }[1]
        elseif R[12] == 0 or R[12] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 96, 15 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[12]", R[12])
        end
      elseif R[13] == 1 then
        if R[12] == 0 or R[12] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 90, 113 }, direction = "East", lights = false, exact = true }[1]
        elseif R[12] == 2 or R[12] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 11, 13 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[12]", R[12])
        end
      else
        unseen("R[13]", R[13])
      end
    elseif R[23] == 4 then
      if R[13] == 0 then
        if R[12] == 0 or R[12] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 100, 18 }, direction = "East", lights = false, exact = true }[1]
        elseif R[12] == 2 or R[12] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 17, 118 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[12]", R[12])
        end
      elseif R[13] == 1 then
        if R[12] == 0 or R[12] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 94, 116 }, direction = "East", lights = false, exact = true }[1]
        elseif R[12] == 2 or R[12] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 15, 16 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[12]", R[12])
        end
      else
        unseen("R[13]", R[13])
      end
    elseif R[23] == 5 then
      if R[13] == 0 then
        if R[12] == 0 or R[12] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 99, 16 }, direction = "East", lights = false, exact = true }[1]
        elseif R[12] == 2 or R[12] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 16, 116 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[12]", R[12])
        end
      elseif R[13] == 1 then
        if R[12] == 0 or R[12] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 93, 114 }, direction = "East", lights = false, exact = true }[1]
        elseif R[12] == 2 or R[12] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 14, 14 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[12]", R[12])
        end
      else
        unseen("R[13]", R[13])
      end
    elseif R[23] == 6 then
      if R[13] == 0 then
        if R[12] == 0 or R[12] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 96, 13 }, direction = "East", lights = false, exact = true }[1]
        elseif R[12] == 2 or R[12] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 13, 113 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[12]", R[12])
        end
      elseif R[13] == 1 then
        if R[12] == 2 or R[12] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 11, 11 }, direction = "East", lights = false, exact = true }[1]
        elseif R[12] == 0 or R[12] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 90, 111 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[12]", R[12])
        end
      else
        unseen("R[13]", R[13])
      end
    elseif R[23] == 7 then
      if R[13] == 0 then
        if R[12] == 0 or R[12] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 102, 16 }, direction = "East", lights = false, exact = true }[1]
        elseif R[12] == 2 or R[12] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 19, 116 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[12]", R[12])
        end
      elseif R[13] == 1 then
        if R[12] == 0 or R[12] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 96, 114 }, direction = "East", lights = false, exact = true }[1]
        elseif R[12] == 2 or R[12] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 17, 14 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[12]", R[12])
        end
      else
        unseen("R[13]", R[13])
      end
    else
      unseen("R[23]", R[23])
    end
    if R[23] == 0 then
      if R[13] == 0 then
        if R[12] == 0 or R[12] == 1 then
          players[2]:center_view({ 100, 19 })
        elseif R[12] == 2 or R[12] == 3 then
          players[2]:center_view({ 17, 119 })
        else
          unseen("R[12]", R[12])
        end
      elseif R[13] == 1 then
        if R[12] == 0 or R[12] == 1 then
          players[2]:center_view({ 94, 117 })
        elseif R[12] == 2 or R[12] == 3 then
          players[2]:center_view({ 15, 17 })
        else
          unseen("R[12]", R[12])
        end
      else
        unseen("R[13]", R[13])
      end
    elseif R[23] == 1 then
      if R[13] == 0 then
        if R[12] == 2 or R[12] == 3 then
          players[2]:center_view({ 21, 115 })
        elseif R[12] == 0 or R[12] == 1 then
          players[2]:center_view({ 104, 15 })
        else
          unseen("R[12]", R[12])
        end
      elseif R[13] == 1 then
        if R[12] == 2 or R[12] == 3 then
          players[2]:center_view({ 19, 13 })
        elseif R[12] == 0 or R[12] == 1 then
          players[2]:center_view({ 98, 113 })
        else
          unseen("R[12]", R[12])
        end
      else
        unseen("R[13]", R[13])
      end
    elseif R[23] == 2 then
      if R[13] == 0 then
        if R[12] == 0 or R[12] == 1 then
          players[2]:center_view({ 104, 19 })
        elseif R[12] == 2 or R[12] == 3 then
          players[2]:center_view({ 21, 119 })
        else
          unseen("R[12]", R[12])
        end
      elseif R[13] == 1 then
        if R[12] == 2 or R[12] == 3 then
          players[2]:center_view({ 19, 17 })
        elseif R[12] == 0 or R[12] == 1 then
          players[2]:center_view({ 98, 117 })
        else
          unseen("R[12]", R[12])
        end
      else
        unseen("R[13]", R[13])
      end
    elseif R[23] == 3 then
      if R[13] == 0 then
        if R[12] == 2 or R[12] == 3 then
          players[2]:center_view({ 13, 115 })
        elseif R[12] == 0 or R[12] == 1 then
          players[2]:center_view({ 96, 15 })
        else
          unseen("R[12]", R[12])
        end
      elseif R[13] == 1 then
        if R[12] == 0 or R[12] == 1 then
          players[2]:center_view({ 90, 113 })
        elseif R[12] == 2 or R[12] == 3 then
          players[2]:center_view({ 11, 13 })
        else
          unseen("R[12]", R[12])
        end
      else
        unseen("R[13]", R[13])
      end
    elseif R[23] == 4 then
      if R[13] == 0 then
        if R[12] == 0 or R[12] == 1 then
          players[2]:center_view({ 100, 18 })
        elseif R[12] == 2 or R[12] == 3 then
          players[2]:center_view({ 17, 118 })
        else
          unseen("R[12]", R[12])
        end
      elseif R[13] == 1 then
        if R[12] == 0 or R[12] == 1 then
          players[2]:center_view({ 94, 116 })
        elseif R[12] == 2 or R[12] == 3 then
          players[2]:center_view({ 15, 16 })
        else
          unseen("R[12]", R[12])
        end
      else
        unseen("R[13]", R[13])
      end
    elseif R[23] == 5 then
      if R[13] == 0 then
        if R[12] == 0 or R[12] == 1 then
          players[2]:center_view({ 99, 16 })
        elseif R[12] == 2 or R[12] == 3 then
          players[2]:center_view({ 16, 116 })
        else
          unseen("R[12]", R[12])
        end
      elseif R[13] == 1 then
        if R[12] == 0 or R[12] == 1 then
          players[2]:center_view({ 93, 114 })
        elseif R[12] == 2 or R[12] == 3 then
          players[2]:center_view({ 14, 14 })
        else
          unseen("R[12]", R[12])
        end
      else
        unseen("R[13]", R[13])
      end
    elseif R[23] == 6 then
      if R[13] == 0 then
        if R[12] == 0 or R[12] == 1 then
          players[2]:center_view({ 96, 13 })
        elseif R[12] == 2 or R[12] == 3 then
          players[2]:center_view({ 13, 113 })
        else
          unseen("R[12]", R[12])
        end
      elseif R[13] == 1 then
        if R[12] == 2 or R[12] == 3 then
          players[2]:center_view({ 11, 11 })
        elseif R[12] == 0 or R[12] == 1 then
          players[2]:center_view({ 90, 111 })
        else
          unseen("R[12]", R[12])
        end
      else
        unseen("R[13]", R[13])
      end
    elseif R[23] == 7 then
      if R[13] == 0 then
        if R[12] == 0 or R[12] == 1 then
          players[2]:center_view({ 102, 16 })
        elseif R[12] == 2 or R[12] == 3 then
          players[2]:center_view({ 19, 116 })
        else
          unseen("R[12]", R[12])
        end
      elseif R[13] == 1 then
        if R[12] == 0 or R[12] == 1 then
          players[2]:center_view({ 96, 114 })
        elseif R[12] == 2 or R[12] == 3 then
          players[2]:center_view({ 17, 14 })
        else
          unseen("R[12]", R[12])
        end
      else
        unseen("R[13]", R[13])
      end
    else
      unseen("R[23]", R[23])
    end
    if R[23] == 1 or R[23] == 2 or R[23] == 3 or R[23] == 4 then
      if R[13] == 0 then
        if R[23] == 1 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 21, 122 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 104, 22 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[23] == 2 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 97, 22 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 14, 122 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[23] == 3 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 18, 122 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 101, 22 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[23] == 4 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 97, 22 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 14, 122 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[23]", R[23])
        end
      elseif R[13] == 1 then
        if R[23] == 1 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 19, 20 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 98, 120 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[23] == 2 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 12, 20 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 91, 120 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[23] == 3 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 95, 120 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 16, 20 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[23] == 4 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 12, 20 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 91, 120 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[23]", R[23])
        end
      else
        unseen("R[13]", R[13])
      end
      if R[23] == 1 or R[23] == 2 then
        if R[23] == 1 then
          if R[13] == 0 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 12, 113 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 95, 13 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 10, 11 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 89, 111 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[23] == 2 then
          if R[13] == 0 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 96, 13 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 13, 113 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 11, 11 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 90, 111 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        else
          unseen("R[23]", R[23])
        end
        if R[23] == 1 then
          if R[13] == 0 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 21, 118 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 104, 18 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 19, 16 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 98, 116 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[23] == 2 then
          if R[13] == 0 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 104, 22 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 21, 122 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 19, 20 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 98, 120 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        else
          unseen("R[23]", R[23])
        end
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
        if R[23] == 1 then
          if R[13] == 0 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 16, 123 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 99, 23 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 14, 21 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 93, 121 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[23] == 2 then
          if R[13] == 0 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 100, 19 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 17, 119 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 15, 17 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 94, 117 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        else
          unseen("R[23]", R[23])
        end
        if R[23] == 1 then
          if R[13] == 0 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 16, 119 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 99, 19 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 14, 17 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 93, 117 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[23] == 2 then
          if R[13] == 0 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 104, 16 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 21, 116 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 19, 14 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 98, 114 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        else
          unseen("R[23]", R[23])
        end
        if R[23] == 1 then
          if R[13] == 0 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 22, 124 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 105, 24 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 20, 22 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 99, 122 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[23] == 2 then
          if R[13] == 0 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 103, 24 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 20, 124 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 18, 22 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 97, 122 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        else
          unseen("R[23]", R[23])
        end
        U[#U]:set_lights(true)
        if R[23] == 1 then
          if R[13] == 0 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 23, 123 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 106, 23 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 21, 21 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 100, 121 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[23] == 2 then
          if R[13] == 0 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 105, 24 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 22, 124 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 20, 22 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 99, 122 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        else
          unseen("R[23]", R[23])
        end
      elseif R[23] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 96, [1] = 96, [2] = 13, [3] = 13 }, [1] = { [0] = 90, [1] = 90, [2] = 11, [3] = 11 } })[R[13]][R[12]], ({ [0] = { [0] = 23, [1] = 23, [2] = 123, [3] = 123 }, [1] = { [0] = 121, [1] = 121, [2] = 21, [3] = 21 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 103, [1] = 103, [2] = 20, [3] = 20 }, [1] = { [0] = 97, [1] = 97, [2] = 18, [3] = 18 } })[R[13]][R[12]], ({ [0] = { [0] = 19, [1] = 19, [2] = 119, [3] = 119 }, [1] = { [0] = 117, [1] = 117, [2] = 17, [3] = 17 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 97, [1] = 97, [2] = 14, [3] = 14 }, [1] = { [0] = 91, [1] = 91, [2] = 12, [3] = 12 } })[R[13]][R[12]], ({ [0] = { [0] = 18, [1] = 18, [2] = 118, [3] = 118 }, [1] = { [0] = 116, [1] = 116, [2] = 16, [3] = 16 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 105, [1] = 105, [2] = 22, [3] = 22 }, [1] = { [0] = 99, [1] = 99, [2] = 20, [3] = 20 } })[R[13]][R[12]], ({ [0] = { [0] = 13, [1] = 13, [2] = 113, [3] = 113 }, [1] = { [0] = 111, [1] = 111, [2] = 11, [3] = 11 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 102, [1] = 102, [2] = 19, [3] = 19 }, [1] = { [0] = 96, [1] = 96, [2] = 17, [3] = 17 } })[R[13]][R[12]], ({ [0] = { [0] = 24, [1] = 24, [2] = 124, [3] = 124 }, [1] = { [0] = 122, [1] = 122, [2] = 22, [3] = 22 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 103, [1] = 103, [2] = 20, [3] = 20 }, [1] = { [0] = 97, [1] = 97, [2] = 18, [3] = 18 } })[R[13]][R[12]], ({ [0] = { [0] = 23, [1] = 23, [2] = 123, [3] = 123 }, [1] = { [0] = 121, [1] = 121, [2] = 21, [3] = 21 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 97, [1] = 97, [2] = 14, [3] = 14 }, [1] = { [0] = 91, [1] = 91, [2] = 12, [3] = 12 } })[R[13]][R[12]], ({ [0] = { [0] = 14, [1] = 14, [2] = 114, [3] = 114 }, [1] = { [0] = 112, [1] = 112, [2] = 12, [3] = 12 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 101, [1] = 101, [2] = 18, [3] = 18 }, [1] = { [0] = 95, [1] = 95, [2] = 16, [3] = 16 } })[R[13]][R[12]], ({ [0] = { [0] = 15, [1] = 15, [2] = 115, [3] = 115 }, [1] = { [0] = 113, [1] = 113, [2] = 13, [3] = 13 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 96, [1] = 96, [2] = 13, [3] = 13 }, [1] = { [0] = 90, [1] = 90, [2] = 11, [3] = 11 } })[R[13]][R[12]], ({ [0] = { [0] = 18, [1] = 18, [2] = 118, [3] = 118 }, [1] = { [0] = 116, [1] = 116, [2] = 16, [3] = 16 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 105, [1] = 105, [2] = 22, [3] = 22 }, [1] = { [0] = 99, [1] = 99, [2] = 20, [3] = 20 } })[R[13]][R[12]], ({ [0] = { [0] = 23, [1] = 23, [2] = 123, [3] = 123 }, [1] = { [0] = 121, [1] = 121, [2] = 21, [3] = 21 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 99, [1] = 99, [2] = 16, [3] = 16 }, [1] = { [0] = 93, [1] = 93, [2] = 14, [3] = 14 } })[R[13]][R[12]], ({ [0] = { [0] = 12, [1] = 12, [2] = 112, [3] = 112 }, [1] = { [0] = 110, [1] = 110, [2] = 10, [3] = 10 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = { [0] = 100, [1] = 100, [2] = 17, [3] = 17 }, [1] = { [0] = 94, [1] = 94, [2] = 15, [3] = 15 } })[R[13]][R[12]], ({ [0] = { [0] = 13, [1] = 13, [2] = 113, [3] = 113 }, [1] = { [0] = 111, [1] = 111, [2] = 11, [3] = 11 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[23]", R[23])
      end
      U[#U]:set_lights(true)
      if R[23] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 103, [1] = 103, [2] = 20, [3] = 20 }, [1] = { [0] = 97, [1] = 97, [2] = 18, [3] = 18 } })[R[13]][R[12]], ({ [0] = { [0] = 24, [1] = 24, [2] = 124, [3] = 124 }, [1] = { [0] = 122, [1] = 122, [2] = 22, [3] = 22 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 101, [1] = 101, [2] = 18, [3] = 18 }, [1] = { [0] = 95, [1] = 95, [2] = 16, [3] = 16 } })[R[13]][R[12]], ({ [0] = { [0] = 23, [1] = 23, [2] = 123, [3] = 123 }, [1] = { [0] = 121, [1] = 121, [2] = 21, [3] = 21 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 104, [1] = 104, [2] = 21, [3] = 21 }, [1] = { [0] = 98, [1] = 98, [2] = 19, [3] = 19 } })[R[13]][R[12]], ({ [0] = { [0] = 24, [1] = 24, [2] = 124, [3] = 124 }, [1] = { [0] = 122, [1] = 122, [2] = 22, [3] = 22 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 94, [1] = 94, [2] = 11, [3] = 11 }, [1] = { [0] = 88, [1] = 88, [2] = 9, [3] = 9 } })[R[13]][R[12]], ({ [0] = { [0] = 20, [1] = 20, [2] = 120, [3] = 120 }, [1] = { [0] = 118, [1] = 118, [2] = 18, [3] = 18 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = { [0] = 100, [1] = 100, [2] = 17, [3] = 17 }, [1] = { [0] = 94, [1] = 94, [2] = 15, [3] = 15 } })[R[13]][R[12]], ({ [0] = { [0] = 13, [1] = 13, [2] = 113, [3] = 113 }, [1] = { [0] = 111, [1] = 111, [2] = 11, [3] = 11 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[23]", R[23])
      end
      U[#U]:set_lights(true)
      if R[23] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 106, [1] = 106, [2] = 23, [3] = 23 }, [1] = { [0] = 100, [1] = 100, [2] = 21, [3] = 21 } })[R[13]][R[12]], ({ [0] = { [0] = 20, [1] = 20, [2] = 120, [3] = 120 }, [1] = { [0] = 118, [1] = 118, [2] = 18, [3] = 18 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 98, [1] = 98, [2] = 15, [3] = 15 }, [1] = { [0] = 92, [1] = 92, [2] = 13, [3] = 13 } })[R[13]][R[12]], ({ [0] = { [0] = 24, [1] = 24, [2] = 124, [3] = 124 }, [1] = { [0] = 122, [1] = 122, [2] = 22, [3] = 22 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 98, [1] = 98, [2] = 15, [3] = 15 }, [1] = { [0] = 92, [1] = 92, [2] = 13, [3] = 13 } })[R[13]][R[12]], ({ [0] = { [0] = 20, [1] = 20, [2] = 120, [3] = 120 }, [1] = { [0] = 118, [1] = 118, [2] = 18, [3] = 18 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 98, [1] = 98, [2] = 15, [3] = 15 }, [1] = { [0] = 92, [1] = 92, [2] = 13, [3] = 13 } })[R[13]][R[12]], ({ [0] = { [0] = 16, [1] = 16, [2] = 116, [3] = 116 }, [1] = { [0] = 114, [1] = 114, [2] = 14, [3] = 14 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 94, [1] = 94, [2] = 11, [3] = 11 }, [1] = { [0] = 88, [1] = 88, [2] = 9, [3] = 9 } })[R[13]][R[12]], ({ [0] = { [0] = 20, [1] = 20, [2] = 120, [3] = 120 }, [1] = { [0] = 118, [1] = 118, [2] = 18, [3] = 18 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[23]", R[23])
      end
      U[#U]:set_lights(true)
      if R[23] == 1 then
        if R[13] == 0 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 23, 120 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 106, 20 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 21, 18 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 100, 118 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 2 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 98, 24 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 15, 124 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 13, 22 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 92, 122 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 3 then
        if R[13] == 0 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 15, 120 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 98, 20 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 92, 118 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 13, 18 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 4 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 98, 16 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 15, 116 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 92, 114 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 13, 14 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      else
        unseen("R[23]", R[23])
      end
    elseif R[23] == 5 or R[23] == 6 or R[23] == 7 then
      if R[13] == 0 then
        if R[23] == 5 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 96, 23 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 13, 123 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[23] == 6 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 105, 23 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 22, 123 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[23] == 7 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 96, 23 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 13, 123 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[23]", R[23])
        end
      elseif R[13] == 1 then
        if R[23] == 5 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 90, 121 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 11, 21 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[23] == 6 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 20, 21 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 99, 121 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[23] == 7 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 90, 121 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 11, 21 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[23]", R[23])
        end
      else
        unseen("R[13]", R[13])
      end
      if R[23] == 5 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 104, 17 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 21, 117 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 98, 115 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 19, 15 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 6 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 96, 22 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 13, 122 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 11, 20 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 90, 120 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 7 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 104, 22 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 21, 122 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 98, 120 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 19, 20 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      else
        unseen("R[23]", R[23])
      end
      if R[23] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 96, [1] = 96, [2] = 13, [3] = 13 }, [1] = { [0] = 90, [1] = 90, [2] = 11, [3] = 11 } })[R[13]][R[12]], ({ [0] = { [0] = 19, [1] = 19, [2] = 119, [3] = 119 }, [1] = { [0] = 117, [1] = 117, [2] = 17, [3] = 17 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 96, [1] = 96, [2] = 13, [3] = 13 }, [1] = { [0] = 90, [1] = 90, [2] = 11, [3] = 11 } })[R[13]][R[12]], ({ [0] = { [0] = 16, [1] = 16, [2] = 116, [3] = 116 }, [1] = { [0] = 114, [1] = 114, [2] = 14, [3] = 14 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 101, [1] = 101, [2] = 18, [3] = 18 }, [1] = { [0] = 95, [1] = 95, [2] = 16, [3] = 16 } })[R[13]][R[12]], ({ [0] = { [0] = 14, [1] = 14, [2] = 114, [3] = 114 }, [1] = { [0] = 112, [1] = 112, [2] = 12, [3] = 12 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[23] == 5 or R[23] == 7 then
        if R[23] == 5 then
          if R[13] == 0 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 104, 13 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 21, 113 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 98, 111 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 19, 11 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[23] == 7 then
          if R[13] == 0 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 97, 13 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 14, 113 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 91, 111 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 12, 11 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        else
          unseen("R[23]", R[23])
        end
        if R[23] == 5 then
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
        elseif R[23] == 7 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 101, [1] = 101, [2] = 18, [3] = 18 }, [1] = { [0] = 95, [1] = 95, [2] = 16, [3] = 16 } })[R[13]][R[12]], ({ [0] = { [0] = 13, [1] = 13, [2] = 113, [3] = 113 }, [1] = { [0] = 111, [1] = 111, [2] = 11, [3] = 11 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 101, [1] = 101, [2] = 18, [3] = 18 }, [1] = { [0] = 95, [1] = 95, [2] = 16, [3] = 16 } })[R[13]][R[12]], ({ [0] = { [0] = 13, [1] = 13, [2] = 113, [3] = 113 }, [1] = { [0] = 111, [1] = 111, [2] = 11, [3] = 11 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 101, [1] = 101, [2] = 18, [3] = 18 }, [1] = { [0] = 95, [1] = 95, [2] = 16, [3] = 16 } })[R[13]][R[12]], ({ [0] = { [0] = 13, [1] = 13, [2] = 113, [3] = 113 }, [1] = { [0] = 111, [1] = 111, [2] = 11, [3] = 11 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[23]", R[23])
        end
        if R[23] == 5 then
          if R[13] == 0 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 103, 21 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 20, 121 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 97, 119 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 18, 19 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[23] == 7 then
          if R[13] == 0 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 102, 19 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 19, 119 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 96, 117 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 17, 17 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        else
          unseen("R[23]", R[23])
        end
        if R[23] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 99, [1] = 99, [2] = 16, [3] = 16 }, [1] = { [0] = 93, [1] = 93, [2] = 14, [3] = 14 } })[R[13]][R[12]], ({ [0] = { [0] = 13, [1] = 13, [2] = 113, [3] = 113 }, [1] = { [0] = 111, [1] = 111, [2] = 11, [3] = 11 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[23] == 7 then
        else
          unseen("R[23]", R[23])
        end
        if R[23] == 5 then
          if R[13] == 0 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 99, 19 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 16, 119 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 93, 117 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 14, 17 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[23] == 7 then
          if R[13] == 0 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 99, 16 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 16, 116 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 93, 114 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 14, 14 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        else
          unseen("R[23]", R[23])
        end
        U[#U]:set_lights(true)
        if R[23] == 5 then
          if R[13] == 0 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 100, 18 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 17, 118 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 94, 116 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 15, 16 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[23] == 7 then
          if R[13] == 0 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 100, 17 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 17, 117 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 94, 115 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 15, 15 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        else
          unseen("R[23]", R[23])
        end
        U[#U]:set_lights(true)
        if R[23] == 5 then
          if R[13] == 0 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 100, 20 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 17, 120 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 94, 118 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 15, 18 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[23] == 7 then
          if R[13] == 0 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 105, 17 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 22, 117 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          elseif R[13] == 1 then
            if R[12] == 0 or R[12] == 1 then
              U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 99, 115 }, direction = "East", lights = false, exact = true }[1]
            elseif R[12] == 2 or R[12] == 3 then
              U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 20, 15 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[13]", R[13])
          end
        else
          unseen("R[23]", R[23])
        end
        U[#U]:set_lights(true)
      else
        unseen("R[23]", R[23])
      end
      if R[23] == 5 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 106, 15 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 23, 115 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 100, 113 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 21, 13 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 6 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 103, 16 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 20, 116 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 18, 14 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 97, 114 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 7 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 99, 14 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 16, 114 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 93, 112 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 14, 12 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      else
        unseen("R[23]", R[23])
      end
      if R[23] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 106, [1] = 106, [2] = 23, [3] = 23 }, [1] = { [0] = 100, [1] = 100, [2] = 21, [3] = 21 } })[R[13]][R[12]], ({ [0] = { [0] = 15, [1] = 15, [2] = 115, [3] = 115 }, [1] = { [0] = 113, [1] = 113, [2] = 13, [3] = 13 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[23] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 103, [1] = 103, [2] = 20, [3] = 20 }, [1] = { [0] = 97, [1] = 97, [2] = 18, [3] = 18 } })[R[13]][R[12]], ({ [0] = { [0] = 16, [1] = 16, [2] = 116, [3] = 116 }, [1] = { [0] = 114, [1] = 114, [2] = 14, [3] = 14 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 103, [1] = 103, [2] = 20, [3] = 20 }, [1] = { [0] = 97, [1] = 97, [2] = 18, [3] = 18 } })[R[13]][R[12]], ({ [0] = { [0] = 16, [1] = 16, [2] = 116, [3] = 116 }, [1] = { [0] = 114, [1] = 114, [2] = 14, [3] = 14 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 98, [1] = 98, [2] = 15, [3] = 15 }, [1] = { [0] = 92, [1] = 92, [2] = 13, [3] = 13 } })[R[13]][R[12]], ({ [0] = { [0] = 24, [1] = 24, [2] = 124, [3] = 124 }, [1] = { [0] = 122, [1] = 122, [2] = 22, [3] = 22 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 99, [1] = 99, [2] = 16, [3] = 16 }, [1] = { [0] = 93, [1] = 93, [2] = 14, [3] = 14 } })[R[13]][R[12]], ({ [0] = { [0] = 23, [1] = 23, [2] = 123, [3] = 123 }, [1] = { [0] = 121, [1] = 121, [2] = 21, [3] = 21 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[23] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 99, [1] = 99, [2] = 16, [3] = 16 }, [1] = { [0] = 93, [1] = 93, [2] = 14, [3] = 14 } })[R[13]][R[12]], ({ [0] = { [0] = 14, [1] = 14, [2] = 114, [3] = 114 }, [1] = { [0] = 112, [1] = 112, [2] = 12, [3] = 12 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[23]", R[23])
      end
    elseif R[23] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 97, [1] = 97, [2] = 14, [3] = 14 }, [1] = { [0] = 91, [1] = 91, [2] = 12, [3] = 12 } })[R[13]][R[12]], ({ [0] = { [0] = 22, [1] = 22, [2] = 122, [3] = 122 }, [1] = { [0] = 120, [1] = 120, [2] = 20, [3] = 20 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 102, [1] = 102, [2] = 19, [3] = 19 }, [1] = { [0] = 96, [1] = 96, [2] = 17, [3] = 17 } })[R[13]][R[12]], ({ [0] = { [0] = 22, [1] = 22, [2] = 122, [3] = 122 }, [1] = { [0] = 120, [1] = 120, [2] = 20, [3] = 20 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 96, [1] = 96, [2] = 13, [3] = 13 }, [1] = { [0] = 90, [1] = 90, [2] = 11, [3] = 11 } })[R[13]][R[12]], ({ [0] = { [0] = 19, [1] = 19, [2] = 119, [3] = 119 }, [1] = { [0] = 117, [1] = 117, [2] = 17, [3] = 17 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 104, [1] = 104, [2] = 21, [3] = 21 }, [1] = { [0] = 98, [1] = 98, [2] = 19, [3] = 19 } })[R[13]][R[12]], ({ [0] = { [0] = 19, [1] = 19, [2] = 119, [3] = 119 }, [1] = { [0] = 117, [1] = 117, [2] = 17, [3] = 17 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 105, [1] = 105, [2] = 22, [3] = 22 }, [1] = { [0] = 99, [1] = 99, [2] = 20, [3] = 20 } })[R[13]][R[12]], ({ [0] = { [0] = 13, [1] = 13, [2] = 113, [3] = 113 }, [1] = { [0] = 111, [1] = 111, [2] = 11, [3] = 11 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 103, [1] = 103, [2] = 20, [3] = 20 }, [1] = { [0] = 97, [1] = 97, [2] = 18, [3] = 18 } })[R[13]][R[12]], ({ [0] = { [0] = 24, [1] = 24, [2] = 124, [3] = 124 }, [1] = { [0] = 122, [1] = 122, [2] = 22, [3] = 22 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 104, [1] = 104, [2] = 21, [3] = 21 }, [1] = { [0] = 98, [1] = 98, [2] = 19, [3] = 19 } })[R[13]][R[12]], ({ [0] = { [0] = 23, [1] = 23, [2] = 123, [3] = 123 }, [1] = { [0] = 121, [1] = 121, [2] = 21, [3] = 21 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 106, [1] = 106, [2] = 23, [3] = 23 }, [1] = { [0] = 100, [1] = 100, [2] = 21, [3] = 21 } })[R[13]][R[12]], ({ [0] = { [0] = 22, [1] = 22, [2] = 122, [3] = 122 }, [1] = { [0] = 120, [1] = 120, [2] = 20, [3] = 20 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 99, [1] = 99, [2] = 16, [3] = 16 }, [1] = { [0] = 93, [1] = 93, [2] = 14, [3] = 14 } })[R[13]][R[12]], ({ [0] = { [0] = 24, [1] = 24, [2] = 124, [3] = 124 }, [1] = { [0] = 122, [1] = 122, [2] = 22, [3] = 22 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 99, [1] = 99, [2] = 16, [3] = 16 }, [1] = { [0] = 93, [1] = 93, [2] = 14, [3] = 14 } })[R[13]][R[12]], ({ [0] = { [0] = 24, [1] = 24, [2] = 124, [3] = 124 }, [1] = { [0] = 122, [1] = 122, [2] = 22, [3] = 22 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[23]", R[23])
    end
    U[#U]:set_lights(true)
    if R[23] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 99, [1] = 99, [2] = 16, [3] = 16 }, [1] = { [0] = 93, [1] = 93, [2] = 14, [3] = 14 } })[R[13]][R[12]], ({ [0] = { [0] = 24, [1] = 24, [2] = 124, [3] = 124 }, [1] = { [0] = 122, [1] = 122, [2] = 22, [3] = 22 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 95, [1] = 95, [2] = 12, [3] = 12 }, [1] = { [0] = 89, [1] = 89, [2] = 10, [3] = 10 } })[R[13]][R[12]], ({ [0] = { [0] = 15, [1] = 15, [2] = 115, [3] = 115 }, [1] = { [0] = 113, [1] = 113, [2] = 13, [3] = 13 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 95, [1] = 95, [2] = 12, [3] = 12 }, [1] = { [0] = 89, [1] = 89, [2] = 10, [3] = 10 } })[R[13]][R[12]], ({ [0] = { [0] = 15, [1] = 15, [2] = 115, [3] = 115 }, [1] = { [0] = 113, [1] = 113, [2] = 13, [3] = 13 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 106, [1] = 106, [2] = 23, [3] = 23 }, [1] = { [0] = 100, [1] = 100, [2] = 21, [3] = 21 } })[R[13]][R[12]], ({ [0] = { [0] = 20, [1] = 20, [2] = 120, [3] = 120 }, [1] = { [0] = 118, [1] = 118, [2] = 18, [3] = 18 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 96, [1] = 96, [2] = 13, [3] = 13 }, [1] = { [0] = 90, [1] = 90, [2] = 11, [3] = 11 } })[R[13]][R[12]], ({ [0] = { [0] = 19, [1] = 19, [2] = 119, [3] = 119 }, [1] = { [0] = 117, [1] = 117, [2] = 17, [3] = 17 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 96, [1] = 96, [2] = 13, [3] = 13 }, [1] = { [0] = 90, [1] = 90, [2] = 11, [3] = 11 } })[R[13]][R[12]], ({ [0] = { [0] = 19, [1] = 19, [2] = 119, [3] = 119 }, [1] = { [0] = 117, [1] = 117, [2] = 17, [3] = 17 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 98, [1] = 98, [2] = 15, [3] = 15 }, [1] = { [0] = 92, [1] = 92, [2] = 13, [3] = 13 } })[R[13]][R[12]], ({ [0] = { [0] = 24, [1] = 24, [2] = 124, [3] = 124 }, [1] = { [0] = 122, [1] = 122, [2] = 22, [3] = 22 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 100, [1] = 100, [2] = 17, [3] = 17 }, [1] = { [0] = 94, [1] = 94, [2] = 15, [3] = 15 } })[R[13]][R[12]], ({ [0] = { [0] = 15, [1] = 15, [2] = 115, [3] = 115 }, [1] = { [0] = 113, [1] = 113, [2] = 13, [3] = 13 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 100, [1] = 100, [2] = 17, [3] = 17 }, [1] = { [0] = 94, [1] = 94, [2] = 15, [3] = 15 } })[R[13]][R[12]], ({ [0] = { [0] = 15, [1] = 15, [2] = 115, [3] = 115 }, [1] = { [0] = 113, [1] = 113, [2] = 13, [3] = 13 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 98, [1] = 98, [2] = 15, [3] = 15 }, [1] = { [0] = 92, [1] = 92, [2] = 13, [3] = 13 } })[R[13]][R[12]], ({ [0] = { [0] = 20, [1] = 20, [2] = 120, [3] = 120 }, [1] = { [0] = 118, [1] = 118, [2] = 18, [3] = 18 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 99, [1] = 99, [2] = 16, [3] = 16 }, [1] = { [0] = 93, [1] = 93, [2] = 14, [3] = 14 } })[R[13]][R[12]], ({ [0] = { [0] = 16, [1] = 16, [2] = 116, [3] = 116 }, [1] = { [0] = 114, [1] = 114, [2] = 14, [3] = 14 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 99, [1] = 99, [2] = 16, [3] = 16 }, [1] = { [0] = 93, [1] = 93, [2] = 14, [3] = 14 } })[R[13]][R[12]], ({ [0] = { [0] = 16, [1] = 16, [2] = 116, [3] = 116 }, [1] = { [0] = 114, [1] = 114, [2] = 14, [3] = 14 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 98, [1] = 98, [2] = 15, [3] = 15 }, [1] = { [0] = 92, [1] = 92, [2] = 13, [3] = 13 } })[R[13]][R[12]], ({ [0] = { [0] = 16, [1] = 16, [2] = 116, [3] = 116 }, [1] = { [0] = 114, [1] = 114, [2] = 14, [3] = 14 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 95, [1] = 95, [2] = 12, [3] = 12 }, [1] = { [0] = 89, [1] = 89, [2] = 10, [3] = 10 } })[R[13]][R[12]], ({ [0] = { [0] = 24, [1] = 24, [2] = 124, [3] = 124 }, [1] = { [0] = 122, [1] = 122, [2] = 22, [3] = 22 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[23] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 106, [1] = 106, [2] = 23, [3] = 23 }, [1] = { [0] = 100, [1] = 100, [2] = 21, [3] = 21 } })[R[13]][R[12]], ({ [0] = { [0] = 15, [1] = 15, [2] = 115, [3] = 115 }, [1] = { [0] = 113, [1] = 113, [2] = 13, [3] = 13 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 106, [1] = 106, [2] = 23, [3] = 23 }, [1] = { [0] = 100, [1] = 100, [2] = 21, [3] = 21 } })[R[13]][R[12]], ({ [0] = { [0] = 21, [1] = 21, [2] = 121, [3] = 121 }, [1] = { [0] = 119, [1] = 119, [2] = 19, [3] = 19 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[23] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 103, [1] = 103, [2] = 20, [3] = 20 }, [1] = { [0] = 97, [1] = 97, [2] = 18, [3] = 18 } })[R[13]][R[12]], ({ [0] = { [0] = 16, [1] = 16, [2] = 116, [3] = 116 }, [1] = { [0] = 114, [1] = 114, [2] = 14, [3] = 14 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 98, [1] = 98, [2] = 15, [3] = 15 }, [1] = { [0] = 92, [1] = 92, [2] = 13, [3] = 13 } })[R[13]][R[12]], ({ [0] = { [0] = 24, [1] = 24, [2] = 124, [3] = 124 }, [1] = { [0] = 122, [1] = 122, [2] = 22, [3] = 22 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 99, [1] = 99, [2] = 16, [3] = 16 }, [1] = { [0] = 93, [1] = 93, [2] = 14, [3] = 14 } })[R[13]][R[12]], ({ [0] = { [0] = 23, [1] = 23, [2] = 123, [3] = 123 }, [1] = { [0] = 121, [1] = 121, [2] = 21, [3] = 21 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 101, [1] = 101, [2] = 18, [3] = 18 }, [1] = { [0] = 95, [1] = 95, [2] = 16, [3] = 16 } })[R[13]][R[12]], ({ [0] = { [0] = 24, [1] = 24, [2] = 124, [3] = 124 }, [1] = { [0] = 122, [1] = 122, [2] = 22, [3] = 22 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 99, [1] = 99, [2] = 16, [3] = 16 }, [1] = { [0] = 93, [1] = 93, [2] = 14, [3] = 14 } })[R[13]][R[12]], ({ [0] = { [0] = 17, [1] = 17, [2] = 117, [3] = 117 }, [1] = { [0] = 115, [1] = 115, [2] = 15, [3] = 15 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 101, [1] = 101, [2] = 18, [3] = 18 }, [1] = { [0] = 95, [1] = 95, [2] = 16, [3] = 16 } })[R[13]][R[12]], ({ [0] = { [0] = 24, [1] = 24, [2] = 124, [3] = 124 }, [1] = { [0] = 122, [1] = 122, [2] = 22, [3] = 22 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 99, [1] = 99, [2] = 16, [3] = 16 }, [1] = { [0] = 93, [1] = 93, [2] = 14, [3] = 14 } })[R[13]][R[12]], ({ [0] = { [0] = 17, [1] = 17, [2] = 117, [3] = 117 }, [1] = { [0] = 115, [1] = 115, [2] = 15, [3] = 15 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 99, [1] = 99, [2] = 16, [3] = 16 }, [1] = { [0] = 93, [1] = 93, [2] = 14, [3] = 14 } })[R[13]][R[12]], ({ [0] = { [0] = 14, [1] = 14, [2] = 114, [3] = 114 }, [1] = { [0] = 112, [1] = 112, [2] = 12, [3] = 12 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 106, [1] = 106, [2] = 23, [3] = 23 }, [1] = { [0] = 100, [1] = 100, [2] = 21, [3] = 21 } })[R[13]][R[12]], ({ [0] = { [0] = 21, [1] = 21, [2] = 121, [3] = 121 }, [1] = { [0] = 119, [1] = 119, [2] = 19, [3] = 19 } })[R[13]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[23]", R[23])
    end
    U[#U]:set_lights(true)
    if R[23] == 0 or R[23] == 1 or R[23] == 2 or R[23] == 3 or R[23] == 6 then
      if R[23] == 0 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 96, 16 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 13, 116 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 90, 114 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 11, 14 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 1 then
        if R[13] == 0 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 12, 118 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 95, 18 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 10, 16 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 89, 116 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 2 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 101, 14 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 18, 114 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 16, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 95, 112 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 3 then
        if R[13] == 0 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 17, 115 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 100, 15 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 94, 113 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 15, 13 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 6 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 100, 18 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 17, 118 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 15, 16 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 94, 116 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      else
        unseen("R[23]", R[23])
      end
    elseif R[23] == 4 or R[23] == 5 or R[23] == 7 then
      if R[23] == 4 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 98, 24 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 15, 124 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 92, 122 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 13, 22 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 5 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 105, 19 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 22, 119 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 99, 117 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 20, 17 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 7 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 105, 24 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 22, 124 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 99, 122 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 20, 22 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      else
        unseen("R[23]", R[23])
      end
    else
      unseen("R[23]", R[23])
    end
    U[#U]:set_lights(true)
    if R[23] == 0 or R[23] == 1 or R[23] == 2 or R[23] == 3 or R[23] == 6 then
      if R[23] == 0 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 97, 16 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 14, 116 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 91, 114 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 12, 14 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 1 then
        if R[13] == 0 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 14, 117 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 97, 17 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 12, 15 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 91, 115 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 2 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 100, 13 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 17, 113 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 15, 11 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 94, 111 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 3 then
        if R[13] == 0 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 16, 114 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 99, 14 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 93, 112 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 14, 12 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 6 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 101, 17 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 18, 117 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 16, 15 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 95, 115 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      else
        unseen("R[23]", R[23])
      end
    elseif R[23] == 4 or R[23] == 5 or R[23] == 7 then
      if R[23] == 4 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 99, 23 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 16, 123 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 93, 121 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 14, 21 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 5 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 106, 18 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 23, 118 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 100, 116 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 21, 16 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      elseif R[23] == 7 then
        if R[13] == 0 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 106, 24 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 23, 124 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        elseif R[13] == 1 then
          if R[12] == 0 or R[12] == 1 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 100, 122 }, direction = "East", lights = false, exact = true }[1]
          elseif R[12] == 2 or R[12] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 21, 22 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[13]", R[13])
        end
      else
        unseen("R[23]", R[23])
      end
    else
      unseen("R[23]", R[23])
    end
    U[#U]:set_lights(true)
    if R[23] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[24] = game.rand(3)
          if R[24] == 0 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 12 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 12 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 12 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 12 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 110 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 110 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 110 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 110 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 10 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 10 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 10 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 10 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[24] == 1 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 15 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 15 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 15 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 15 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 115 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 115 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 115 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 115 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 94, 113 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 94, 113 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 94, 113 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 94, 113 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 15, 13 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 15, 13 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 15, 13 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 15, 13 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[24] == 2 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 21 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 21 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 21 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 21 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 121 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 121 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 121 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 121 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 119 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 119 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 119 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 119 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 19 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 19 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 19 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 19 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          else
            unseen("R[24]", R[24])
          end
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = { [0] = 99, [1] = 99, [2] = 16, [3] = 16 }, [1] = { [0] = 93, [1] = 93, [2] = 14, [3] = 14 } })[R[13]][R[12]], ({ [0] = { [0] = 21, [1] = 21, [2] = 121, [3] = 121 }, [1] = { [0] = 119, [1] = 119, [2] = 19, [3] = 19 } })[R[13]][R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = { [0] = 99, [1] = 99, [2] = 16, [3] = 16 }, [1] = { [0] = 93, [1] = 93, [2] = 14, [3] = 14 } })[R[13]][R[12]], ({ [0] = { [0] = 21, [1] = 21, [2] = 121, [3] = 121 }, [1] = { [0] = 119, [1] = 119, [2] = 19, [3] = 19 } })[R[13]][R[12]] })
        for i = 1, game.initial_units() do
          R[25] = game.rand(3)
          if R[25] == 0 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 120 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 120 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 120 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 120 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 20 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 20 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 20 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 20 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[25] == 1 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 116 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 116 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 116 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 116 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 14, 14 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 14, 14 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 14, 14 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 14, 14 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[25] == 2 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 102, 12 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 102, 12 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 102, 12 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 102, 12 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 110 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 110 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 110 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 110 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 10 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 10 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 10 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 10 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          else
            unseen("R[25]", R[25])
          end
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = { [0] = 100, [1] = 100, [2] = 17, [3] = 17 }, [1] = { [0] = 94, [1] = 94, [2] = 15, [3] = 15 } })[R[13]][R[12]], ({ [0] = { [0] = 21, [1] = 21, [2] = 121, [3] = 121 }, [1] = { [0] = 119, [1] = 119, [2] = 19, [3] = 19 } })[R[13]][R[12]] })
        game.create_tube({ ({ [0] = { [0] = 100, [1] = 100, [2] = 17, [3] = 17 }, [1] = { [0] = 94, [1] = 94, [2] = 15, [3] = 15 } })[R[13]][R[12]], ({ [0] = { [0] = 22, [1] = 22, [2] = 122, [3] = 122 }, [1] = { [0] = 120, [1] = 120, [2] = 20, [3] = 20 } })[R[13]][R[12]] })
        game.create_tube({ ({ [0] = { [0] = 101, [1] = 101, [2] = 18, [3] = 18 }, [1] = { [0] = 95, [1] = 95, [2] = 16, [3] = 16 } })[R[13]][R[12]], ({ [0] = { [0] = 22, [1] = 22, [2] = 122, [3] = 122 }, [1] = { [0] = 120, [1] = 120, [2] = 20, [3] = 20 } })[R[13]][R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = { [0] = 100, [1] = 100, [2] = 17, [3] = 17 }, [1] = { [0] = 94, [1] = 94, [2] = 15, [3] = 15 } })[R[13]][R[12]], ({ [0] = { [0] = 21, [1] = 21, [2] = 121, [3] = 121 }, [1] = { [0] = 119, [1] = 119, [2] = 19, [3] = 19 } })[R[13]][R[12]] })
        game.create_tube({ ({ [0] = { [0] = 100, [1] = 100, [2] = 17, [3] = 17 }, [1] = { [0] = 94, [1] = 94, [2] = 15, [3] = 15 } })[R[13]][R[12]], ({ [0] = { [0] = 22, [1] = 22, [2] = 122, [3] = 122 }, [1] = { [0] = 120, [1] = 120, [2] = 20, [3] = 20 } })[R[13]][R[12]] })
        game.create_tube({ ({ [0] = { [0] = 101, [1] = 101, [2] = 18, [3] = 18 }, [1] = { [0] = 95, [1] = 95, [2] = 16, [3] = 16 } })[R[13]][R[12]], ({ [0] = { [0] = 22, [1] = 22, [2] = 122, [3] = 122 }, [1] = { [0] = 120, [1] = 120, [2] = 20, [3] = 20 } })[R[13]][R[12]] })
        for i = 1, game.initial_units() do
          R[26] = game.rand(3)
          if R[26] == 0 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 12 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 12 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 12 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 12 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 98, 110 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 98, 110 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 98, 110 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 98, 110 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 10 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 10 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 10 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 10 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[26] == 1 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 17 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 17 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 17 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 17 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 13, 117 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 13, 117 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 13, 117 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 13, 117 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 90, 115 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 90, 115 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 90, 115 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 90, 115 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 11, 15 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 11, 15 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 11, 15 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 11, 15 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[26] == 2 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 94, 120 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 94, 120 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 94, 120 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 94, 120 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 15, 20 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 15, 20 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 15, 20 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 15, 20 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          else
            unseen("R[26]", R[26])
          end
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = { [0] = 97, [1] = 97, [2] = 14, [3] = 14 }, [1] = { [0] = 91, [1] = 91, [2] = 12, [3] = 12 } })[R[13]][R[12]], ({ [0] = { [0] = 21, [1] = 21, [2] = 121, [3] = 121 }, [1] = { [0] = 119, [1] = 119, [2] = 19, [3] = 19 } })[R[13]][R[12]] })
        game.create_tube({ ({ [0] = { [0] = 100, [1] = 100, [2] = 17, [3] = 17 }, [1] = { [0] = 94, [1] = 94, [2] = 15, [3] = 15 } })[R[13]][R[12]], ({ [0] = { [0] = 18, [1] = 18, [2] = 118, [3] = 118 }, [1] = { [0] = 116, [1] = 116, [2] = 16, [3] = 16 } })[R[13]][R[12]] })
        game.create_tube({ ({ [0] = { [0] = 101, [1] = 101, [2] = 18, [3] = 18 }, [1] = { [0] = 95, [1] = 95, [2] = 16, [3] = 16 } })[R[13]][R[12]], ({ [0] = { [0] = 18, [1] = 18, [2] = 118, [3] = 118 }, [1] = { [0] = 116, [1] = 116, [2] = 16, [3] = 16 } })[R[13]][R[12]] })
        game.create_tube({ ({ [0] = { [0] = 103, [1] = 103, [2] = 20, [3] = 20 }, [1] = { [0] = 97, [1] = 97, [2] = 18, [3] = 18 } })[R[13]][R[12]], ({ [0] = { [0] = 21, [1] = 21, [2] = 121, [3] = 121 }, [1] = { [0] = 119, [1] = 119, [2] = 19, [3] = 19 } })[R[13]][R[12]] })
        game.create_tube({ ({ [0] = { [0] = 103, [1] = 103, [2] = 20, [3] = 20 }, [1] = { [0] = 97, [1] = 97, [2] = 18, [3] = 18 } })[R[13]][R[12]], ({ [0] = { [0] = 22, [1] = 22, [2] = 122, [3] = 122 }, [1] = { [0] = 120, [1] = 120, [2] = 20, [3] = 20 } })[R[13]][R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = { [0] = 97, [1] = 97, [2] = 14, [3] = 14 }, [1] = { [0] = 91, [1] = 91, [2] = 12, [3] = 12 } })[R[13]][R[12]], ({ [0] = { [0] = 21, [1] = 21, [2] = 121, [3] = 121 }, [1] = { [0] = 119, [1] = 119, [2] = 19, [3] = 19 } })[R[13]][R[12]] })
        game.create_tube({ ({ [0] = { [0] = 100, [1] = 100, [2] = 17, [3] = 17 }, [1] = { [0] = 94, [1] = 94, [2] = 15, [3] = 15 } })[R[13]][R[12]], ({ [0] = { [0] = 18, [1] = 18, [2] = 118, [3] = 118 }, [1] = { [0] = 116, [1] = 116, [2] = 16, [3] = 16 } })[R[13]][R[12]] })
        game.create_tube({ ({ [0] = { [0] = 101, [1] = 101, [2] = 18, [3] = 18 }, [1] = { [0] = 95, [1] = 95, [2] = 16, [3] = 16 } })[R[13]][R[12]], ({ [0] = { [0] = 18, [1] = 18, [2] = 118, [3] = 118 }, [1] = { [0] = 116, [1] = 116, [2] = 16, [3] = 16 } })[R[13]][R[12]] })
        game.create_tube({ ({ [0] = { [0] = 103, [1] = 103, [2] = 20, [3] = 20 }, [1] = { [0] = 97, [1] = 97, [2] = 18, [3] = 18 } })[R[13]][R[12]], ({ [0] = { [0] = 21, [1] = 21, [2] = 121, [3] = 121 }, [1] = { [0] = 119, [1] = 119, [2] = 19, [3] = 19 } })[R[13]][R[12]] })
        game.create_tube({ ({ [0] = { [0] = 103, [1] = 103, [2] = 20, [3] = 20 }, [1] = { [0] = 97, [1] = 97, [2] = 18, [3] = 18 } })[R[13]][R[12]], ({ [0] = { [0] = 22, [1] = 22, [2] = 122, [3] = 122 }, [1] = { [0] = 120, [1] = 120, [2] = 20, [3] = 20 } })[R[13]][R[12]] })
        for i = 1, game.initial_units() do
          R[27] = game.rand(3)
          if R[27] == 0 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 23 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 23 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 23 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 23 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 123 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 123 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 123 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 123 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 121 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 121 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 121 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 121 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 21 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 21 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 21 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 21 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[27] == 1 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 17 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 17 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 17 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 17 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 117 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 117 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 117 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 117 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 115 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 115 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 115 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 115 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 15 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 15 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 15 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 15 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[27] == 2 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 12 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 12 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 12 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 12 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 14, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 14, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 14, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 14, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 110 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 110 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 110 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 110 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 10 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 10 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 10 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 10 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          else
            unseen("R[27]", R[27])
          end
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = { [0] = 96, [1] = 96, [2] = 13, [3] = 13 }, [1] = { [0] = 90, [1] = 90, [2] = 11, [3] = 11 } })[R[13]][R[12]], ({ [0] = { [0] = 20, [1] = 20, [2] = 120, [3] = 120 }, [1] = { [0] = 118, [1] = 118, [2] = 18, [3] = 18 } })[R[13]][R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = { [0] = 96, [1] = 96, [2] = 13, [3] = 13 }, [1] = { [0] = 90, [1] = 90, [2] = 11, [3] = 11 } })[R[13]][R[12]], ({ [0] = { [0] = 20, [1] = 20, [2] = 120, [3] = 120 }, [1] = { [0] = 118, [1] = 118, [2] = 18, [3] = 18 } })[R[13]][R[12]] })
        for i = 1, game.initial_units() do
          R[28] = game.rand(3)
          if R[28] == 0 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 12 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 12 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 12 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 12 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 98, 110 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 98, 110 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 98, 110 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 98, 110 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 10 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 10 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 10 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 10 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[28] == 1 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 18 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 18 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 18 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 18 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 118 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 118 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 118 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 118 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 116 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 116 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 116 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 116 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[28] == 2 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 120 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 120 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 120 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 120 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 20 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 20 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 20 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 20 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          else
            unseen("R[28]", R[28])
          end
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          if R[29] == 0 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 23 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 23 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 23 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 23 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 123 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 123 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 123 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 123 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 121 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 121 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 121 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 121 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 21 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 21 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 21 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 21 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[29] == 1 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 18 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 18 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 18 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 18 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 118 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 118 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 118 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 118 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 116 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 116 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 116 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 116 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[29] == 2 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 13 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 13 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 13 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 13 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 113 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 113 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 113 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 113 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 111 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 111 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 111 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 111 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 11 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 11 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 11 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 11 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          else
            unseen("R[29]", R[29])
          end
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          if R[30] == 0 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 13 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 13 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 13 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 13 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 113 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 113 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 113 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 113 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 111 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 111 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 111 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 111 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 11 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 11 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 11 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 11 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[30] == 1 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 19 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 19 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 19 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 19 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 119 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 119 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 119 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 119 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 98, 117 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 98, 117 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 98, 117 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 98, 117 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 17 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 17 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 17 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 17 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[30] == 2 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 20 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 20 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 20 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 20 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 120 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 120 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 120 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 120 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 118 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 118 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 118 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 118 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 18 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 18 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 18 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 18 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          else
            unseen("R[30]", R[30])
          end
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          if R[31] == 0 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 120 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 120 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 120 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 120 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 14, 20 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 14, 20 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 14, 20 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 14, 20 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[31] == 1 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 18 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 18 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 18 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 18 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 118 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 118 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 118 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 118 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 116 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 116 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 116 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 89, 116 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 10, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[31] == 2 then
            if R[13] == 0 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 13 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 13 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 13 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 13 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 113 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 113 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 113 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 113 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            elseif R[13] == 1 then
              if R[12] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 111 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 111 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 111 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 111 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 11 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 11 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[12] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 11 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 20, 11 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[12]", R[12])
              end
            else
              unseen("R[13]", R[13])
            end
          else
            unseen("R[31]", R[31])
          end
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[23]", R[23])
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
    game.initial_set_tile({ 63, 74 }, 1140)
    game.initial_set_tile({ 63, 75 }, 1150)
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 100, 6 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 8, 17 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 36, 109 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 96, 100 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 67, 83 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 58, 60 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 72, 56 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 59, 82 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 65, 89 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 65, 73 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 71, 63 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 77, 49 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 54, 65 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 40, 117 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 94, 124 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 74, 99 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 14, 2 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 22, 28 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 109, 3 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 91, 21 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 53, 78 } }
    R[0] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 50, [1] = 75, [2] = 68, [3] = 76 })[R[0]], ({ [0] = 18, [1] = 8, [2] = 31, [3] = 43 })[R[0]] } }
    R[1] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 36, [2] = 13, [3] = 44 })[R[1]], ({ [0] = 48, [1] = 61, [2] = 70, [3] = 48 })[R[1]] } }
    R[2] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 55, [1] = 78, [2] = 66, [3] = 57 })[R[2]], ({ [0] = 113, [1] = 117, [2] = 120, [3] = 100 })[R[2]] } }
    R[3] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 117, [1] = 123, [2] = 102, [3] = 78 })[R[3]], ({ [0] = 78, [1] = 49, [2] = 57, [3] = 95 })[R[3]] } }
    R[4] = draw_avoid(4, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 50, [1] = 75, [2] = 68, [3] = 76 })[R[4]], ({ [0] = 18, [1] = 8, [2] = 31, [3] = 43 })[R[4]] } }
    R[5] = draw_avoid(4, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 36, [2] = 13, [3] = 44 })[R[5]], ({ [0] = 48, [1] = 61, [2] = 70, [3] = 48 })[R[5]] } }
    R[6] = draw_avoid(4, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 55, [1] = 78, [2] = 66, [3] = 57 })[R[6]], ({ [0] = 113, [1] = 117, [2] = 120, [3] = 100 })[R[6]] } }
    R[7] = draw_avoid(4, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 117, [1] = 123, [2] = 102, [3] = 78 })[R[7]], ({ [0] = 78, [1] = 49, [2] = 57, [3] = 95 })[R[7]] } }
    R[8] = draw_avoid(4, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 50, [1] = 75, [2] = 68, [3] = 76 })[R[8]], ({ [0] = 18, [1] = 8, [2] = 31, [3] = 43 })[R[8]] } }
    R[9] = draw_avoid(4, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 36, [2] = 13, [3] = 44 })[R[9]], ({ [0] = 48, [1] = 61, [2] = 70, [3] = 48 })[R[9]] } }
    R[10] = draw_avoid(4, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 55, [1] = 78, [2] = 66, [3] = 57 })[R[10]], ({ [0] = 113, [1] = 117, [2] = 120, [3] = 100 })[R[10]] } }
    R[11] = draw_avoid(4, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 117, [1] = 123, [2] = 102, [3] = 78 })[R[11]], ({ [0] = 78, [1] = 49, [2] = 57, [3] = 95 })[R[11]] } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 54, 42 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 96, 49 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 95, 88 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 35, 86 } }
    pick(4, 3, { 12, 32, 33 })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 29, [1] = 10, [2] = 82, [3] = 95 })[R[12]], ({ [0] = 23, [1] = 105, [2] = 106, [3] = 29 })[R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 17, [1] = 25, [2] = 102, [3] = 83 })[R[12]], ({ [0] = 30, [1] = 110, [2] = 107, [3] = 21 })[R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { ({ [0] = 27, [1] = 7, [2] = 111, [3] = 115 })[R[12]], ({ [0] = 8, [1] = 110, [2] = 119, [3] = 26 })[R[12]] } }
    U[#U + 1] = game.create_unit{ type = "CommonOreMine", player = players[1], at = { ({ [0] = 27, [1] = 7, [2] = 111, [3] = 115 })[R[12]], ({ [0] = 8, [1] = 110, [2] = 119, [3] = 26 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    R[14] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [3] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [4] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [5] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[14]][R[12]], ({ [0] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [5] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [6] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [3] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [4] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [5] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[14]][R[12]], ({ [0] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [5] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [6] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[14]][R[12]] })
    if R[14] == 1 or R[14] == 2 or R[14] == 3 or R[14] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [3] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [4] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[14]][R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 1 or R[14] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 } })[R[14]][R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[12]], ({ [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 } })[R[14]][R[12]], ({ [1] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 } })[R[14]][R[12]], ({ [1] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [2] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [2] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 } })[R[14]][R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[14]][R[12]], ({ [1] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [2] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[12]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 10, [1] = 112, [2] = 110, [3] = 12 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[14]", R[14])
      end
      U[#U]:set_lights(true)
      if R[14] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 9, [1] = 11, [2] = 88, [3] = 94 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[14]", R[14])
      end
      U[#U]:set_lights(true)
      if R[14] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 9, [1] = 11, [2] = 88, [3] = 94 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[14]", R[14])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [2] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [3] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [4] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 } })[R[14]][R[12]], ({ [1] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [2] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [3] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [4] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[14] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[14] == 5 or R[14] == 6 or R[14] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [6] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [7] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 } })[R[14]][R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 } })[R[14]][R[12]], ({ [5] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [6] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [7] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 5 or R[14] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [7] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[14]][R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        if R[14] == 5 then
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
        elseif R[14] == 7 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[14]", R[14])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [5] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[14]][R[12]], ({ [5] = { [0] = 19, [1] = 121, [2] = 119, [3] = 21 }, [7] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        if R[14] == 7 then
        elseif R[14] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[14]", R[14])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [5] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [5] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [7] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [7] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[14]][R[12]], ({ [5] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [7] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[14] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[14]", R[14])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [6] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 }, [7] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 } })[R[14]][R[12]], ({ [5] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [6] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [7] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[14] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[14] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[14]", R[14])
      end
    else
      unseen("R[14]", R[14])
    end
    U[#U]:set_lights(true)
    if R[14] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[14] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[14] == 6 then
      if LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 15, [1] = 117, [2] = 115, [3] = 17 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 15, [1] = 117, [2] = 115, [3] = 17 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[14]", R[14])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[14]], player = players[1], at = { ({ [0] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [3] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [4] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [5] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [6] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [7] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[14]][R[12]], ({ [0] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [5] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [6] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [7] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[14]], player = players[1], at = { ({ [0] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [1] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [3] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [4] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [5] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [6] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [7] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 } })[R[14]][R[12]], ({ [0] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [3] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 }, [4] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [5] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [6] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [7] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[14] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[34] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [1] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[34]][R[12]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 19, [1] = 121, [2] = 119, [3] = 21 } })[R[34]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        for i = 1, game.initial_units() do
          R[35] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[35]][R[12]], ({ [0] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [1] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [2] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 } })[R[35]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
        for i = 1, game.initial_units() do
          R[36] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [1] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 } })[R[36]][R[12]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[36]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
        for i = 1, game.initial_units() do
          R[37] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [1] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [2] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[37]][R[12]], ({ [0] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 } })[R[37]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] })
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [1] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[38]][R[12]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[38]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 } })[R[39]][R[12]], ({ [0] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[39]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[40]][R[12]], ({ [0] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [1] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [2] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 } })[R[40]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[41] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[41]][R[12]], ({ [0] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[41]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[14]", R[14])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 29, [1] = 10, [2] = 82, [3] = 95 })[R[32]], ({ [0] = 23, [1] = 105, [2] = 106, [3] = 29 })[R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 17, [1] = 25, [2] = 102, [3] = 83 })[R[32]], ({ [0] = 30, [1] = 110, [2] = 107, [3] = 21 })[R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { ({ [0] = 27, [1] = 7, [2] = 111, [3] = 115 })[R[32]], ({ [0] = 8, [1] = 110, [2] = 119, [3] = 26 })[R[32]] } }
    U[#U + 1] = game.create_unit{ type = "CommonOreMine", player = players[2], at = { ({ [0] = 27, [1] = 7, [2] = 111, [3] = 115 })[R[32]], ({ [0] = 8, [1] = 110, [2] = 119, [3] = 26 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
    R[23] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 15, [1] = 19, [2] = 19, [3] = 11, [4] = 15, [5] = 14, [6] = 11, [7] = 17 }, [1] = { [0] = 17, [1] = 21, [2] = 21, [3] = 13, [4] = 17, [5] = 16, [6] = 13, [7] = 19 }, [2] = { [0] = 94, [1] = 98, [2] = 98, [3] = 90, [4] = 94, [5] = 93, [6] = 90, [7] = 96 }, [3] = { [0] = 100, [1] = 104, [2] = 104, [3] = 96, [4] = 100, [5] = 99, [6] = 96, [7] = 102 } })[R[32]][R[23]], ({ [0] = { [0] = 17, [1] = 13, [2] = 17, [3] = 13, [4] = 16, [5] = 14, [6] = 11, [7] = 14 }, [1] = { [0] = 119, [1] = 115, [2] = 119, [3] = 115, [4] = 118, [5] = 116, [6] = 113, [7] = 116 }, [2] = { [0] = 117, [1] = 113, [2] = 117, [3] = 113, [4] = 116, [5] = 114, [6] = 111, [7] = 114 }, [3] = { [0] = 19, [1] = 15, [2] = 19, [3] = 15, [4] = 18, [5] = 16, [6] = 13, [7] = 16 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 15, [1] = 19, [2] = 19, [3] = 11, [4] = 15, [5] = 14, [6] = 11, [7] = 17 }, [1] = { [0] = 17, [1] = 21, [2] = 21, [3] = 13, [4] = 17, [5] = 16, [6] = 13, [7] = 19 }, [2] = { [0] = 94, [1] = 98, [2] = 98, [3] = 90, [4] = 94, [5] = 93, [6] = 90, [7] = 96 }, [3] = { [0] = 100, [1] = 104, [2] = 104, [3] = 96, [4] = 100, [5] = 99, [6] = 96, [7] = 102 } })[R[32]][R[23]], ({ [0] = { [0] = 17, [1] = 13, [2] = 17, [3] = 13, [4] = 16, [5] = 14, [6] = 11, [7] = 14 }, [1] = { [0] = 119, [1] = 115, [2] = 119, [3] = 115, [4] = 118, [5] = 116, [6] = 113, [7] = 116 }, [2] = { [0] = 117, [1] = 113, [2] = 117, [3] = 113, [4] = 116, [5] = 114, [6] = 111, [7] = 114 }, [3] = { [0] = 19, [1] = 15, [2] = 19, [3] = 15, [4] = 18, [5] = 16, [6] = 13, [7] = 16 } })[R[32]][R[23]] })
    if R[23] == 1 or R[23] == 2 or R[23] == 3 or R[23] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 19, [2] = 12, [3] = 16, [4] = 12 }, [1] = { [1] = 21, [2] = 14, [3] = 18, [4] = 14 }, [2] = { [1] = 98, [2] = 91, [3] = 95, [4] = 91 }, [3] = { [1] = 104, [2] = 97, [3] = 101, [4] = 97 } })[R[32]][R[23]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      if R[23] == 1 or R[23] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [1] = 10, [2] = 11 }, [1] = { [1] = 12, [2] = 13 }, [2] = { [1] = 89, [2] = 90 }, [3] = { [1] = 95, [2] = 96 } })[R[32]][R[23]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[32]], ({ [0] = { [1] = 16, [2] = 20 }, [1] = { [1] = 118, [2] = 122 }, [2] = { [1] = 116, [2] = 120 }, [3] = { [1] = 18, [2] = 22 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [1] = 14, [2] = 15 }, [1] = { [1] = 16, [2] = 17 }, [2] = { [1] = 93, [2] = 94 }, [3] = { [1] = 99, [2] = 100 } })[R[32]][R[23]], ({ [0] = { [1] = 21, [2] = 17 }, [1] = { [1] = 123, [2] = 119 }, [2] = { [1] = 121, [2] = 117 }, [3] = { [1] = 23, [2] = 19 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [1] = 14, [2] = 19 }, [1] = { [1] = 16, [2] = 21 }, [2] = { [1] = 93, [2] = 98 }, [3] = { [1] = 99, [2] = 104 } })[R[32]][R[23]], ({ [0] = { [1] = 17, [2] = 14 }, [1] = { [1] = 119, [2] = 116 }, [2] = { [1] = 117, [2] = 114 }, [3] = { [1] = 19, [2] = 16 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 20, [2] = 18 }, [1] = { [1] = 22, [2] = 20 }, [2] = { [1] = 99, [2] = 97 }, [3] = { [1] = 105, [2] = 103 } })[R[32]][R[23]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[32]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[32]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 10, [1] = 112, [2] = 110, [3] = 12 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[32]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[32]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[23]", R[23])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[23]], player = players[2], at = { ({ [0] = { [1] = 21, [2] = 20, [3] = 18, [4] = 15 }, [1] = { [1] = 23, [2] = 22, [3] = 20, [4] = 17 }, [2] = { [1] = 100, [2] = 99, [3] = 97, [4] = 94 }, [3] = { [1] = 106, [2] = 105, [3] = 103, [4] = 100 } })[R[32]][R[23]], ({ [0] = { [1] = 21, [2] = 22, [3] = 21, [4] = 11 }, [1] = { [1] = 123, [2] = 124, [3] = 123, [4] = 113 }, [2] = { [1] = 121, [2] = 122, [3] = 121, [4] = 111 }, [3] = { [1] = 23, [2] = 24, [3] = 23, [4] = 13 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[23]], player = players[2], at = { ({ [0] = { [1] = 18, [2] = 16, [3] = 19, [4] = 9 }, [1] = { [1] = 20, [2] = 18, [3] = 21, [4] = 11 }, [2] = { [1] = 97, [2] = 95, [3] = 98, [4] = 88 }, [3] = { [1] = 103, [2] = 101, [3] = 104, [4] = 94 } })[R[32]][R[23]], ({ [0] = { [1] = 22, [2] = 21, [3] = 22, [4] = 18 }, [1] = { [1] = 124, [2] = 123, [3] = 124, [4] = 120 }, [2] = { [1] = 122, [2] = 121, [3] = 122, [4] = 118 }, [3] = { [1] = 24, [2] = 23, [3] = 24, [4] = 20 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [1] = 21, [2] = 13, [3] = 13, [4] = 13 }, [1] = { [1] = 23, [2] = 15, [3] = 15, [4] = 15 }, [2] = { [1] = 100, [2] = 92, [3] = 92, [4] = 92 }, [3] = { [1] = 106, [2] = 98, [3] = 98, [4] = 98 } })[R[32]][R[23]], ({ [0] = { [1] = 18, [2] = 22, [3] = 18, [4] = 14 }, [1] = { [1] = 120, [2] = 124, [3] = 120, [4] = 116 }, [2] = { [1] = 118, [2] = 122, [3] = 118, [4] = 114 }, [3] = { [1] = 20, [2] = 24, [3] = 20, [4] = 16 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
      if R[23] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[32]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[32]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[32]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[23]", R[23])
      end
    elseif R[23] == 5 or R[23] == 6 or R[23] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [5] = 11, [6] = 20, [7] = 11 }, [1] = { [5] = 13, [6] = 22, [7] = 13 }, [2] = { [5] = 90, [6] = 99, [7] = 90 }, [3] = { [5] = 96, [6] = 105, [7] = 96 } })[R[32]][R[23]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [5] = 19, [6] = 11, [7] = 19 }, [1] = { [5] = 21, [6] = 13, [7] = 21 }, [2] = { [5] = 98, [6] = 90, [7] = 98 }, [3] = { [5] = 104, [6] = 96, [7] = 104 } })[R[32]][R[23]], ({ [0] = { [5] = 15, [6] = 20, [7] = 20 }, [1] = { [5] = 117, [6] = 122, [7] = 122 }, [2] = { [5] = 115, [6] = 120, [7] = 120 }, [3] = { [5] = 17, [6] = 22, [7] = 22 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
      if R[23] == 5 or R[23] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [5] = 19, [7] = 12 }, [1] = { [5] = 21, [7] = 14 }, [2] = { [5] = 98, [7] = 91 }, [3] = { [5] = 104, [7] = 97 } })[R[32]][R[23]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        if R[23] == 5 then
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
        elseif R[23] == 7 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[23]", R[23])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [5] = 18, [7] = 17 }, [1] = { [5] = 20, [7] = 19 }, [2] = { [5] = 97, [7] = 96 }, [3] = { [5] = 103, [7] = 102 } })[R[32]][R[23]], ({ [0] = { [5] = 19, [7] = 17 }, [1] = { [5] = 121, [7] = 119 }, [2] = { [5] = 119, [7] = 117 }, [3] = { [5] = 21, [7] = 19 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
        if R[23] == 7 then
        elseif R[23] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[23]", R[23])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = { [5] = 17, [7] = 14 }, [1] = { [5] = 119, [7] = 116 }, [2] = { [5] = 117, [7] = 114 }, [3] = { [5] = 19, [7] = 16 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = { [5] = 16, [7] = 15 }, [1] = { [5] = 118, [7] = 117 }, [2] = { [5] = 116, [7] = 115 }, [3] = { [5] = 18, [7] = 17 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [5] = 15, [7] = 20 }, [1] = { [5] = 17, [7] = 22 }, [2] = { [5] = 94, [7] = 99 }, [3] = { [5] = 100, [7] = 105 } })[R[32]][R[23]], ({ [0] = { [5] = 18, [7] = 15 }, [1] = { [5] = 120, [7] = 117 }, [2] = { [5] = 118, [7] = 115 }, [3] = { [5] = 20, [7] = 17 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[23] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[23]", R[23])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [5] = 21, [6] = 18, [7] = 14 }, [1] = { [5] = 23, [6] = 20, [7] = 16 }, [2] = { [5] = 100, [6] = 97, [7] = 93 }, [3] = { [5] = 106, [6] = 103, [7] = 99 } })[R[32]][R[23]], ({ [0] = { [5] = 13, [6] = 14, [7] = 12 }, [1] = { [5] = 115, [6] = 116, [7] = 114 }, [2] = { [5] = 113, [6] = 114, [7] = 112 }, [3] = { [5] = 15, [6] = 16, [7] = 14 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
      if R[23] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[32]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[23] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[23] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[23]", R[23])
      end
    elseif R[23] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[32]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[32]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[32]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[23]", R[23])
    end
    U[#U]:set_lights(true)
    if R[23] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[32]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[32]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[32]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[32]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[32]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[23] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[32]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[23] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 15, [1] = 117, [2] = 115, [3] = 17 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 15, [1] = 117, [2] = 115, [3] = 17 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[23]", R[23])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 11, [1] = 10, [2] = 16, [3] = 15, [4] = 13, [5] = 20, [6] = 15, [7] = 20 }, [1] = { [0] = 13, [1] = 12, [2] = 18, [3] = 17, [4] = 15, [5] = 22, [6] = 17, [7] = 22 }, [2] = { [0] = 90, [1] = 89, [2] = 95, [3] = 94, [4] = 92, [5] = 99, [6] = 94, [7] = 99 }, [3] = { [0] = 96, [1] = 95, [2] = 101, [3] = 100, [4] = 98, [5] = 105, [6] = 100, [7] = 105 } })[R[32]][R[23]], ({ [0] = { [0] = 14, [1] = 16, [2] = 12, [3] = 13, [4] = 22, [5] = 17, [6] = 16, [7] = 22 }, [1] = { [0] = 116, [1] = 118, [2] = 114, [3] = 115, [4] = 124, [5] = 119, [6] = 118, [7] = 124 }, [2] = { [0] = 114, [1] = 116, [2] = 112, [3] = 113, [4] = 122, [5] = 117, [6] = 116, [7] = 122 }, [3] = { [0] = 16, [1] = 18, [2] = 14, [3] = 15, [4] = 24, [5] = 19, [6] = 18, [7] = 24 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 12, [1] = 12, [2] = 15, [3] = 14, [4] = 14, [5] = 21, [6] = 16, [7] = 21 }, [1] = { [0] = 14, [1] = 14, [2] = 17, [3] = 16, [4] = 16, [5] = 23, [6] = 18, [7] = 23 }, [2] = { [0] = 91, [1] = 91, [2] = 94, [3] = 93, [4] = 93, [5] = 100, [6] = 95, [7] = 100 }, [3] = { [0] = 97, [1] = 97, [2] = 100, [3] = 99, [4] = 99, [5] = 106, [6] = 101, [7] = 106 } })[R[32]][R[23]], ({ [0] = { [0] = 14, [1] = 15, [2] = 11, [3] = 12, [4] = 21, [5] = 16, [6] = 15, [7] = 22 }, [1] = { [0] = 116, [1] = 117, [2] = 113, [3] = 114, [4] = 123, [5] = 118, [6] = 117, [7] = 124 }, [2] = { [0] = 114, [1] = 115, [2] = 111, [3] = 112, [4] = 121, [5] = 116, [6] = 115, [7] = 122 }, [3] = { [0] = 16, [1] = 17, [2] = 13, [3] = 14, [4] = 23, [5] = 18, [6] = 17, [7] = 24 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[23] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [1] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[42]][R[32]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 19, [1] = 121, [2] = 119, [3] = 21 } })[R[42]][R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] })
        for i = 1, game.initial_units() do
          R[43] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[43]][R[32]], ({ [0] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [1] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [2] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 } })[R[43]][R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] })
        for i = 1, game.initial_units() do
          R[44] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [1] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 } })[R[44]][R[32]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[44]][R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[32]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[32]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] })
        for i = 1, game.initial_units() do
          R[45] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [1] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [2] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[45]][R[32]], ({ [0] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 } })[R[45]][R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[32]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[32]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[32]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[32]] })
        for i = 1, game.initial_units() do
          R[46] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [1] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[46]][R[32]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[46]][R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[47] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 } })[R[47]][R[32]], ({ [0] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[47]][R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[48] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[48]][R[32]], ({ [0] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [1] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [2] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 } })[R[48]][R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[49] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[49]][R[32]], ({ [0] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[49]][R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[23]", R[23])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 29, [1] = 10, [2] = 82, [3] = 95 })[R[33]], ({ [0] = 23, [1] = 105, [2] = 106, [3] = 29 })[R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 17, [1] = 25, [2] = 102, [3] = 83 })[R[33]], ({ [0] = 30, [1] = 110, [2] = 107, [3] = 21 })[R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { ({ [0] = 27, [1] = 7, [2] = 111, [3] = 115 })[R[33]], ({ [0] = 8, [1] = 110, [2] = 119, [3] = 26 })[R[33]] } }
    U[#U + 1] = game.create_unit{ type = "CommonOreMine", player = players[3], at = { ({ [0] = 27, [1] = 7, [2] = 111, [3] = 115 })[R[33]], ({ [0] = 8, [1] = 110, [2] = 119, [3] = 26 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
    R[50] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [3] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [4] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [5] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[50]][R[33]], ({ [0] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [5] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [6] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [3] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [4] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [5] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[50]][R[33]], ({ [0] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [5] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [6] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[50]][R[33]] })
    if R[50] == 1 or R[50] == 2 or R[50] == 3 or R[50] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [3] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [4] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[50]][R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      if R[50] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[33]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[50] == 1 or R[50] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 } })[R[50]][R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[33]], ({ [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 } })[R[50]][R[33]], ({ [1] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 } })[R[50]][R[33]], ({ [1] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [2] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [2] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 } })[R[50]][R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[50] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[33]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[33]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 10, [1] = 112, [2] = 110, [3] = 12 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[50]", R[50])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[50]], player = players[3], at = { ({ [1] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [3] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 }, [4] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 } })[R[50]][R[33]], ({ [1] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [2] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [3] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [4] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[50]], player = players[3], at = { ({ [1] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [3] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [4] = { [0] = 9, [1] = 11, [2] = 88, [3] = 94 } })[R[50]][R[33]], ({ [1] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [2] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [3] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [4] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [2] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [3] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [4] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 } })[R[50]][R[33]], ({ [1] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [2] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [3] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [4] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
      if R[50] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[33]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[50] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[50] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[33]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[50] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[33]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[50]", R[50])
      end
    elseif R[50] == 5 or R[50] == 6 or R[50] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [6] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [7] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 } })[R[50]][R[33]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 } })[R[50]][R[33]], ({ [5] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [6] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [7] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
      if R[50] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[50] == 5 or R[50] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [5] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [7] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[50]][R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        if R[50] == 5 then
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
        elseif R[50] == 7 then
          if LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[50]", R[50])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [5] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[50]][R[33]], ({ [5] = { [0] = 19, [1] = 121, [2] = 119, [3] = 21 }, [7] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
        if R[50] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[50] == 7 then
        else
          unseen("R[50]", R[50])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [5] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [5] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [7] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [5] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [7] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[50]][R[33]], ({ [5] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [7] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[50]", R[50])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [6] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 }, [7] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 } })[R[50]][R[33]], ({ [5] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [6] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [7] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
      if R[50] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[33]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[50] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[50] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[50]", R[50])
      end
    elseif R[50] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[33]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[33]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[50]", R[50])
    end
    U[#U]:set_lights(true)
    if R[50] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[33]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[33]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[50] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[33]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[50] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[50] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[33]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[50] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[33]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[50] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[33]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[50] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 15, [1] = 117, [2] = 115, [3] = 17 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 15, [1] = 117, [2] = 115, [3] = 17 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[50] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[50]", R[50])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[50]], player = players[3], at = { ({ [0] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [3] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [4] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [5] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [6] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [7] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[50]][R[33]], ({ [0] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [5] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [6] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [7] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[50]], player = players[3], at = { ({ [0] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [1] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [3] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [4] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [5] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [6] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [7] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 } })[R[50]][R[33]], ({ [0] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [3] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 }, [4] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [5] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [6] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [7] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[50] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[51] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [1] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[51]][R[33]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 19, [1] = 121, [2] = 119, [3] = 21 } })[R[51]][R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[50] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] })
        for i = 1, game.initial_units() do
          R[52] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[52]][R[33]], ({ [0] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [1] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [2] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 } })[R[52]][R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[50] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] })
        for i = 1, game.initial_units() do
          R[53] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [1] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 } })[R[53]][R[33]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[53]][R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[50] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[33]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[33]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[33]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[33]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] })
        for i = 1, game.initial_units() do
          R[54] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [1] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [2] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[54]][R[33]], ({ [0] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 } })[R[54]][R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[50] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[33]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[33]] })
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [1] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[55]][R[33]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[55]][R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[50] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[56] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 } })[R[56]][R[33]], ({ [0] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[56]][R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[50] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[57] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[57]][R[33]], ({ [0] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [1] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [2] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 } })[R[57]][R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[50] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[58] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[58]][R[33]], ({ [0] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[58]][R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[50]", R[50])
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
    game.initial_set_tile({ 63, 74 }, 1140)
    game.initial_set_tile({ 63, 75 }, 1150)
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 100, 6 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 8, 17 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 36, 109 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 96, 100 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 67, 83 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 58, 60 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 72, 56 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 59, 82 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 65, 89 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 65, 73 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 71, 63 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 77, 49 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 54, 65 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 40, 117 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 94, 124 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 74, 99 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 14, 2 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 22, 28 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 109, 3 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 91, 21 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 53, 78 } }
    R[0] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 50, [1] = 75, [2] = 68, [3] = 76 })[R[0]], ({ [0] = 18, [1] = 8, [2] = 31, [3] = 43 })[R[0]] } }
    R[1] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 36, [2] = 13, [3] = 44 })[R[1]], ({ [0] = 48, [1] = 61, [2] = 70, [3] = 48 })[R[1]] } }
    R[2] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 55, [1] = 78, [2] = 66, [3] = 57 })[R[2]], ({ [0] = 113, [1] = 117, [2] = 120, [3] = 100 })[R[2]] } }
    R[3] = game.rand(4)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 117, [1] = 123, [2] = 102, [3] = 78 })[R[3]], ({ [0] = 78, [1] = 49, [2] = 57, [3] = 95 })[R[3]] } }
    R[4] = draw_avoid(4, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 50, [1] = 75, [2] = 68, [3] = 76 })[R[4]], ({ [0] = 18, [1] = 8, [2] = 31, [3] = 43 })[R[4]] } }
    R[5] = draw_avoid(4, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 36, [2] = 13, [3] = 44 })[R[5]], ({ [0] = 48, [1] = 61, [2] = 70, [3] = 48 })[R[5]] } }
    R[6] = draw_avoid(4, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 55, [1] = 78, [2] = 66, [3] = 57 })[R[6]], ({ [0] = 113, [1] = 117, [2] = 120, [3] = 100 })[R[6]] } }
    R[7] = draw_avoid(4, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 117, [1] = 123, [2] = 102, [3] = 78 })[R[7]], ({ [0] = 78, [1] = 49, [2] = 57, [3] = 95 })[R[7]] } }
    R[8] = draw_avoid(4, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 50, [1] = 75, [2] = 68, [3] = 76 })[R[8]], ({ [0] = 18, [1] = 8, [2] = 31, [3] = 43 })[R[8]] } }
    R[9] = draw_avoid(4, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 36, [2] = 13, [3] = 44 })[R[9]], ({ [0] = 48, [1] = 61, [2] = 70, [3] = 48 })[R[9]] } }
    R[10] = draw_avoid(4, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 55, [1] = 78, [2] = 66, [3] = 57 })[R[10]], ({ [0] = 113, [1] = 117, [2] = 120, [3] = 100 })[R[10]] } }
    R[11] = draw_avoid(4, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 117, [1] = 123, [2] = 102, [3] = 78 })[R[11]], ({ [0] = 78, [1] = 49, [2] = 57, [3] = 95 })[R[11]] } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 54, 42 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 96, 49 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 95, 88 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 35, 86 } }
    pick(4, 4, { 12, 32, 33, 59 })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 29, [1] = 10, [2] = 82, [3] = 95 })[R[12]], ({ [0] = 23, [1] = 105, [2] = 106, [3] = 29 })[R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 17, [1] = 25, [2] = 102, [3] = 83 })[R[12]], ({ [0] = 30, [1] = 110, [2] = 107, [3] = 21 })[R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { ({ [0] = 27, [1] = 7, [2] = 111, [3] = 115 })[R[12]], ({ [0] = 8, [1] = 110, [2] = 119, [3] = 26 })[R[12]] } }
    U[#U + 1] = game.create_unit{ type = "CommonOreMine", player = players[1], at = { ({ [0] = 27, [1] = 7, [2] = 111, [3] = 115 })[R[12]], ({ [0] = 8, [1] = 110, [2] = 119, [3] = 26 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    R[14] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [3] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [4] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [5] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[14]][R[12]], ({ [0] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [5] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [6] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [3] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [4] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [5] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[14]][R[12]], ({ [0] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [5] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [6] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[14]][R[12]] })
    if R[14] == 1 or R[14] == 2 or R[14] == 3 or R[14] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [3] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [4] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[14]][R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 1 or R[14] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 } })[R[14]][R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[12]], ({ [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 } })[R[14]][R[12]], ({ [1] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 } })[R[14]][R[12]], ({ [1] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [2] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [2] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 } })[R[14]][R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[14]][R[12]], ({ [1] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [2] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[12]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 10, [1] = 112, [2] = 110, [3] = 12 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[14]", R[14])
      end
      U[#U]:set_lights(true)
      if R[14] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 9, [1] = 11, [2] = 88, [3] = 94 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[14]", R[14])
      end
      U[#U]:set_lights(true)
      if R[14] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 9, [1] = 11, [2] = 88, [3] = 94 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[14]", R[14])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [2] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [3] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [4] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 } })[R[14]][R[12]], ({ [1] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [2] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [3] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [4] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[14] == 5 or R[14] == 6 or R[14] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [6] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [7] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 } })[R[14]][R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 } })[R[14]][R[12]], ({ [5] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [6] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [7] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[14] == 5 or R[14] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [7] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[14]][R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        if R[14] == 5 then
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
        elseif R[14] == 7 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[14]", R[14])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [5] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[14]][R[12]], ({ [5] = { [0] = 19, [1] = 121, [2] = 119, [3] = 21 }, [7] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        if R[14] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[14] == 7 then
        else
          unseen("R[14]", R[14])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [5] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [5] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [7] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [7] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[14]][R[12]], ({ [5] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [7] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[14]", R[14])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [6] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 }, [7] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 } })[R[14]][R[12]], ({ [5] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [6] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [7] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[14] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[14] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[14]", R[14])
      end
    elseif R[14] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[12]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[14]", R[14])
    end
    U[#U]:set_lights(true)
    if R[14] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[14] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[14] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 15, [1] = 117, [2] = 115, [3] = 17 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 15, [1] = 117, [2] = 115, [3] = 17 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[14]", R[14])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[14]], player = players[1], at = { ({ [0] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [3] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [4] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [5] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [6] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [7] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[14]][R[12]], ({ [0] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [5] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [6] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [7] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[14]], player = players[1], at = { ({ [0] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [1] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [3] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [4] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [5] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [6] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [7] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 } })[R[14]][R[12]], ({ [0] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [3] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 }, [4] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [5] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [6] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [7] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 } })[R[14]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[14] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[60] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [1] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[60]][R[12]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 19, [1] = 121, [2] = 119, [3] = 21 } })[R[60]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 1 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        for i = 1, game.initial_units() do
          R[61] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[61]][R[12]], ({ [0] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [1] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [2] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 } })[R[61]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
        for i = 1, game.initial_units() do
          R[62] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [1] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 } })[R[62]][R[12]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[62]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[12]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[12]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[12]] })
        for i = 1, game.initial_units() do
          R[63] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [1] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [2] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[63]][R[12]], ({ [0] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 } })[R[63]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 4 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] })
        for i = 1, game.initial_units() do
          R[64] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [1] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[64]][R[12]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[64]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[12]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[12]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[65] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 } })[R[65]][R[12]], ({ [0] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[65]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[66] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[66]][R[12]], ({ [0] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [1] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [2] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 } })[R[66]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[67] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[67]][R[12]], ({ [0] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[67]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[14]", R[14])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 29, [1] = 10, [2] = 82, [3] = 95 })[R[32]], ({ [0] = 23, [1] = 105, [2] = 106, [3] = 29 })[R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 17, [1] = 25, [2] = 102, [3] = 83 })[R[32]], ({ [0] = 30, [1] = 110, [2] = 107, [3] = 21 })[R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { ({ [0] = 27, [1] = 7, [2] = 111, [3] = 115 })[R[32]], ({ [0] = 8, [1] = 110, [2] = 119, [3] = 26 })[R[32]] } }
    U[#U + 1] = game.create_unit{ type = "CommonOreMine", player = players[2], at = { ({ [0] = 27, [1] = 7, [2] = 111, [3] = 115 })[R[32]], ({ [0] = 8, [1] = 110, [2] = 119, [3] = 26 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
    R[23] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 15, [1] = 19, [2] = 19, [3] = 11, [4] = 15, [5] = 14, [6] = 11, [7] = 17 }, [1] = { [0] = 17, [1] = 21, [2] = 21, [3] = 13, [4] = 17, [5] = 16, [6] = 13, [7] = 19 }, [2] = { [0] = 94, [1] = 98, [2] = 98, [3] = 90, [4] = 94, [5] = 93, [6] = 90, [7] = 96 }, [3] = { [0] = 100, [1] = 104, [2] = 104, [3] = 96, [4] = 100, [5] = 99, [6] = 96, [7] = 102 } })[R[32]][R[23]], ({ [0] = { [0] = 17, [1] = 13, [2] = 17, [3] = 13, [4] = 16, [5] = 14, [6] = 11, [7] = 14 }, [1] = { [0] = 119, [1] = 115, [2] = 119, [3] = 115, [4] = 118, [5] = 116, [6] = 113, [7] = 116 }, [2] = { [0] = 117, [1] = 113, [2] = 117, [3] = 113, [4] = 116, [5] = 114, [6] = 111, [7] = 114 }, [3] = { [0] = 19, [1] = 15, [2] = 19, [3] = 15, [4] = 18, [5] = 16, [6] = 13, [7] = 16 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 15, [1] = 19, [2] = 19, [3] = 11, [4] = 15, [5] = 14, [6] = 11, [7] = 17 }, [1] = { [0] = 17, [1] = 21, [2] = 21, [3] = 13, [4] = 17, [5] = 16, [6] = 13, [7] = 19 }, [2] = { [0] = 94, [1] = 98, [2] = 98, [3] = 90, [4] = 94, [5] = 93, [6] = 90, [7] = 96 }, [3] = { [0] = 100, [1] = 104, [2] = 104, [3] = 96, [4] = 100, [5] = 99, [6] = 96, [7] = 102 } })[R[32]][R[23]], ({ [0] = { [0] = 17, [1] = 13, [2] = 17, [3] = 13, [4] = 16, [5] = 14, [6] = 11, [7] = 14 }, [1] = { [0] = 119, [1] = 115, [2] = 119, [3] = 115, [4] = 118, [5] = 116, [6] = 113, [7] = 116 }, [2] = { [0] = 117, [1] = 113, [2] = 117, [3] = 113, [4] = 116, [5] = 114, [6] = 111, [7] = 114 }, [3] = { [0] = 19, [1] = 15, [2] = 19, [3] = 15, [4] = 18, [5] = 16, [6] = 13, [7] = 16 } })[R[32]][R[23]] })
    if R[23] == 1 or R[23] == 2 or R[23] == 3 or R[23] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 19, [2] = 12, [3] = 16, [4] = 12 }, [1] = { [1] = 21, [2] = 14, [3] = 18, [4] = 14 }, [2] = { [1] = 98, [2] = 91, [3] = 95, [4] = 91 }, [3] = { [1] = 104, [2] = 97, [3] = 101, [4] = 97 } })[R[32]][R[23]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      if R[23] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[32]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[32]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 10, [1] = 112, [2] = 110, [3] = 12 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[23] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[32]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[32]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 1 or R[23] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [1] = 10, [2] = 11 }, [1] = { [1] = 12, [2] = 13 }, [2] = { [1] = 89, [2] = 90 }, [3] = { [1] = 95, [2] = 96 } })[R[32]][R[23]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[32]], ({ [0] = { [1] = 16, [2] = 20 }, [1] = { [1] = 118, [2] = 122 }, [2] = { [1] = 116, [2] = 120 }, [3] = { [1] = 18, [2] = 22 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [1] = 14, [2] = 15 }, [1] = { [1] = 16, [2] = 17 }, [2] = { [1] = 93, [2] = 94 }, [3] = { [1] = 99, [2] = 100 } })[R[32]][R[23]], ({ [0] = { [1] = 21, [2] = 17 }, [1] = { [1] = 123, [2] = 119 }, [2] = { [1] = 121, [2] = 117 }, [3] = { [1] = 23, [2] = 19 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [1] = 14, [2] = 19 }, [1] = { [1] = 16, [2] = 21 }, [2] = { [1] = 93, [2] = 98 }, [3] = { [1] = 99, [2] = 104 } })[R[32]][R[23]], ({ [0] = { [1] = 17, [2] = 14 }, [1] = { [1] = 119, [2] = 116 }, [2] = { [1] = 117, [2] = 114 }, [3] = { [1] = 19, [2] = 16 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 20, [2] = 18 }, [1] = { [1] = 22, [2] = 20 }, [2] = { [1] = 99, [2] = 97 }, [3] = { [1] = 105, [2] = 103 } })[R[32]][R[23]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 21, [2] = 20 }, [1] = { [1] = 23, [2] = 22 }, [2] = { [1] = 100, [2] = 99 }, [3] = { [1] = 106, [2] = 105 } })[R[32]][R[23]], ({ [0] = { [1] = 21, [2] = 22 }, [1] = { [1] = 123, [2] = 124 }, [2] = { [1] = 121, [2] = 122 }, [3] = { [1] = 23, [2] = 24 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[23]", R[23])
      end
      U[#U]:set_lights(true)
      if R[23] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 9, [1] = 11, [2] = 88, [3] = 94 })[R[32]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[23]", R[23])
      end
      U[#U]:set_lights(true)
      if R[23] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[32]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[32]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[23] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[32]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 9, [1] = 11, [2] = 88, [3] = 94 })[R[32]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[23]", R[23])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [1] = 21, [2] = 13, [3] = 13, [4] = 13 }, [1] = { [1] = 23, [2] = 15, [3] = 15, [4] = 15 }, [2] = { [1] = 100, [2] = 92, [3] = 92, [4] = 92 }, [3] = { [1] = 106, [2] = 98, [3] = 98, [4] = 98 } })[R[32]][R[23]], ({ [0] = { [1] = 18, [2] = 22, [3] = 18, [4] = 14 }, [1] = { [1] = 120, [2] = 124, [3] = 120, [4] = 116 }, [2] = { [1] = 118, [2] = 122, [3] = 118, [4] = 114 }, [3] = { [1] = 20, [2] = 24, [3] = 20, [4] = 16 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[23] == 5 or R[23] == 6 or R[23] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [5] = 11, [6] = 20, [7] = 11 }, [1] = { [5] = 13, [6] = 22, [7] = 13 }, [2] = { [5] = 90, [6] = 99, [7] = 90 }, [3] = { [5] = 96, [6] = 105, [7] = 96 } })[R[32]][R[23]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [5] = 19, [6] = 11, [7] = 19 }, [1] = { [5] = 21, [6] = 13, [7] = 21 }, [2] = { [5] = 98, [6] = 90, [7] = 98 }, [3] = { [5] = 104, [6] = 96, [7] = 104 } })[R[32]][R[23]], ({ [0] = { [5] = 15, [6] = 20, [7] = 20 }, [1] = { [5] = 117, [6] = 122, [7] = 122 }, [2] = { [5] = 115, [6] = 120, [7] = 120 }, [3] = { [5] = 17, [6] = 22, [7] = 22 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
      if R[23] == 5 or R[23] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [5] = 19, [7] = 12 }, [1] = { [5] = 21, [7] = 14 }, [2] = { [5] = 98, [7] = 91 }, [3] = { [5] = 104, [7] = 97 } })[R[32]][R[23]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        if R[23] == 5 then
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
        elseif R[23] == 7 then
          if LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[23]", R[23])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [5] = 18, [7] = 17 }, [1] = { [5] = 20, [7] = 19 }, [2] = { [5] = 97, [7] = 96 }, [3] = { [5] = 103, [7] = 102 } })[R[32]][R[23]], ({ [0] = { [5] = 19, [7] = 17 }, [1] = { [5] = 121, [7] = 119 }, [2] = { [5] = 119, [7] = 117 }, [3] = { [5] = 21, [7] = 19 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
        if R[23] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[23] == 7 then
        else
          unseen("R[23]", R[23])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = { [5] = 17, [7] = 14 }, [1] = { [5] = 119, [7] = 116 }, [2] = { [5] = 117, [7] = 114 }, [3] = { [5] = 19, [7] = 16 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = { [5] = 16, [7] = 15 }, [1] = { [5] = 118, [7] = 117 }, [2] = { [5] = 116, [7] = 115 }, [3] = { [5] = 18, [7] = 17 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [5] = 15, [7] = 20 }, [1] = { [5] = 17, [7] = 22 }, [2] = { [5] = 94, [7] = 99 }, [3] = { [5] = 100, [7] = 105 } })[R[32]][R[23]], ({ [0] = { [5] = 18, [7] = 15 }, [1] = { [5] = 120, [7] = 117 }, [2] = { [5] = 118, [7] = 115 }, [3] = { [5] = 20, [7] = 17 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[23] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[23]", R[23])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [5] = 21, [6] = 18, [7] = 14 }, [1] = { [5] = 23, [6] = 20, [7] = 16 }, [2] = { [5] = 100, [6] = 97, [7] = 93 }, [3] = { [5] = 106, [6] = 103, [7] = 99 } })[R[32]][R[23]], ({ [0] = { [5] = 13, [6] = 14, [7] = 12 }, [1] = { [5] = 115, [6] = 116, [7] = 114 }, [2] = { [5] = 113, [6] = 114, [7] = 112 }, [3] = { [5] = 15, [6] = 16, [7] = 14 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
      if R[23] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[32]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[23] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[23] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[23]", R[23])
      end
    elseif R[23] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[32]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[32]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[32]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[23]", R[23])
    end
    U[#U]:set_lights(true)
    if R[23] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[32]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[32]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[32]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[32]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[32]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[23] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[32]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[23] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 15, [1] = 117, [2] = 115, [3] = 17 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 15, [1] = 117, [2] = 115, [3] = 17 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[23]", R[23])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 11, [1] = 10, [2] = 16, [3] = 15, [4] = 13, [5] = 20, [6] = 15, [7] = 20 }, [1] = { [0] = 13, [1] = 12, [2] = 18, [3] = 17, [4] = 15, [5] = 22, [6] = 17, [7] = 22 }, [2] = { [0] = 90, [1] = 89, [2] = 95, [3] = 94, [4] = 92, [5] = 99, [6] = 94, [7] = 99 }, [3] = { [0] = 96, [1] = 95, [2] = 101, [3] = 100, [4] = 98, [5] = 105, [6] = 100, [7] = 105 } })[R[32]][R[23]], ({ [0] = { [0] = 14, [1] = 16, [2] = 12, [3] = 13, [4] = 22, [5] = 17, [6] = 16, [7] = 22 }, [1] = { [0] = 116, [1] = 118, [2] = 114, [3] = 115, [4] = 124, [5] = 119, [6] = 118, [7] = 124 }, [2] = { [0] = 114, [1] = 116, [2] = 112, [3] = 113, [4] = 122, [5] = 117, [6] = 116, [7] = 122 }, [3] = { [0] = 16, [1] = 18, [2] = 14, [3] = 15, [4] = 24, [5] = 19, [6] = 18, [7] = 24 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 12, [1] = 12, [2] = 15, [3] = 14, [4] = 14, [5] = 21, [6] = 16, [7] = 21 }, [1] = { [0] = 14, [1] = 14, [2] = 17, [3] = 16, [4] = 16, [5] = 23, [6] = 18, [7] = 23 }, [2] = { [0] = 91, [1] = 91, [2] = 94, [3] = 93, [4] = 93, [5] = 100, [6] = 95, [7] = 100 }, [3] = { [0] = 97, [1] = 97, [2] = 100, [3] = 99, [4] = 99, [5] = 106, [6] = 101, [7] = 106 } })[R[32]][R[23]], ({ [0] = { [0] = 14, [1] = 15, [2] = 11, [3] = 12, [4] = 21, [5] = 16, [6] = 15, [7] = 22 }, [1] = { [0] = 116, [1] = 117, [2] = 113, [3] = 114, [4] = 123, [5] = 118, [6] = 117, [7] = 124 }, [2] = { [0] = 114, [1] = 115, [2] = 111, [3] = 112, [4] = 121, [5] = 116, [6] = 115, [7] = 122 }, [3] = { [0] = 16, [1] = 17, [2] = 13, [3] = 14, [4] = 23, [5] = 18, [6] = 17, [7] = 24 } })[R[32]][R[23]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[23] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[68] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [1] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[68]][R[32]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 19, [1] = 121, [2] = 119, [3] = 21 } })[R[68]][R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] })
        for i = 1, game.initial_units() do
          R[69] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[69]][R[32]], ({ [0] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [1] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [2] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 } })[R[69]][R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] })
        for i = 1, game.initial_units() do
          R[70] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [1] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 } })[R[70]][R[32]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[70]][R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[32]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[32]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[32]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[32]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[32]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[32]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[32]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[32]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[32]] })
        for i = 1, game.initial_units() do
          R[71] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [1] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [2] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[71]][R[32]], ({ [0] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 } })[R[71]][R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[32]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[32]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[32]] })
        for i = 1, game.initial_units() do
          R[72] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [1] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[72]][R[32]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[72]][R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[73] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 } })[R[73]][R[32]], ({ [0] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[73]][R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[74] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[74]][R[32]], ({ [0] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [1] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [2] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 } })[R[74]][R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[23] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[75] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[75]][R[32]], ({ [0] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[75]][R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[23]", R[23])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 29, [1] = 10, [2] = 82, [3] = 95 })[R[33]], ({ [0] = 23, [1] = 105, [2] = 106, [3] = 29 })[R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 17, [1] = 25, [2] = 102, [3] = 83 })[R[33]], ({ [0] = 30, [1] = 110, [2] = 107, [3] = 21 })[R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { ({ [0] = 27, [1] = 7, [2] = 111, [3] = 115 })[R[33]], ({ [0] = 8, [1] = 110, [2] = 119, [3] = 26 })[R[33]] } }
    U[#U + 1] = game.create_unit{ type = "CommonOreMine", player = players[3], at = { ({ [0] = 27, [1] = 7, [2] = 111, [3] = 115 })[R[33]], ({ [0] = 8, [1] = 110, [2] = 119, [3] = 26 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
    R[50] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [3] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [4] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [5] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[50]][R[33]], ({ [0] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [5] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [6] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [3] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [4] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [5] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[50]][R[33]], ({ [0] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [5] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [6] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[50]][R[33]] })
    if R[50] == 1 or R[50] == 2 or R[50] == 3 or R[50] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [3] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [4] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[50]][R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      if R[50] == 1 or R[50] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 } })[R[50]][R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[33]], ({ [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 } })[R[50]][R[33]], ({ [1] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 } })[R[50]][R[33]], ({ [1] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [2] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [2] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 } })[R[50]][R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[50]][R[33]], ({ [1] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [2] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[50] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[33]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[50] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[33]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[33]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 10, [1] = 112, [2] = 110, [3] = 12 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[50]", R[50])
      end
      U[#U]:set_lights(true)
      if R[50] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[50] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[50] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[50] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 9, [1] = 11, [2] = 88, [3] = 94 })[R[33]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[50]", R[50])
      end
      U[#U]:set_lights(true)
      if R[50] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[33]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[50] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[50] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[33]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[50] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[33]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 9, [1] = 11, [2] = 88, [3] = 94 })[R[33]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[50]", R[50])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [2] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [3] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [4] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 } })[R[50]][R[33]], ({ [1] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [2] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [3] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [4] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[50] == 5 or R[50] == 6 or R[50] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [6] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [7] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 } })[R[50]][R[33]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 } })[R[50]][R[33]], ({ [5] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [6] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [7] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
      if R[50] == 5 or R[50] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [5] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [7] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[50]][R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        if R[50] == 5 then
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
        elseif R[50] == 7 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[50]", R[50])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [5] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[50]][R[33]], ({ [5] = { [0] = 19, [1] = 121, [2] = 119, [3] = 21 }, [7] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
        if R[50] == 7 then
        elseif R[50] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[50]", R[50])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [5] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [5] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [7] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [5] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [7] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[50]][R[33]], ({ [5] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [7] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[50] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[50]", R[50])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [6] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 }, [7] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 } })[R[50]][R[33]], ({ [5] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [6] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [7] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
      if R[50] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[33]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[50] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[50] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[50]", R[50])
      end
    elseif R[50] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[33]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[33]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[33]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[50]", R[50])
    end
    U[#U]:set_lights(true)
    if R[50] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[33]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[33]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[50] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[33]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[50] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[50] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[33]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[50] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[33]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[50] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[33]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[50] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 15, [1] = 117, [2] = 115, [3] = 17 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 15, [1] = 117, [2] = 115, [3] = 17 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[50] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[50]", R[50])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[50]], player = players[3], at = { ({ [0] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [3] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [4] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [5] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [6] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [7] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[50]][R[33]], ({ [0] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [5] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [6] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [7] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[50]], player = players[3], at = { ({ [0] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [1] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [3] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [4] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [5] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [6] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [7] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 } })[R[50]][R[33]], ({ [0] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [3] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 }, [4] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [5] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [6] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [7] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 } })[R[50]][R[33]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[50] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[76] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [1] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[76]][R[33]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 19, [1] = 121, [2] = 119, [3] = 21 } })[R[76]][R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[50] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] })
        for i = 1, game.initial_units() do
          R[77] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[77]][R[33]], ({ [0] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [1] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [2] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 } })[R[77]][R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[50] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] })
        for i = 1, game.initial_units() do
          R[78] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [1] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 } })[R[78]][R[33]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[78]][R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[50] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[33]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[33]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] })
        for i = 1, game.initial_units() do
          R[79] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [1] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [2] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[79]][R[33]], ({ [0] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 } })[R[79]][R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[33]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[33]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[33]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[33]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[33]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[33]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[33]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[50] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[33]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[33]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[33]] })
        for i = 1, game.initial_units() do
          R[80] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [1] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[80]][R[33]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[80]][R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[50] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[81] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 } })[R[81]][R[33]], ({ [0] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[81]][R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[50] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[82] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[82]][R[33]], ({ [0] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [1] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [2] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 } })[R[82]][R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[50] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[83] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[83]][R[33]], ({ [0] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[83]][R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[50]", R[50])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [0] = 29, [1] = 10, [2] = 82, [3] = 95 })[R[59]], ({ [0] = 23, [1] = 105, [2] = 106, [3] = 29 })[R[59]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [0] = 17, [1] = 25, [2] = 102, [3] = 83 })[R[59]], ({ [0] = 30, [1] = 110, [2] = 107, [3] = 21 })[R[59]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { ({ [0] = 27, [1] = 7, [2] = 111, [3] = 115 })[R[59]], ({ [0] = 8, [1] = 110, [2] = 119, [3] = 26 })[R[59]] } }
    U[#U + 1] = game.create_unit{ type = "CommonOreMine", player = players[4], at = { ({ [0] = 27, [1] = 7, [2] = 111, [3] = 115 })[R[59]], ({ [0] = 8, [1] = 110, [2] = 119, [3] = 26 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
    R[84] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [3] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [4] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [5] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[84]][R[59]], ({ [0] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [5] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [6] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[84]][R[59]] }, direction = "East", lights = false, exact = true }[1]
    players[4]:center_view({ ({ [0] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [3] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [4] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [5] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[84]][R[59]], ({ [0] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [5] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [6] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[84]][R[59]] })
    if R[84] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[59]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[59]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[59]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[59]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[59]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[59]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[59]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[59]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[59]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[59]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[84] == 1 or R[84] == 2 or R[84] == 3 or R[84] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [3] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [4] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[84]][R[59]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      if R[84] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[59]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[59]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[59]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[59]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[59]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[84] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[59]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[59]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[59]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 20, [1] = 22, [2] = 99, [3] = 105 })[R[59]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[59]], ({ [0] = 10, [1] = 112, [2] = 110, [3] = 12 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[84] == 1 or R[84] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 } })[R[84]][R[59]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 19, [1] = 21, [2] = 98, [3] = 104 })[R[59]], ({ [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[84]][R[59]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 } })[R[84]][R[59]], ({ [1] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [2] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 } })[R[84]][R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 } })[R[84]][R[59]], ({ [1] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [2] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[84]][R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [1] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [2] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 } })[R[84]][R[59]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[84]", R[84])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[84]], player = players[4], at = { ({ [1] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [3] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 }, [4] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 } })[R[84]][R[59]], ({ [1] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [2] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [3] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [4] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[84]][R[59]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[84]], player = players[4], at = { ({ [1] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [3] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [4] = { [0] = 9, [1] = 11, [2] = 88, [3] = 94 } })[R[84]][R[59]], ({ [1] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [2] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [3] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [4] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 } })[R[84]][R[59]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [1] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [2] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [3] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [4] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 } })[R[84]][R[59]], ({ [1] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [2] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [3] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [4] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[84]][R[59]] }, direction = "East", lights = false, exact = true }[1]
      if R[84] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[59]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[84] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[59]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[84] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[59]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[84] == 4 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[59]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[84]", R[84])
      end
    elseif R[84] == 5 or R[84] == 6 or R[84] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [5] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [6] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [7] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 } })[R[84]][R[59]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [5] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [6] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [7] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 } })[R[84]][R[59]], ({ [5] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [6] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [7] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[84]][R[59]] }, direction = "East", lights = false, exact = true }[1]
      if R[84] == 5 or R[84] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [5] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [7] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[84]][R[59]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        if R[84] == 5 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[59]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[59]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[59]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif R[84] == 7 then
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
          unseen("R[84]", R[84])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [5] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [7] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[84]][R[59]], ({ [0] = 11, [1] = 113, [2] = 111, [3] = 13 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        if R[84] == 5 then
        elseif R[84] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 17, [1] = 19, [2] = 96, [3] = 102 })[R[59]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[84]", R[84])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[59]], ({ [5] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [7] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 } })[R[84]][R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[59]], ({ [5] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [7] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 } })[R[84]][R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [5] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [7] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[84]][R[59]], ({ [5] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 }, [7] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 } })[R[84]][R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[84] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[59]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[59]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[59]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[84]", R[84])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [5] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [6] = { [0] = 18, [1] = 20, [2] = 97, [3] = 103 }, [7] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 } })[R[84]][R[59]], ({ [5] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [6] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [7] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 } })[R[84]][R[59]] }, direction = "East", lights = false, exact = true }[1]
      if R[84] == 5 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[59]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[84] == 6 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[59]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[59]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[59]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[59]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[84] == 7 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[59]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[84]", R[84])
      end
    else
      unseen("R[84]", R[84])
    end
    U[#U]:set_lights(true)
    if R[84] == 0 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[59]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[59]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[59]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[84] == 1 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[59]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[59]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[59]], ({ [0] = 17, [1] = 119, [2] = 117, [3] = 19 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[84] == 2 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[59]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[59]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[59]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[84] == 3 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[59]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[59]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[59]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[84] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[59]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 10, [1] = 12, [2] = 89, [3] = 95 })[R[59]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[84] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[59]], ({ [0] = 13, [1] = 115, [2] = 113, [3] = 15 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[59]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[84] == 6 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[59]], ({ [0] = 14, [1] = 116, [2] = 114, [3] = 16 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 13, [1] = 15, [2] = 92, [3] = 98 })[R[59]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[59]], ({ [0] = 21, [1] = 123, [2] = 121, [3] = 23 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[59]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[59]], ({ [0] = 15, [1] = 117, [2] = 115, [3] = 17 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[59]], ({ [0] = 22, [1] = 124, [2] = 122, [3] = 24 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[59]], ({ [0] = 15, [1] = 117, [2] = 115, [3] = 17 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[84] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[59]], ({ [0] = 12, [1] = 114, [2] = 112, [3] = 14 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 21, [1] = 23, [2] = 100, [3] = 106 })[R[59]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[59]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[84]", R[84])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[84]], player = players[4], at = { ({ [0] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [3] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [4] = { [0] = 13, [1] = 15, [2] = 92, [3] = 98 }, [5] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [6] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [7] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[84]][R[59]], ({ [0] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 }, [3] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [4] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 }, [5] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [6] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [7] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 } })[R[84]][R[59]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[84]], player = players[4], at = { ({ [0] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [1] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [3] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [4] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [5] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 }, [6] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [7] = { [0] = 21, [1] = 23, [2] = 100, [3] = 106 } })[R[84]][R[59]], ({ [0] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [3] = { [0] = 12, [1] = 114, [2] = 112, [3] = 14 }, [4] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [5] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [6] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [7] = { [0] = 22, [1] = 124, [2] = 122, [3] = 24 } })[R[84]][R[59]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[84] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[85] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [1] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[85]][R[59]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 13, [1] = 115, [2] = 113, [3] = 15 }, [2] = { [0] = 19, [1] = 121, [2] = 119, [3] = 21 } })[R[85]][R[59]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[84] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[59]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[59]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 16, [2] = 93, [3] = 99 })[R[59]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[59]] })
        for i = 1, game.initial_units() do
          R[86] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [1] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [2] = { [0] = 17, [1] = 19, [2] = 96, [3] = 102 } })[R[86]][R[59]], ({ [0] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [1] = { [0] = 14, [1] = 116, [2] = 114, [3] = 16 }, [2] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 } })[R[86]][R[59]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[84] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[59]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[59]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[59]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[59]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[59]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[59]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[59]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[59]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[59]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[59]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[59]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[59]] })
        for i = 1, game.initial_units() do
          R[87] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [1] = { [0] = 11, [1] = 13, [2] = 90, [3] = 96 }, [2] = { [0] = 15, [1] = 17, [2] = 94, [3] = 100 } })[R[87]][R[59]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[87]][R[59]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[84] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[59]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[59]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[59]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[59]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[59]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[59]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[59]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[59]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[59]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[59]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 12, [1] = 14, [2] = 91, [3] = 97 })[R[59]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[59]] })
        game.create_tube({ ({ [0] = 15, [1] = 17, [2] = 94, [3] = 100 })[R[59]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[59]] })
        game.create_tube({ ({ [0] = 16, [1] = 18, [2] = 95, [3] = 101 })[R[59]], ({ [0] = 16, [1] = 118, [2] = 116, [3] = 18 })[R[59]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[59]], ({ [0] = 19, [1] = 121, [2] = 119, [3] = 21 })[R[59]] })
        game.create_tube({ ({ [0] = 18, [1] = 20, [2] = 97, [3] = 103 })[R[59]], ({ [0] = 20, [1] = 122, [2] = 120, [3] = 22 })[R[59]] })
        for i = 1, game.initial_units() do
          R[88] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [1] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [2] = { [0] = 12, [1] = 14, [2] = 91, [3] = 97 } })[R[88]][R[59]], ({ [0] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [1] = { [0] = 15, [1] = 117, [2] = 115, [3] = 17 }, [2] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 } })[R[88]][R[59]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[84] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[59]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[59]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 11, [1] = 13, [2] = 90, [3] = 96 })[R[59]], ({ [0] = 18, [1] = 120, [2] = 118, [3] = 20 })[R[59]] })
        for i = 1, game.initial_units() do
          R[89] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [1] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[89]][R[59]], ({ [0] = { [0] = 10, [1] = 112, [2] = 110, [3] = 12 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 } })[R[89]][R[59]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[84] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[90] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 } })[R[90]][R[59]], ({ [0] = { [0] = 21, [1] = 123, [2] = 121, [3] = 23 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[90]][R[59]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[84] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[91] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 }, [1] = { [0] = 19, [1] = 21, [2] = 98, [3] = 104 }, [2] = { [0] = 16, [1] = 18, [2] = 95, [3] = 101 } })[R[91]][R[59]], ({ [0] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 }, [1] = { [0] = 17, [1] = 119, [2] = 117, [3] = 19 }, [2] = { [0] = 18, [1] = 120, [2] = 118, [3] = 20 } })[R[91]][R[59]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[84] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[92] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 14, [1] = 16, [2] = 93, [3] = 99 }, [1] = { [0] = 10, [1] = 12, [2] = 89, [3] = 95 }, [2] = { [0] = 20, [1] = 22, [2] = 99, [3] = 105 } })[R[92]][R[59]], ({ [0] = { [0] = 20, [1] = 122, [2] = 120, [3] = 22 }, [1] = { [0] = 16, [1] = 118, [2] = 116, [3] = 18 }, [2] = { [0] = 11, [1] = 113, [2] = 111, [3] = 13 } })[R[92]][R[59]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[84]", R[84])
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
    trigger.time{min = 3600, max = 12000, one_shot = false, on = Quakes}  -- after 36 to 120 marks
    trigger.count{type = "MagmaVent", cargo = "None", compare = ">=", count = 1, one_shot = true, on = Lava}
  end
  return true
end
