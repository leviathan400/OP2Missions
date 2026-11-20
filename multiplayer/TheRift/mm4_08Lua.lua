-- mm4_08Lua.lua  -  4 Player, Midas, 'The Rift' map. (Lua)
--
-- Converted by op2dll from mm4_08.dll ("4 Player, Midas, 'The Rift' map."): its setup replayed. `on_init` makes the original's
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 193, 89 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 190, 124 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 71, 34 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 45, 57 } }
    R[0] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[0]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[0]] } }
    R[1] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[1]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[1]] } }
    R[2] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[2]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[2]] } }
    R[3] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[3]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 69 })[R[3]] } }
    R[4] = draw_avoid(8, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[4]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[4]] } }
    R[5] = draw_avoid(8, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[5]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[5]] } }
    R[6] = draw_avoid(8, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[6]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[6]] } }
    R[7] = draw_avoid(8, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[7]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 69 })[R[7]] } }
    R[8] = draw_avoid(8, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[8]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[8]] } }
    R[9] = draw_avoid(8, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[9]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[9]] } }
    R[10] = draw_avoid(8, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[10]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[10]] } }
    R[11] = draw_avoid(8, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[11]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 69 })[R[11]] } }
    R[12] = draw_avoid(8, { R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[12]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[12]] } }
    R[13] = draw_avoid(8, { R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[13]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[13]] } }
    R[14] = draw_avoid(8, { R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[14]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[14]] } }
    R[15] = draw_avoid(8, { R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[15]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 69 })[R[15]] } }
    R[16] = draw_avoid(8, { R[12], R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[16]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[16]] } }
    R[17] = draw_avoid(8, { R[13], R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[17]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[17]] } }
    R[18] = draw_avoid(8, { R[14], R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[18]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[18]] } }
    R[19] = draw_avoid(8, { R[15], R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[19]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 69 })[R[19]] } }
    R[20] = game.rand(4)
    R[21] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 50, [1] = 23, [2] = 172, [3] = 244 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 48, [1] = 19, [2] = 170, [3] = 239 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 6, [1] = 45, [2] = 108, [3] = 88 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 20, [1] = 59, [2] = 111, [3] = 94 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 50, [1] = 23, [2] = 172, [3] = 244 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 48, [1] = 19, [2] = 170, [3] = 239 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 6, [1] = 45, [2] = 108, [3] = 88 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 20, [1] = 59, [2] = 111, [3] = 94 } })[R[21]][R[20]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 39, [1] = 12, [2] = 164, [3] = 233 }, [3] = { [0] = 58, [1] = 31, [2] = 172, [3] = 252 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 41, [1] = 12, [2] = 179, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 11, [1] = 42, [2] = 97, [3] = 82 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 23, [1] = 62, [2] = 126, [3] = 102 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    if R[21] == 0 or R[21] == 1 or R[21] == 2 or R[21] == 5 or R[21] == 6 or R[21] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 62, [1] = 42, [2] = 187, [3] = 253 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 42, [1] = 15, [2] = 167, [3] = 236 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 48, [1] = 21, [2] = 180, [3] = 242 }, [7] = { [0] = 41, [1] = 12, [2] = 180, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 18, [1] = 49, [2] = 104, [3] = 89 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [5] = { [0] = 23, [1] = 65, [2] = 124, [3] = 101 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[21] == 0 then
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
      elseif R[21] == 1 then
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
      elseif R[21] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[20]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[20]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[20]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[20]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[20]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[20]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[21]", R[21])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 39, [1] = 19, [2] = 164, [3] = 230 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 39, [1] = 12, [2] = 171, [3] = 233 }, [7] = { [0] = 57, [1] = 28, [2] = 171, [3] = 248 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 28, [1] = 59, [2] = 114, [3] = 99 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 25, [1] = 64, [2] = 119, [3] = 99 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[21] == 2 or R[21] == 5 or R[21] == 6 or R[21] == 7 then
      elseif R[21] == 0 or R[21] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 } })[R[21]][R[20]], ({ [0] = { [0] = 27, [1] = 65, [2] = 120, [3] = 103 }, [1] = { [0] = 36, [1] = 67, [2] = 122, [3] = 107 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[21]", R[21])
      end
    elseif R[21] == 3 or R[21] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 } })[R[21]][R[20]], ({ [3] = { [0] = 23, [1] = 62, [2] = 110, [3] = 102 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[21] == 3 then
        if R[20] == 0 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 45, 12 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 45, 12 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 45, 12 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[20] == 1 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 18, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 18, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 18, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[20] == 2 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 183, 122 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 183, 122 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 183, 122 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[20] == 3 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 239, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 239, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 239, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[20]", R[20])
        end
      elseif R[21] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 122, [3] = 100 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 122, [3] = 100 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 122, [3] = 100 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[21]", R[21])
      end
    else
      unseen("R[21]", R[21])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 39, [1] = 19, [2] = 164, [3] = 230 }, [1] = { [0] = 48, [1] = 21, [2] = 163, [3] = 238 }, [2] = { [0] = 59, [1] = 32, [2] = 184, [3] = 253 }, [3] = { [0] = 51, [1] = 24, [2] = 164, [3] = 245 }, [4] = { [0] = 33, [1] = 10, [2] = 164, [3] = 229 }, [5] = { [0] = 34, [1] = 8, [2] = 164, [3] = 219 }, [6] = { [0] = 31, [1] = 4, [2] = 163, [3] = 225 }, [7] = { [0] = 49, [1] = 20, [2] = 163, [3] = 240 } })[R[21]][R[20]], ({ [0] = { [0] = 29, [1] = 67, [2] = 122, [3] = 105 }, [1] = { [0] = 33, [1] = 64, [2] = 119, [3] = 104 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 6, [1] = 45, [2] = 114, [3] = 85 }, [4] = { [0] = 12, [1] = 50, [2] = 114, [3] = 92 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 29, [1] = 68, [2] = 119, [3] = 103 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 46, [1] = 26, [2] = 171, [3] = 237 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 40, [1] = 13, [2] = 182, [3] = 234 }, [4] = { [0] = 51, [1] = 28, [2] = 182, [3] = 247 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 59, [1] = 30, [2] = 170, [3] = 250 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 15, [1] = 54, [2] = 117, [3] = 97 }, [3] = { [0] = 13, [1] = 52, [2] = 118, [3] = 92 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 9, [1] = 51, [2] = 110, [3] = 87 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 20, [1] = 59, [2] = 124, [3] = 94 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 43, [1] = 16, [2] = 184, [3] = 237 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 17, [1] = 48, [2] = 103, [3] = 88 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 9, [1] = 48, [2] = 118, [3] = 88 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 60, [1] = 33, [2] = 176, [3] = 254 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 31, [2] = 176, [3] = 252 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 9, [1] = 48, [2] = 126, [3] = 88 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 184, [3] = 240 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 24, [1] = 63, [2] = 118, [3] = 103 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 184, [3] = 240 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 24, [1] = 63, [2] = 118, [3] = 103 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 40, [1] = 13, [2] = 176, [3] = 234 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "RoboSurveyor", [3] = "CargoTruck" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 40, [1] = 13, [2] = 177, [3] = 234 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 39, [1] = 13, [2] = 169, [3] = 224 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 43, [1] = 14, [2] = 175, [3] = 234 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 19, [1] = 58, [2] = 121, [3] = 101 }, [3] = { [0] = 13, [1] = 52, [2] = 122, [3] = 92 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 8, [1] = 50, [2] = 109, [3] = 86 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 20, [1] = 59, [2] = 121, [3] = 94 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [3] = { [0] = 46, [1] = 19, [2] = 179, [3] = 240 }, [4] = { [0] = 48, [1] = 25, [2] = 179, [3] = 244 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 38, [1] = 9, [2] = 184, [3] = 229 } })[R[21]][R[20]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 10, [1] = 41, [2] = 96, [3] = 81 }, [2] = { [0] = 20, [1] = 59, [2] = 122, [3] = 102 }, [3] = { [0] = 24, [1] = 63, [2] = 113, [3] = 103 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 12, [1] = 54, [2] = 118, [3] = 96 }, [7] = { [0] = 17, [1] = 56, [2] = 118, [3] = 91 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 60, [1] = 33, [2] = 176, [3] = 254 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 31, [2] = 176, [3] = 252 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 9, [1] = 48, [2] = 126, [3] = 88 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboSurveyor", [3] = "ConVec" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 177, [3] = 240 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 39, [1] = 13, [2] = 169, [3] = 224 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 43, [1] = 14, [2] = 175, [3] = 234 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 19, [1] = 58, [2] = 121, [3] = 101 }, [3] = { [0] = 24, [1] = 63, [2] = 122, [3] = 103 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 8, [1] = 50, [2] = 109, [3] = 86 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 20, [1] = 59, [2] = 121, [3] = 94 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [3] = { [0] = 46, [1] = 19, [2] = 179, [3] = 240 }, [4] = { [0] = 48, [1] = 25, [2] = 179, [3] = 244 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 38, [1] = 9, [2] = 184, [3] = 229 } })[R[21]][R[20]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 10, [1] = 41, [2] = 96, [3] = 81 }, [2] = { [0] = 20, [1] = 59, [2] = 122, [3] = 102 }, [3] = { [0] = 24, [1] = 63, [2] = 113, [3] = 103 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 12, [1] = 54, [2] = 118, [3] = 96 }, [7] = { [0] = 17, [1] = 56, [2] = 118, [3] = 91 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 60, [1] = 33, [2] = 176, [3] = 254 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 31, [2] = 176, [3] = 252 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 9, [1] = 48, [2] = 126, [3] = 88 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 184, [3] = 240 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 24, [1] = 63, [2] = 118, [3] = 103 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 46, [1] = 19, [2] = 176, [3] = 240 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 24, [1] = 63, [2] = 126, [3] = 103 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "RoboSurveyor", [3] = "CargoTruck" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 40, [1] = 13, [2] = 177, [3] = 234 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 39, [1] = 13, [2] = 169, [3] = 224 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 43, [1] = 14, [2] = 175, [3] = 234 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 19, [1] = 58, [2] = 121, [3] = 101 }, [3] = { [0] = 13, [1] = 52, [2] = 122, [3] = 92 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 8, [1] = 50, [2] = 109, [3] = 86 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 20, [1] = 59, [2] = 121, [3] = 94 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [3] = { [0] = 46, [1] = 19, [2] = 179, [3] = 240 }, [4] = { [0] = 48, [1] = 25, [2] = 179, [3] = 244 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 38, [1] = 9, [2] = 184, [3] = 229 } })[R[21]][R[20]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 10, [1] = 41, [2] = 96, [3] = 81 }, [2] = { [0] = 20, [1] = 59, [2] = 122, [3] = 102 }, [3] = { [0] = 24, [1] = 63, [2] = 113, [3] = 103 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 12, [1] = 54, [2] = 118, [3] = 96 }, [7] = { [0] = 17, [1] = 56, [2] = 118, [3] = 91 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 62, [1] = 42, [2] = 187, [3] = 253 }, [1] = { [0] = 56, [1] = 29, [2] = 171, [3] = 246 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 50, [1] = 23, [2] = 185, [3] = 244 }, [4] = { [0] = 54, [1] = 31, [2] = 185, [3] = 250 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 52, [1] = 23, [2] = 184, [3] = 243 } })[R[21]][R[20]], ({ [0] = { [0] = 24, [1] = 62, [2] = 117, [3] = 100 }, [1] = { [0] = 23, [1] = 54, [2] = 109, [3] = 94 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 10, [1] = 49, [2] = 109, [3] = 89 }, [4] = { [0] = 7, [1] = 45, [2] = 109, [3] = 87 }, [5] = { [0] = 25, [1] = 67, [2] = 126, [3] = 103 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 19, [1] = 58, [2] = 121, [3] = 93 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 22, [2] = 167, [3] = 233 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 42, [1] = 15, [2] = 167, [3] = 236 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 19, [1] = 58, [2] = 112, [3] = 98 }, [4] = { [0] = 10, [1] = 48, [2] = 112, [3] = 90 }, [5] = { [0] = 14, [1] = 56, [2] = 115, [3] = 92 }, [6] = { [0] = 7, [1] = 49, [2] = 113, [3] = 91 }, [7] = { [0] = 16, [1] = 55, [2] = 113, [3] = 90 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 43, [1] = 23, [2] = 168, [3] = 234 }, [1] = { [0] = 51, [1] = 24, [2] = 166, [3] = 241 }, [2] = { [0] = 43, [1] = 16, [2] = 168, [3] = 237 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 20, [1] = 59, [2] = 113, [3] = 99 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 15, [1] = 57, [2] = 116, [3] = 93 }, [6] = { [0] = 8, [1] = 50, [2] = 114, [3] = 92 }, [7] = { [0] = 17, [1] = 56, [2] = 114, [3] = 91 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 52, [1] = 25, [2] = 167, [3] = 242 }, [2] = { [0] = 44, [1] = 17, [2] = 169, [3] = 238 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 21, [1] = 60, [2] = 114, [3] = 100 }, [4] = { [0] = 12, [1] = 50, [2] = 114, [3] = 92 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 9, [1] = 51, [2] = 115, [3] = 93 }, [7] = { [0] = 18, [1] = 57, [2] = 115, [3] = 92 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 25, [2] = 170, [3] = 236 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 43, [1] = 16, [2] = 172, [3] = 237 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 8, [1] = 47, [2] = 110, [3] = 90 }, [3] = { [0] = 19, [1] = 58, [2] = 115, [3] = 98 }, [4] = { [0] = 13, [1] = 51, [2] = 115, [3] = 93 }, [5] = { [0] = 20, [1] = 62, [2] = 121, [3] = 98 }, [6] = { [0] = 10, [1] = 52, [2] = 116, [3] = 94 }, [7] = { [0] = 19, [1] = 58, [2] = 116, [3] = 93 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 26, [2] = 171, [3] = 237 }, [1] = { [0] = 54, [1] = 27, [2] = 169, [3] = 244 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 9, [1] = 48, [2] = 111, [3] = 91 }, [3] = { [0] = 15, [1] = 54, [2] = 116, [3] = 94 }, [4] = { [0] = 14, [1] = 52, [2] = 116, [3] = 94 }, [5] = { [0] = 21, [1] = 63, [2] = 122, [3] = 99 }, [6] = { [0] = 11, [1] = 53, [2] = 117, [3] = 95 }, [7] = { [0] = 20, [1] = 59, [2] = 117, [3] = 94 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 27, [2] = 172, [3] = 238 }, [1] = { [0] = 55, [1] = 28, [2] = 170, [3] = 245 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 41, [1] = 14, [2] = 173, [3] = 235 }, [7] = { [0] = 41, [1] = 12, [2] = 173, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 10, [1] = 49, [2] = 112, [3] = 92 }, [3] = { [0] = 16, [1] = 55, [2] = 120, [3] = 95 }, [4] = { [0] = 18, [1] = 56, [2] = 120, [3] = 98 }, [5] = { [0] = 22, [1] = 64, [2] = 123, [3] = 100 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 21, [1] = 60, [2] = 111, [3] = 95 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 28, [2] = 173, [3] = 239 }, [1] = { [0] = 56, [1] = 29, [2] = 171, [3] = 246 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 47, [1] = 21, [2] = 177, [3] = 232 }, [6] = { [0] = 42, [1] = 15, [2] = 174, [3] = 236 }, [7] = { [0] = 41, [1] = 12, [2] = 174, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 17, [1] = 56, [2] = 121, [3] = 96 }, [4] = { [0] = 19, [1] = 57, [2] = 121, [3] = 99 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 22, [1] = 61, [2] = 111, [3] = 96 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 47, [1] = 21, [2] = 177, [3] = 232 }, [6] = { [0] = 42, [1] = 15, [2] = 174, [3] = 236 }, [7] = { [0] = 41, [1] = 12, [2] = 174, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 15, [1] = 53, [2] = 108, [3] = 91 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 12, [1] = 51, [2] = 114, [3] = 94 }, [3] = { [0] = 18, [1] = 57, [2] = 122, [3] = 97 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 23, [1] = 62, [2] = 119, [3] = 97 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 41, [1] = 12, [2] = 175, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 14, [1] = 45, [2] = 100, [3] = 85 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 19, [1] = 58, [2] = 123, [3] = 98 }, [4] = { [0] = 21, [1] = 59, [2] = 123, [3] = 101 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 24, [1] = 63, [2] = 111, [3] = 98 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 45, [1] = 18, [2] = 172, [3] = 239 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 44, [1] = 15, [2] = 175, [3] = 235 } })[R[21]][R[20]], ({ [0] = { [0] = 17, [1] = 55, [2] = 110, [3] = 93 }, [1] = { [0] = 15, [1] = 46, [2] = 101, [3] = 86 }, [2] = { [0] = 14, [1] = 53, [2] = 116, [3] = 96 }, [3] = { [0] = 15, [1] = 54, [2] = 124, [3] = 94 }, [4] = { [0] = 22, [1] = 60, [2] = 124, [3] = 102 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 45, [1] = 18, [2] = 175, [3] = 239 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 49, [1] = 23, [2] = 179, [3] = 234 }, [6] = { [0] = 44, [1] = 17, [2] = 176, [3] = 238 }, [7] = { [0] = 44, [1] = 15, [2] = 176, [3] = 235 } })[R[21]][R[20]], ({ [0] = { [0] = 18, [1] = 56, [2] = 111, [3] = 94 }, [1] = { [0] = 16, [1] = 47, [2] = 102, [3] = 87 }, [2] = { [0] = 15, [1] = 54, [2] = 117, [3] = 97 }, [3] = { [0] = 19, [1] = 58, [2] = 110, [3] = 98 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 46, [1] = 19, [2] = 175, [3] = 240 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 49, [1] = 23, [2] = 179, [3] = 234 }, [6] = { [0] = 44, [1] = 17, [2] = 176, [3] = 238 }, [7] = { [0] = 45, [1] = 16, [2] = 176, [3] = 236 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 47, [1] = 20, [2] = 175, [3] = 241 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [6] = { [0] = 45, [1] = 18, [2] = 177, [3] = 239 }, [7] = { [0] = 45, [1] = 16, [2] = 177, [3] = 236 } })[R[21]][R[20]], ({ [0] = { [0] = 23, [1] = 61, [2] = 116, [3] = 99 }, [1] = { [0] = 21, [1] = 52, [2] = 107, [3] = 92 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 19, [1] = 58, [2] = 126, [3] = 98 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 46, [1] = 19, [2] = 171, [3] = 240 }, [3] = { [0] = 48, [1] = 21, [2] = 176, [3] = 242 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [6] = { [0] = 45, [1] = 18, [2] = 177, [3] = 239 }, [7] = { [0] = 46, [1] = 17, [2] = 177, [3] = 237 } })[R[21]][R[20]], ({ [0] = { [0] = 24, [1] = 62, [2] = 117, [3] = 100 }, [1] = { [0] = 22, [1] = 53, [2] = 108, [3] = 93 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 110, [3] = 91 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 46, [1] = 19, [2] = 171, [3] = 240 }, [3] = { [0] = 48, [1] = 21, [2] = 176, [3] = 242 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 51, [1] = 25, [2] = 181, [3] = 236 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 46, [1] = 17, [2] = 179, [3] = 237 } })[R[21]][R[20]], ({ [0] = { [0] = 25, [1] = 63, [2] = 118, [3] = 101 }, [1] = { [0] = 23, [1] = 54, [2] = 109, [3] = 94 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 7, [1] = 49, [2] = 113, [3] = 91 }, [7] = { [0] = 26, [1] = 65, [2] = 113, [3] = 100 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 53, [1] = 33, [2] = 178, [3] = 244 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 49, [1] = 22, [2] = 176, [3] = 243 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 51, [1] = 25, [2] = 181, [3] = 236 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 47, [1] = 18, [2] = 179, [3] = 238 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 126, [3] = 91 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 8, [1] = 50, [2] = 114, [3] = 92 }, [7] = { [0] = 13, [1] = 52, [2] = 114, [3] = 87 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 54, [1] = 34, [2] = 179, [3] = 245 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 50, [1] = 23, [2] = 177, [3] = 244 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 47, [1] = 18, [2] = 179, [3] = 238 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 25, [1] = 56, [2] = 111, [3] = 96 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 12, [1] = 51, [2] = 110, [3] = 91 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 9, [1] = 51, [2] = 115, [3] = 93 }, [7] = { [0] = 26, [1] = 65, [2] = 115, [3] = 100 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 48, [1] = 21, [2] = 173, [3] = 242 }, [3] = { [0] = 51, [1] = 24, [2] = 177, [3] = 245 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 53, [1] = 27, [2] = 183, [3] = 238 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 48, [1] = 19, [2] = 179, [3] = 239 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 26, [1] = 57, [2] = 112, [3] = 97 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 111, [3] = 91 }, [4] = { [0] = 9, [1] = 47, [2] = 111, [3] = 89 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 10, [1] = 52, [2] = 116, [3] = 94 }, [7] = { [0] = 13, [1] = 52, [2] = 116, [3] = 87 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 56, [1] = 36, [2] = 181, [3] = 247 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 48, [1] = 21, [2] = 173, [3] = 242 }, [3] = { [0] = 52, [1] = 25, [2] = 177, [3] = 246 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 48, [1] = 19, [2] = 179, [3] = 239 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 31, [1] = 62, [2] = 117, [3] = 102 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 12, [1] = 51, [2] = 118, [3] = 91 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 11, [1] = 53, [2] = 117, [3] = 95 }, [7] = { [0] = 14, [1] = 53, [2] = 117, [3] = 88 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 57, [1] = 37, [2] = 182, [3] = 248 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 49, [1] = 22, [2] = 174, [3] = 243 }, [3] = { [0] = 53, [1] = 26, [2] = 177, [3] = 247 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 48, [1] = 19, [2] = 183, [3] = 239 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 32, [1] = 63, [2] = 118, [3] = 103 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 126, [3] = 91 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 15, [1] = 54, [2] = 119, [3] = 89 } })[R[21]][R[20]] })
    if R[21] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 58, [1] = 38, [2] = 183, [3] = 249 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 59, [1] = 39, [2] = 184, [3] = 250 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 58, [1] = 38, [2] = 183, [3] = 249 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 59, [1] = 39, [2] = 184, [3] = 250 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[20]] })
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 56, [1] = 36, [2] = 181, [3] = 247 }, [1] = { [0] = 43, [1] = 23, [2] = 168, [3] = 234 }, [2] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 } })[R[22]][R[20]], ({ [0] = { [0] = 14, [1] = 52, [2] = 107, [3] = 90 }, [1] = { [0] = 23, [1] = 61, [2] = 116, [3] = 99 }, [2] = { [0] = 26, [1] = 64, [2] = 119, [3] = 102 } })[R[22]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 34, [1] = 65, [2] = 120, [3] = 105 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 34, [1] = 65, [2] = 120, [3] = 105 })[R[20]] })
        for i = 1, game.initial_units() do
          R[23] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 49, [1] = 22, [2] = 164, [3] = 239 }, [1] = { [0] = 51, [1] = 24, [2] = 166, [3] = 241 }, [2] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 } })[R[23]][R[20]], ({ [0] = { [0] = 28, [1] = 59, [2] = 114, [3] = 99 }, [1] = { [0] = 30, [1] = 61, [2] = 116, [3] = 101 }, [2] = { [0] = 22, [1] = 53, [2] = 108, [3] = 93 } })[R[23]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[24] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 40, [1] = 13, [2] = 165, [3] = 234 }, [1] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [2] = { [0] = 58, [1] = 31, [2] = 183, [3] = 252 } })[R[24]][R[20]], ({ [0] = { [0] = 5, [1] = 44, [2] = 107, [3] = 87 }, [1] = { [0] = 21, [1] = 60, [2] = 123, [3] = 103 }, [2] = { [0] = 14, [1] = 53, [2] = 116, [3] = 96 } })[R[24]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 3 then
      game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 178, [3] = 247 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 111, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 178, [3] = 248 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 112, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 55, [1] = 28, [2] = 178, [3] = 249 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 118, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 56, [1] = 29, [2] = 178, [3] = 250 })[R[20]], ({ [0] = 15, [1] = 54, [2] = 126, [3] = 94 })[R[20]] })
      game.create_tube({ ({ [0] = 56, [1] = 29, [2] = 179, [3] = 250 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 112, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 179, [3] = 251 })[R[20]], ({ [0] = 15, [1] = 54, [2] = 118, [3] = 94 })[R[20]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 179, [3] = 251 })[R[20]], ({ [0] = 16, [1] = 55, [2] = 126, [3] = 95 })[R[20]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[20]], ({ [0] = 17, [1] = 56, [2] = 112, [3] = 96 })[R[20]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[20]], ({ [0] = 18, [1] = 57, [2] = 118, [3] = 97 })[R[20]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 126, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 181, [3] = 252 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 117, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 181, [3] = 252 })[R[20]], ({ [0] = 20, [1] = 59, [2] = 118, [3] = 99 })[R[20]] })
      if R[20] == 0 then
        if game.initial_units() == 0 then
          game.create_tube({ 58, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 58, 21 })
          for i = 1, game.initial_units() do
            R[25] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 51, [1] = 52, [2] = 39 })[R[25]], ({ [0] = 15, [1] = 22, [2] = 19 })[R[25]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 1 then
        if game.initial_units() == 0 then
          game.create_tube({ 31, 60 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 31, 60 })
          for i = 1, game.initial_units() do
            R[26] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 24, [1] = 25, [2] = 12 })[R[26]], ({ [0] = 54, [1] = 61, [2] = 58 })[R[26]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 2 then
        if game.initial_units() == 0 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
          for i = 1, game.initial_units() do
            R[27] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 176, [1] = 167, [2] = 175 })[R[27]], ({ [0] = 109, [1] = 117, [2] = 112 })[R[27]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 3 then
        if game.initial_units() == 0 then
          game.create_tube({ 252, 100 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 252, 100 })
          for i = 1, game.initial_units() do
            R[28] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 245, [1] = 246, [2] = 233 })[R[28]], ({ [0] = 94, [1] = 101, [2] = 98 })[R[28]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[20]", R[20])
      end
    elseif R[21] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 9, [1] = 47, [2] = 111, [3] = 89 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 17, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 18, [1] = 56, [2] = 120, [3] = 98 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 13, [1] = 51, [2] = 115, [3] = 93 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 14, [1] = 52, [2] = 116, [3] = 94 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 9, [1] = 47, [2] = 111, [3] = 89 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 17, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 18, [1] = 56, [2] = 120, [3] = 98 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 13, [1] = 51, [2] = 115, [3] = 93 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 14, [1] = 52, [2] = 116, [3] = 94 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [1] = { [0] = 36, [1] = 13, [2] = 167, [3] = 232 }, [2] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 } })[R[29]][R[20]], ({ [0] = { [0] = 7, [1] = 45, [2] = 109, [3] = 87 }, [1] = { [0] = 15, [1] = 53, [2] = 117, [3] = 95 }, [2] = { [0] = 10, [1] = 48, [2] = 112, [3] = 90 } })[R[29]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 20, [1] = 62, [2] = 121, [3] = 98 })[R[20]] })
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 21, [1] = 63, [2] = 122, [3] = 99 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 20, [1] = 62, [2] = 121, [3] = 98 })[R[20]] })
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 21, [1] = 63, [2] = 122, [3] = 99 })[R[20]] })
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [1] = { [0] = 33, [1] = 7, [2] = 163, [3] = 218 }, [2] = { [0] = 55, [1] = 29, [2] = 185, [3] = 240 } })[R[30]][R[20]], ({ [0] = { [0] = 27, [1] = 69, [2] = 128, [3] = 105 }, [1] = { [0] = 14, [1] = 56, [2] = 115, [3] = 92 }, [2] = { [0] = 27, [1] = 69, [2] = 128, [3] = 105 } })[R[30]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 52, [1] = 25, [2] = 184, [3] = 246 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 185, [3] = 247 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 186, [3] = 248 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 52, [1] = 25, [2] = 184, [3] = 246 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 185, [3] = 247 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 186, [3] = 248 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 33, [1] = 6, [2] = 165, [3] = 227 }, [1] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [2] = { [0] = 59, [1] = 32, [2] = 191, [3] = 253 } })[R[31]][R[20]], ({ [0] = { [0] = 3, [1] = 45, [2] = 109, [3] = 87 }, [1] = { [0] = 1, [1] = 43, [2] = 107, [3] = 85 }, [2] = { [0] = 16, [1] = 58, [2] = 122, [3] = 100 } })[R[31]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 7 then
      game.create_tube({ ({ [0] = 48, [1] = 19, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 16, [1] = 55, [2] = 119, [3] = 90 })[R[20]] })
      game.create_tube({ ({ [0] = 48, [1] = 19, [2] = 185, [3] = 239 })[R[20]], ({ [0] = 17, [1] = 56, [2] = 119, [3] = 91 })[R[20]] })
      if R[20] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
          for i = 1, game.initial_units() do
            R[32] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 46, [1] = 52, [2] = 40 })[R[32]], ({ [0] = 9, [1] = 9, [2] = 30 })[R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
          for i = 1, game.initial_units() do
            R[33] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 17, [1] = 23, [2] = 11 })[R[33]], ({ [0] = 48, [1] = 48, [2] = 69 })[R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 2 then
        if game.initial_units() == 0 then
          game.create_tube({ 186, 119 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 186, 119 })
          for i = 1, game.initial_units() do
            R[34] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 165, [1] = 170, [2] = 191 })[R[34]], ({ [0] = 109, [1] = 107, [2] = 122 })[R[34]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
          for i = 1, game.initial_units() do
            R[35] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 237, [1] = 243, [2] = 231 })[R[35]], ({ [0] = 83, [1] = 83, [2] = 104 })[R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[20]", R[20])
      end
    else
      unseen("R[21]", R[21])
    end
    R[36] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 30, [1] = 50, [2] = 241, [3] = 175 }, [1] = { [0] = 20, [1] = 47, [2] = 237, [3] = 162 }, [2] = { [0] = 18, [1] = 45, [2] = 239, [3] = 170 }, [3] = { [0] = 23, [1] = 50, [2] = 244, [3] = 172 }, [4] = { [0] = 18, [1] = 41, [2] = 237, [3] = 172 }, [5] = { [0] = 18, [1] = 44, [2] = 229, [3] = 174 }, [6] = { [0] = 11, [1] = 38, [2] = 232, [3] = 170 }, [7] = { [0] = 19, [1] = 48, [2] = 239, [3] = 170 } })[R[36]][R[20]], ({ [0] = { [0] = 58, [1] = 20, [2] = 96, [3] = 113 }, [1] = { [0] = 55, [1] = 24, [2] = 95, [3] = 110 }, [2] = { [0] = 45, [1] = 6, [2] = 88, [3] = 108 }, [3] = { [0] = 58, [1] = 19, [2] = 98, [3] = 118 }, [4] = { [0] = 54, [1] = 16, [2] = 96, [3] = 118 }, [5] = { [0] = 60, [1] = 18, [2] = 96, [3] = 119 }, [6] = { [0] = 47, [1] = 5, [2] = 89, [3] = 111 }, [7] = { [0] = 59, [1] = 20, [2] = 94, [3] = 111 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 30, [1] = 50, [2] = 241, [3] = 175 }, [1] = { [0] = 20, [1] = 47, [2] = 237, [3] = 162 }, [2] = { [0] = 18, [1] = 45, [2] = 239, [3] = 170 }, [3] = { [0] = 23, [1] = 50, [2] = 244, [3] = 172 }, [4] = { [0] = 18, [1] = 41, [2] = 237, [3] = 172 }, [5] = { [0] = 18, [1] = 44, [2] = 229, [3] = 174 }, [6] = { [0] = 11, [1] = 38, [2] = 232, [3] = 170 }, [7] = { [0] = 19, [1] = 48, [2] = 239, [3] = 170 } })[R[36]][R[20]], ({ [0] = { [0] = 58, [1] = 20, [2] = 96, [3] = 113 }, [1] = { [0] = 55, [1] = 24, [2] = 95, [3] = 110 }, [2] = { [0] = 45, [1] = 6, [2] = 88, [3] = 108 }, [3] = { [0] = 58, [1] = 19, [2] = 98, [3] = 118 }, [4] = { [0] = 54, [1] = 16, [2] = 96, [3] = 118 }, [5] = { [0] = 60, [1] = 18, [2] = 96, [3] = 119 }, [6] = { [0] = 47, [1] = 5, [2] = 89, [3] = 111 }, [7] = { [0] = 59, [1] = 20, [2] = 94, [3] = 111 } })[R[36]][R[20]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 30, [1] = 50, [2] = 241, [3] = 175 }, [1] = { [0] = 30, [1] = 57, [2] = 247, [3] = 172 }, [2] = { [0] = 12, [1] = 39, [2] = 233, [3] = 164 }, [3] = { [0] = 31, [1] = 58, [2] = 252, [3] = 172 }, [4] = { [0] = 18, [1] = 41, [2] = 237, [3] = 172 }, [5] = { [0] = 18, [1] = 44, [2] = 229, [3] = 174 }, [6] = { [0] = 20, [1] = 47, [2] = 241, [3] = 179 }, [7] = { [0] = 12, [1] = 41, [2] = 232, [3] = 179 } })[R[36]][R[20]], ({ [0] = { [0] = 51, [1] = 13, [2] = 89, [3] = 106 }, [1] = { [0] = 42, [1] = 11, [2] = 82, [3] = 97 }, [2] = { [0] = 50, [1] = 11, [2] = 93, [3] = 113 }, [3] = { [0] = 62, [1] = 23, [2] = 102, [3] = 126 }, [4] = { [0] = 62, [1] = 24, [2] = 104, [3] = 126 }, [5] = { [0] = 66, [1] = 24, [2] = 102, [3] = 125 }, [6] = { [0] = 47, [1] = 5, [2] = 89, [3] = 111 }, [7] = { [0] = 65, [1] = 26, [2] = 100, [3] = 111 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    if R[36] == 0 or R[36] == 1 or R[36] == 2 or R[36] == 5 or R[36] == 6 or R[36] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 62, [2] = 253, [3] = 187 }, [1] = { [0] = 31, [1] = 58, [2] = 248, [3] = 173 }, [2] = { [0] = 15, [1] = 42, [2] = 236, [3] = 167 }, [5] = { [0] = 28, [1] = 54, [2] = 239, [3] = 184 }, [6] = { [0] = 21, [1] = 48, [2] = 242, [3] = 180 }, [7] = { [0] = 12, [1] = 41, [2] = 232, [3] = 180 } })[R[36]][R[20]], ({ [0] = { [0] = 58, [1] = 20, [2] = 96, [3] = 113 }, [1] = { [0] = 49, [1] = 18, [2] = 89, [3] = 104 }, [2] = { [0] = 56, [1] = 17, [2] = 99, [3] = 119 }, [5] = { [0] = 65, [1] = 23, [2] = 101, [3] = 124 }, [6] = { [0] = 55, [1] = 13, [2] = 97, [3] = 119 }, [7] = { [0] = 52, [1] = 13, [2] = 87, [3] = 119 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[36] == 0 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 19, [1] = 39, [2] = 230, [3] = 164 })[R[20]], ({ [0] = 58, [1] = 20, [2] = 96, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 19, [1] = 39, [2] = 230, [3] = 164 })[R[20]], ({ [0] = 58, [1] = 20, [2] = 96, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 19, [1] = 39, [2] = 230, [3] = 164 })[R[20]], ({ [0] = 58, [1] = 20, [2] = 96, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[36] == 1 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 31, [1] = 58, [2] = 248, [3] = 173 })[R[20]], ({ [0] = 59, [1] = 28, [2] = 99, [3] = 114 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 31, [1] = 58, [2] = 248, [3] = 173 })[R[20]], ({ [0] = 59, [1] = 28, [2] = 99, [3] = 114 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 31, [1] = 58, [2] = 248, [3] = 173 })[R[20]], ({ [0] = 59, [1] = 28, [2] = 99, [3] = 114 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[36] == 2 then
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
      elseif R[36] == 5 then
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
      elseif R[36] == 6 then
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
      elseif R[36] == 7 then
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
        unseen("R[36]", R[36])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 30, [1] = 50, [2] = 241, [3] = 175 }, [1] = { [0] = 30, [1] = 57, [2] = 247, [3] = 172 }, [2] = { [0] = 24, [1] = 51, [2] = 245, [3] = 176 }, [5] = { [0] = 28, [1] = 54, [2] = 239, [3] = 184 }, [6] = { [0] = 29, [1] = 56, [2] = 250, [3] = 188 }, [7] = { [0] = 27, [1] = 56, [2] = 247, [3] = 188 } })[R[36]][R[20]], ({ [0] = { [0] = 65, [1] = 27, [2] = 103, [3] = 120 }, [1] = { [0] = 67, [1] = 36, [2] = 107, [3] = 122 }, [2] = { [0] = 50, [1] = 11, [2] = 93, [3] = 113 }, [5] = { [0] = 58, [1] = 16, [2] = 94, [3] = 117 }, [6] = { [0] = 55, [1] = 13, [2] = 97, [3] = 119 }, [7] = { [0] = 52, [1] = 13, [2] = 87, [3] = 119 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[36] == 2 or R[36] == 5 or R[36] == 6 or R[36] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [2] = { [0] = 24, [1] = 51, [2] = 245, [3] = 176 }, [5] = { [0] = 18, [1] = 44, [2] = 229, [3] = 174 }, [6] = { [0] = 12, [1] = 39, [2] = 233, [3] = 171 }, [7] = { [0] = 28, [1] = 57, [2] = 248, [3] = 171 } })[R[36]][R[20]], ({ [2] = { [0] = 56, [1] = 17, [2] = 99, [3] = 119 }, [5] = { [0] = 53, [1] = 11, [2] = 89, [3] = 112 }, [6] = { [0] = 55, [1] = 13, [2] = 97, [3] = 119 }, [7] = { [0] = 64, [1] = 25, [2] = 99, [3] = 119 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[36] == 0 or R[36] == 1 then
      else
        unseen("R[36]", R[36])
      end
    elseif R[36] == 3 or R[36] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [3] = { [0] = 15, [1] = 42, [2] = 236, [3] = 172 }, [4] = { [0] = 18, [1] = 41, [2] = 237, [3] = 172 } })[R[36]][R[20]], ({ [3] = { [0] = 62, [1] = 23, [2] = 102, [3] = 110 }, [4] = { [0] = 46, [1] = 8, [2] = 88, [3] = 110 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[36] == 3 then
        if R[20] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
        elseif R[20] == 0 or R[20] == 1 or R[20] == 2 then
        else
          unseen("R[20]", R[20])
        end
      elseif R[36] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 29, [1] = 52, [2] = 248, [3] = 183 })[R[20]], ({ [0] = 48, [1] = 10, [2] = 90, [3] = 112 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[36]", R[36])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [3] = { [0] = 18, [1] = 45, [2] = 239, [3] = 183 }, [4] = { [0] = 29, [1] = 52, [2] = 248, [3] = 183 } })[R[36]][R[20]], ({ [3] = { [0] = 51, [1] = 12, [2] = 91, [3] = 122 }, [4] = { [0] = 58, [1] = 20, [2] = 100, [3] = 122 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[36] == 3 then
        if R[20] == 0 then
          if LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[20] == 1 then
          if LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[20] == 2 then
          if LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[20] == 3 then
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
          unseen("R[20]", R[20])
        end
      elseif R[36] == 4 then
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
        unseen("R[36]", R[36])
      end
    else
      unseen("R[36]", R[36])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 39, [2] = 230, [3] = 164 }, [1] = { [0] = 21, [1] = 48, [2] = 238, [3] = 163 }, [2] = { [0] = 32, [1] = 59, [2] = 253, [3] = 184 }, [3] = { [0] = 24, [1] = 51, [2] = 245, [3] = 164 }, [4] = { [0] = 10, [1] = 33, [2] = 229, [3] = 164 }, [5] = { [0] = 8, [1] = 34, [2] = 219, [3] = 164 }, [6] = { [0] = 4, [1] = 31, [2] = 225, [3] = 163 }, [7] = { [0] = 20, [1] = 49, [2] = 240, [3] = 163 } })[R[36]][R[20]], ({ [0] = { [0] = 67, [1] = 29, [2] = 105, [3] = 122 }, [1] = { [0] = 64, [1] = 33, [2] = 104, [3] = 119 }, [2] = { [0] = 50, [1] = 11, [2] = 93, [3] = 113 }, [3] = { [0] = 45, [1] = 6, [2] = 85, [3] = 114 }, [4] = { [0] = 50, [1] = 12, [2] = 92, [3] = 114 }, [5] = { [0] = 60, [1] = 18, [2] = 96, [3] = 119 }, [6] = { [0] = 55, [1] = 13, [2] = 97, [3] = 119 }, [7] = { [0] = 68, [1] = 29, [2] = 103, [3] = 119 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 46, [2] = 237, [3] = 171 }, [1] = { [0] = 20, [1] = 47, [2] = 237, [3] = 162 }, [2] = { [0] = 28, [1] = 55, [2] = 249, [3] = 180 }, [3] = { [0] = 13, [1] = 40, [2] = 234, [3] = 182 }, [4] = { [0] = 28, [1] = 51, [2] = 247, [3] = 182 }, [5] = { [0] = 26, [1] = 52, [2] = 237, [3] = 182 }, [6] = { [0] = 11, [1] = 38, [2] = 232, [3] = 170 }, [7] = { [0] = 30, [1] = 59, [2] = 250, [3] = 170 } })[R[36]][R[20]], ({ [0] = { [0] = 54, [1] = 16, [2] = 92, [3] = 109 }, [1] = { [0] = 50, [1] = 19, [2] = 90, [3] = 105 }, [2] = { [0] = 54, [1] = 15, [2] = 97, [3] = 117 }, [3] = { [0] = 52, [1] = 13, [2] = 92, [3] = 118 }, [4] = { [0] = 54, [1] = 16, [2] = 96, [3] = 118 }, [5] = { [0] = 51, [1] = 9, [2] = 87, [3] = 110 }, [6] = { [0] = 60, [1] = 18, [2] = 102, [3] = 124 }, [7] = { [0] = 59, [1] = 20, [2] = 94, [3] = 124 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 44, [2] = 235, [3] = 169 }, [1] = { [0] = 20, [1] = 47, [2] = 237, [3] = 162 }, [2] = { [0] = 28, [1] = 55, [2] = 249, [3] = 180 }, [3] = { [0] = 16, [1] = 43, [2] = 237, [3] = 184 }, [4] = { [0] = 30, [1] = 53, [2] = 249, [3] = 184 }, [5] = { [0] = 26, [1] = 52, [2] = 237, [3] = 182 }, [6] = { [0] = 9, [1] = 36, [2] = 230, [3] = 168 }, [7] = { [0] = 30, [1] = 59, [2] = 250, [3] = 168 } })[R[36]][R[20]], ({ [0] = { [0] = 54, [1] = 16, [2] = 92, [3] = 109 }, [1] = { [0] = 48, [1] = 17, [2] = 88, [3] = 103 }, [2] = { [0] = 52, [1] = 13, [2] = 95, [3] = 115 }, [3] = { [0] = 48, [1] = 9, [2] = 88, [3] = 118 }, [4] = { [0] = 54, [1] = 16, [2] = 96, [3] = 118 }, [5] = { [0] = 53, [1] = 11, [2] = 89, [3] = 112 }, [6] = { [0] = 60, [1] = 18, [2] = 102, [3] = 124 }, [7] = { [0] = 61, [1] = 22, [2] = 96, [3] = 124 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[36]][R[20]], player = players[2], at = { ({ [0] = { [0] = 35, [1] = 55, [2] = 246, [3] = 180 }, [1] = { [0] = 23, [1] = 50, [2] = 240, [3] = 165 }, [2] = { [0] = 10, [1] = 37, [2] = 231, [3] = 162 }, [3] = { [0] = 33, [1] = 60, [2] = 254, [3] = 176 }, [4] = { [0] = 22, [1] = 45, [2] = 241, [3] = 176 }, [5] = { [0] = 14, [1] = 40, [2] = 225, [3] = 170 }, [6] = { [0] = 24, [1] = 51, [2] = 245, [3] = 183 }, [7] = { [0] = 29, [1] = 58, [2] = 249, [3] = 183 } })[R[36]][R[20]], ({ [0] = { [0] = 60, [1] = 22, [2] = 98, [3] = 115 }, [1] = { [0] = 50, [1] = 19, [2] = 90, [3] = 105 }, [2] = { [0] = 55, [1] = 16, [2] = 98, [3] = 118 }, [3] = { [0] = 52, [1] = 13, [2] = 92, [3] = 126 }, [4] = { [0] = 62, [1] = 24, [2] = 104, [3] = 126 }, [5] = { [0] = 61, [1] = 19, [2] = 97, [3] = 120 }, [6] = { [0] = 47, [1] = 5, [2] = 89, [3] = 111 }, [7] = { [0] = 53, [1] = 14, [2] = 88, [3] = 111 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[36]][R[20]], player = players[2], at = { ({ [0] = { [0] = 35, [1] = 55, [2] = 246, [3] = 180 }, [1] = { [0] = 23, [1] = 50, [2] = 240, [3] = 165 }, [2] = { [0] = 10, [1] = 37, [2] = 231, [3] = 162 }, [3] = { [0] = 31, [1] = 58, [2] = 252, [3] = 176 }, [4] = { [0] = 22, [1] = 45, [2] = 241, [3] = 176 }, [5] = { [0] = 14, [1] = 40, [2] = 225, [3] = 170 }, [6] = { [0] = 24, [1] = 51, [2] = 245, [3] = 183 }, [7] = { [0] = 29, [1] = 58, [2] = 249, [3] = 183 } })[R[36]][R[20]], ({ [0] = { [0] = 60, [1] = 22, [2] = 98, [3] = 115 }, [1] = { [0] = 50, [1] = 19, [2] = 90, [3] = 105 }, [2] = { [0] = 55, [1] = 16, [2] = 98, [3] = 118 }, [3] = { [0] = 48, [1] = 9, [2] = 88, [3] = 126 }, [4] = { [0] = 62, [1] = 24, [2] = 104, [3] = 126 }, [5] = { [0] = 61, [1] = 19, [2] = 97, [3] = 120 }, [6] = { [0] = 47, [1] = 5, [2] = 89, [3] = 111 }, [7] = { [0] = 53, [1] = 14, [2] = 88, [3] = 111 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "CargoTruck" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[36]][R[20]], player = players[2], at = { ({ [0] = { [0] = 24, [1] = 44, [2] = 235, [3] = 169 }, [1] = { [0] = 20, [1] = 47, [2] = 237, [3] = 162 }, [2] = { [0] = 28, [1] = 55, [2] = 249, [3] = 180 }, [3] = { [0] = 19, [1] = 46, [2] = 240, [3] = 184 }, [4] = { [0] = 30, [1] = 53, [2] = 249, [3] = 184 }, [5] = { [0] = 26, [1] = 52, [2] = 237, [3] = 182 }, [6] = { [0] = 9, [1] = 36, [2] = 230, [3] = 168 }, [7] = { [0] = 30, [1] = 59, [2] = 250, [3] = 168 } })[R[36]][R[20]], ({ [0] = { [0] = 54, [1] = 16, [2] = 92, [3] = 109 }, [1] = { [0] = 50, [1] = 19, [2] = 90, [3] = 105 }, [2] = { [0] = 52, [1] = 13, [2] = 95, [3] = 115 }, [3] = { [0] = 63, [1] = 24, [2] = 103, [3] = 118 }, [4] = { [0] = 54, [1] = 16, [2] = 96, [3] = 118 }, [5] = { [0] = 53, [1] = 11, [2] = 89, [3] = 112 }, [6] = { [0] = 60, [1] = 18, [2] = 102, [3] = 124 }, [7] = { [0] = 61, [1] = 22, [2] = 96, [3] = 124 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "CargoTruck" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[36]][R[20]], player = players[2], at = { ({ [0] = { [0] = 24, [1] = 44, [2] = 235, [3] = 169 }, [1] = { [0] = 23, [1] = 50, [2] = 240, [3] = 165 }, [2] = { [0] = 28, [1] = 55, [2] = 249, [3] = 180 }, [3] = { [0] = 19, [1] = 46, [2] = 240, [3] = 184 }, [4] = { [0] = 30, [1] = 53, [2] = 249, [3] = 184 }, [5] = { [0] = 26, [1] = 52, [2] = 237, [3] = 182 }, [6] = { [0] = 9, [1] = 36, [2] = 230, [3] = 168 }, [7] = { [0] = 30, [1] = 59, [2] = 250, [3] = 168 } })[R[36]][R[20]], ({ [0] = { [0] = 54, [1] = 16, [2] = 92, [3] = 109 }, [1] = { [0] = 50, [1] = 19, [2] = 90, [3] = 105 }, [2] = { [0] = 52, [1] = 13, [2] = 95, [3] = 115 }, [3] = { [0] = 63, [1] = 24, [2] = 103, [3] = 118 }, [4] = { [0] = 54, [1] = 16, [2] = 96, [3] = 118 }, [5] = { [0] = 53, [1] = 11, [2] = 89, [3] = 112 }, [6] = { [0] = 60, [1] = 18, [2] = 102, [3] = 124 }, [7] = { [0] = 61, [1] = 22, [2] = 96, [3] = 124 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[36]][R[20]], player = players[2], at = { ({ [0] = { [0] = 35, [1] = 55, [2] = 246, [3] = 180 }, [1] = { [0] = 20, [1] = 47, [2] = 237, [3] = 162 }, [2] = { [0] = 10, [1] = 37, [2] = 231, [3] = 162 }, [3] = { [0] = 13, [1] = 40, [2] = 234, [3] = 176 }, [4] = { [0] = 22, [1] = 45, [2] = 241, [3] = 176 }, [5] = { [0] = 14, [1] = 40, [2] = 225, [3] = 170 }, [6] = { [0] = 24, [1] = 51, [2] = 245, [3] = 183 }, [7] = { [0] = 29, [1] = 58, [2] = 249, [3] = 183 } })[R[36]][R[20]], ({ [0] = { [0] = 60, [1] = 22, [2] = 98, [3] = 115 }, [1] = { [0] = 50, [1] = 19, [2] = 90, [3] = 105 }, [2] = { [0] = 55, [1] = 16, [2] = 98, [3] = 118 }, [3] = { [0] = 52, [1] = 13, [2] = 92, [3] = 126 }, [4] = { [0] = 62, [1] = 24, [2] = 104, [3] = 126 }, [5] = { [0] = 61, [1] = 19, [2] = 97, [3] = 120 }, [6] = { [0] = 47, [1] = 5, [2] = 89, [3] = 111 }, [7] = { [0] = 53, [1] = 14, [2] = 88, [3] = 111 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "RoboSurveyor" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[36]][R[20]], player = players[2], at = { ({ [0] = { [0] = 21, [1] = 41, [2] = 232, [3] = 166 }, [1] = { [0] = 23, [1] = 50, [2] = 240, [3] = 165 }, [2] = { [0] = 28, [1] = 55, [2] = 249, [3] = 180 }, [3] = { [0] = 13, [1] = 40, [2] = 234, [3] = 177 }, [4] = { [0] = 23, [1] = 46, [2] = 242, [3] = 177 }, [5] = { [0] = 13, [1] = 39, [2] = 224, [3] = 169 }, [6] = { [0] = 16, [1] = 43, [2] = 237, [3] = 175 }, [7] = { [0] = 14, [1] = 43, [2] = 234, [3] = 175 } })[R[36]][R[20]], ({ [0] = { [0] = 54, [1] = 16, [2] = 92, [3] = 109 }, [1] = { [0] = 44, [1] = 13, [2] = 84, [3] = 99 }, [2] = { [0] = 58, [1] = 19, [2] = 101, [3] = 121 }, [3] = { [0] = 52, [1] = 13, [2] = 92, [3] = 122 }, [4] = { [0] = 58, [1] = 20, [2] = 100, [3] = 122 }, [5] = { [0] = 50, [1] = 8, [2] = 86, [3] = 109 }, [6] = { [0] = 57, [1] = 15, [2] = 99, [3] = 121 }, [7] = { [0] = 59, [1] = 20, [2] = 94, [3] = 121 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[36]][R[20]], player = players[2], at = { ({ [0] = { [0] = 21, [1] = 41, [2] = 232, [3] = 166 }, [1] = { [0] = 26, [1] = 53, [2] = 243, [3] = 168 }, [2] = { [0] = 24, [1] = 51, [2] = 245, [3] = 176 }, [3] = { [0] = 19, [1] = 46, [2] = 240, [3] = 179 }, [4] = { [0] = 25, [1] = 48, [2] = 244, [3] = 179 }, [5] = { [0] = 22, [1] = 48, [2] = 233, [3] = 178 }, [6] = { [0] = 25, [1] = 52, [2] = 246, [3] = 184 }, [7] = { [0] = 9, [1] = 38, [2] = 229, [3] = 184 } })[R[36]][R[20]], ({ [0] = { [0] = 51, [1] = 13, [2] = 89, [3] = 106 }, [1] = { [0] = 41, [1] = 10, [2] = 81, [3] = 96 }, [2] = { [0] = 59, [1] = 20, [2] = 102, [3] = 122 }, [3] = { [0] = 63, [1] = 24, [2] = 103, [3] = 113 }, [4] = { [0] = 49, [1] = 11, [2] = 91, [3] = 113 }, [5] = { [0] = 58, [1] = 16, [2] = 94, [3] = 117 }, [6] = { [0] = 54, [1] = 12, [2] = 96, [3] = 118 }, [7] = { [0] = 56, [1] = 17, [2] = 91, [3] = 118 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[36]][R[20]], player = players[2], at = { ({ [0] = { [0] = 35, [1] = 55, [2] = 246, [3] = 180 }, [1] = { [0] = 23, [1] = 50, [2] = 240, [3] = 165 }, [2] = { [0] = 10, [1] = 37, [2] = 231, [3] = 162 }, [3] = { [0] = 33, [1] = 60, [2] = 254, [3] = 176 }, [4] = { [0] = 22, [1] = 45, [2] = 241, [3] = 176 }, [5] = { [0] = 14, [1] = 40, [2] = 225, [3] = 170 }, [6] = { [0] = 24, [1] = 51, [2] = 245, [3] = 183 }, [7] = { [0] = 29, [1] = 58, [2] = 249, [3] = 183 } })[R[36]][R[20]], ({ [0] = { [0] = 60, [1] = 22, [2] = 98, [3] = 115 }, [1] = { [0] = 50, [1] = 19, [2] = 90, [3] = 105 }, [2] = { [0] = 55, [1] = 16, [2] = 98, [3] = 118 }, [3] = { [0] = 52, [1] = 13, [2] = 92, [3] = 126 }, [4] = { [0] = 62, [1] = 24, [2] = 104, [3] = 126 }, [5] = { [0] = 61, [1] = 19, [2] = 97, [3] = 120 }, [6] = { [0] = 47, [1] = 5, [2] = 89, [3] = 111 }, [7] = { [0] = 53, [1] = 14, [2] = 88, [3] = 111 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[36]][R[20]], player = players[2], at = { ({ [0] = { [0] = 35, [1] = 55, [2] = 246, [3] = 180 }, [1] = { [0] = 23, [1] = 50, [2] = 240, [3] = 165 }, [2] = { [0] = 10, [1] = 37, [2] = 231, [3] = 162 }, [3] = { [0] = 31, [1] = 58, [2] = 252, [3] = 176 }, [4] = { [0] = 22, [1] = 45, [2] = 241, [3] = 176 }, [5] = { [0] = 14, [1] = 40, [2] = 225, [3] = 170 }, [6] = { [0] = 24, [1] = 51, [2] = 245, [3] = 183 }, [7] = { [0] = 29, [1] = 58, [2] = 249, [3] = 183 } })[R[36]][R[20]], ({ [0] = { [0] = 60, [1] = 22, [2] = 98, [3] = 115 }, [1] = { [0] = 50, [1] = 19, [2] = 90, [3] = 105 }, [2] = { [0] = 55, [1] = 16, [2] = 98, [3] = 118 }, [3] = { [0] = 48, [1] = 9, [2] = 88, [3] = 126 }, [4] = { [0] = 62, [1] = 24, [2] = 104, [3] = 126 }, [5] = { [0] = 61, [1] = 19, [2] = 97, [3] = 120 }, [6] = { [0] = 47, [1] = 5, [2] = 89, [3] = 111 }, [7] = { [0] = 53, [1] = 14, [2] = 88, [3] = 111 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[36]][R[20]], player = players[2], at = { ({ [0] = { [0] = 21, [1] = 41, [2] = 232, [3] = 166 }, [1] = { [0] = 23, [1] = 50, [2] = 240, [3] = 165 }, [2] = { [0] = 28, [1] = 55, [2] = 249, [3] = 180 }, [3] = { [0] = 19, [1] = 46, [2] = 240, [3] = 177 }, [4] = { [0] = 23, [1] = 46, [2] = 242, [3] = 177 }, [5] = { [0] = 13, [1] = 39, [2] = 224, [3] = 169 }, [6] = { [0] = 16, [1] = 43, [2] = 237, [3] = 175 }, [7] = { [0] = 14, [1] = 43, [2] = 234, [3] = 175 } })[R[36]][R[20]], ({ [0] = { [0] = 54, [1] = 16, [2] = 92, [3] = 109 }, [1] = { [0] = 44, [1] = 13, [2] = 84, [3] = 99 }, [2] = { [0] = 58, [1] = 19, [2] = 101, [3] = 121 }, [3] = { [0] = 63, [1] = 24, [2] = 103, [3] = 122 }, [4] = { [0] = 58, [1] = 20, [2] = 100, [3] = 122 }, [5] = { [0] = 50, [1] = 8, [2] = 86, [3] = 109 }, [6] = { [0] = 57, [1] = 15, [2] = 99, [3] = 121 }, [7] = { [0] = 59, [1] = 20, [2] = 94, [3] = 121 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[36]][R[20]], player = players[2], at = { ({ [0] = { [0] = 21, [1] = 41, [2] = 232, [3] = 166 }, [1] = { [0] = 26, [1] = 53, [2] = 243, [3] = 168 }, [2] = { [0] = 24, [1] = 51, [2] = 245, [3] = 176 }, [3] = { [0] = 19, [1] = 46, [2] = 240, [3] = 179 }, [4] = { [0] = 25, [1] = 48, [2] = 244, [3] = 179 }, [5] = { [0] = 22, [1] = 48, [2] = 233, [3] = 178 }, [6] = { [0] = 25, [1] = 52, [2] = 246, [3] = 184 }, [7] = { [0] = 9, [1] = 38, [2] = 229, [3] = 184 } })[R[36]][R[20]], ({ [0] = { [0] = 51, [1] = 13, [2] = 89, [3] = 106 }, [1] = { [0] = 41, [1] = 10, [2] = 81, [3] = 96 }, [2] = { [0] = 59, [1] = 20, [2] = 102, [3] = 122 }, [3] = { [0] = 63, [1] = 24, [2] = 103, [3] = 113 }, [4] = { [0] = 49, [1] = 11, [2] = 91, [3] = 113 }, [5] = { [0] = 58, [1] = 16, [2] = 94, [3] = 117 }, [6] = { [0] = 54, [1] = 12, [2] = 96, [3] = 118 }, [7] = { [0] = 56, [1] = 17, [2] = 91, [3] = 118 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[36]][R[20]], player = players[2], at = { ({ [0] = { [0] = 35, [1] = 55, [2] = 246, [3] = 180 }, [1] = { [0] = 23, [1] = 50, [2] = 240, [3] = 165 }, [2] = { [0] = 10, [1] = 37, [2] = 231, [3] = 162 }, [3] = { [0] = 33, [1] = 60, [2] = 254, [3] = 176 }, [4] = { [0] = 22, [1] = 45, [2] = 241, [3] = 176 }, [5] = { [0] = 14, [1] = 40, [2] = 225, [3] = 170 }, [6] = { [0] = 24, [1] = 51, [2] = 245, [3] = 183 }, [7] = { [0] = 29, [1] = 58, [2] = 249, [3] = 183 } })[R[36]][R[20]], ({ [0] = { [0] = 60, [1] = 22, [2] = 98, [3] = 115 }, [1] = { [0] = 50, [1] = 19, [2] = 90, [3] = 105 }, [2] = { [0] = 55, [1] = 16, [2] = 98, [3] = 118 }, [3] = { [0] = 52, [1] = 13, [2] = 92, [3] = 126 }, [4] = { [0] = 62, [1] = 24, [2] = 104, [3] = 126 }, [5] = { [0] = 61, [1] = 19, [2] = 97, [3] = 120 }, [6] = { [0] = 47, [1] = 5, [2] = 89, [3] = 111 }, [7] = { [0] = 53, [1] = 14, [2] = 88, [3] = 111 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[36]][R[20]], player = players[2], at = { ({ [0] = { [0] = 35, [1] = 55, [2] = 246, [3] = 180 }, [1] = { [0] = 23, [1] = 50, [2] = 240, [3] = 165 }, [2] = { [0] = 10, [1] = 37, [2] = 231, [3] = 162 }, [3] = { [0] = 31, [1] = 58, [2] = 252, [3] = 176 }, [4] = { [0] = 22, [1] = 45, [2] = 241, [3] = 176 }, [5] = { [0] = 14, [1] = 40, [2] = 225, [3] = 170 }, [6] = { [0] = 24, [1] = 51, [2] = 245, [3] = 183 }, [7] = { [0] = 29, [1] = 58, [2] = 249, [3] = 183 } })[R[36]][R[20]], ({ [0] = { [0] = 60, [1] = 22, [2] = 98, [3] = 115 }, [1] = { [0] = 50, [1] = 19, [2] = 90, [3] = 105 }, [2] = { [0] = 55, [1] = 16, [2] = 98, [3] = 118 }, [3] = { [0] = 48, [1] = 9, [2] = 88, [3] = 126 }, [4] = { [0] = 62, [1] = 24, [2] = 104, [3] = 126 }, [5] = { [0] = 61, [1] = 19, [2] = 97, [3] = 120 }, [6] = { [0] = 47, [1] = 5, [2] = 89, [3] = 111 }, [7] = { [0] = 53, [1] = 14, [2] = 88, [3] = 111 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "CargoTruck" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[36]][R[20]], player = players[2], at = { ({ [0] = { [0] = 24, [1] = 44, [2] = 235, [3] = 169 }, [1] = { [0] = 20, [1] = 47, [2] = 237, [3] = 162 }, [2] = { [0] = 28, [1] = 55, [2] = 249, [3] = 180 }, [3] = { [0] = 19, [1] = 46, [2] = 240, [3] = 184 }, [4] = { [0] = 30, [1] = 53, [2] = 249, [3] = 184 }, [5] = { [0] = 26, [1] = 52, [2] = 237, [3] = 182 }, [6] = { [0] = 9, [1] = 36, [2] = 230, [3] = 168 }, [7] = { [0] = 30, [1] = 59, [2] = 250, [3] = 168 } })[R[36]][R[20]], ({ [0] = { [0] = 54, [1] = 16, [2] = 92, [3] = 109 }, [1] = { [0] = 50, [1] = 19, [2] = 90, [3] = 105 }, [2] = { [0] = 52, [1] = 13, [2] = 95, [3] = 115 }, [3] = { [0] = 63, [1] = 24, [2] = 103, [3] = 118 }, [4] = { [0] = 54, [1] = 16, [2] = 96, [3] = 118 }, [5] = { [0] = 53, [1] = 11, [2] = 89, [3] = 112 }, [6] = { [0] = 60, [1] = 18, [2] = 102, [3] = 124 }, [7] = { [0] = 61, [1] = 22, [2] = 96, [3] = 124 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 35, [1] = 55, [2] = 246, [3] = 180 }, [1] = { [0] = 23, [1] = 50, [2] = 240, [3] = 165 }, [2] = { [0] = 10, [1] = 37, [2] = 231, [3] = 162 }, [3] = { [0] = 19, [1] = 46, [2] = 240, [3] = 176 }, [4] = { [0] = 22, [1] = 45, [2] = 241, [3] = 176 }, [5] = { [0] = 14, [1] = 40, [2] = 225, [3] = 170 }, [6] = { [0] = 24, [1] = 51, [2] = 245, [3] = 183 }, [7] = { [0] = 29, [1] = 58, [2] = 249, [3] = 183 } })[R[36]][R[20]], ({ [0] = { [0] = 60, [1] = 22, [2] = 98, [3] = 115 }, [1] = { [0] = 50, [1] = 19, [2] = 90, [3] = 105 }, [2] = { [0] = 55, [1] = 16, [2] = 98, [3] = 118 }, [3] = { [0] = 63, [1] = 24, [2] = 103, [3] = 126 }, [4] = { [0] = 62, [1] = 24, [2] = 104, [3] = 126 }, [5] = { [0] = 61, [1] = 19, [2] = 97, [3] = 120 }, [6] = { [0] = 47, [1] = 5, [2] = 89, [3] = 111 }, [7] = { [0] = 53, [1] = 14, [2] = 88, [3] = 111 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "RoboSurveyor" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[36]][R[20]], player = players[2], at = { ({ [0] = { [0] = 21, [1] = 41, [2] = 232, [3] = 166 }, [1] = { [0] = 23, [1] = 50, [2] = 240, [3] = 165 }, [2] = { [0] = 28, [1] = 55, [2] = 249, [3] = 180 }, [3] = { [0] = 13, [1] = 40, [2] = 234, [3] = 177 }, [4] = { [0] = 23, [1] = 46, [2] = 242, [3] = 177 }, [5] = { [0] = 13, [1] = 39, [2] = 224, [3] = 169 }, [6] = { [0] = 16, [1] = 43, [2] = 237, [3] = 175 }, [7] = { [0] = 14, [1] = 43, [2] = 234, [3] = 175 } })[R[36]][R[20]], ({ [0] = { [0] = 54, [1] = 16, [2] = 92, [3] = 109 }, [1] = { [0] = 44, [1] = 13, [2] = 84, [3] = 99 }, [2] = { [0] = 58, [1] = 19, [2] = 101, [3] = 121 }, [3] = { [0] = 52, [1] = 13, [2] = 92, [3] = 122 }, [4] = { [0] = 58, [1] = 20, [2] = 100, [3] = 122 }, [5] = { [0] = 50, [1] = 8, [2] = 86, [3] = 109 }, [6] = { [0] = 57, [1] = 15, [2] = 99, [3] = 121 }, [7] = { [0] = 59, [1] = 20, [2] = 94, [3] = 121 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[36]][R[20]], player = players[2], at = { ({ [0] = { [0] = 21, [1] = 41, [2] = 232, [3] = 166 }, [1] = { [0] = 26, [1] = 53, [2] = 243, [3] = 168 }, [2] = { [0] = 24, [1] = 51, [2] = 245, [3] = 176 }, [3] = { [0] = 19, [1] = 46, [2] = 240, [3] = 179 }, [4] = { [0] = 25, [1] = 48, [2] = 244, [3] = 179 }, [5] = { [0] = 22, [1] = 48, [2] = 233, [3] = 178 }, [6] = { [0] = 25, [1] = 52, [2] = 246, [3] = 184 }, [7] = { [0] = 9, [1] = 38, [2] = 229, [3] = 184 } })[R[36]][R[20]], ({ [0] = { [0] = 51, [1] = 13, [2] = 89, [3] = 106 }, [1] = { [0] = 41, [1] = 10, [2] = 81, [3] = 96 }, [2] = { [0] = 59, [1] = 20, [2] = 102, [3] = 122 }, [3] = { [0] = 63, [1] = 24, [2] = 103, [3] = 113 }, [4] = { [0] = 49, [1] = 11, [2] = 91, [3] = 113 }, [5] = { [0] = 58, [1] = 16, [2] = 94, [3] = 117 }, [6] = { [0] = 54, [1] = 12, [2] = 96, [3] = 118 }, [7] = { [0] = 56, [1] = 17, [2] = 91, [3] = 118 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 62, [2] = 253, [3] = 187 }, [1] = { [0] = 29, [1] = 56, [2] = 246, [3] = 171 }, [2] = { [0] = 20, [1] = 47, [2] = 241, [3] = 172 }, [3] = { [0] = 23, [1] = 50, [2] = 244, [3] = 185 }, [4] = { [0] = 31, [1] = 54, [2] = 250, [3] = 185 }, [5] = { [0] = 14, [1] = 40, [2] = 225, [3] = 170 }, [6] = { [0] = 25, [1] = 52, [2] = 246, [3] = 184 }, [7] = { [0] = 23, [1] = 52, [2] = 243, [3] = 184 } })[R[36]][R[20]], ({ [0] = { [0] = 62, [1] = 24, [2] = 100, [3] = 117 }, [1] = { [0] = 54, [1] = 23, [2] = 94, [3] = 109 }, [2] = { [0] = 52, [1] = 13, [2] = 95, [3] = 115 }, [3] = { [0] = 49, [1] = 10, [2] = 89, [3] = 109 }, [4] = { [0] = 45, [1] = 7, [2] = 87, [3] = 109 }, [5] = { [0] = 67, [1] = 25, [2] = 103, [3] = 126 }, [6] = { [0] = 57, [1] = 15, [2] = 99, [3] = 121 }, [7] = { [0] = 58, [1] = 19, [2] = 93, [3] = 121 } })[R[36]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 22, [1] = 42, [2] = 233, [3] = 167 }, [1] = { [0] = 23, [1] = 50, [2] = 240, [3] = 165 }, [2] = { [0] = 15, [1] = 42, [2] = 236, [3] = 167 }, [3] = { [0] = 15, [1] = 42, [2] = 236, [3] = 172 }, [4] = { [0] = 18, [1] = 41, [2] = 237, [3] = 172 }, [5] = { [0] = 18, [1] = 44, [2] = 229, [3] = 174 }, [6] = { [0] = 11, [1] = 38, [2] = 232, [3] = 170 }, [7] = { [0] = 12, [1] = 41, [2] = 232, [3] = 170 } })[R[36]][R[20]], ({ [0] = { [0] = 58, [1] = 20, [2] = 96, [3] = 113 }, [1] = { [0] = 55, [1] = 24, [2] = 95, [3] = 110 }, [2] = { [0] = 50, [1] = 11, [2] = 93, [3] = 113 }, [3] = { [0] = 58, [1] = 19, [2] = 98, [3] = 112 }, [4] = { [0] = 48, [1] = 10, [2] = 90, [3] = 112 }, [5] = { [0] = 56, [1] = 14, [2] = 92, [3] = 115 }, [6] = { [0] = 49, [1] = 7, [2] = 91, [3] = 113 }, [7] = { [0] = 55, [1] = 16, [2] = 90, [3] = 113 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 43, [2] = 234, [3] = 168 }, [1] = { [0] = 24, [1] = 51, [2] = 241, [3] = 166 }, [2] = { [0] = 16, [1] = 43, [2] = 237, [3] = 168 }, [3] = { [0] = 15, [1] = 42, [2] = 236, [3] = 172 }, [4] = { [0] = 18, [1] = 41, [2] = 237, [3] = 172 }, [5] = { [0] = 18, [1] = 44, [2] = 229, [3] = 174 }, [6] = { [0] = 11, [1] = 38, [2] = 232, [3] = 170 }, [7] = { [0] = 12, [1] = 41, [2] = 232, [3] = 170 } })[R[36]][R[20]], ({ [0] = { [0] = 58, [1] = 20, [2] = 96, [3] = 113 }, [1] = { [0] = 55, [1] = 24, [2] = 95, [3] = 110 }, [2] = { [0] = 50, [1] = 11, [2] = 93, [3] = 113 }, [3] = { [0] = 59, [1] = 20, [2] = 99, [3] = 113 }, [4] = { [0] = 49, [1] = 11, [2] = 91, [3] = 113 }, [5] = { [0] = 57, [1] = 15, [2] = 93, [3] = 116 }, [6] = { [0] = 50, [1] = 8, [2] = 92, [3] = 114 }, [7] = { [0] = 56, [1] = 17, [2] = 91, [3] = 114 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 44, [2] = 235, [3] = 169 }, [1] = { [0] = 25, [1] = 52, [2] = 242, [3] = 167 }, [2] = { [0] = 17, [1] = 44, [2] = 238, [3] = 169 }, [3] = { [0] = 15, [1] = 42, [2] = 236, [3] = 172 }, [4] = { [0] = 18, [1] = 41, [2] = 237, [3] = 172 }, [5] = { [0] = 18, [1] = 44, [2] = 229, [3] = 174 }, [6] = { [0] = 11, [1] = 38, [2] = 232, [3] = 170 }, [7] = { [0] = 12, [1] = 41, [2] = 232, [3] = 170 } })[R[36]][R[20]], ({ [0] = { [0] = 58, [1] = 20, [2] = 96, [3] = 113 }, [1] = { [0] = 55, [1] = 24, [2] = 95, [3] = 110 }, [2] = { [0] = 50, [1] = 11, [2] = 93, [3] = 113 }, [3] = { [0] = 60, [1] = 21, [2] = 100, [3] = 114 }, [4] = { [0] = 50, [1] = 12, [2] = 92, [3] = 114 }, [5] = { [0] = 58, [1] = 16, [2] = 94, [3] = 117 }, [6] = { [0] = 51, [1] = 9, [2] = 93, [3] = 115 }, [7] = { [0] = 57, [1] = 18, [2] = 92, [3] = 115 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 25, [1] = 45, [2] = 236, [3] = 170 }, [1] = { [0] = 26, [1] = 53, [2] = 243, [3] = 168 }, [2] = { [0] = 18, [1] = 45, [2] = 239, [3] = 170 }, [3] = { [0] = 16, [1] = 43, [2] = 237, [3] = 172 }, [4] = { [0] = 18, [1] = 41, [2] = 237, [3] = 172 }, [5] = { [0] = 18, [1] = 44, [2] = 229, [3] = 174 }, [6] = { [0] = 11, [1] = 38, [2] = 232, [3] = 170 }, [7] = { [0] = 12, [1] = 41, [2] = 232, [3] = 170 } })[R[36]][R[20]], ({ [0] = { [0] = 58, [1] = 20, [2] = 96, [3] = 113 }, [1] = { [0] = 55, [1] = 24, [2] = 95, [3] = 110 }, [2] = { [0] = 47, [1] = 8, [2] = 90, [3] = 110 }, [3] = { [0] = 58, [1] = 19, [2] = 98, [3] = 115 }, [4] = { [0] = 51, [1] = 13, [2] = 93, [3] = 115 }, [5] = { [0] = 62, [1] = 20, [2] = 98, [3] = 121 }, [6] = { [0] = 52, [1] = 10, [2] = 94, [3] = 116 }, [7] = { [0] = 58, [1] = 19, [2] = 93, [3] = 116 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 46, [2] = 237, [3] = 171 }, [1] = { [0] = 27, [1] = 54, [2] = 244, [3] = 169 }, [2] = { [0] = 18, [1] = 45, [2] = 239, [3] = 170 }, [3] = { [0] = 17, [1] = 44, [2] = 238, [3] = 172 }, [4] = { [0] = 18, [1] = 41, [2] = 237, [3] = 172 }, [5] = { [0] = 18, [1] = 44, [2] = 229, [3] = 174 }, [6] = { [0] = 11, [1] = 38, [2] = 232, [3] = 170 }, [7] = { [0] = 12, [1] = 41, [2] = 232, [3] = 170 } })[R[36]][R[20]], ({ [0] = { [0] = 58, [1] = 20, [2] = 96, [3] = 113 }, [1] = { [0] = 55, [1] = 24, [2] = 95, [3] = 110 }, [2] = { [0] = 48, [1] = 9, [2] = 91, [3] = 111 }, [3] = { [0] = 54, [1] = 15, [2] = 94, [3] = 116 }, [4] = { [0] = 52, [1] = 14, [2] = 94, [3] = 116 }, [5] = { [0] = 63, [1] = 21, [2] = 99, [3] = 122 }, [6] = { [0] = 53, [1] = 11, [2] = 95, [3] = 117 }, [7] = { [0] = 59, [1] = 20, [2] = 94, [3] = 117 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 47, [2] = 238, [3] = 172 }, [1] = { [0] = 28, [1] = 55, [2] = 245, [3] = 170 }, [2] = { [0] = 18, [1] = 45, [2] = 239, [3] = 170 }, [3] = { [0] = 17, [1] = 44, [2] = 238, [3] = 172 }, [4] = { [0] = 18, [1] = 41, [2] = 237, [3] = 172 }, [5] = { [0] = 18, [1] = 44, [2] = 229, [3] = 174 }, [6] = { [0] = 14, [1] = 41, [2] = 235, [3] = 173 }, [7] = { [0] = 12, [1] = 41, [2] = 232, [3] = 173 } })[R[36]][R[20]], ({ [0] = { [0] = 58, [1] = 20, [2] = 96, [3] = 113 }, [1] = { [0] = 55, [1] = 24, [2] = 95, [3] = 110 }, [2] = { [0] = 49, [1] = 10, [2] = 92, [3] = 112 }, [3] = { [0] = 55, [1] = 16, [2] = 95, [3] = 120 }, [4] = { [0] = 56, [1] = 18, [2] = 98, [3] = 120 }, [5] = { [0] = 64, [1] = 22, [2] = 100, [3] = 123 }, [6] = { [0] = 47, [1] = 5, [2] = 89, [3] = 111 }, [7] = { [0] = 60, [1] = 21, [2] = 95, [3] = 111 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 48, [2] = 239, [3] = 173 }, [1] = { [0] = 29, [1] = 56, [2] = 246, [3] = 171 }, [2] = { [0] = 18, [1] = 45, [2] = 239, [3] = 170 }, [3] = { [0] = 17, [1] = 44, [2] = 238, [3] = 172 }, [4] = { [0] = 18, [1] = 41, [2] = 237, [3] = 172 }, [5] = { [0] = 21, [1] = 47, [2] = 232, [3] = 177 }, [6] = { [0] = 15, [1] = 42, [2] = 236, [3] = 174 }, [7] = { [0] = 12, [1] = 41, [2] = 232, [3] = 174 } })[R[36]][R[20]], ({ [0] = { [0] = 58, [1] = 20, [2] = 96, [3] = 113 }, [1] = { [0] = 55, [1] = 24, [2] = 95, [3] = 110 }, [2] = { [0] = 50, [1] = 11, [2] = 93, [3] = 113 }, [3] = { [0] = 56, [1] = 17, [2] = 96, [3] = 121 }, [4] = { [0] = 57, [1] = 19, [2] = 99, [3] = 121 }, [5] = { [0] = 60, [1] = 18, [2] = 96, [3] = 119 }, [6] = { [0] = 47, [1] = 5, [2] = 89, [3] = 111 }, [7] = { [0] = 61, [1] = 22, [2] = 96, [3] = 111 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 50, [2] = 241, [3] = 175 }, [1] = { [0] = 30, [1] = 57, [2] = 247, [3] = 172 }, [2] = { [0] = 18, [1] = 45, [2] = 239, [3] = 170 }, [3] = { [0] = 17, [1] = 44, [2] = 238, [3] = 172 }, [4] = { [0] = 18, [1] = 41, [2] = 237, [3] = 172 }, [5] = { [0] = 21, [1] = 47, [2] = 232, [3] = 177 }, [6] = { [0] = 15, [1] = 42, [2] = 236, [3] = 174 }, [7] = { [0] = 12, [1] = 41, [2] = 232, [3] = 174 } })[R[36]][R[20]], ({ [0] = { [0] = 53, [1] = 15, [2] = 91, [3] = 108 }, [1] = { [0] = 44, [1] = 13, [2] = 84, [3] = 99 }, [2] = { [0] = 51, [1] = 12, [2] = 94, [3] = 114 }, [3] = { [0] = 57, [1] = 18, [2] = 97, [3] = 122 }, [4] = { [0] = 58, [1] = 20, [2] = 100, [3] = 122 }, [5] = { [0] = 66, [1] = 24, [2] = 102, [3] = 125 }, [6] = { [0] = 55, [1] = 13, [2] = 97, [3] = 119 }, [7] = { [0] = 62, [1] = 23, [2] = 97, [3] = 119 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 50, [2] = 241, [3] = 175 }, [1] = { [0] = 30, [1] = 57, [2] = 247, [3] = 172 }, [2] = { [0] = 18, [1] = 45, [2] = 239, [3] = 170 }, [3] = { [0] = 17, [1] = 44, [2] = 238, [3] = 172 }, [4] = { [0] = 18, [1] = 41, [2] = 237, [3] = 172 }, [5] = { [0] = 22, [1] = 48, [2] = 233, [3] = 178 }, [6] = { [0] = 16, [1] = 43, [2] = 237, [3] = 175 }, [7] = { [0] = 12, [1] = 41, [2] = 232, [3] = 175 } })[R[36]][R[20]], ({ [0] = { [0] = 54, [1] = 16, [2] = 92, [3] = 109 }, [1] = { [0] = 45, [1] = 14, [2] = 85, [3] = 100 }, [2] = { [0] = 52, [1] = 13, [2] = 95, [3] = 115 }, [3] = { [0] = 58, [1] = 19, [2] = 98, [3] = 123 }, [4] = { [0] = 59, [1] = 21, [2] = 101, [3] = 123 }, [5] = { [0] = 60, [1] = 18, [2] = 96, [3] = 119 }, [6] = { [0] = 47, [1] = 5, [2] = 89, [3] = 111 }, [7] = { [0] = 63, [1] = 24, [2] = 98, [3] = 111 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 50, [2] = 241, [3] = 175 }, [1] = { [0] = 30, [1] = 57, [2] = 247, [3] = 172 }, [2] = { [0] = 18, [1] = 45, [2] = 239, [3] = 170 }, [3] = { [0] = 18, [1] = 45, [2] = 239, [3] = 172 }, [4] = { [0] = 18, [1] = 41, [2] = 237, [3] = 172 }, [5] = { [0] = 22, [1] = 48, [2] = 233, [3] = 178 }, [6] = { [0] = 16, [1] = 43, [2] = 237, [3] = 175 }, [7] = { [0] = 15, [1] = 44, [2] = 235, [3] = 175 } })[R[36]][R[20]], ({ [0] = { [0] = 55, [1] = 17, [2] = 93, [3] = 110 }, [1] = { [0] = 46, [1] = 15, [2] = 86, [3] = 101 }, [2] = { [0] = 53, [1] = 14, [2] = 96, [3] = 116 }, [3] = { [0] = 54, [1] = 15, [2] = 94, [3] = 124 }, [4] = { [0] = 60, [1] = 22, [2] = 102, [3] = 124 }, [5] = { [0] = 66, [1] = 24, [2] = 102, [3] = 125 }, [6] = { [0] = 55, [1] = 13, [2] = 97, [3] = 119 }, [7] = { [0] = 52, [1] = 13, [2] = 87, [3] = 119 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 50, [2] = 241, [3] = 175 }, [1] = { [0] = 30, [1] = 57, [2] = 247, [3] = 172 }, [2] = { [0] = 18, [1] = 45, [2] = 239, [3] = 170 }, [3] = { [0] = 18, [1] = 45, [2] = 239, [3] = 175 }, [4] = { [0] = 21, [1] = 44, [2] = 240, [3] = 175 }, [5] = { [0] = 23, [1] = 49, [2] = 234, [3] = 179 }, [6] = { [0] = 17, [1] = 44, [2] = 238, [3] = 176 }, [7] = { [0] = 15, [1] = 44, [2] = 235, [3] = 176 } })[R[36]][R[20]], ({ [0] = { [0] = 56, [1] = 18, [2] = 94, [3] = 111 }, [1] = { [0] = 47, [1] = 16, [2] = 87, [3] = 102 }, [2] = { [0] = 54, [1] = 15, [2] = 97, [3] = 117 }, [3] = { [0] = 58, [1] = 19, [2] = 98, [3] = 110 }, [4] = { [0] = 46, [1] = 8, [2] = 88, [3] = 110 }, [5] = { [0] = 60, [1] = 18, [2] = 96, [3] = 119 }, [6] = { [0] = 47, [1] = 5, [2] = 89, [3] = 111 }, [7] = { [0] = 65, [1] = 26, [2] = 100, [3] = 111 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 50, [2] = 241, [3] = 175 }, [1] = { [0] = 30, [1] = 57, [2] = 247, [3] = 172 }, [2] = { [0] = 18, [1] = 45, [2] = 239, [3] = 170 }, [3] = { [0] = 19, [1] = 46, [2] = 240, [3] = 175 }, [4] = { [0] = 21, [1] = 44, [2] = 240, [3] = 175 }, [5] = { [0] = 23, [1] = 49, [2] = 234, [3] = 179 }, [6] = { [0] = 17, [1] = 44, [2] = 238, [3] = 176 }, [7] = { [0] = 16, [1] = 45, [2] = 236, [3] = 176 } })[R[36]][R[20]], ({ [0] = { [0] = 60, [1] = 22, [2] = 98, [3] = 115 }, [1] = { [0] = 55, [1] = 24, [2] = 95, [3] = 110 }, [2] = { [0] = 55, [1] = 16, [2] = 98, [3] = 118 }, [3] = { [0] = 58, [1] = 19, [2] = 98, [3] = 118 }, [4] = { [0] = 54, [1] = 16, [2] = 96, [3] = 118 }, [5] = { [0] = 66, [1] = 24, [2] = 102, [3] = 125 }, [6] = { [0] = 55, [1] = 13, [2] = 97, [3] = 119 }, [7] = { [0] = 52, [1] = 13, [2] = 87, [3] = 119 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 50, [2] = 241, [3] = 175 }, [1] = { [0] = 31, [1] = 58, [2] = 248, [3] = 173 }, [2] = { [0] = 18, [1] = 45, [2] = 239, [3] = 170 }, [3] = { [0] = 20, [1] = 47, [2] = 241, [3] = 175 }, [4] = { [0] = 21, [1] = 44, [2] = 240, [3] = 175 }, [5] = { [0] = 24, [1] = 50, [2] = 235, [3] = 180 }, [6] = { [0] = 18, [1] = 45, [2] = 239, [3] = 177 }, [7] = { [0] = 16, [1] = 45, [2] = 236, [3] = 177 } })[R[36]][R[20]], ({ [0] = { [0] = 61, [1] = 23, [2] = 99, [3] = 116 }, [1] = { [0] = 52, [1] = 21, [2] = 92, [3] = 107 }, [2] = { [0] = 56, [1] = 17, [2] = 99, [3] = 119 }, [3] = { [0] = 58, [1] = 19, [2] = 98, [3] = 126 }, [4] = { [0] = 62, [1] = 24, [2] = 104, [3] = 126 }, [5] = { [0] = 60, [1] = 18, [2] = 96, [3] = 119 }, [6] = { [0] = 47, [1] = 5, [2] = 89, [3] = 111 }, [7] = { [0] = 65, [1] = 26, [2] = 100, [3] = 111 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 50, [2] = 241, [3] = 175 }, [1] = { [0] = 31, [1] = 58, [2] = 248, [3] = 173 }, [2] = { [0] = 19, [1] = 46, [2] = 240, [3] = 171 }, [3] = { [0] = 21, [1] = 48, [2] = 242, [3] = 176 }, [4] = { [0] = 22, [1] = 45, [2] = 241, [3] = 176 }, [5] = { [0] = 24, [1] = 50, [2] = 235, [3] = 180 }, [6] = { [0] = 18, [1] = 45, [2] = 239, [3] = 177 }, [7] = { [0] = 17, [1] = 46, [2] = 237, [3] = 177 } })[R[36]][R[20]], ({ [0] = { [0] = 62, [1] = 24, [2] = 100, [3] = 117 }, [1] = { [0] = 53, [1] = 22, [2] = 93, [3] = 108 }, [2] = { [0] = 50, [1] = 11, [2] = 93, [3] = 113 }, [3] = { [0] = 51, [1] = 12, [2] = 91, [3] = 110 }, [4] = { [0] = 46, [1] = 8, [2] = 88, [3] = 110 }, [5] = { [0] = 66, [1] = 24, [2] = 102, [3] = 125 }, [6] = { [0] = 55, [1] = 13, [2] = 97, [3] = 119 }, [7] = { [0] = 52, [1] = 13, [2] = 87, [3] = 119 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 50, [2] = 241, [3] = 175 }, [1] = { [0] = 31, [1] = 58, [2] = 248, [3] = 173 }, [2] = { [0] = 19, [1] = 46, [2] = 240, [3] = 171 }, [3] = { [0] = 21, [1] = 48, [2] = 242, [3] = 176 }, [4] = { [0] = 22, [1] = 45, [2] = 241, [3] = 176 }, [5] = { [0] = 25, [1] = 51, [2] = 236, [3] = 181 }, [6] = { [0] = 20, [1] = 47, [2] = 241, [3] = 179 }, [7] = { [0] = 17, [1] = 46, [2] = 237, [3] = 179 } })[R[36]][R[20]], ({ [0] = { [0] = 63, [1] = 25, [2] = 101, [3] = 118 }, [1] = { [0] = 54, [1] = 23, [2] = 94, [3] = 109 }, [2] = { [0] = 56, [1] = 17, [2] = 99, [3] = 119 }, [3] = { [0] = 58, [1] = 19, [2] = 98, [3] = 118 }, [4] = { [0] = 54, [1] = 16, [2] = 96, [3] = 118 }, [5] = { [0] = 60, [1] = 18, [2] = 96, [3] = 119 }, [6] = { [0] = 49, [1] = 7, [2] = 91, [3] = 113 }, [7] = { [0] = 65, [1] = 26, [2] = 100, [3] = 113 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 33, [1] = 53, [2] = 244, [3] = 178 }, [1] = { [0] = 31, [1] = 58, [2] = 248, [3] = 173 }, [2] = { [0] = 20, [1] = 47, [2] = 241, [3] = 172 }, [3] = { [0] = 22, [1] = 49, [2] = 243, [3] = 176 }, [4] = { [0] = 22, [1] = 45, [2] = 241, [3] = 176 }, [5] = { [0] = 25, [1] = 51, [2] = 236, [3] = 181 }, [6] = { [0] = 20, [1] = 47, [2] = 241, [3] = 179 }, [7] = { [0] = 18, [1] = 47, [2] = 238, [3] = 179 } })[R[36]][R[20]], ({ [0] = { [0] = 58, [1] = 20, [2] = 96, [3] = 113 }, [1] = { [0] = 55, [1] = 24, [2] = 95, [3] = 110 }, [2] = { [0] = 50, [1] = 11, [2] = 93, [3] = 113 }, [3] = { [0] = 51, [1] = 12, [2] = 91, [3] = 126 }, [4] = { [0] = 62, [1] = 24, [2] = 104, [3] = 126 }, [5] = { [0] = 66, [1] = 24, [2] = 102, [3] = 125 }, [6] = { [0] = 50, [1] = 8, [2] = 92, [3] = 114 }, [7] = { [0] = 52, [1] = 13, [2] = 87, [3] = 114 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 34, [1] = 54, [2] = 245, [3] = 179 }, [1] = { [0] = 31, [1] = 58, [2] = 248, [3] = 173 }, [2] = { [0] = 20, [1] = 47, [2] = 241, [3] = 172 }, [3] = { [0] = 23, [1] = 50, [2] = 244, [3] = 177 }, [4] = { [0] = 23, [1] = 46, [2] = 242, [3] = 177 }, [5] = { [0] = 26, [1] = 52, [2] = 237, [3] = 182 }, [6] = { [0] = 20, [1] = 47, [2] = 241, [3] = 179 }, [7] = { [0] = 18, [1] = 47, [2] = 238, [3] = 179 } })[R[36]][R[20]], ({ [0] = { [0] = 58, [1] = 20, [2] = 96, [3] = 113 }, [1] = { [0] = 56, [1] = 25, [2] = 96, [3] = 111 }, [2] = { [0] = 56, [1] = 17, [2] = 99, [3] = 119 }, [3] = { [0] = 51, [1] = 12, [2] = 91, [3] = 110 }, [4] = { [0] = 46, [1] = 8, [2] = 88, [3] = 110 }, [5] = { [0] = 60, [1] = 18, [2] = 96, [3] = 119 }, [6] = { [0] = 51, [1] = 9, [2] = 93, [3] = 115 }, [7] = { [0] = 65, [1] = 26, [2] = 100, [3] = 115 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 55, [2] = 246, [3] = 180 }, [1] = { [0] = 31, [1] = 58, [2] = 248, [3] = 173 }, [2] = { [0] = 21, [1] = 48, [2] = 242, [3] = 173 }, [3] = { [0] = 24, [1] = 51, [2] = 245, [3] = 177 }, [4] = { [0] = 23, [1] = 46, [2] = 242, [3] = 177 }, [5] = { [0] = 27, [1] = 53, [2] = 238, [3] = 183 }, [6] = { [0] = 20, [1] = 47, [2] = 241, [3] = 179 }, [7] = { [0] = 19, [1] = 48, [2] = 239, [3] = 179 } })[R[36]][R[20]], ({ [0] = { [0] = 58, [1] = 20, [2] = 96, [3] = 113 }, [1] = { [0] = 57, [1] = 26, [2] = 97, [3] = 112 }, [2] = { [0] = 50, [1] = 11, [2] = 93, [3] = 113 }, [3] = { [0] = 51, [1] = 12, [2] = 91, [3] = 111 }, [4] = { [0] = 47, [1] = 9, [2] = 89, [3] = 111 }, [5] = { [0] = 60, [1] = 18, [2] = 96, [3] = 119 }, [6] = { [0] = 52, [1] = 10, [2] = 94, [3] = 116 }, [7] = { [0] = 52, [1] = 13, [2] = 87, [3] = 116 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 56, [2] = 247, [3] = 181 }, [1] = { [0] = 31, [1] = 58, [2] = 248, [3] = 173 }, [2] = { [0] = 21, [1] = 48, [2] = 242, [3] = 173 }, [3] = { [0] = 25, [1] = 52, [2] = 246, [3] = 177 }, [4] = { [0] = 23, [1] = 46, [2] = 242, [3] = 177 }, [5] = { [0] = 28, [1] = 54, [2] = 239, [3] = 184 }, [6] = { [0] = 20, [1] = 47, [2] = 241, [3] = 179 }, [7] = { [0] = 19, [1] = 48, [2] = 239, [3] = 179 } })[R[36]][R[20]], ({ [0] = { [0] = 58, [1] = 20, [2] = 96, [3] = 113 }, [1] = { [0] = 62, [1] = 31, [2] = 102, [3] = 117 }, [2] = { [0] = 56, [1] = 17, [2] = 99, [3] = 119 }, [3] = { [0] = 51, [1] = 12, [2] = 91, [3] = 118 }, [4] = { [0] = 54, [1] = 16, [2] = 96, [3] = 118 }, [5] = { [0] = 60, [1] = 18, [2] = 96, [3] = 119 }, [6] = { [0] = 53, [1] = 11, [2] = 95, [3] = 117 }, [7] = { [0] = 53, [1] = 14, [2] = 88, [3] = 117 } })[R[36]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 57, [2] = 248, [3] = 182 }, [1] = { [0] = 31, [1] = 58, [2] = 248, [3] = 173 }, [2] = { [0] = 22, [1] = 49, [2] = 243, [3] = 174 }, [3] = { [0] = 26, [1] = 53, [2] = 247, [3] = 177 }, [4] = { [0] = 23, [1] = 46, [2] = 242, [3] = 177 }, [5] = { [0] = 28, [1] = 54, [2] = 239, [3] = 184 }, [6] = { [0] = 24, [1] = 51, [2] = 245, [3] = 183 }, [7] = { [0] = 19, [1] = 48, [2] = 239, [3] = 183 } })[R[36]][R[20]], ({ [0] = { [0] = 58, [1] = 20, [2] = 96, [3] = 113 }, [1] = { [0] = 63, [1] = 32, [2] = 103, [3] = 118 }, [2] = { [0] = 50, [1] = 11, [2] = 93, [3] = 113 }, [3] = { [0] = 51, [1] = 12, [2] = 91, [3] = 126 }, [4] = { [0] = 62, [1] = 24, [2] = 104, [3] = 126 }, [5] = { [0] = 61, [1] = 19, [2] = 97, [3] = 120 }, [6] = { [0] = 55, [1] = 13, [2] = 97, [3] = 119 }, [7] = { [0] = 54, [1] = 15, [2] = 89, [3] = 119 } })[R[36]][R[20]] })
    if R[36] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 58, [2] = 249, [3] = 183 })[R[20]], ({ [0] = 58, [1] = 20, [2] = 96, [3] = 113 })[R[20]] })
        game.create_tube({ ({ [0] = 39, [1] = 59, [2] = 250, [3] = 184 })[R[20]], ({ [0] = 58, [1] = 20, [2] = 96, [3] = 113 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 58, [2] = 249, [3] = 183 })[R[20]], ({ [0] = 58, [1] = 20, [2] = 96, [3] = 113 })[R[20]] })
        game.create_tube({ ({ [0] = 39, [1] = 59, [2] = 250, [3] = 184 })[R[20]], ({ [0] = 58, [1] = 20, [2] = 96, [3] = 113 })[R[20]] })
        for i = 1, game.initial_units() do
          R[37] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 56, [2] = 247, [3] = 181 }, [1] = { [0] = 23, [1] = 43, [2] = 234, [3] = 168 }, [2] = { [0] = 35, [1] = 55, [2] = 246, [3] = 180 } })[R[37]][R[20]], ({ [0] = { [0] = 52, [1] = 14, [2] = 90, [3] = 107 }, [1] = { [0] = 61, [1] = 23, [2] = 99, [3] = 116 }, [2] = { [0] = 64, [1] = 26, [2] = 102, [3] = 119 } })[R[37]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 58, [2] = 248, [3] = 173 })[R[20]], ({ [0] = 64, [1] = 33, [2] = 104, [3] = 119 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 58, [2] = 248, [3] = 173 })[R[20]], ({ [0] = 64, [1] = 33, [2] = 104, [3] = 119 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 58, [2] = 248, [3] = 173 })[R[20]], ({ [0] = 65, [1] = 34, [2] = 105, [3] = 120 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 58, [2] = 248, [3] = 173 })[R[20]], ({ [0] = 64, [1] = 33, [2] = 104, [3] = 119 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 58, [2] = 248, [3] = 173 })[R[20]], ({ [0] = 64, [1] = 33, [2] = 104, [3] = 119 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 58, [2] = 248, [3] = 173 })[R[20]], ({ [0] = 65, [1] = 34, [2] = 105, [3] = 120 })[R[20]] })
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 49, [2] = 239, [3] = 164 }, [1] = { [0] = 24, [1] = 51, [2] = 241, [3] = 166 }, [2] = { [0] = 26, [1] = 53, [2] = 243, [3] = 168 } })[R[38]][R[20]], ({ [0] = { [0] = 59, [1] = 28, [2] = 99, [3] = 114 }, [1] = { [0] = 61, [1] = 30, [2] = 101, [3] = 116 }, [2] = { [0] = 53, [1] = 22, [2] = 93, [3] = 108 } })[R[38]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 13, [1] = 40, [2] = 234, [3] = 165 }, [1] = { [0] = 18, [1] = 45, [2] = 239, [3] = 170 }, [2] = { [0] = 31, [1] = 58, [2] = 252, [3] = 183 } })[R[39]][R[20]], ({ [0] = { [0] = 44, [1] = 5, [2] = 87, [3] = 107 }, [1] = { [0] = 60, [1] = 21, [2] = 103, [3] = 123 }, [2] = { [0] = 53, [1] = 14, [2] = 96, [3] = 116 } })[R[39]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 3 then
      game.create_tube({ ({ [0] = 26, [1] = 53, [2] = 247, [3] = 178 })[R[20]], ({ [0] = 58, [1] = 19, [2] = 98, [3] = 111 })[R[20]] })
      game.create_tube({ ({ [0] = 27, [1] = 54, [2] = 248, [3] = 178 })[R[20]], ({ [0] = 58, [1] = 19, [2] = 98, [3] = 112 })[R[20]] })
      game.create_tube({ ({ [0] = 28, [1] = 55, [2] = 249, [3] = 178 })[R[20]], ({ [0] = 58, [1] = 19, [2] = 98, [3] = 118 })[R[20]] })
      game.create_tube({ ({ [0] = 29, [1] = 56, [2] = 250, [3] = 178 })[R[20]], ({ [0] = 54, [1] = 15, [2] = 94, [3] = 126 })[R[20]] })
      game.create_tube({ ({ [0] = 29, [1] = 56, [2] = 250, [3] = 179 })[R[20]], ({ [0] = 58, [1] = 19, [2] = 98, [3] = 112 })[R[20]] })
      game.create_tube({ ({ [0] = 30, [1] = 57, [2] = 251, [3] = 179 })[R[20]], ({ [0] = 54, [1] = 15, [2] = 94, [3] = 118 })[R[20]] })
      game.create_tube({ ({ [0] = 30, [1] = 57, [2] = 251, [3] = 179 })[R[20]], ({ [0] = 55, [1] = 16, [2] = 95, [3] = 126 })[R[20]] })
      game.create_tube({ ({ [0] = 30, [1] = 57, [2] = 251, [3] = 180 })[R[20]], ({ [0] = 56, [1] = 17, [2] = 96, [3] = 112 })[R[20]] })
      game.create_tube({ ({ [0] = 30, [1] = 57, [2] = 251, [3] = 180 })[R[20]], ({ [0] = 57, [1] = 18, [2] = 97, [3] = 118 })[R[20]] })
      game.create_tube({ ({ [0] = 30, [1] = 57, [2] = 251, [3] = 180 })[R[20]], ({ [0] = 58, [1] = 19, [2] = 98, [3] = 126 })[R[20]] })
      game.create_tube({ ({ [0] = 31, [1] = 58, [2] = 252, [3] = 181 })[R[20]], ({ [0] = 58, [1] = 19, [2] = 98, [3] = 117 })[R[20]] })
      game.create_tube({ ({ [0] = 31, [1] = 58, [2] = 252, [3] = 181 })[R[20]], ({ [0] = 59, [1] = 20, [2] = 99, [3] = 118 })[R[20]] })
      if R[20] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 31, 60 })
          for i = 1, game.initial_units() do
            R[40] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 24, [1] = 25, [2] = 12 })[R[40]], ({ [0] = 54, [1] = 61, [2] = 58 })[R[40]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 31, 60 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 58, 21 })
          for i = 1, game.initial_units() do
            R[41] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 51, [1] = 52, [2] = 39 })[R[41]], ({ [0] = 15, [1] = 22, [2] = 19 })[R[41]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 58, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 2 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 252, 100 })
          for i = 1, game.initial_units() do
            R[42] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 245, [1] = 246, [2] = 233 })[R[42]], ({ [0] = 94, [1] = 101, [2] = 98 })[R[42]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 252, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 3 then
        if game.initial_units() == 0 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
          for i = 1, game.initial_units() do
            R[43] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 176, [1] = 167, [2] = 175 })[R[43]], ({ [0] = 109, [1] = 117, [2] = 112 })[R[43]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[20]", R[20])
      end
    elseif R[36] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 47, [2] = 243, [3] = 178 })[R[20]], ({ [0] = 47, [1] = 9, [2] = 89, [3] = 111 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 47, [2] = 243, [3] = 178 })[R[20]], ({ [0] = 48, [1] = 10, [2] = 90, [3] = 112 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 47, [2] = 243, [3] = 178 })[R[20]], ({ [0] = 54, [1] = 16, [2] = 96, [3] = 118 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 47, [2] = 243, [3] = 178 })[R[20]], ({ [0] = 62, [1] = 24, [2] = 104, [3] = 126 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 48, [2] = 244, [3] = 179 })[R[20]], ({ [0] = 48, [1] = 10, [2] = 90, [3] = 112 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 48, [2] = 244, [3] = 179 })[R[20]], ({ [0] = 54, [1] = 16, [2] = 96, [3] = 118 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 48, [2] = 244, [3] = 179 })[R[20]], ({ [0] = 62, [1] = 24, [2] = 104, [3] = 126 })[R[20]] })
        game.create_tube({ ({ [0] = 26, [1] = 49, [2] = 245, [3] = 180 })[R[20]], ({ [0] = 48, [1] = 10, [2] = 90, [3] = 112 })[R[20]] })
        game.create_tube({ ({ [0] = 26, [1] = 49, [2] = 245, [3] = 180 })[R[20]], ({ [0] = 54, [1] = 16, [2] = 96, [3] = 118 })[R[20]] })
        game.create_tube({ ({ [0] = 26, [1] = 49, [2] = 245, [3] = 180 })[R[20]], ({ [0] = 62, [1] = 24, [2] = 104, [3] = 126 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 50, [2] = 246, [3] = 181 })[R[20]], ({ [0] = 53, [1] = 15, [2] = 95, [3] = 117 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 50, [2] = 246, [3] = 181 })[R[20]], ({ [0] = 54, [1] = 16, [2] = 96, [3] = 118 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 50, [2] = 246, [3] = 181 })[R[20]], ({ [0] = 55, [1] = 17, [2] = 97, [3] = 119 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 50, [2] = 246, [3] = 181 })[R[20]], ({ [0] = 56, [1] = 18, [2] = 98, [3] = 120 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 50, [2] = 246, [3] = 181 })[R[20]], ({ [0] = 61, [1] = 23, [2] = 103, [3] = 125 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 50, [2] = 246, [3] = 181 })[R[20]], ({ [0] = 62, [1] = 24, [2] = 104, [3] = 126 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 51, [2] = 247, [3] = 182 })[R[20]], ({ [0] = 53, [1] = 15, [2] = 95, [3] = 117 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 51, [2] = 247, [3] = 182 })[R[20]], ({ [0] = 61, [1] = 23, [2] = 103, [3] = 125 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 52, [2] = 248, [3] = 183 })[R[20]], ({ [0] = 51, [1] = 13, [2] = 93, [3] = 115 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 52, [2] = 248, [3] = 183 })[R[20]], ({ [0] = 52, [1] = 14, [2] = 94, [3] = 116 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 52, [2] = 248, [3] = 183 })[R[20]], ({ [0] = 53, [1] = 15, [2] = 95, [3] = 117 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 52, [2] = 248, [3] = 183 })[R[20]], ({ [0] = 61, [1] = 23, [2] = 103, [3] = 125 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 47, [2] = 243, [3] = 178 })[R[20]], ({ [0] = 47, [1] = 9, [2] = 89, [3] = 111 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 47, [2] = 243, [3] = 178 })[R[20]], ({ [0] = 48, [1] = 10, [2] = 90, [3] = 112 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 47, [2] = 243, [3] = 178 })[R[20]], ({ [0] = 54, [1] = 16, [2] = 96, [3] = 118 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 47, [2] = 243, [3] = 178 })[R[20]], ({ [0] = 62, [1] = 24, [2] = 104, [3] = 126 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 48, [2] = 244, [3] = 179 })[R[20]], ({ [0] = 48, [1] = 10, [2] = 90, [3] = 112 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 48, [2] = 244, [3] = 179 })[R[20]], ({ [0] = 54, [1] = 16, [2] = 96, [3] = 118 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 48, [2] = 244, [3] = 179 })[R[20]], ({ [0] = 62, [1] = 24, [2] = 104, [3] = 126 })[R[20]] })
        game.create_tube({ ({ [0] = 26, [1] = 49, [2] = 245, [3] = 180 })[R[20]], ({ [0] = 48, [1] = 10, [2] = 90, [3] = 112 })[R[20]] })
        game.create_tube({ ({ [0] = 26, [1] = 49, [2] = 245, [3] = 180 })[R[20]], ({ [0] = 54, [1] = 16, [2] = 96, [3] = 118 })[R[20]] })
        game.create_tube({ ({ [0] = 26, [1] = 49, [2] = 245, [3] = 180 })[R[20]], ({ [0] = 62, [1] = 24, [2] = 104, [3] = 126 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 50, [2] = 246, [3] = 181 })[R[20]], ({ [0] = 53, [1] = 15, [2] = 95, [3] = 117 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 50, [2] = 246, [3] = 181 })[R[20]], ({ [0] = 54, [1] = 16, [2] = 96, [3] = 118 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 50, [2] = 246, [3] = 181 })[R[20]], ({ [0] = 55, [1] = 17, [2] = 97, [3] = 119 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 50, [2] = 246, [3] = 181 })[R[20]], ({ [0] = 56, [1] = 18, [2] = 98, [3] = 120 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 50, [2] = 246, [3] = 181 })[R[20]], ({ [0] = 61, [1] = 23, [2] = 103, [3] = 125 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 50, [2] = 246, [3] = 181 })[R[20]], ({ [0] = 62, [1] = 24, [2] = 104, [3] = 126 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 51, [2] = 247, [3] = 182 })[R[20]], ({ [0] = 53, [1] = 15, [2] = 95, [3] = 117 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 51, [2] = 247, [3] = 182 })[R[20]], ({ [0] = 61, [1] = 23, [2] = 103, [3] = 125 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 52, [2] = 248, [3] = 183 })[R[20]], ({ [0] = 51, [1] = 13, [2] = 93, [3] = 115 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 52, [2] = 248, [3] = 183 })[R[20]], ({ [0] = 52, [1] = 14, [2] = 94, [3] = 116 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 52, [2] = 248, [3] = 183 })[R[20]], ({ [0] = 53, [1] = 15, [2] = 95, [3] = 117 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 52, [2] = 248, [3] = 183 })[R[20]], ({ [0] = 61, [1] = 23, [2] = 103, [3] = 125 })[R[20]] })
        for i = 1, game.initial_units() do
          R[44] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 45, [2] = 241, [3] = 176 }, [1] = { [0] = 13, [1] = 36, [2] = 232, [3] = 167 }, [2] = { [0] = 21, [1] = 44, [2] = 240, [3] = 175 } })[R[44]][R[20]], ({ [0] = { [0] = 45, [1] = 7, [2] = 87, [3] = 109 }, [1] = { [0] = 53, [1] = 15, [2] = 95, [3] = 117 }, [2] = { [0] = 48, [1] = 10, [2] = 90, [3] = 112 } })[R[44]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 54, [2] = 239, [3] = 184 })[R[20]], ({ [0] = 62, [1] = 20, [2] = 98, [3] = 121 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 54, [2] = 239, [3] = 184 })[R[20]], ({ [0] = 63, [1] = 21, [2] = 99, [3] = 122 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 54, [2] = 239, [3] = 184 })[R[20]], ({ [0] = 62, [1] = 20, [2] = 98, [3] = 121 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 54, [2] = 239, [3] = 184 })[R[20]], ({ [0] = 63, [1] = 21, [2] = 99, [3] = 122 })[R[20]] })
        for i = 1, game.initial_units() do
          R[45] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 50, [2] = 235, [3] = 180 }, [1] = { [0] = 7, [1] = 33, [2] = 218, [3] = 163 }, [2] = { [0] = 29, [1] = 55, [2] = 240, [3] = 185 } })[R[45]][R[20]], ({ [0] = { [0] = 69, [1] = 27, [2] = 105, [3] = 128 }, [1] = { [0] = 56, [1] = 14, [2] = 92, [3] = 115 }, [2] = { [0] = 69, [1] = 27, [2] = 105, [3] = 128 } })[R[45]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 52, [2] = 246, [3] = 184 })[R[20]], ({ [0] = 55, [1] = 13, [2] = 97, [3] = 119 })[R[20]] })
        game.create_tube({ ({ [0] = 26, [1] = 53, [2] = 247, [3] = 185 })[R[20]], ({ [0] = 55, [1] = 13, [2] = 97, [3] = 119 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 54, [2] = 248, [3] = 186 })[R[20]], ({ [0] = 55, [1] = 13, [2] = 97, [3] = 119 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 52, [2] = 246, [3] = 184 })[R[20]], ({ [0] = 55, [1] = 13, [2] = 97, [3] = 119 })[R[20]] })
        game.create_tube({ ({ [0] = 26, [1] = 53, [2] = 247, [3] = 185 })[R[20]], ({ [0] = 55, [1] = 13, [2] = 97, [3] = 119 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 54, [2] = 248, [3] = 186 })[R[20]], ({ [0] = 55, [1] = 13, [2] = 97, [3] = 119 })[R[20]] })
        for i = 1, game.initial_units() do
          R[46] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 6, [1] = 33, [2] = 227, [3] = 165 }, [1] = { [0] = 11, [1] = 38, [2] = 232, [3] = 170 }, [2] = { [0] = 32, [1] = 59, [2] = 253, [3] = 191 } })[R[46]][R[20]], ({ [0] = { [0] = 45, [1] = 3, [2] = 87, [3] = 109 }, [1] = { [0] = 43, [1] = 1, [2] = 85, [3] = 107 }, [2] = { [0] = 58, [1] = 16, [2] = 100, [3] = 122 } })[R[46]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 7 then
      game.create_tube({ ({ [0] = 19, [1] = 48, [2] = 239, [3] = 184 })[R[20]], ({ [0] = 55, [1] = 16, [2] = 90, [3] = 119 })[R[20]] })
      game.create_tube({ ({ [0] = 19, [1] = 48, [2] = 239, [3] = 185 })[R[20]], ({ [0] = 56, [1] = 17, [2] = 91, [3] = 119 })[R[20]] })
      if R[20] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
          for i = 1, game.initial_units() do
            R[47] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 17, [1] = 23, [2] = 11 })[R[47]], ({ [0] = 48, [1] = 48, [2] = 69 })[R[47]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
          for i = 1, game.initial_units() do
            R[48] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 46, [1] = 52, [2] = 40 })[R[48]], ({ [0] = 9, [1] = 9, [2] = 30 })[R[48]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 2 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
          for i = 1, game.initial_units() do
            R[49] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 237, [1] = 243, [2] = 231 })[R[49]], ({ [0] = 83, [1] = 83, [2] = 104 })[R[49]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 3 then
        if game.initial_units() == 0 then
          game.create_tube({ 186, 119 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 186, 119 })
          for i = 1, game.initial_units() do
            R[50] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 165, [1] = 170, [2] = 191 })[R[50]], ({ [0] = 109, [1] = 107, [2] = 122 })[R[50]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[20]", R[20])
      end
    else
      unseen("R[36]", R[36])
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 193, 89 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 190, 124 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 71, 34 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 45, 57 } }
    R[0] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[0]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[0]] } }
    R[1] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[1]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[1]] } }
    R[2] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[2]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[2]] } }
    R[3] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[3]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 69 })[R[3]] } }
    R[4] = draw_avoid(8, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[4]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[4]] } }
    R[5] = draw_avoid(8, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[5]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[5]] } }
    R[6] = draw_avoid(8, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[6]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[6]] } }
    R[7] = draw_avoid(8, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[7]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 69 })[R[7]] } }
    R[8] = draw_avoid(8, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[8]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[8]] } }
    R[9] = draw_avoid(8, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[9]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[9]] } }
    R[10] = draw_avoid(8, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[10]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[10]] } }
    R[11] = draw_avoid(8, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[11]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 69 })[R[11]] } }
    R[12] = draw_avoid(8, { R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[12]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[12]] } }
    R[13] = draw_avoid(8, { R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[13]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[13]] } }
    R[14] = draw_avoid(8, { R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[14]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[14]] } }
    R[15] = draw_avoid(8, { R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[15]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 69 })[R[15]] } }
    R[16] = draw_avoid(8, { R[12], R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[16]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[16]] } }
    R[17] = draw_avoid(8, { R[13], R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[17]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[17]] } }
    R[18] = draw_avoid(8, { R[14], R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[18]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[18]] } }
    R[19] = draw_avoid(8, { R[15], R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[19]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 69 })[R[19]] } }
    pick(4, 3, { 20, 51, 52 })
    R[21] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 50, [1] = 23, [2] = 172, [3] = 244 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 48, [1] = 19, [2] = 170, [3] = 239 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 6, [1] = 45, [2] = 108, [3] = 88 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 20, [1] = 59, [2] = 111, [3] = 94 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 50, [1] = 23, [2] = 172, [3] = 244 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 48, [1] = 19, [2] = 170, [3] = 239 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 6, [1] = 45, [2] = 108, [3] = 88 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 20, [1] = 59, [2] = 111, [3] = 94 } })[R[21]][R[20]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 39, [1] = 12, [2] = 164, [3] = 233 }, [3] = { [0] = 58, [1] = 31, [2] = 172, [3] = 252 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 41, [1] = 12, [2] = 179, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 11, [1] = 42, [2] = 97, [3] = 82 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 23, [1] = 62, [2] = 126, [3] = 102 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    if R[21] == 3 or R[21] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 } })[R[21]][R[20]], ({ [3] = { [0] = 23, [1] = 62, [2] = 110, [3] = 102 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[21] == 3 then
        if R[20] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
        elseif R[20] == 0 or R[20] == 1 or R[20] == 3 then
        else
          unseen("R[20]", R[20])
        end
      elseif R[21] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[21]", R[21])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [3] = { [0] = 45, [1] = 18, [2] = 183, [3] = 239 }, [4] = { [0] = 52, [1] = 29, [2] = 183, [3] = 248 } })[R[21]][R[20]], ({ [3] = { [0] = 12, [1] = 51, [2] = 122, [3] = 91 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[21] == 3 then
        if R[20] == 0 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[20] == 1 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[20] == 2 then
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
        elseif R[20] == 3 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[20]", R[20])
        end
      elseif R[21] == 4 then
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
        unseen("R[21]", R[21])
      end
    elseif R[21] == 0 or R[21] == 1 or R[21] == 2 or R[21] == 5 or R[21] == 6 or R[21] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 62, [1] = 42, [2] = 187, [3] = 253 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 42, [1] = 15, [2] = 167, [3] = 236 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 48, [1] = 21, [2] = 180, [3] = 242 }, [7] = { [0] = 41, [1] = 12, [2] = 180, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 18, [1] = 49, [2] = 104, [3] = 89 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [5] = { [0] = 23, [1] = 65, [2] = 124, [3] = 101 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[21] == 0 then
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
      elseif R[21] == 1 then
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
      elseif R[21] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[20]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[20]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[20]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[20]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[20]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[20]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[21]", R[21])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 39, [1] = 19, [2] = 164, [3] = 230 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 39, [1] = 12, [2] = 171, [3] = 233 }, [7] = { [0] = 57, [1] = 28, [2] = 171, [3] = 248 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 28, [1] = 59, [2] = 114, [3] = 99 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 25, [1] = 64, [2] = 119, [3] = 99 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[21] == 2 or R[21] == 5 or R[21] == 6 or R[21] == 7 then
      elseif R[21] == 0 or R[21] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 } })[R[21]][R[20]], ({ [0] = { [0] = 27, [1] = 65, [2] = 120, [3] = 103 }, [1] = { [0] = 36, [1] = 67, [2] = 122, [3] = 107 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[21]", R[21])
      end
    else
      unseen("R[21]", R[21])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 39, [1] = 19, [2] = 164, [3] = 230 }, [1] = { [0] = 48, [1] = 21, [2] = 163, [3] = 238 }, [2] = { [0] = 59, [1] = 32, [2] = 184, [3] = 253 }, [3] = { [0] = 51, [1] = 24, [2] = 164, [3] = 245 }, [4] = { [0] = 33, [1] = 10, [2] = 164, [3] = 229 }, [5] = { [0] = 34, [1] = 8, [2] = 164, [3] = 219 }, [6] = { [0] = 31, [1] = 4, [2] = 163, [3] = 225 }, [7] = { [0] = 49, [1] = 20, [2] = 163, [3] = 240 } })[R[21]][R[20]], ({ [0] = { [0] = 29, [1] = 67, [2] = 122, [3] = 105 }, [1] = { [0] = 33, [1] = 64, [2] = 119, [3] = 104 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 6, [1] = 45, [2] = 114, [3] = 85 }, [4] = { [0] = 12, [1] = 50, [2] = 114, [3] = 92 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 29, [1] = 68, [2] = 119, [3] = 103 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 46, [1] = 26, [2] = 171, [3] = 237 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 40, [1] = 13, [2] = 182, [3] = 234 }, [4] = { [0] = 51, [1] = 28, [2] = 182, [3] = 247 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 59, [1] = 30, [2] = 170, [3] = 250 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 15, [1] = 54, [2] = 117, [3] = 97 }, [3] = { [0] = 13, [1] = 52, [2] = 118, [3] = 92 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 9, [1] = 51, [2] = 110, [3] = 87 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 20, [1] = 59, [2] = 124, [3] = 94 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 43, [1] = 16, [2] = 184, [3] = 237 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 17, [1] = 48, [2] = 103, [3] = 88 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 9, [1] = 48, [2] = 118, [3] = 88 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 60, [1] = 33, [2] = 176, [3] = 254 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 31, [2] = 176, [3] = 252 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 9, [1] = 48, [2] = 126, [3] = 88 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 184, [3] = 240 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 24, [1] = 63, [2] = 118, [3] = 103 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 184, [3] = 240 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 24, [1] = 63, [2] = 118, [3] = 103 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 40, [1] = 13, [2] = 176, [3] = 234 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "RoboSurveyor", [3] = "CargoTruck" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 40, [1] = 13, [2] = 177, [3] = 234 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 39, [1] = 13, [2] = 169, [3] = 224 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 43, [1] = 14, [2] = 175, [3] = 234 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 19, [1] = 58, [2] = 121, [3] = 101 }, [3] = { [0] = 13, [1] = 52, [2] = 122, [3] = 92 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 8, [1] = 50, [2] = 109, [3] = 86 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 20, [1] = 59, [2] = 121, [3] = 94 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [3] = { [0] = 46, [1] = 19, [2] = 179, [3] = 240 }, [4] = { [0] = 48, [1] = 25, [2] = 179, [3] = 244 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 38, [1] = 9, [2] = 184, [3] = 229 } })[R[21]][R[20]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 10, [1] = 41, [2] = 96, [3] = 81 }, [2] = { [0] = 20, [1] = 59, [2] = 122, [3] = 102 }, [3] = { [0] = 24, [1] = 63, [2] = 113, [3] = 103 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 12, [1] = 54, [2] = 118, [3] = 96 }, [7] = { [0] = 17, [1] = 56, [2] = 118, [3] = 91 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 60, [1] = 33, [2] = 176, [3] = 254 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 31, [2] = 176, [3] = 252 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 9, [1] = 48, [2] = 126, [3] = 88 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 184, [3] = 240 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 24, [1] = 63, [2] = 118, [3] = 103 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 46, [1] = 19, [2] = 176, [3] = 240 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 24, [1] = 63, [2] = 126, [3] = 103 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "RoboSurveyor", [3] = "CargoTruck" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 40, [1] = 13, [2] = 177, [3] = 234 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 39, [1] = 13, [2] = 169, [3] = 224 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 43, [1] = 14, [2] = 175, [3] = 234 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 19, [1] = 58, [2] = 121, [3] = 101 }, [3] = { [0] = 13, [1] = 52, [2] = 122, [3] = 92 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 8, [1] = 50, [2] = 109, [3] = 86 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 20, [1] = 59, [2] = 121, [3] = 94 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [3] = { [0] = 46, [1] = 19, [2] = 179, [3] = 240 }, [4] = { [0] = 48, [1] = 25, [2] = 179, [3] = 244 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 38, [1] = 9, [2] = 184, [3] = 229 } })[R[21]][R[20]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 10, [1] = 41, [2] = 96, [3] = 81 }, [2] = { [0] = 20, [1] = 59, [2] = 122, [3] = 102 }, [3] = { [0] = 24, [1] = 63, [2] = 113, [3] = 103 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 12, [1] = 54, [2] = 118, [3] = 96 }, [7] = { [0] = 17, [1] = 56, [2] = 118, [3] = 91 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 60, [1] = 33, [2] = 176, [3] = 254 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 31, [2] = 176, [3] = 252 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 9, [1] = 48, [2] = 126, [3] = 88 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboSurveyor", [3] = "ConVec" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 177, [3] = 240 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 39, [1] = 13, [2] = 169, [3] = 224 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 43, [1] = 14, [2] = 175, [3] = 234 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 19, [1] = 58, [2] = 121, [3] = 101 }, [3] = { [0] = 24, [1] = 63, [2] = 122, [3] = 103 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 8, [1] = 50, [2] = 109, [3] = 86 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 20, [1] = 59, [2] = 121, [3] = 94 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[21]][R[20]], player = players[1], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [3] = { [0] = 46, [1] = 19, [2] = 179, [3] = 240 }, [4] = { [0] = 48, [1] = 25, [2] = 179, [3] = 244 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 38, [1] = 9, [2] = 184, [3] = 229 } })[R[21]][R[20]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 10, [1] = 41, [2] = 96, [3] = 81 }, [2] = { [0] = 20, [1] = 59, [2] = 122, [3] = 102 }, [3] = { [0] = 24, [1] = 63, [2] = 113, [3] = 103 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 12, [1] = 54, [2] = 118, [3] = 96 }, [7] = { [0] = 17, [1] = 56, [2] = 118, [3] = 91 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 62, [1] = 42, [2] = 187, [3] = 253 }, [1] = { [0] = 56, [1] = 29, [2] = 171, [3] = 246 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 50, [1] = 23, [2] = 185, [3] = 244 }, [4] = { [0] = 54, [1] = 31, [2] = 185, [3] = 250 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 52, [1] = 23, [2] = 184, [3] = 243 } })[R[21]][R[20]], ({ [0] = { [0] = 24, [1] = 62, [2] = 117, [3] = 100 }, [1] = { [0] = 23, [1] = 54, [2] = 109, [3] = 94 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 10, [1] = 49, [2] = 109, [3] = 89 }, [4] = { [0] = 7, [1] = 45, [2] = 109, [3] = 87 }, [5] = { [0] = 25, [1] = 67, [2] = 126, [3] = 103 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 19, [1] = 58, [2] = 121, [3] = 93 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 22, [2] = 167, [3] = 233 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 42, [1] = 15, [2] = 167, [3] = 236 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 19, [1] = 58, [2] = 112, [3] = 98 }, [4] = { [0] = 10, [1] = 48, [2] = 112, [3] = 90 }, [5] = { [0] = 14, [1] = 56, [2] = 115, [3] = 92 }, [6] = { [0] = 7, [1] = 49, [2] = 113, [3] = 91 }, [7] = { [0] = 16, [1] = 55, [2] = 113, [3] = 90 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 43, [1] = 23, [2] = 168, [3] = 234 }, [1] = { [0] = 51, [1] = 24, [2] = 166, [3] = 241 }, [2] = { [0] = 43, [1] = 16, [2] = 168, [3] = 237 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 20, [1] = 59, [2] = 113, [3] = 99 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 15, [1] = 57, [2] = 116, [3] = 93 }, [6] = { [0] = 8, [1] = 50, [2] = 114, [3] = 92 }, [7] = { [0] = 17, [1] = 56, [2] = 114, [3] = 91 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 52, [1] = 25, [2] = 167, [3] = 242 }, [2] = { [0] = 44, [1] = 17, [2] = 169, [3] = 238 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 21, [1] = 60, [2] = 114, [3] = 100 }, [4] = { [0] = 12, [1] = 50, [2] = 114, [3] = 92 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 9, [1] = 51, [2] = 115, [3] = 93 }, [7] = { [0] = 18, [1] = 57, [2] = 115, [3] = 92 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 25, [2] = 170, [3] = 236 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 43, [1] = 16, [2] = 172, [3] = 237 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 8, [1] = 47, [2] = 110, [3] = 90 }, [3] = { [0] = 19, [1] = 58, [2] = 115, [3] = 98 }, [4] = { [0] = 13, [1] = 51, [2] = 115, [3] = 93 }, [5] = { [0] = 20, [1] = 62, [2] = 121, [3] = 98 }, [6] = { [0] = 10, [1] = 52, [2] = 116, [3] = 94 }, [7] = { [0] = 19, [1] = 58, [2] = 116, [3] = 93 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 26, [2] = 171, [3] = 237 }, [1] = { [0] = 54, [1] = 27, [2] = 169, [3] = 244 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 9, [1] = 48, [2] = 111, [3] = 91 }, [3] = { [0] = 15, [1] = 54, [2] = 116, [3] = 94 }, [4] = { [0] = 14, [1] = 52, [2] = 116, [3] = 94 }, [5] = { [0] = 21, [1] = 63, [2] = 122, [3] = 99 }, [6] = { [0] = 11, [1] = 53, [2] = 117, [3] = 95 }, [7] = { [0] = 20, [1] = 59, [2] = 117, [3] = 94 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 27, [2] = 172, [3] = 238 }, [1] = { [0] = 55, [1] = 28, [2] = 170, [3] = 245 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 41, [1] = 14, [2] = 173, [3] = 235 }, [7] = { [0] = 41, [1] = 12, [2] = 173, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 10, [1] = 49, [2] = 112, [3] = 92 }, [3] = { [0] = 16, [1] = 55, [2] = 120, [3] = 95 }, [4] = { [0] = 18, [1] = 56, [2] = 120, [3] = 98 }, [5] = { [0] = 22, [1] = 64, [2] = 123, [3] = 100 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 21, [1] = 60, [2] = 111, [3] = 95 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 28, [2] = 173, [3] = 239 }, [1] = { [0] = 56, [1] = 29, [2] = 171, [3] = 246 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 47, [1] = 21, [2] = 177, [3] = 232 }, [6] = { [0] = 42, [1] = 15, [2] = 174, [3] = 236 }, [7] = { [0] = 41, [1] = 12, [2] = 174, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 17, [1] = 56, [2] = 121, [3] = 96 }, [4] = { [0] = 19, [1] = 57, [2] = 121, [3] = 99 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 22, [1] = 61, [2] = 111, [3] = 96 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 47, [1] = 21, [2] = 177, [3] = 232 }, [6] = { [0] = 42, [1] = 15, [2] = 174, [3] = 236 }, [7] = { [0] = 41, [1] = 12, [2] = 174, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 15, [1] = 53, [2] = 108, [3] = 91 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 12, [1] = 51, [2] = 114, [3] = 94 }, [3] = { [0] = 18, [1] = 57, [2] = 122, [3] = 97 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 23, [1] = 62, [2] = 119, [3] = 97 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 41, [1] = 12, [2] = 175, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 14, [1] = 45, [2] = 100, [3] = 85 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 19, [1] = 58, [2] = 123, [3] = 98 }, [4] = { [0] = 21, [1] = 59, [2] = 123, [3] = 101 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 24, [1] = 63, [2] = 111, [3] = 98 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 45, [1] = 18, [2] = 172, [3] = 239 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 44, [1] = 15, [2] = 175, [3] = 235 } })[R[21]][R[20]], ({ [0] = { [0] = 17, [1] = 55, [2] = 110, [3] = 93 }, [1] = { [0] = 15, [1] = 46, [2] = 101, [3] = 86 }, [2] = { [0] = 14, [1] = 53, [2] = 116, [3] = 96 }, [3] = { [0] = 15, [1] = 54, [2] = 124, [3] = 94 }, [4] = { [0] = 22, [1] = 60, [2] = 124, [3] = 102 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 45, [1] = 18, [2] = 175, [3] = 239 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 49, [1] = 23, [2] = 179, [3] = 234 }, [6] = { [0] = 44, [1] = 17, [2] = 176, [3] = 238 }, [7] = { [0] = 44, [1] = 15, [2] = 176, [3] = 235 } })[R[21]][R[20]], ({ [0] = { [0] = 18, [1] = 56, [2] = 111, [3] = 94 }, [1] = { [0] = 16, [1] = 47, [2] = 102, [3] = 87 }, [2] = { [0] = 15, [1] = 54, [2] = 117, [3] = 97 }, [3] = { [0] = 19, [1] = 58, [2] = 110, [3] = 98 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 46, [1] = 19, [2] = 175, [3] = 240 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 49, [1] = 23, [2] = 179, [3] = 234 }, [6] = { [0] = 44, [1] = 17, [2] = 176, [3] = 238 }, [7] = { [0] = 45, [1] = 16, [2] = 176, [3] = 236 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 47, [1] = 20, [2] = 175, [3] = 241 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [6] = { [0] = 45, [1] = 18, [2] = 177, [3] = 239 }, [7] = { [0] = 45, [1] = 16, [2] = 177, [3] = 236 } })[R[21]][R[20]], ({ [0] = { [0] = 23, [1] = 61, [2] = 116, [3] = 99 }, [1] = { [0] = 21, [1] = 52, [2] = 107, [3] = 92 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 19, [1] = 58, [2] = 126, [3] = 98 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 46, [1] = 19, [2] = 171, [3] = 240 }, [3] = { [0] = 48, [1] = 21, [2] = 176, [3] = 242 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [6] = { [0] = 45, [1] = 18, [2] = 177, [3] = 239 }, [7] = { [0] = 46, [1] = 17, [2] = 177, [3] = 237 } })[R[21]][R[20]], ({ [0] = { [0] = 24, [1] = 62, [2] = 117, [3] = 100 }, [1] = { [0] = 22, [1] = 53, [2] = 108, [3] = 93 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 110, [3] = 91 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 46, [1] = 19, [2] = 171, [3] = 240 }, [3] = { [0] = 48, [1] = 21, [2] = 176, [3] = 242 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 51, [1] = 25, [2] = 181, [3] = 236 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 46, [1] = 17, [2] = 179, [3] = 237 } })[R[21]][R[20]], ({ [0] = { [0] = 25, [1] = 63, [2] = 118, [3] = 101 }, [1] = { [0] = 23, [1] = 54, [2] = 109, [3] = 94 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 7, [1] = 49, [2] = 113, [3] = 91 }, [7] = { [0] = 26, [1] = 65, [2] = 113, [3] = 100 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 53, [1] = 33, [2] = 178, [3] = 244 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 49, [1] = 22, [2] = 176, [3] = 243 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 51, [1] = 25, [2] = 181, [3] = 236 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 47, [1] = 18, [2] = 179, [3] = 238 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 126, [3] = 91 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 8, [1] = 50, [2] = 114, [3] = 92 }, [7] = { [0] = 13, [1] = 52, [2] = 114, [3] = 87 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 54, [1] = 34, [2] = 179, [3] = 245 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 50, [1] = 23, [2] = 177, [3] = 244 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 47, [1] = 18, [2] = 179, [3] = 238 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 25, [1] = 56, [2] = 111, [3] = 96 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 12, [1] = 51, [2] = 110, [3] = 91 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 9, [1] = 51, [2] = 115, [3] = 93 }, [7] = { [0] = 26, [1] = 65, [2] = 115, [3] = 100 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 48, [1] = 21, [2] = 173, [3] = 242 }, [3] = { [0] = 51, [1] = 24, [2] = 177, [3] = 245 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 53, [1] = 27, [2] = 183, [3] = 238 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 48, [1] = 19, [2] = 179, [3] = 239 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 26, [1] = 57, [2] = 112, [3] = 97 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 111, [3] = 91 }, [4] = { [0] = 9, [1] = 47, [2] = 111, [3] = 89 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 10, [1] = 52, [2] = 116, [3] = 94 }, [7] = { [0] = 13, [1] = 52, [2] = 116, [3] = 87 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 56, [1] = 36, [2] = 181, [3] = 247 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 48, [1] = 21, [2] = 173, [3] = 242 }, [3] = { [0] = 52, [1] = 25, [2] = 177, [3] = 246 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 48, [1] = 19, [2] = 179, [3] = 239 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 31, [1] = 62, [2] = 117, [3] = 102 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 12, [1] = 51, [2] = 118, [3] = 91 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 11, [1] = 53, [2] = 117, [3] = 95 }, [7] = { [0] = 14, [1] = 53, [2] = 117, [3] = 88 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 57, [1] = 37, [2] = 182, [3] = 248 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 49, [1] = 22, [2] = 174, [3] = 243 }, [3] = { [0] = 53, [1] = 26, [2] = 177, [3] = 247 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 48, [1] = 19, [2] = 183, [3] = 239 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 32, [1] = 63, [2] = 118, [3] = 103 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 126, [3] = 91 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 15, [1] = 54, [2] = 119, [3] = 89 } })[R[21]][R[20]] })
    if R[21] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 58, [1] = 38, [2] = 183, [3] = 249 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 59, [1] = 39, [2] = 184, [3] = 250 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 58, [1] = 38, [2] = 183, [3] = 249 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 59, [1] = 39, [2] = 184, [3] = 250 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[20]] })
        for i = 1, game.initial_units() do
          R[53] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 56, [1] = 36, [2] = 181, [3] = 247 }, [1] = { [0] = 43, [1] = 23, [2] = 168, [3] = 234 }, [2] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 } })[R[53]][R[20]], ({ [0] = { [0] = 14, [1] = 52, [2] = 107, [3] = 90 }, [1] = { [0] = 23, [1] = 61, [2] = 116, [3] = 99 }, [2] = { [0] = 26, [1] = 64, [2] = 119, [3] = 102 } })[R[53]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 34, [1] = 65, [2] = 120, [3] = 105 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 34, [1] = 65, [2] = 120, [3] = 105 })[R[20]] })
        for i = 1, game.initial_units() do
          R[54] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 49, [1] = 22, [2] = 164, [3] = 239 }, [1] = { [0] = 51, [1] = 24, [2] = 166, [3] = 241 }, [2] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 } })[R[54]][R[20]], ({ [0] = { [0] = 28, [1] = 59, [2] = 114, [3] = 99 }, [1] = { [0] = 30, [1] = 61, [2] = 116, [3] = 101 }, [2] = { [0] = 22, [1] = 53, [2] = 108, [3] = 93 } })[R[54]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 40, [1] = 13, [2] = 165, [3] = 234 }, [1] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [2] = { [0] = 58, [1] = 31, [2] = 183, [3] = 252 } })[R[55]][R[20]], ({ [0] = { [0] = 5, [1] = 44, [2] = 107, [3] = 87 }, [1] = { [0] = 21, [1] = 60, [2] = 123, [3] = 103 }, [2] = { [0] = 14, [1] = 53, [2] = 116, [3] = 96 } })[R[55]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 3 then
      game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 178, [3] = 247 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 111, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 178, [3] = 248 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 112, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 55, [1] = 28, [2] = 178, [3] = 249 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 118, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 56, [1] = 29, [2] = 178, [3] = 250 })[R[20]], ({ [0] = 15, [1] = 54, [2] = 126, [3] = 94 })[R[20]] })
      game.create_tube({ ({ [0] = 56, [1] = 29, [2] = 179, [3] = 250 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 112, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 179, [3] = 251 })[R[20]], ({ [0] = 15, [1] = 54, [2] = 118, [3] = 94 })[R[20]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 179, [3] = 251 })[R[20]], ({ [0] = 16, [1] = 55, [2] = 126, [3] = 95 })[R[20]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[20]], ({ [0] = 17, [1] = 56, [2] = 112, [3] = 96 })[R[20]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[20]], ({ [0] = 18, [1] = 57, [2] = 118, [3] = 97 })[R[20]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 126, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 181, [3] = 252 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 117, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 181, [3] = 252 })[R[20]], ({ [0] = 20, [1] = 59, [2] = 118, [3] = 99 })[R[20]] })
      if R[20] == 0 then
        if game.initial_units() == 0 then
          game.create_tube({ 58, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 58, 21 })
          for i = 1, game.initial_units() do
            R[56] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 51, [1] = 52, [2] = 39 })[R[56]], ({ [0] = 15, [1] = 22, [2] = 19 })[R[56]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 1 then
        if game.initial_units() == 0 then
          game.create_tube({ 31, 60 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 31, 60 })
          for i = 1, game.initial_units() do
            R[57] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 24, [1] = 25, [2] = 12 })[R[57]], ({ [0] = 54, [1] = 61, [2] = 58 })[R[57]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 2 then
        if game.initial_units() == 0 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
          for i = 1, game.initial_units() do
            R[58] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 176, [1] = 167, [2] = 175 })[R[58]], ({ [0] = 109, [1] = 117, [2] = 112 })[R[58]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 3 then
        if game.initial_units() == 0 then
          game.create_tube({ 252, 100 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 252, 100 })
          for i = 1, game.initial_units() do
            R[59] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 245, [1] = 246, [2] = 233 })[R[59]], ({ [0] = 94, [1] = 101, [2] = 98 })[R[59]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[20]", R[20])
      end
    elseif R[21] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 9, [1] = 47, [2] = 111, [3] = 89 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 17, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 18, [1] = 56, [2] = 120, [3] = 98 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 13, [1] = 51, [2] = 115, [3] = 93 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 14, [1] = 52, [2] = 116, [3] = 94 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 9, [1] = 47, [2] = 111, [3] = 89 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 17, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 18, [1] = 56, [2] = 120, [3] = 98 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 13, [1] = 51, [2] = 115, [3] = 93 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 14, [1] = 52, [2] = 116, [3] = 94 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
        for i = 1, game.initial_units() do
          R[60] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [1] = { [0] = 36, [1] = 13, [2] = 167, [3] = 232 }, [2] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 } })[R[60]][R[20]], ({ [0] = { [0] = 7, [1] = 45, [2] = 109, [3] = 87 }, [1] = { [0] = 15, [1] = 53, [2] = 117, [3] = 95 }, [2] = { [0] = 10, [1] = 48, [2] = 112, [3] = 90 } })[R[60]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 20, [1] = 62, [2] = 121, [3] = 98 })[R[20]] })
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 21, [1] = 63, [2] = 122, [3] = 99 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 20, [1] = 62, [2] = 121, [3] = 98 })[R[20]] })
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 21, [1] = 63, [2] = 122, [3] = 99 })[R[20]] })
        for i = 1, game.initial_units() do
          R[61] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [1] = { [0] = 33, [1] = 7, [2] = 163, [3] = 218 }, [2] = { [0] = 55, [1] = 29, [2] = 185, [3] = 240 } })[R[61]][R[20]], ({ [0] = { [0] = 27, [1] = 69, [2] = 128, [3] = 105 }, [1] = { [0] = 14, [1] = 56, [2] = 115, [3] = 92 }, [2] = { [0] = 27, [1] = 69, [2] = 128, [3] = 105 } })[R[61]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 52, [1] = 25, [2] = 184, [3] = 246 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 185, [3] = 247 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 186, [3] = 248 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 52, [1] = 25, [2] = 184, [3] = 246 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 185, [3] = 247 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 186, [3] = 248 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        for i = 1, game.initial_units() do
          R[62] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 33, [1] = 6, [2] = 165, [3] = 227 }, [1] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [2] = { [0] = 59, [1] = 32, [2] = 191, [3] = 253 } })[R[62]][R[20]], ({ [0] = { [0] = 3, [1] = 45, [2] = 109, [3] = 87 }, [1] = { [0] = 1, [1] = 43, [2] = 107, [3] = 85 }, [2] = { [0] = 16, [1] = 58, [2] = 122, [3] = 100 } })[R[62]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 7 then
      game.create_tube({ ({ [0] = 48, [1] = 19, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 16, [1] = 55, [2] = 119, [3] = 90 })[R[20]] })
      game.create_tube({ ({ [0] = 48, [1] = 19, [2] = 185, [3] = 239 })[R[20]], ({ [0] = 17, [1] = 56, [2] = 119, [3] = 91 })[R[20]] })
      if R[20] == 0 then
        if game.initial_units() == 0 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
          for i = 1, game.initial_units() do
            R[63] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 46, [1] = 52, [2] = 40 })[R[63]], ({ [0] = 9, [1] = 9, [2] = 30 })[R[63]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 1 then
        if game.initial_units() == 0 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
          for i = 1, game.initial_units() do
            R[64] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 17, [1] = 23, [2] = 11 })[R[64]], ({ [0] = 48, [1] = 48, [2] = 69 })[R[64]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 2 then
        if game.initial_units() == 0 then
          game.create_tube({ 186, 119 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 186, 119 })
          for i = 1, game.initial_units() do
            R[65] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 165, [1] = 170, [2] = 191 })[R[65]], ({ [0] = 109, [1] = 107, [2] = 122 })[R[65]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 3 then
        if game.initial_units() == 0 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
          for i = 1, game.initial_units() do
            R[66] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 237, [1] = 243, [2] = 231 })[R[66]], ({ [0] = 83, [1] = 83, [2] = 104 })[R[66]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[20]", R[20])
      end
    else
      unseen("R[21]", R[21])
    end
    R[36] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 50, [1] = 47, [2] = 45, [3] = 50, [4] = 41, [5] = 44, [6] = 38, [7] = 48 }, [1] = { [0] = 30, [1] = 20, [2] = 18, [3] = 23, [4] = 18, [5] = 18, [6] = 11, [7] = 19 }, [2] = { [0] = 175, [1] = 162, [2] = 170, [3] = 172, [4] = 172, [5] = 174, [6] = 170, [7] = 170 }, [3] = { [0] = 241, [1] = 237, [2] = 239, [3] = 244, [4] = 237, [5] = 229, [6] = 232, [7] = 239 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 6, [3] = 19, [4] = 16, [5] = 18, [6] = 5, [7] = 20 }, [1] = { [0] = 58, [1] = 55, [2] = 45, [3] = 58, [4] = 54, [5] = 60, [6] = 47, [7] = 59 }, [2] = { [0] = 113, [1] = 110, [2] = 108, [3] = 118, [4] = 118, [5] = 119, [6] = 111, [7] = 111 }, [3] = { [0] = 96, [1] = 95, [2] = 88, [3] = 98, [4] = 96, [5] = 96, [6] = 89, [7] = 94 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 50, [1] = 47, [2] = 45, [3] = 50, [4] = 41, [5] = 44, [6] = 38, [7] = 48 }, [1] = { [0] = 30, [1] = 20, [2] = 18, [3] = 23, [4] = 18, [5] = 18, [6] = 11, [7] = 19 }, [2] = { [0] = 175, [1] = 162, [2] = 170, [3] = 172, [4] = 172, [5] = 174, [6] = 170, [7] = 170 }, [3] = { [0] = 241, [1] = 237, [2] = 239, [3] = 244, [4] = 237, [5] = 229, [6] = 232, [7] = 239 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 6, [3] = 19, [4] = 16, [5] = 18, [6] = 5, [7] = 20 }, [1] = { [0] = 58, [1] = 55, [2] = 45, [3] = 58, [4] = 54, [5] = 60, [6] = 47, [7] = 59 }, [2] = { [0] = 113, [1] = 110, [2] = 108, [3] = 118, [4] = 118, [5] = 119, [6] = 111, [7] = 111 }, [3] = { [0] = 96, [1] = 95, [2] = 88, [3] = 98, [4] = 96, [5] = 96, [6] = 89, [7] = 94 } })[R[51]][R[36]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 50, [1] = 57, [2] = 39, [3] = 58, [4] = 41, [5] = 44, [6] = 47, [7] = 41 }, [1] = { [0] = 30, [1] = 30, [2] = 12, [3] = 31, [4] = 18, [5] = 18, [6] = 20, [7] = 12 }, [2] = { [0] = 175, [1] = 172, [2] = 164, [3] = 172, [4] = 172, [5] = 174, [6] = 179, [7] = 179 }, [3] = { [0] = 241, [1] = 247, [2] = 233, [3] = 252, [4] = 237, [5] = 229, [6] = 241, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 13, [1] = 11, [2] = 11, [3] = 23, [4] = 24, [5] = 24, [6] = 5, [7] = 26 }, [1] = { [0] = 51, [1] = 42, [2] = 50, [3] = 62, [4] = 62, [5] = 66, [6] = 47, [7] = 65 }, [2] = { [0] = 106, [1] = 97, [2] = 113, [3] = 126, [4] = 126, [5] = 125, [6] = 111, [7] = 111 }, [3] = { [0] = 89, [1] = 82, [2] = 93, [3] = 102, [4] = 104, [5] = 102, [6] = 89, [7] = 100 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    if R[36] == 3 or R[36] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [3] = 42, [4] = 41 }, [1] = { [3] = 15, [4] = 18 }, [2] = { [3] = 172, [4] = 172 }, [3] = { [3] = 236, [4] = 237 } })[R[51]][R[36]], ({ [0] = { [3] = 23, [4] = 8 }, [1] = { [3] = 62, [4] = 46 }, [2] = { [3] = 110, [4] = 110 }, [3] = { [3] = 102, [4] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[51] == 0 then
        if R[36] == 3 then
        elseif R[36] == 4 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 52, 10 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[36]", R[36])
        end
      elseif R[51] == 1 then
        if R[36] == 3 then
        elseif R[36] == 4 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 29, 48 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[36]", R[36])
        end
      elseif R[51] == 2 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
      elseif R[51] == 3 then
        if R[36] == 3 then
        elseif R[36] == 4 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 248, 90 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[36]", R[36])
        end
      else
        unseen("R[51]", R[51])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [3] = 45, [4] = 52 }, [1] = { [3] = 18, [4] = 29 }, [2] = { [3] = 183, [4] = 183 }, [3] = { [3] = 239, [4] = 248 } })[R[51]][R[36]], ({ [0] = { [3] = 12, [4] = 20 }, [1] = { [3] = 51, [4] = 58 }, [2] = { [3] = 122, [4] = 122 }, [3] = { [3] = 91, [4] = 100 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[36] == 3 then
        if R[51] == 0 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[51] == 1 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[51] == 2 then
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
        elseif R[51] == 3 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[51]", R[51])
        end
      elseif R[36] == 4 then
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
        unseen("R[36]", R[36])
      end
    elseif R[36] == 0 or R[36] == 1 or R[36] == 2 or R[36] == 5 or R[36] == 6 or R[36] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 62, [1] = 58, [2] = 42, [5] = 54, [6] = 48, [7] = 41 }, [1] = { [0] = 42, [1] = 31, [2] = 15, [5] = 28, [6] = 21, [7] = 12 }, [2] = { [0] = 187, [1] = 173, [2] = 167, [5] = 184, [6] = 180, [7] = 180 }, [3] = { [0] = 253, [1] = 248, [2] = 236, [5] = 239, [6] = 242, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 18, [2] = 17, [5] = 23, [6] = 13, [7] = 13 }, [1] = { [0] = 58, [1] = 49, [2] = 56, [5] = 65, [6] = 55, [7] = 52 }, [2] = { [0] = 113, [1] = 104, [2] = 119, [5] = 124, [6] = 119, [7] = 119 }, [3] = { [0] = 96, [1] = 89, [2] = 99, [5] = 101, [6] = 97, [7] = 87 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[36] == 0 then
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
      elseif R[36] == 1 then
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
      elseif R[36] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[51]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[51]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[51]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[36] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[51]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[51]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[51]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[36] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[36] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[51]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[51]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[51]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[36]", R[36])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 39, [1] = 58, [2] = 51, [5] = 44, [6] = 39, [7] = 57 }, [1] = { [0] = 19, [1] = 31, [2] = 24, [5] = 18, [6] = 12, [7] = 28 }, [2] = { [0] = 164, [1] = 173, [2] = 176, [5] = 174, [6] = 171, [7] = 171 }, [3] = { [0] = 230, [1] = 248, [2] = 245, [5] = 229, [6] = 233, [7] = 248 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 28, [2] = 17, [5] = 11, [6] = 13, [7] = 25 }, [1] = { [0] = 58, [1] = 59, [2] = 56, [5] = 53, [6] = 55, [7] = 64 }, [2] = { [0] = 113, [1] = 114, [2] = 119, [5] = 112, [6] = 119, [7] = 119 }, [3] = { [0] = 96, [1] = 99, [2] = 99, [5] = 89, [6] = 97, [7] = 99 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[36] == 2 or R[36] == 5 or R[36] == 6 or R[36] == 7 then
      elseif R[36] == 0 or R[36] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 50, [1] = 57 }, [1] = { [0] = 30, [1] = 30 }, [2] = { [0] = 175, [1] = 172 }, [3] = { [0] = 241, [1] = 247 } })[R[51]][R[36]], ({ [0] = { [0] = 27, [1] = 36 }, [1] = { [0] = 65, [1] = 67 }, [2] = { [0] = 120, [1] = 122 }, [3] = { [0] = 103, [1] = 107 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[36]", R[36])
      end
    else
      unseen("R[36]", R[36])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 39, [1] = 48, [2] = 59, [3] = 51, [4] = 33, [5] = 34, [6] = 31, [7] = 49 }, [1] = { [0] = 19, [1] = 21, [2] = 32, [3] = 24, [4] = 10, [5] = 8, [6] = 4, [7] = 20 }, [2] = { [0] = 164, [1] = 163, [2] = 184, [3] = 164, [4] = 164, [5] = 164, [6] = 163, [7] = 163 }, [3] = { [0] = 230, [1] = 238, [2] = 253, [3] = 245, [4] = 229, [5] = 219, [6] = 225, [7] = 240 } })[R[51]][R[36]], ({ [0] = { [0] = 29, [1] = 33, [2] = 11, [3] = 6, [4] = 12, [5] = 18, [6] = 13, [7] = 29 }, [1] = { [0] = 67, [1] = 64, [2] = 50, [3] = 45, [4] = 50, [5] = 60, [6] = 55, [7] = 68 }, [2] = { [0] = 122, [1] = 119, [2] = 113, [3] = 114, [4] = 114, [5] = 119, [6] = 119, [7] = 119 }, [3] = { [0] = 105, [1] = 104, [2] = 93, [3] = 85, [4] = 92, [5] = 96, [6] = 97, [7] = 103 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 46, [1] = 47, [2] = 55, [3] = 40, [4] = 51, [5] = 52, [6] = 38, [7] = 59 }, [1] = { [0] = 26, [1] = 20, [2] = 28, [3] = 13, [4] = 28, [5] = 26, [6] = 11, [7] = 30 }, [2] = { [0] = 171, [1] = 162, [2] = 180, [3] = 182, [4] = 182, [5] = 182, [6] = 170, [7] = 170 }, [3] = { [0] = 237, [1] = 237, [2] = 249, [3] = 234, [4] = 247, [5] = 237, [6] = 232, [7] = 250 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 19, [2] = 15, [3] = 13, [4] = 16, [5] = 9, [6] = 18, [7] = 20 }, [1] = { [0] = 54, [1] = 50, [2] = 54, [3] = 52, [4] = 54, [5] = 51, [6] = 60, [7] = 59 }, [2] = { [0] = 109, [1] = 105, [2] = 117, [3] = 118, [4] = 118, [5] = 110, [6] = 124, [7] = 124 }, [3] = { [0] = 92, [1] = 90, [2] = 97, [3] = 92, [4] = 96, [5] = 87, [6] = 102, [7] = 94 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 44, [1] = 47, [2] = 55, [3] = 43, [4] = 53, [5] = 52, [6] = 36, [7] = 59 }, [1] = { [0] = 24, [1] = 20, [2] = 28, [3] = 16, [4] = 30, [5] = 26, [6] = 9, [7] = 30 }, [2] = { [0] = 169, [1] = 162, [2] = 180, [3] = 184, [4] = 184, [5] = 182, [6] = 168, [7] = 168 }, [3] = { [0] = 235, [1] = 237, [2] = 249, [3] = 237, [4] = 249, [5] = 237, [6] = 230, [7] = 250 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 17, [2] = 13, [3] = 9, [4] = 16, [5] = 11, [6] = 18, [7] = 22 }, [1] = { [0] = 54, [1] = 48, [2] = 52, [3] = 48, [4] = 54, [5] = 53, [6] = 60, [7] = 61 }, [2] = { [0] = 109, [1] = 103, [2] = 115, [3] = 118, [4] = 118, [5] = 112, [6] = 124, [7] = 124 }, [3] = { [0] = 92, [1] = 88, [2] = 95, [3] = 88, [4] = 96, [5] = 89, [6] = 102, [7] = 96 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 55, [1] = 50, [2] = 37, [3] = 60, [4] = 45, [5] = 40, [6] = 51, [7] = 58 }, [1] = { [0] = 35, [1] = 23, [2] = 10, [3] = 33, [4] = 22, [5] = 14, [6] = 24, [7] = 29 }, [2] = { [0] = 180, [1] = 165, [2] = 162, [3] = 176, [4] = 176, [5] = 170, [6] = 183, [7] = 183 }, [3] = { [0] = 246, [1] = 240, [2] = 231, [3] = 254, [4] = 241, [5] = 225, [6] = 245, [7] = 249 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 19, [2] = 16, [3] = 13, [4] = 24, [5] = 19, [6] = 5, [7] = 14 }, [1] = { [0] = 60, [1] = 50, [2] = 55, [3] = 52, [4] = 62, [5] = 61, [6] = 47, [7] = 53 }, [2] = { [0] = 115, [1] = 105, [2] = 118, [3] = 126, [4] = 126, [5] = 120, [6] = 111, [7] = 111 }, [3] = { [0] = 98, [1] = 90, [2] = 98, [3] = 92, [4] = 104, [5] = 97, [6] = 89, [7] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 55, [1] = 50, [2] = 37, [3] = 58, [4] = 45, [5] = 40, [6] = 51, [7] = 58 }, [1] = { [0] = 35, [1] = 23, [2] = 10, [3] = 31, [4] = 22, [5] = 14, [6] = 24, [7] = 29 }, [2] = { [0] = 180, [1] = 165, [2] = 162, [3] = 176, [4] = 176, [5] = 170, [6] = 183, [7] = 183 }, [3] = { [0] = 246, [1] = 240, [2] = 231, [3] = 252, [4] = 241, [5] = 225, [6] = 245, [7] = 249 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 19, [2] = 16, [3] = 9, [4] = 24, [5] = 19, [6] = 5, [7] = 14 }, [1] = { [0] = 60, [1] = 50, [2] = 55, [3] = 48, [4] = 62, [5] = 61, [6] = 47, [7] = 53 }, [2] = { [0] = 115, [1] = 105, [2] = 118, [3] = 126, [4] = 126, [5] = 120, [6] = 111, [7] = 111 }, [3] = { [0] = 98, [1] = 90, [2] = 98, [3] = 88, [4] = 104, [5] = 97, [6] = 89, [7] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 44, [1] = 47, [2] = 55, [3] = 46, [4] = 53, [5] = 52, [6] = 36, [7] = 59 }, [1] = { [0] = 24, [1] = 20, [2] = 28, [3] = 19, [4] = 30, [5] = 26, [6] = 9, [7] = 30 }, [2] = { [0] = 169, [1] = 162, [2] = 180, [3] = 184, [4] = 184, [5] = 182, [6] = 168, [7] = 168 }, [3] = { [0] = 235, [1] = 237, [2] = 249, [3] = 240, [4] = 249, [5] = 237, [6] = 230, [7] = 250 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 19, [2] = 13, [3] = 24, [4] = 16, [5] = 11, [6] = 18, [7] = 22 }, [1] = { [0] = 54, [1] = 50, [2] = 52, [3] = 63, [4] = 54, [5] = 53, [6] = 60, [7] = 61 }, [2] = { [0] = 109, [1] = 105, [2] = 115, [3] = 118, [4] = 118, [5] = 112, [6] = 124, [7] = 124 }, [3] = { [0] = 92, [1] = 90, [2] = 95, [3] = 103, [4] = 96, [5] = 89, [6] = 102, [7] = 96 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [3] = { [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 44, [1] = 50, [2] = 55, [3] = 46, [4] = 53, [5] = 52, [6] = 36, [7] = 59 }, [1] = { [0] = 24, [1] = 23, [2] = 28, [3] = 19, [4] = 30, [5] = 26, [6] = 9, [7] = 30 }, [2] = { [0] = 169, [1] = 165, [2] = 180, [3] = 184, [4] = 184, [5] = 182, [6] = 168, [7] = 168 }, [3] = { [0] = 235, [1] = 240, [2] = 249, [3] = 240, [4] = 249, [5] = 237, [6] = 230, [7] = 250 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 19, [2] = 13, [3] = 24, [4] = 16, [5] = 11, [6] = 18, [7] = 22 }, [1] = { [0] = 54, [1] = 50, [2] = 52, [3] = 63, [4] = 54, [5] = 53, [6] = 60, [7] = 61 }, [2] = { [0] = 109, [1] = 105, [2] = 115, [3] = 118, [4] = 118, [5] = 112, [6] = 124, [7] = 124 }, [3] = { [0] = 92, [1] = 90, [2] = 95, [3] = 103, [4] = 96, [5] = 89, [6] = 102, [7] = 96 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [3] = { [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 55, [1] = 47, [2] = 37, [3] = 40, [4] = 45, [5] = 40, [6] = 51, [7] = 58 }, [1] = { [0] = 35, [1] = 20, [2] = 10, [3] = 13, [4] = 22, [5] = 14, [6] = 24, [7] = 29 }, [2] = { [0] = 180, [1] = 162, [2] = 162, [3] = 176, [4] = 176, [5] = 170, [6] = 183, [7] = 183 }, [3] = { [0] = 246, [1] = 237, [2] = 231, [3] = 234, [4] = 241, [5] = 225, [6] = 245, [7] = 249 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 19, [2] = 16, [3] = 13, [4] = 24, [5] = 19, [6] = 5, [7] = 14 }, [1] = { [0] = 60, [1] = 50, [2] = 55, [3] = 52, [4] = 62, [5] = 61, [6] = 47, [7] = 53 }, [2] = { [0] = 115, [1] = 105, [2] = 118, [3] = 126, [4] = 126, [5] = 120, [6] = 111, [7] = 111 }, [3] = { [0] = 98, [1] = 90, [2] = 98, [3] = 92, [4] = 104, [5] = 97, [6] = 89, [7] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 50, [2] = 55, [3] = 40, [4] = 46, [5] = 39, [6] = 43, [7] = 43 }, [1] = { [0] = 21, [1] = 23, [2] = 28, [3] = 13, [4] = 23, [5] = 13, [6] = 16, [7] = 14 }, [2] = { [0] = 166, [1] = 165, [2] = 180, [3] = 177, [4] = 177, [5] = 169, [6] = 175, [7] = 175 }, [3] = { [0] = 232, [1] = 240, [2] = 249, [3] = 234, [4] = 242, [5] = 224, [6] = 237, [7] = 234 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 13, [2] = 19, [3] = 13, [4] = 20, [5] = 8, [6] = 15, [7] = 20 }, [1] = { [0] = 54, [1] = 44, [2] = 58, [3] = 52, [4] = 58, [5] = 50, [6] = 57, [7] = 59 }, [2] = { [0] = 109, [1] = 99, [2] = 121, [3] = 122, [4] = 122, [5] = 109, [6] = 121, [7] = 121 }, [3] = { [0] = 92, [1] = 84, [2] = 101, [3] = 92, [4] = 100, [5] = 86, [6] = 99, [7] = 94 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 53, [2] = 51, [3] = 46, [4] = 48, [5] = 48, [6] = 52, [7] = 38 }, [1] = { [0] = 21, [1] = 26, [2] = 24, [3] = 19, [4] = 25, [5] = 22, [6] = 25, [7] = 9 }, [2] = { [0] = 166, [1] = 168, [2] = 176, [3] = 179, [4] = 179, [5] = 178, [6] = 184, [7] = 184 }, [3] = { [0] = 232, [1] = 243, [2] = 245, [3] = 240, [4] = 244, [5] = 233, [6] = 246, [7] = 229 } })[R[51]][R[36]], ({ [0] = { [0] = 13, [1] = 10, [2] = 20, [3] = 24, [4] = 11, [5] = 16, [6] = 12, [7] = 17 }, [1] = { [0] = 51, [1] = 41, [2] = 59, [3] = 63, [4] = 49, [5] = 58, [6] = 54, [7] = 56 }, [2] = { [0] = 106, [1] = 96, [2] = 122, [3] = 113, [4] = 113, [5] = 117, [6] = 118, [7] = 118 }, [3] = { [0] = 89, [1] = 81, [2] = 102, [3] = 103, [4] = 91, [5] = 94, [6] = 96, [7] = 91 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 55, [1] = 50, [2] = 37, [3] = 60, [4] = 45, [5] = 40, [6] = 51, [7] = 58 }, [1] = { [0] = 35, [1] = 23, [2] = 10, [3] = 33, [4] = 22, [5] = 14, [6] = 24, [7] = 29 }, [2] = { [0] = 180, [1] = 165, [2] = 162, [3] = 176, [4] = 176, [5] = 170, [6] = 183, [7] = 183 }, [3] = { [0] = 246, [1] = 240, [2] = 231, [3] = 254, [4] = 241, [5] = 225, [6] = 245, [7] = 249 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 19, [2] = 16, [3] = 13, [4] = 24, [5] = 19, [6] = 5, [7] = 14 }, [1] = { [0] = 60, [1] = 50, [2] = 55, [3] = 52, [4] = 62, [5] = 61, [6] = 47, [7] = 53 }, [2] = { [0] = 115, [1] = 105, [2] = 118, [3] = 126, [4] = 126, [5] = 120, [6] = 111, [7] = 111 }, [3] = { [0] = 98, [1] = 90, [2] = 98, [3] = 92, [4] = 104, [5] = 97, [6] = 89, [7] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 55, [1] = 50, [2] = 37, [3] = 58, [4] = 45, [5] = 40, [6] = 51, [7] = 58 }, [1] = { [0] = 35, [1] = 23, [2] = 10, [3] = 31, [4] = 22, [5] = 14, [6] = 24, [7] = 29 }, [2] = { [0] = 180, [1] = 165, [2] = 162, [3] = 176, [4] = 176, [5] = 170, [6] = 183, [7] = 183 }, [3] = { [0] = 246, [1] = 240, [2] = 231, [3] = 252, [4] = 241, [5] = 225, [6] = 245, [7] = 249 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 19, [2] = 16, [3] = 9, [4] = 24, [5] = 19, [6] = 5, [7] = 14 }, [1] = { [0] = 60, [1] = 50, [2] = 55, [3] = 48, [4] = 62, [5] = 61, [6] = 47, [7] = 53 }, [2] = { [0] = 115, [1] = 105, [2] = 118, [3] = 126, [4] = 126, [5] = 120, [6] = 111, [7] = 111 }, [3] = { [0] = 98, [1] = 90, [2] = 98, [3] = 88, [4] = 104, [5] = 97, [6] = 89, [7] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 44, [1] = 47, [2] = 55, [3] = 46, [4] = 53, [5] = 52, [6] = 36, [7] = 59 }, [1] = { [0] = 24, [1] = 20, [2] = 28, [3] = 19, [4] = 30, [5] = 26, [6] = 9, [7] = 30 }, [2] = { [0] = 169, [1] = 162, [2] = 180, [3] = 184, [4] = 184, [5] = 182, [6] = 168, [7] = 168 }, [3] = { [0] = 235, [1] = 237, [2] = 249, [3] = 240, [4] = 249, [5] = 237, [6] = 230, [7] = 250 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 19, [2] = 13, [3] = 24, [4] = 16, [5] = 11, [6] = 18, [7] = 22 }, [1] = { [0] = 54, [1] = 50, [2] = 52, [3] = 63, [4] = 54, [5] = 53, [6] = 60, [7] = 61 }, [2] = { [0] = 109, [1] = 105, [2] = 115, [3] = 118, [4] = 118, [5] = 112, [6] = 124, [7] = 124 }, [3] = { [0] = 92, [1] = 90, [2] = 95, [3] = 103, [4] = 96, [5] = 89, [6] = 102, [7] = 96 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 55, [1] = 50, [2] = 37, [3] = 46, [4] = 45, [5] = 40, [6] = 51, [7] = 58 }, [1] = { [0] = 35, [1] = 23, [2] = 10, [3] = 19, [4] = 22, [5] = 14, [6] = 24, [7] = 29 }, [2] = { [0] = 180, [1] = 165, [2] = 162, [3] = 176, [4] = 176, [5] = 170, [6] = 183, [7] = 183 }, [3] = { [0] = 246, [1] = 240, [2] = 231, [3] = 240, [4] = 241, [5] = 225, [6] = 245, [7] = 249 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 19, [2] = 16, [3] = 24, [4] = 24, [5] = 19, [6] = 5, [7] = 14 }, [1] = { [0] = 60, [1] = 50, [2] = 55, [3] = 63, [4] = 62, [5] = 61, [6] = 47, [7] = 53 }, [2] = { [0] = 115, [1] = 105, [2] = 118, [3] = 126, [4] = 126, [5] = 120, [6] = 111, [7] = 111 }, [3] = { [0] = 98, [1] = 90, [2] = 98, [3] = 103, [4] = 104, [5] = 97, [6] = 89, [7] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 50, [2] = 55, [3] = 40, [4] = 46, [5] = 39, [6] = 43, [7] = 43 }, [1] = { [0] = 21, [1] = 23, [2] = 28, [3] = 13, [4] = 23, [5] = 13, [6] = 16, [7] = 14 }, [2] = { [0] = 166, [1] = 165, [2] = 180, [3] = 177, [4] = 177, [5] = 169, [6] = 175, [7] = 175 }, [3] = { [0] = 232, [1] = 240, [2] = 249, [3] = 234, [4] = 242, [5] = 224, [6] = 237, [7] = 234 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 13, [2] = 19, [3] = 13, [4] = 20, [5] = 8, [6] = 15, [7] = 20 }, [1] = { [0] = 54, [1] = 44, [2] = 58, [3] = 52, [4] = 58, [5] = 50, [6] = 57, [7] = 59 }, [2] = { [0] = 109, [1] = 99, [2] = 121, [3] = 122, [4] = 122, [5] = 109, [6] = 121, [7] = 121 }, [3] = { [0] = 92, [1] = 84, [2] = 101, [3] = 92, [4] = 100, [5] = 86, [6] = 99, [7] = 94 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 53, [2] = 51, [3] = 46, [4] = 48, [5] = 48, [6] = 52, [7] = 38 }, [1] = { [0] = 21, [1] = 26, [2] = 24, [3] = 19, [4] = 25, [5] = 22, [6] = 25, [7] = 9 }, [2] = { [0] = 166, [1] = 168, [2] = 176, [3] = 179, [4] = 179, [5] = 178, [6] = 184, [7] = 184 }, [3] = { [0] = 232, [1] = 243, [2] = 245, [3] = 240, [4] = 244, [5] = 233, [6] = 246, [7] = 229 } })[R[51]][R[36]], ({ [0] = { [0] = 13, [1] = 10, [2] = 20, [3] = 24, [4] = 11, [5] = 16, [6] = 12, [7] = 17 }, [1] = { [0] = 51, [1] = 41, [2] = 59, [3] = 63, [4] = 49, [5] = 58, [6] = 54, [7] = 56 }, [2] = { [0] = 106, [1] = 96, [2] = 122, [3] = 113, [4] = 113, [5] = 117, [6] = 118, [7] = 118 }, [3] = { [0] = 89, [1] = 81, [2] = 102, [3] = 103, [4] = 91, [5] = 94, [6] = 96, [7] = 91 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 55, [1] = 50, [2] = 37, [3] = 60, [4] = 45, [5] = 40, [6] = 51, [7] = 58 }, [1] = { [0] = 35, [1] = 23, [2] = 10, [3] = 33, [4] = 22, [5] = 14, [6] = 24, [7] = 29 }, [2] = { [0] = 180, [1] = 165, [2] = 162, [3] = 176, [4] = 176, [5] = 170, [6] = 183, [7] = 183 }, [3] = { [0] = 246, [1] = 240, [2] = 231, [3] = 254, [4] = 241, [5] = 225, [6] = 245, [7] = 249 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 19, [2] = 16, [3] = 13, [4] = 24, [5] = 19, [6] = 5, [7] = 14 }, [1] = { [0] = 60, [1] = 50, [2] = 55, [3] = 52, [4] = 62, [5] = 61, [6] = 47, [7] = 53 }, [2] = { [0] = 115, [1] = 105, [2] = 118, [3] = 126, [4] = 126, [5] = 120, [6] = 111, [7] = 111 }, [3] = { [0] = 98, [1] = 90, [2] = 98, [3] = 92, [4] = 104, [5] = 97, [6] = 89, [7] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 55, [1] = 50, [2] = 37, [3] = 58, [4] = 45, [5] = 40, [6] = 51, [7] = 58 }, [1] = { [0] = 35, [1] = 23, [2] = 10, [3] = 31, [4] = 22, [5] = 14, [6] = 24, [7] = 29 }, [2] = { [0] = 180, [1] = 165, [2] = 162, [3] = 176, [4] = 176, [5] = 170, [6] = 183, [7] = 183 }, [3] = { [0] = 246, [1] = 240, [2] = 231, [3] = 252, [4] = 241, [5] = 225, [6] = 245, [7] = 249 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 19, [2] = 16, [3] = 9, [4] = 24, [5] = 19, [6] = 5, [7] = 14 }, [1] = { [0] = 60, [1] = 50, [2] = 55, [3] = 48, [4] = 62, [5] = 61, [6] = 47, [7] = 53 }, [2] = { [0] = 115, [1] = 105, [2] = 118, [3] = 126, [4] = 126, [5] = 120, [6] = 111, [7] = 111 }, [3] = { [0] = 98, [1] = 90, [2] = 98, [3] = 88, [4] = 104, [5] = 97, [6] = 89, [7] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 50, [2] = 55, [3] = 46, [4] = 46, [5] = 39, [6] = 43, [7] = 43 }, [1] = { [0] = 21, [1] = 23, [2] = 28, [3] = 19, [4] = 23, [5] = 13, [6] = 16, [7] = 14 }, [2] = { [0] = 166, [1] = 165, [2] = 180, [3] = 177, [4] = 177, [5] = 169, [6] = 175, [7] = 175 }, [3] = { [0] = 232, [1] = 240, [2] = 249, [3] = 240, [4] = 242, [5] = 224, [6] = 237, [7] = 234 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 13, [2] = 19, [3] = 24, [4] = 20, [5] = 8, [6] = 15, [7] = 20 }, [1] = { [0] = 54, [1] = 44, [2] = 58, [3] = 63, [4] = 58, [5] = 50, [6] = 57, [7] = 59 }, [2] = { [0] = 109, [1] = 99, [2] = 121, [3] = 122, [4] = 122, [5] = 109, [6] = 121, [7] = 121 }, [3] = { [0] = 92, [1] = 84, [2] = 101, [3] = 103, [4] = 100, [5] = 86, [6] = 99, [7] = 94 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 53, [2] = 51, [3] = 46, [4] = 48, [5] = 48, [6] = 52, [7] = 38 }, [1] = { [0] = 21, [1] = 26, [2] = 24, [3] = 19, [4] = 25, [5] = 22, [6] = 25, [7] = 9 }, [2] = { [0] = 166, [1] = 168, [2] = 176, [3] = 179, [4] = 179, [5] = 178, [6] = 184, [7] = 184 }, [3] = { [0] = 232, [1] = 243, [2] = 245, [3] = 240, [4] = 244, [5] = 233, [6] = 246, [7] = 229 } })[R[51]][R[36]], ({ [0] = { [0] = 13, [1] = 10, [2] = 20, [3] = 24, [4] = 11, [5] = 16, [6] = 12, [7] = 17 }, [1] = { [0] = 51, [1] = 41, [2] = 59, [3] = 63, [4] = 49, [5] = 58, [6] = 54, [7] = 56 }, [2] = { [0] = 106, [1] = 96, [2] = 122, [3] = 113, [4] = 113, [5] = 117, [6] = 118, [7] = 118 }, [3] = { [0] = 89, [1] = 81, [2] = 102, [3] = 103, [4] = 91, [5] = 94, [6] = 96, [7] = 91 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 62, [1] = 56, [2] = 47, [3] = 50, [4] = 54, [5] = 40, [6] = 52, [7] = 52 }, [1] = { [0] = 42, [1] = 29, [2] = 20, [3] = 23, [4] = 31, [5] = 14, [6] = 25, [7] = 23 }, [2] = { [0] = 187, [1] = 171, [2] = 172, [3] = 185, [4] = 185, [5] = 170, [6] = 184, [7] = 184 }, [3] = { [0] = 253, [1] = 246, [2] = 241, [3] = 244, [4] = 250, [5] = 225, [6] = 246, [7] = 243 } })[R[51]][R[36]], ({ [0] = { [0] = 24, [1] = 23, [2] = 13, [3] = 10, [4] = 7, [5] = 25, [6] = 15, [7] = 19 }, [1] = { [0] = 62, [1] = 54, [2] = 52, [3] = 49, [4] = 45, [5] = 67, [6] = 57, [7] = 58 }, [2] = { [0] = 117, [1] = 109, [2] = 115, [3] = 109, [4] = 109, [5] = 126, [6] = 121, [7] = 121 }, [3] = { [0] = 100, [1] = 94, [2] = 95, [3] = 89, [4] = 87, [5] = 103, [6] = 99, [7] = 93 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 50, [2] = 42, [3] = 42, [4] = 41, [5] = 44, [6] = 38, [7] = 41 }, [1] = { [0] = 22, [1] = 23, [2] = 15, [3] = 15, [4] = 18, [5] = 18, [6] = 11, [7] = 12 }, [2] = { [0] = 167, [1] = 165, [2] = 167, [3] = 172, [4] = 172, [5] = 174, [6] = 170, [7] = 170 }, [3] = { [0] = 233, [1] = 240, [2] = 236, [3] = 236, [4] = 237, [5] = 229, [6] = 232, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 11, [3] = 19, [4] = 10, [5] = 14, [6] = 7, [7] = 16 }, [1] = { [0] = 58, [1] = 55, [2] = 50, [3] = 58, [4] = 48, [5] = 56, [6] = 49, [7] = 55 }, [2] = { [0] = 113, [1] = 110, [2] = 113, [3] = 112, [4] = 112, [5] = 115, [6] = 113, [7] = 113 }, [3] = { [0] = 96, [1] = 95, [2] = 93, [3] = 98, [4] = 90, [5] = 92, [6] = 91, [7] = 90 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 43, [1] = 51, [2] = 43, [3] = 42, [4] = 41, [5] = 44, [6] = 38, [7] = 41 }, [1] = { [0] = 23, [1] = 24, [2] = 16, [3] = 15, [4] = 18, [5] = 18, [6] = 11, [7] = 12 }, [2] = { [0] = 168, [1] = 166, [2] = 168, [3] = 172, [4] = 172, [5] = 174, [6] = 170, [7] = 170 }, [3] = { [0] = 234, [1] = 241, [2] = 237, [3] = 236, [4] = 237, [5] = 229, [6] = 232, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 11, [3] = 20, [4] = 11, [5] = 15, [6] = 8, [7] = 17 }, [1] = { [0] = 58, [1] = 55, [2] = 50, [3] = 59, [4] = 49, [5] = 57, [6] = 50, [7] = 56 }, [2] = { [0] = 113, [1] = 110, [2] = 113, [3] = 113, [4] = 113, [5] = 116, [6] = 114, [7] = 114 }, [3] = { [0] = 96, [1] = 95, [2] = 93, [3] = 99, [4] = 91, [5] = 93, [6] = 92, [7] = 91 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 44, [1] = 52, [2] = 44, [3] = 42, [4] = 41, [5] = 44, [6] = 38, [7] = 41 }, [1] = { [0] = 24, [1] = 25, [2] = 17, [3] = 15, [4] = 18, [5] = 18, [6] = 11, [7] = 12 }, [2] = { [0] = 169, [1] = 167, [2] = 169, [3] = 172, [4] = 172, [5] = 174, [6] = 170, [7] = 170 }, [3] = { [0] = 235, [1] = 242, [2] = 238, [3] = 236, [4] = 237, [5] = 229, [6] = 232, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 11, [3] = 21, [4] = 12, [5] = 16, [6] = 9, [7] = 18 }, [1] = { [0] = 58, [1] = 55, [2] = 50, [3] = 60, [4] = 50, [5] = 58, [6] = 51, [7] = 57 }, [2] = { [0] = 113, [1] = 110, [2] = 113, [3] = 114, [4] = 114, [5] = 117, [6] = 115, [7] = 115 }, [3] = { [0] = 96, [1] = 95, [2] = 93, [3] = 100, [4] = 92, [5] = 94, [6] = 93, [7] = 92 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 53, [2] = 45, [3] = 43, [4] = 41, [5] = 44, [6] = 38, [7] = 41 }, [1] = { [0] = 25, [1] = 26, [2] = 18, [3] = 16, [4] = 18, [5] = 18, [6] = 11, [7] = 12 }, [2] = { [0] = 170, [1] = 168, [2] = 170, [3] = 172, [4] = 172, [5] = 174, [6] = 170, [7] = 170 }, [3] = { [0] = 236, [1] = 243, [2] = 239, [3] = 237, [4] = 237, [5] = 229, [6] = 232, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 8, [3] = 19, [4] = 13, [5] = 20, [6] = 10, [7] = 19 }, [1] = { [0] = 58, [1] = 55, [2] = 47, [3] = 58, [4] = 51, [5] = 62, [6] = 52, [7] = 58 }, [2] = { [0] = 113, [1] = 110, [2] = 110, [3] = 115, [4] = 115, [5] = 121, [6] = 116, [7] = 116 }, [3] = { [0] = 96, [1] = 95, [2] = 90, [3] = 98, [4] = 93, [5] = 98, [6] = 94, [7] = 93 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 54, [2] = 45, [3] = 44, [4] = 41, [5] = 44, [6] = 38, [7] = 41 }, [1] = { [0] = 26, [1] = 27, [2] = 18, [3] = 17, [4] = 18, [5] = 18, [6] = 11, [7] = 12 }, [2] = { [0] = 171, [1] = 169, [2] = 170, [3] = 172, [4] = 172, [5] = 174, [6] = 170, [7] = 170 }, [3] = { [0] = 237, [1] = 244, [2] = 239, [3] = 238, [4] = 237, [5] = 229, [6] = 232, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 9, [3] = 15, [4] = 14, [5] = 21, [6] = 11, [7] = 20 }, [1] = { [0] = 58, [1] = 55, [2] = 48, [3] = 54, [4] = 52, [5] = 63, [6] = 53, [7] = 59 }, [2] = { [0] = 113, [1] = 110, [2] = 111, [3] = 116, [4] = 116, [5] = 122, [6] = 117, [7] = 117 }, [3] = { [0] = 96, [1] = 95, [2] = 91, [3] = 94, [4] = 94, [5] = 99, [6] = 95, [7] = 94 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 55, [2] = 45, [3] = 44, [4] = 41, [5] = 44, [6] = 41, [7] = 41 }, [1] = { [0] = 27, [1] = 28, [2] = 18, [3] = 17, [4] = 18, [5] = 18, [6] = 14, [7] = 12 }, [2] = { [0] = 172, [1] = 170, [2] = 170, [3] = 172, [4] = 172, [5] = 174, [6] = 173, [7] = 173 }, [3] = { [0] = 238, [1] = 245, [2] = 239, [3] = 238, [4] = 237, [5] = 229, [6] = 235, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 10, [3] = 16, [4] = 18, [5] = 22, [6] = 5, [7] = 21 }, [1] = { [0] = 58, [1] = 55, [2] = 49, [3] = 55, [4] = 56, [5] = 64, [6] = 47, [7] = 60 }, [2] = { [0] = 113, [1] = 110, [2] = 112, [3] = 120, [4] = 120, [5] = 123, [6] = 111, [7] = 111 }, [3] = { [0] = 96, [1] = 95, [2] = 92, [3] = 95, [4] = 98, [5] = 100, [6] = 89, [7] = 95 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 56, [2] = 45, [3] = 44, [4] = 41, [5] = 47, [6] = 42, [7] = 41 }, [1] = { [0] = 28, [1] = 29, [2] = 18, [3] = 17, [4] = 18, [5] = 21, [6] = 15, [7] = 12 }, [2] = { [0] = 173, [1] = 171, [2] = 170, [3] = 172, [4] = 172, [5] = 177, [6] = 174, [7] = 174 }, [3] = { [0] = 239, [1] = 246, [2] = 239, [3] = 238, [4] = 237, [5] = 232, [6] = 236, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 11, [3] = 17, [4] = 19, [5] = 18, [6] = 5, [7] = 22 }, [1] = { [0] = 58, [1] = 55, [2] = 50, [3] = 56, [4] = 57, [5] = 60, [6] = 47, [7] = 61 }, [2] = { [0] = 113, [1] = 110, [2] = 113, [3] = 121, [4] = 121, [5] = 119, [6] = 111, [7] = 111 }, [3] = { [0] = 96, [1] = 95, [2] = 93, [3] = 96, [4] = 99, [5] = 96, [6] = 89, [7] = 96 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 57, [2] = 45, [3] = 44, [4] = 41, [5] = 47, [6] = 42, [7] = 41 }, [1] = { [0] = 30, [1] = 30, [2] = 18, [3] = 17, [4] = 18, [5] = 21, [6] = 15, [7] = 12 }, [2] = { [0] = 175, [1] = 172, [2] = 170, [3] = 172, [4] = 172, [5] = 177, [6] = 174, [7] = 174 }, [3] = { [0] = 241, [1] = 247, [2] = 239, [3] = 238, [4] = 237, [5] = 232, [6] = 236, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 15, [1] = 13, [2] = 12, [3] = 18, [4] = 20, [5] = 24, [6] = 13, [7] = 23 }, [1] = { [0] = 53, [1] = 44, [2] = 51, [3] = 57, [4] = 58, [5] = 66, [6] = 55, [7] = 62 }, [2] = { [0] = 108, [1] = 99, [2] = 114, [3] = 122, [4] = 122, [5] = 125, [6] = 119, [7] = 119 }, [3] = { [0] = 91, [1] = 84, [2] = 94, [3] = 97, [4] = 100, [5] = 102, [6] = 97, [7] = 97 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 57, [2] = 45, [3] = 44, [4] = 41, [5] = 48, [6] = 43, [7] = 41 }, [1] = { [0] = 30, [1] = 30, [2] = 18, [3] = 17, [4] = 18, [5] = 22, [6] = 16, [7] = 12 }, [2] = { [0] = 175, [1] = 172, [2] = 170, [3] = 172, [4] = 172, [5] = 178, [6] = 175, [7] = 175 }, [3] = { [0] = 241, [1] = 247, [2] = 239, [3] = 238, [4] = 237, [5] = 233, [6] = 237, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 14, [2] = 13, [3] = 19, [4] = 21, [5] = 18, [6] = 5, [7] = 24 }, [1] = { [0] = 54, [1] = 45, [2] = 52, [3] = 58, [4] = 59, [5] = 60, [6] = 47, [7] = 63 }, [2] = { [0] = 109, [1] = 100, [2] = 115, [3] = 123, [4] = 123, [5] = 119, [6] = 111, [7] = 111 }, [3] = { [0] = 92, [1] = 85, [2] = 95, [3] = 98, [4] = 101, [5] = 96, [6] = 89, [7] = 98 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 57, [2] = 45, [3] = 45, [4] = 41, [5] = 48, [6] = 43, [7] = 44 }, [1] = { [0] = 30, [1] = 30, [2] = 18, [3] = 18, [4] = 18, [5] = 22, [6] = 16, [7] = 15 }, [2] = { [0] = 175, [1] = 172, [2] = 170, [3] = 172, [4] = 172, [5] = 178, [6] = 175, [7] = 175 }, [3] = { [0] = 241, [1] = 247, [2] = 239, [3] = 239, [4] = 237, [5] = 233, [6] = 237, [7] = 235 } })[R[51]][R[36]], ({ [0] = { [0] = 17, [1] = 15, [2] = 14, [3] = 15, [4] = 22, [5] = 24, [6] = 13, [7] = 13 }, [1] = { [0] = 55, [1] = 46, [2] = 53, [3] = 54, [4] = 60, [5] = 66, [6] = 55, [7] = 52 }, [2] = { [0] = 110, [1] = 101, [2] = 116, [3] = 124, [4] = 124, [5] = 125, [6] = 119, [7] = 119 }, [3] = { [0] = 93, [1] = 86, [2] = 96, [3] = 94, [4] = 102, [5] = 102, [6] = 97, [7] = 87 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 57, [2] = 45, [3] = 45, [4] = 44, [5] = 49, [6] = 44, [7] = 44 }, [1] = { [0] = 30, [1] = 30, [2] = 18, [3] = 18, [4] = 21, [5] = 23, [6] = 17, [7] = 15 }, [2] = { [0] = 175, [1] = 172, [2] = 170, [3] = 175, [4] = 175, [5] = 179, [6] = 176, [7] = 176 }, [3] = { [0] = 241, [1] = 247, [2] = 239, [3] = 239, [4] = 240, [5] = 234, [6] = 238, [7] = 235 } })[R[51]][R[36]], ({ [0] = { [0] = 18, [1] = 16, [2] = 15, [3] = 19, [4] = 8, [5] = 18, [6] = 5, [7] = 26 }, [1] = { [0] = 56, [1] = 47, [2] = 54, [3] = 58, [4] = 46, [5] = 60, [6] = 47, [7] = 65 }, [2] = { [0] = 111, [1] = 102, [2] = 117, [3] = 110, [4] = 110, [5] = 119, [6] = 111, [7] = 111 }, [3] = { [0] = 94, [1] = 87, [2] = 97, [3] = 98, [4] = 88, [5] = 96, [6] = 89, [7] = 100 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 57, [2] = 45, [3] = 46, [4] = 44, [5] = 49, [6] = 44, [7] = 45 }, [1] = { [0] = 30, [1] = 30, [2] = 18, [3] = 19, [4] = 21, [5] = 23, [6] = 17, [7] = 16 }, [2] = { [0] = 175, [1] = 172, [2] = 170, [3] = 175, [4] = 175, [5] = 179, [6] = 176, [7] = 176 }, [3] = { [0] = 241, [1] = 247, [2] = 239, [3] = 240, [4] = 240, [5] = 234, [6] = 238, [7] = 236 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 24, [2] = 16, [3] = 19, [4] = 16, [5] = 24, [6] = 13, [7] = 13 }, [1] = { [0] = 60, [1] = 55, [2] = 55, [3] = 58, [4] = 54, [5] = 66, [6] = 55, [7] = 52 }, [2] = { [0] = 115, [1] = 110, [2] = 118, [3] = 118, [4] = 118, [5] = 125, [6] = 119, [7] = 119 }, [3] = { [0] = 98, [1] = 95, [2] = 98, [3] = 98, [4] = 96, [5] = 102, [6] = 97, [7] = 87 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 58, [2] = 45, [3] = 47, [4] = 44, [5] = 50, [6] = 45, [7] = 45 }, [1] = { [0] = 30, [1] = 31, [2] = 18, [3] = 20, [4] = 21, [5] = 24, [6] = 18, [7] = 16 }, [2] = { [0] = 175, [1] = 173, [2] = 170, [3] = 175, [4] = 175, [5] = 180, [6] = 177, [7] = 177 }, [3] = { [0] = 241, [1] = 248, [2] = 239, [3] = 241, [4] = 240, [5] = 235, [6] = 239, [7] = 236 } })[R[51]][R[36]], ({ [0] = { [0] = 23, [1] = 21, [2] = 17, [3] = 19, [4] = 24, [5] = 18, [6] = 5, [7] = 26 }, [1] = { [0] = 61, [1] = 52, [2] = 56, [3] = 58, [4] = 62, [5] = 60, [6] = 47, [7] = 65 }, [2] = { [0] = 116, [1] = 107, [2] = 119, [3] = 126, [4] = 126, [5] = 119, [6] = 111, [7] = 111 }, [3] = { [0] = 99, [1] = 92, [2] = 99, [3] = 98, [4] = 104, [5] = 96, [6] = 89, [7] = 100 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 58, [2] = 46, [3] = 48, [4] = 45, [5] = 50, [6] = 45, [7] = 46 }, [1] = { [0] = 30, [1] = 31, [2] = 19, [3] = 21, [4] = 22, [5] = 24, [6] = 18, [7] = 17 }, [2] = { [0] = 175, [1] = 173, [2] = 171, [3] = 176, [4] = 176, [5] = 180, [6] = 177, [7] = 177 }, [3] = { [0] = 241, [1] = 248, [2] = 240, [3] = 242, [4] = 241, [5] = 235, [6] = 239, [7] = 237 } })[R[51]][R[36]], ({ [0] = { [0] = 24, [1] = 22, [2] = 11, [3] = 12, [4] = 8, [5] = 24, [6] = 13, [7] = 13 }, [1] = { [0] = 62, [1] = 53, [2] = 50, [3] = 51, [4] = 46, [5] = 66, [6] = 55, [7] = 52 }, [2] = { [0] = 117, [1] = 108, [2] = 113, [3] = 110, [4] = 110, [5] = 125, [6] = 119, [7] = 119 }, [3] = { [0] = 100, [1] = 93, [2] = 93, [3] = 91, [4] = 88, [5] = 102, [6] = 97, [7] = 87 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 58, [2] = 46, [3] = 48, [4] = 45, [5] = 51, [6] = 47, [7] = 46 }, [1] = { [0] = 30, [1] = 31, [2] = 19, [3] = 21, [4] = 22, [5] = 25, [6] = 20, [7] = 17 }, [2] = { [0] = 175, [1] = 173, [2] = 171, [3] = 176, [4] = 176, [5] = 181, [6] = 179, [7] = 179 }, [3] = { [0] = 241, [1] = 248, [2] = 240, [3] = 242, [4] = 241, [5] = 236, [6] = 241, [7] = 237 } })[R[51]][R[36]], ({ [0] = { [0] = 25, [1] = 23, [2] = 17, [3] = 19, [4] = 16, [5] = 18, [6] = 7, [7] = 26 }, [1] = { [0] = 63, [1] = 54, [2] = 56, [3] = 58, [4] = 54, [5] = 60, [6] = 49, [7] = 65 }, [2] = { [0] = 118, [1] = 109, [2] = 119, [3] = 118, [4] = 118, [5] = 119, [6] = 113, [7] = 113 }, [3] = { [0] = 101, [1] = 94, [2] = 99, [3] = 98, [4] = 96, [5] = 96, [6] = 91, [7] = 100 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 53, [1] = 58, [2] = 47, [3] = 49, [4] = 45, [5] = 51, [6] = 47, [7] = 47 }, [1] = { [0] = 33, [1] = 31, [2] = 20, [3] = 22, [4] = 22, [5] = 25, [6] = 20, [7] = 18 }, [2] = { [0] = 178, [1] = 173, [2] = 172, [3] = 176, [4] = 176, [5] = 181, [6] = 179, [7] = 179 }, [3] = { [0] = 244, [1] = 248, [2] = 241, [3] = 243, [4] = 241, [5] = 236, [6] = 241, [7] = 238 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 11, [3] = 12, [4] = 24, [5] = 24, [6] = 8, [7] = 13 }, [1] = { [0] = 58, [1] = 55, [2] = 50, [3] = 51, [4] = 62, [5] = 66, [6] = 50, [7] = 52 }, [2] = { [0] = 113, [1] = 110, [2] = 113, [3] = 126, [4] = 126, [5] = 125, [6] = 114, [7] = 114 }, [3] = { [0] = 96, [1] = 95, [2] = 93, [3] = 91, [4] = 104, [5] = 102, [6] = 92, [7] = 87 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 54, [1] = 58, [2] = 47, [3] = 50, [4] = 46, [5] = 52, [6] = 47, [7] = 47 }, [1] = { [0] = 34, [1] = 31, [2] = 20, [3] = 23, [4] = 23, [5] = 26, [6] = 20, [7] = 18 }, [2] = { [0] = 179, [1] = 173, [2] = 172, [3] = 177, [4] = 177, [5] = 182, [6] = 179, [7] = 179 }, [3] = { [0] = 245, [1] = 248, [2] = 241, [3] = 244, [4] = 242, [5] = 237, [6] = 241, [7] = 238 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 25, [2] = 17, [3] = 12, [4] = 8, [5] = 18, [6] = 9, [7] = 26 }, [1] = { [0] = 58, [1] = 56, [2] = 56, [3] = 51, [4] = 46, [5] = 60, [6] = 51, [7] = 65 }, [2] = { [0] = 113, [1] = 111, [2] = 119, [3] = 110, [4] = 110, [5] = 119, [6] = 115, [7] = 115 }, [3] = { [0] = 96, [1] = 96, [2] = 99, [3] = 91, [4] = 88, [5] = 96, [6] = 93, [7] = 100 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 55, [1] = 58, [2] = 48, [3] = 51, [4] = 46, [5] = 53, [6] = 47, [7] = 48 }, [1] = { [0] = 35, [1] = 31, [2] = 21, [3] = 24, [4] = 23, [5] = 27, [6] = 20, [7] = 19 }, [2] = { [0] = 180, [1] = 173, [2] = 173, [3] = 177, [4] = 177, [5] = 183, [6] = 179, [7] = 179 }, [3] = { [0] = 246, [1] = 248, [2] = 242, [3] = 245, [4] = 242, [5] = 238, [6] = 241, [7] = 239 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 26, [2] = 11, [3] = 12, [4] = 9, [5] = 18, [6] = 10, [7] = 13 }, [1] = { [0] = 58, [1] = 57, [2] = 50, [3] = 51, [4] = 47, [5] = 60, [6] = 52, [7] = 52 }, [2] = { [0] = 113, [1] = 112, [2] = 113, [3] = 111, [4] = 111, [5] = 119, [6] = 116, [7] = 116 }, [3] = { [0] = 96, [1] = 97, [2] = 93, [3] = 91, [4] = 89, [5] = 96, [6] = 94, [7] = 87 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 56, [1] = 58, [2] = 48, [3] = 52, [4] = 46, [5] = 54, [6] = 47, [7] = 48 }, [1] = { [0] = 36, [1] = 31, [2] = 21, [3] = 25, [4] = 23, [5] = 28, [6] = 20, [7] = 19 }, [2] = { [0] = 181, [1] = 173, [2] = 173, [3] = 177, [4] = 177, [5] = 184, [6] = 179, [7] = 179 }, [3] = { [0] = 247, [1] = 248, [2] = 242, [3] = 246, [4] = 242, [5] = 239, [6] = 241, [7] = 239 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 31, [2] = 17, [3] = 12, [4] = 16, [5] = 18, [6] = 11, [7] = 14 }, [1] = { [0] = 58, [1] = 62, [2] = 56, [3] = 51, [4] = 54, [5] = 60, [6] = 53, [7] = 53 }, [2] = { [0] = 113, [1] = 117, [2] = 119, [3] = 118, [4] = 118, [5] = 119, [6] = 117, [7] = 117 }, [3] = { [0] = 96, [1] = 102, [2] = 99, [3] = 91, [4] = 96, [5] = 96, [6] = 95, [7] = 88 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 57, [1] = 58, [2] = 49, [3] = 53, [4] = 46, [5] = 54, [6] = 51, [7] = 48 }, [1] = { [0] = 37, [1] = 31, [2] = 22, [3] = 26, [4] = 23, [5] = 28, [6] = 24, [7] = 19 }, [2] = { [0] = 182, [1] = 173, [2] = 174, [3] = 177, [4] = 177, [5] = 184, [6] = 183, [7] = 183 }, [3] = { [0] = 248, [1] = 248, [2] = 243, [3] = 247, [4] = 242, [5] = 239, [6] = 245, [7] = 239 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 32, [2] = 11, [3] = 12, [4] = 24, [5] = 19, [6] = 13, [7] = 15 }, [1] = { [0] = 58, [1] = 63, [2] = 50, [3] = 51, [4] = 62, [5] = 61, [6] = 55, [7] = 54 }, [2] = { [0] = 113, [1] = 118, [2] = 113, [3] = 126, [4] = 126, [5] = 120, [6] = 119, [7] = 119 }, [3] = { [0] = 96, [1] = 103, [2] = 93, [3] = 91, [4] = 104, [5] = 97, [6] = 97, [7] = 89 } })[R[51]][R[36]] })
    if R[36] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 58, [1] = 38, [2] = 183, [3] = 249 })[R[51]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 59, [1] = 39, [2] = 184, [3] = 250 })[R[51]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[51]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 58, [1] = 38, [2] = 183, [3] = 249 })[R[51]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 59, [1] = 39, [2] = 184, [3] = 250 })[R[51]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[51]] })
        for i = 1, game.initial_units() do
          R[67] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 56, [1] = 36, [2] = 181, [3] = 247 }, [1] = { [0] = 43, [1] = 23, [2] = 168, [3] = 234 }, [2] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 } })[R[67]][R[51]], ({ [0] = { [0] = 14, [1] = 52, [2] = 107, [3] = 90 }, [1] = { [0] = 23, [1] = 61, [2] = 116, [3] = 99 }, [2] = { [0] = 26, [1] = 64, [2] = 119, [3] = 102 } })[R[67]][R[51]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[51]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[51]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[51]], ({ [0] = 34, [1] = 65, [2] = 120, [3] = 105 })[R[51]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[51]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[51]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[51]], ({ [0] = 34, [1] = 65, [2] = 120, [3] = 105 })[R[51]] })
        for i = 1, game.initial_units() do
          R[68] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 49, [1] = 22, [2] = 164, [3] = 239 }, [1] = { [0] = 51, [1] = 24, [2] = 166, [3] = 241 }, [2] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 } })[R[68]][R[51]], ({ [0] = { [0] = 28, [1] = 59, [2] = 114, [3] = 99 }, [1] = { [0] = 30, [1] = 61, [2] = 116, [3] = 101 }, [2] = { [0] = 22, [1] = 53, [2] = 108, [3] = 93 } })[R[68]][R[51]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[69] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 40, [1] = 13, [2] = 165, [3] = 234 }, [1] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [2] = { [0] = 58, [1] = 31, [2] = 183, [3] = 252 } })[R[69]][R[51]], ({ [0] = { [0] = 5, [1] = 44, [2] = 107, [3] = 87 }, [1] = { [0] = 21, [1] = 60, [2] = 123, [3] = 103 }, [2] = { [0] = 14, [1] = 53, [2] = 116, [3] = 96 } })[R[69]][R[51]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 3 then
      game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 178, [3] = 247 })[R[51]], ({ [0] = 19, [1] = 58, [2] = 111, [3] = 98 })[R[51]] })
      game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 178, [3] = 248 })[R[51]], ({ [0] = 19, [1] = 58, [2] = 112, [3] = 98 })[R[51]] })
      game.create_tube({ ({ [0] = 55, [1] = 28, [2] = 178, [3] = 249 })[R[51]], ({ [0] = 19, [1] = 58, [2] = 118, [3] = 98 })[R[51]] })
      game.create_tube({ ({ [0] = 56, [1] = 29, [2] = 178, [3] = 250 })[R[51]], ({ [0] = 15, [1] = 54, [2] = 126, [3] = 94 })[R[51]] })
      game.create_tube({ ({ [0] = 56, [1] = 29, [2] = 179, [3] = 250 })[R[51]], ({ [0] = 19, [1] = 58, [2] = 112, [3] = 98 })[R[51]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 179, [3] = 251 })[R[51]], ({ [0] = 15, [1] = 54, [2] = 118, [3] = 94 })[R[51]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 179, [3] = 251 })[R[51]], ({ [0] = 16, [1] = 55, [2] = 126, [3] = 95 })[R[51]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[51]], ({ [0] = 17, [1] = 56, [2] = 112, [3] = 96 })[R[51]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[51]], ({ [0] = 18, [1] = 57, [2] = 118, [3] = 97 })[R[51]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[51]], ({ [0] = 19, [1] = 58, [2] = 126, [3] = 98 })[R[51]] })
      game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 181, [3] = 252 })[R[51]], ({ [0] = 19, [1] = 58, [2] = 117, [3] = 98 })[R[51]] })
      game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 181, [3] = 252 })[R[51]], ({ [0] = 20, [1] = 59, [2] = 118, [3] = 99 })[R[51]] })
      if R[51] == 0 then
        if game.initial_units() == 0 then
          game.create_tube({ 58, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 58, 21 })
          for i = 1, game.initial_units() do
            R[70] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 51, [1] = 52, [2] = 39 })[R[70]], ({ [0] = 15, [1] = 22, [2] = 19 })[R[70]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[51] == 1 then
        if game.initial_units() == 0 then
          game.create_tube({ 31, 60 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 31, 60 })
          for i = 1, game.initial_units() do
            R[71] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 24, [1] = 25, [2] = 12 })[R[71]], ({ [0] = 54, [1] = 61, [2] = 58 })[R[71]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[51] == 2 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
          for i = 1, game.initial_units() do
            R[72] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 176, [1] = 167, [2] = 175 })[R[72]], ({ [0] = 109, [1] = 117, [2] = 112 })[R[72]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[51] == 3 then
        if game.initial_units() == 0 then
          game.create_tube({ 252, 100 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 252, 100 })
          for i = 1, game.initial_units() do
            R[73] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 245, [1] = 246, [2] = 233 })[R[73]], ({ [0] = 94, [1] = 101, [2] = 98 })[R[73]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[51]", R[51])
      end
    elseif R[36] == 4 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[51]], ({ [0] = 9, [1] = 47, [2] = 111, [3] = 89 })[R[51]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[51]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[51]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[51]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[51]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[51]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[51]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[51]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[51]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[51]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[51]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[51]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[51]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 17, [1] = 55, [2] = 119, [3] = 97 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 18, [1] = 56, [2] = 120, [3] = 98 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[51]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[51]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[51]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[51]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 13, [1] = 51, [2] = 115, [3] = 93 })[R[51]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 14, [1] = 52, [2] = 116, [3] = 94 })[R[51]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[51]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[51]] })
        for i = 1, game.initial_units() do
          R[74] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [1] = { [0] = 36, [1] = 13, [2] = 167, [3] = 232 }, [2] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 } })[R[74]][R[51]], ({ [0] = { [0] = 7, [1] = 45, [2] = 109, [3] = 87 }, [1] = { [0] = 15, [1] = 53, [2] = 117, [3] = 95 }, [2] = { [0] = 10, [1] = 48, [2] = 112, [3] = 90 } })[R[74]][R[51]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[51]], ({ [0] = 9, [1] = 47, [2] = 111, [3] = 89 })[R[51]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[51]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[51]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[51]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[51]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[51]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[51]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[51]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[51]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[51]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[51]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[51]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[51]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 17, [1] = 55, [2] = 119, [3] = 97 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 18, [1] = 56, [2] = 120, [3] = 98 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[51]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[51]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[51]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[51]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 13, [1] = 51, [2] = 115, [3] = 93 })[R[51]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 14, [1] = 52, [2] = 116, [3] = 94 })[R[51]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[51]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[51]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[51]], ({ [0] = 20, [1] = 62, [2] = 121, [3] = 98 })[R[51]] })
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[51]], ({ [0] = 21, [1] = 63, [2] = 122, [3] = 99 })[R[51]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[51]], ({ [0] = 20, [1] = 62, [2] = 121, [3] = 98 })[R[51]] })
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[51]], ({ [0] = 21, [1] = 63, [2] = 122, [3] = 99 })[R[51]] })
        for i = 1, game.initial_units() do
          R[75] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [1] = { [0] = 33, [1] = 7, [2] = 163, [3] = 218 }, [2] = { [0] = 55, [1] = 29, [2] = 185, [3] = 240 } })[R[75]][R[51]], ({ [0] = { [0] = 27, [1] = 69, [2] = 128, [3] = 105 }, [1] = { [0] = 14, [1] = 56, [2] = 115, [3] = 92 }, [2] = { [0] = 27, [1] = 69, [2] = 128, [3] = 105 } })[R[75]][R[51]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 52, [1] = 25, [2] = 184, [3] = 246 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] })
        game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 185, [3] = 247 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] })
        game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 186, [3] = 248 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 52, [1] = 25, [2] = 184, [3] = 246 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] })
        game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 185, [3] = 247 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] })
        game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 186, [3] = 248 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] })
        for i = 1, game.initial_units() do
          R[76] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 33, [1] = 6, [2] = 165, [3] = 227 }, [1] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [2] = { [0] = 59, [1] = 32, [2] = 191, [3] = 253 } })[R[76]][R[51]], ({ [0] = { [0] = 3, [1] = 45, [2] = 109, [3] = 87 }, [1] = { [0] = 1, [1] = 43, [2] = 107, [3] = 85 }, [2] = { [0] = 16, [1] = 58, [2] = 122, [3] = 100 } })[R[76]][R[51]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 7 then
      game.create_tube({ ({ [0] = 48, [1] = 19, [2] = 184, [3] = 239 })[R[51]], ({ [0] = 16, [1] = 55, [2] = 119, [3] = 90 })[R[51]] })
      game.create_tube({ ({ [0] = 48, [1] = 19, [2] = 185, [3] = 239 })[R[51]], ({ [0] = 17, [1] = 56, [2] = 119, [3] = 91 })[R[51]] })
      if R[51] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
          for i = 1, game.initial_units() do
            R[77] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 46, [1] = 52, [2] = 40 })[R[77]], ({ [0] = 9, [1] = 9, [2] = 30 })[R[77]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[51] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
          for i = 1, game.initial_units() do
            R[78] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 17, [1] = 23, [2] = 11 })[R[78]], ({ [0] = 48, [1] = 48, [2] = 69 })[R[78]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[51] == 2 then
        if game.initial_units() == 0 then
          game.create_tube({ 186, 119 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 186, 119 })
          for i = 1, game.initial_units() do
            R[79] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 165, [1] = 170, [2] = 191 })[R[79]], ({ [0] = 109, [1] = 107, [2] = 122 })[R[79]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[51] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
          for i = 1, game.initial_units() do
            R[80] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 237, [1] = 243, [2] = 231 })[R[80]], ({ [0] = 83, [1] = 83, [2] = 104 })[R[80]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[51]", R[51])
      end
    else
      unseen("R[36]", R[36])
    end
    R[81] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 50, [1] = 23, [2] = 172, [3] = 244 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 48, [1] = 19, [2] = 170, [3] = 239 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 6, [1] = 45, [2] = 108, [3] = 88 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 20, [1] = 59, [2] = 111, [3] = 94 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 50, [1] = 23, [2] = 172, [3] = 244 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 48, [1] = 19, [2] = 170, [3] = 239 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 6, [1] = 45, [2] = 108, [3] = 88 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 20, [1] = 59, [2] = 111, [3] = 94 } })[R[81]][R[52]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 39, [1] = 12, [2] = 164, [3] = 233 }, [3] = { [0] = 58, [1] = 31, [2] = 172, [3] = 252 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 41, [1] = 12, [2] = 179, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 11, [1] = 42, [2] = 97, [3] = 82 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 23, [1] = 62, [2] = 126, [3] = 102 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    if R[81] == 0 or R[81] == 1 or R[81] == 2 or R[81] == 5 or R[81] == 6 or R[81] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = { [0] = 62, [1] = 42, [2] = 187, [3] = 253 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 42, [1] = 15, [2] = 167, [3] = 236 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 48, [1] = 21, [2] = 180, [3] = 242 }, [7] = { [0] = 41, [1] = 12, [2] = 180, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 18, [1] = 49, [2] = 104, [3] = 89 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [5] = { [0] = 23, [1] = 65, [2] = 124, [3] = 101 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      if R[81] == 0 then
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
      elseif R[81] == 1 then
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
      elseif R[81] == 2 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[52]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[52]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[52]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[81] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[52]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[52]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[52]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[81] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[52]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[52]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[52]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[81] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[52]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[52]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[52]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[81]", R[81])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = { [0] = 39, [1] = 19, [2] = 164, [3] = 230 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 39, [1] = 12, [2] = 171, [3] = 233 }, [7] = { [0] = 57, [1] = 28, [2] = 171, [3] = 248 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 28, [1] = 59, [2] = 114, [3] = 99 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 25, [1] = 64, [2] = 119, [3] = 99 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      if R[81] == 2 or R[81] == 5 or R[81] == 6 or R[81] == 7 then
      elseif R[81] == 0 or R[81] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 } })[R[81]][R[52]], ({ [0] = { [0] = 27, [1] = 65, [2] = 120, [3] = 103 }, [1] = { [0] = 36, [1] = 67, [2] = 122, [3] = 107 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[81]", R[81])
      end
    elseif R[81] == 3 or R[81] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 } })[R[81]][R[52]], ({ [3] = { [0] = 23, [1] = 62, [2] = 110, [3] = 102 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      if R[81] == 3 then
        if R[52] == 0 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 45, 12 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 45, 12 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 45, 12 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[52] == 1 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 18, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 18, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 18, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[52] == 2 then
          if LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 183, 122 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 183, 122 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 183, 122 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[52] == 3 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 239, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 239, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 239, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[52]", R[52])
        end
      elseif R[81] == 4 then
        if LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 20, [1] = 58, [2] = 122, [3] = 100 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 20, [1] = 58, [2] = 122, [3] = 100 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[3].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 20, [1] = 58, [2] = 122, [3] = 100 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[81]", R[81])
      end
    else
      unseen("R[81]", R[81])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = { [0] = 39, [1] = 19, [2] = 164, [3] = 230 }, [1] = { [0] = 48, [1] = 21, [2] = 163, [3] = 238 }, [2] = { [0] = 59, [1] = 32, [2] = 184, [3] = 253 }, [3] = { [0] = 51, [1] = 24, [2] = 164, [3] = 245 }, [4] = { [0] = 33, [1] = 10, [2] = 164, [3] = 229 }, [5] = { [0] = 34, [1] = 8, [2] = 164, [3] = 219 }, [6] = { [0] = 31, [1] = 4, [2] = 163, [3] = 225 }, [7] = { [0] = 49, [1] = 20, [2] = 163, [3] = 240 } })[R[81]][R[52]], ({ [0] = { [0] = 29, [1] = 67, [2] = 122, [3] = 105 }, [1] = { [0] = 33, [1] = 64, [2] = 119, [3] = 104 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 6, [1] = 45, [2] = 114, [3] = 85 }, [4] = { [0] = 12, [1] = 50, [2] = 114, [3] = 92 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 29, [1] = 68, [2] = 119, [3] = 103 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 46, [1] = 26, [2] = 171, [3] = 237 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 40, [1] = 13, [2] = 182, [3] = 234 }, [4] = { [0] = 51, [1] = 28, [2] = 182, [3] = 247 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 59, [1] = 30, [2] = 170, [3] = 250 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 15, [1] = 54, [2] = 117, [3] = 97 }, [3] = { [0] = 13, [1] = 52, [2] = 118, [3] = 92 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 9, [1] = 51, [2] = 110, [3] = 87 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 20, [1] = 59, [2] = 124, [3] = 94 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 43, [1] = 16, [2] = 184, [3] = 237 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 17, [1] = 48, [2] = 103, [3] = 88 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 9, [1] = 48, [2] = 118, [3] = 88 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[3].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 60, [1] = 33, [2] = 176, [3] = 254 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 31, [2] = 176, [3] = 252 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 9, [1] = 48, [2] = 126, [3] = 88 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 184, [3] = 240 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 24, [1] = 63, [2] = 118, [3] = 103 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 184, [3] = 240 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 24, [1] = 63, [2] = 118, [3] = 103 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 40, [1] = 13, [2] = 176, [3] = 234 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "RoboSurveyor", [3] = "CargoTruck" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 40, [1] = 13, [2] = 177, [3] = 234 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 39, [1] = 13, [2] = 169, [3] = 224 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 43, [1] = 14, [2] = 175, [3] = 234 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 19, [1] = 58, [2] = 121, [3] = 101 }, [3] = { [0] = 13, [1] = 52, [2] = 122, [3] = 92 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 8, [1] = 50, [2] = 109, [3] = 86 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 20, [1] = 59, [2] = 121, [3] = 94 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [3] = { [0] = 46, [1] = 19, [2] = 179, [3] = 240 }, [4] = { [0] = 48, [1] = 25, [2] = 179, [3] = 244 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 38, [1] = 9, [2] = 184, [3] = 229 } })[R[81]][R[52]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 10, [1] = 41, [2] = 96, [3] = 81 }, [2] = { [0] = 20, [1] = 59, [2] = 122, [3] = 102 }, [3] = { [0] = 24, [1] = 63, [2] = 113, [3] = 103 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 12, [1] = 54, [2] = 118, [3] = 96 }, [7] = { [0] = 17, [1] = 56, [2] = 118, [3] = 91 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 60, [1] = 33, [2] = 176, [3] = 254 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 31, [2] = 176, [3] = 252 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 9, [1] = 48, [2] = 126, [3] = 88 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 184, [3] = 240 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 24, [1] = 63, [2] = 118, [3] = 103 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 46, [1] = 19, [2] = 176, [3] = 240 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 24, [1] = 63, [2] = 126, [3] = 103 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "RoboSurveyor", [3] = "CargoTruck" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 40, [1] = 13, [2] = 177, [3] = 234 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 39, [1] = 13, [2] = 169, [3] = 224 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 43, [1] = 14, [2] = 175, [3] = 234 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 19, [1] = 58, [2] = 121, [3] = 101 }, [3] = { [0] = 13, [1] = 52, [2] = 122, [3] = 92 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 8, [1] = 50, [2] = 109, [3] = 86 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 20, [1] = 59, [2] = 121, [3] = 94 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [3] = { [0] = 46, [1] = 19, [2] = 179, [3] = 240 }, [4] = { [0] = 48, [1] = 25, [2] = 179, [3] = 244 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 38, [1] = 9, [2] = 184, [3] = 229 } })[R[81]][R[52]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 10, [1] = 41, [2] = 96, [3] = 81 }, [2] = { [0] = 20, [1] = 59, [2] = 122, [3] = 102 }, [3] = { [0] = 24, [1] = 63, [2] = 113, [3] = 103 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 12, [1] = 54, [2] = 118, [3] = 96 }, [7] = { [0] = 17, [1] = 56, [2] = 118, [3] = 91 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 60, [1] = 33, [2] = 176, [3] = 254 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 31, [2] = 176, [3] = 252 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 9, [1] = 48, [2] = 126, [3] = 88 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboSurveyor", [3] = "ConVec" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 177, [3] = 240 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 39, [1] = 13, [2] = 169, [3] = 224 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 43, [1] = 14, [2] = 175, [3] = 234 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 19, [1] = 58, [2] = 121, [3] = 101 }, [3] = { [0] = 24, [1] = 63, [2] = 122, [3] = 103 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 8, [1] = 50, [2] = 109, [3] = 86 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 20, [1] = 59, [2] = 121, [3] = 94 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [3] = { [0] = 46, [1] = 19, [2] = 179, [3] = 240 }, [4] = { [0] = 48, [1] = 25, [2] = 179, [3] = 244 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 38, [1] = 9, [2] = 184, [3] = 229 } })[R[81]][R[52]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 10, [1] = 41, [2] = 96, [3] = 81 }, [2] = { [0] = 20, [1] = 59, [2] = 122, [3] = 102 }, [3] = { [0] = 24, [1] = 63, [2] = 113, [3] = 103 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 12, [1] = 54, [2] = 118, [3] = 96 }, [7] = { [0] = 17, [1] = 56, [2] = 118, [3] = 91 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 62, [1] = 42, [2] = 187, [3] = 253 }, [1] = { [0] = 56, [1] = 29, [2] = 171, [3] = 246 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 50, [1] = 23, [2] = 185, [3] = 244 }, [4] = { [0] = 54, [1] = 31, [2] = 185, [3] = 250 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 52, [1] = 23, [2] = 184, [3] = 243 } })[R[81]][R[52]], ({ [0] = { [0] = 24, [1] = 62, [2] = 117, [3] = 100 }, [1] = { [0] = 23, [1] = 54, [2] = 109, [3] = 94 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 10, [1] = 49, [2] = 109, [3] = 89 }, [4] = { [0] = 7, [1] = 45, [2] = 109, [3] = 87 }, [5] = { [0] = 25, [1] = 67, [2] = 126, [3] = 103 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 19, [1] = 58, [2] = 121, [3] = 93 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 22, [2] = 167, [3] = 233 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 42, [1] = 15, [2] = 167, [3] = 236 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 19, [1] = 58, [2] = 112, [3] = 98 }, [4] = { [0] = 10, [1] = 48, [2] = 112, [3] = 90 }, [5] = { [0] = 14, [1] = 56, [2] = 115, [3] = 92 }, [6] = { [0] = 7, [1] = 49, [2] = 113, [3] = 91 }, [7] = { [0] = 16, [1] = 55, [2] = 113, [3] = 90 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 43, [1] = 23, [2] = 168, [3] = 234 }, [1] = { [0] = 51, [1] = 24, [2] = 166, [3] = 241 }, [2] = { [0] = 43, [1] = 16, [2] = 168, [3] = 237 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 20, [1] = 59, [2] = 113, [3] = 99 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 15, [1] = 57, [2] = 116, [3] = 93 }, [6] = { [0] = 8, [1] = 50, [2] = 114, [3] = 92 }, [7] = { [0] = 17, [1] = 56, [2] = 114, [3] = 91 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 52, [1] = 25, [2] = 167, [3] = 242 }, [2] = { [0] = 44, [1] = 17, [2] = 169, [3] = 238 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 21, [1] = 60, [2] = 114, [3] = 100 }, [4] = { [0] = 12, [1] = 50, [2] = 114, [3] = 92 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 9, [1] = 51, [2] = 115, [3] = 93 }, [7] = { [0] = 18, [1] = 57, [2] = 115, [3] = 92 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 25, [2] = 170, [3] = 236 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 43, [1] = 16, [2] = 172, [3] = 237 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 8, [1] = 47, [2] = 110, [3] = 90 }, [3] = { [0] = 19, [1] = 58, [2] = 115, [3] = 98 }, [4] = { [0] = 13, [1] = 51, [2] = 115, [3] = 93 }, [5] = { [0] = 20, [1] = 62, [2] = 121, [3] = 98 }, [6] = { [0] = 10, [1] = 52, [2] = 116, [3] = 94 }, [7] = { [0] = 19, [1] = 58, [2] = 116, [3] = 93 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 26, [2] = 171, [3] = 237 }, [1] = { [0] = 54, [1] = 27, [2] = 169, [3] = 244 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 9, [1] = 48, [2] = 111, [3] = 91 }, [3] = { [0] = 15, [1] = 54, [2] = 116, [3] = 94 }, [4] = { [0] = 14, [1] = 52, [2] = 116, [3] = 94 }, [5] = { [0] = 21, [1] = 63, [2] = 122, [3] = 99 }, [6] = { [0] = 11, [1] = 53, [2] = 117, [3] = 95 }, [7] = { [0] = 20, [1] = 59, [2] = 117, [3] = 94 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 27, [2] = 172, [3] = 238 }, [1] = { [0] = 55, [1] = 28, [2] = 170, [3] = 245 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 41, [1] = 14, [2] = 173, [3] = 235 }, [7] = { [0] = 41, [1] = 12, [2] = 173, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 10, [1] = 49, [2] = 112, [3] = 92 }, [3] = { [0] = 16, [1] = 55, [2] = 120, [3] = 95 }, [4] = { [0] = 18, [1] = 56, [2] = 120, [3] = 98 }, [5] = { [0] = 22, [1] = 64, [2] = 123, [3] = 100 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 21, [1] = 60, [2] = 111, [3] = 95 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 28, [2] = 173, [3] = 239 }, [1] = { [0] = 56, [1] = 29, [2] = 171, [3] = 246 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 47, [1] = 21, [2] = 177, [3] = 232 }, [6] = { [0] = 42, [1] = 15, [2] = 174, [3] = 236 }, [7] = { [0] = 41, [1] = 12, [2] = 174, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 17, [1] = 56, [2] = 121, [3] = 96 }, [4] = { [0] = 19, [1] = 57, [2] = 121, [3] = 99 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 22, [1] = 61, [2] = 111, [3] = 96 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 47, [1] = 21, [2] = 177, [3] = 232 }, [6] = { [0] = 42, [1] = 15, [2] = 174, [3] = 236 }, [7] = { [0] = 41, [1] = 12, [2] = 174, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 15, [1] = 53, [2] = 108, [3] = 91 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 12, [1] = 51, [2] = 114, [3] = 94 }, [3] = { [0] = 18, [1] = 57, [2] = 122, [3] = 97 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 23, [1] = 62, [2] = 119, [3] = 97 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 41, [1] = 12, [2] = 175, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 14, [1] = 45, [2] = 100, [3] = 85 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 19, [1] = 58, [2] = 123, [3] = 98 }, [4] = { [0] = 21, [1] = 59, [2] = 123, [3] = 101 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 24, [1] = 63, [2] = 111, [3] = 98 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 45, [1] = 18, [2] = 172, [3] = 239 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 44, [1] = 15, [2] = 175, [3] = 235 } })[R[81]][R[52]], ({ [0] = { [0] = 17, [1] = 55, [2] = 110, [3] = 93 }, [1] = { [0] = 15, [1] = 46, [2] = 101, [3] = 86 }, [2] = { [0] = 14, [1] = 53, [2] = 116, [3] = 96 }, [3] = { [0] = 15, [1] = 54, [2] = 124, [3] = 94 }, [4] = { [0] = 22, [1] = 60, [2] = 124, [3] = 102 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 45, [1] = 18, [2] = 175, [3] = 239 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 49, [1] = 23, [2] = 179, [3] = 234 }, [6] = { [0] = 44, [1] = 17, [2] = 176, [3] = 238 }, [7] = { [0] = 44, [1] = 15, [2] = 176, [3] = 235 } })[R[81]][R[52]], ({ [0] = { [0] = 18, [1] = 56, [2] = 111, [3] = 94 }, [1] = { [0] = 16, [1] = 47, [2] = 102, [3] = 87 }, [2] = { [0] = 15, [1] = 54, [2] = 117, [3] = 97 }, [3] = { [0] = 19, [1] = 58, [2] = 110, [3] = 98 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 46, [1] = 19, [2] = 175, [3] = 240 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 49, [1] = 23, [2] = 179, [3] = 234 }, [6] = { [0] = 44, [1] = 17, [2] = 176, [3] = 238 }, [7] = { [0] = 45, [1] = 16, [2] = 176, [3] = 236 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 47, [1] = 20, [2] = 175, [3] = 241 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [6] = { [0] = 45, [1] = 18, [2] = 177, [3] = 239 }, [7] = { [0] = 45, [1] = 16, [2] = 177, [3] = 236 } })[R[81]][R[52]], ({ [0] = { [0] = 23, [1] = 61, [2] = 116, [3] = 99 }, [1] = { [0] = 21, [1] = 52, [2] = 107, [3] = 92 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 19, [1] = 58, [2] = 126, [3] = 98 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 46, [1] = 19, [2] = 171, [3] = 240 }, [3] = { [0] = 48, [1] = 21, [2] = 176, [3] = 242 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [6] = { [0] = 45, [1] = 18, [2] = 177, [3] = 239 }, [7] = { [0] = 46, [1] = 17, [2] = 177, [3] = 237 } })[R[81]][R[52]], ({ [0] = { [0] = 24, [1] = 62, [2] = 117, [3] = 100 }, [1] = { [0] = 22, [1] = 53, [2] = 108, [3] = 93 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 110, [3] = 91 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 46, [1] = 19, [2] = 171, [3] = 240 }, [3] = { [0] = 48, [1] = 21, [2] = 176, [3] = 242 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 51, [1] = 25, [2] = 181, [3] = 236 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 46, [1] = 17, [2] = 179, [3] = 237 } })[R[81]][R[52]], ({ [0] = { [0] = 25, [1] = 63, [2] = 118, [3] = 101 }, [1] = { [0] = 23, [1] = 54, [2] = 109, [3] = 94 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 7, [1] = 49, [2] = 113, [3] = 91 }, [7] = { [0] = 26, [1] = 65, [2] = 113, [3] = 100 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 53, [1] = 33, [2] = 178, [3] = 244 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 49, [1] = 22, [2] = 176, [3] = 243 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 51, [1] = 25, [2] = 181, [3] = 236 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 47, [1] = 18, [2] = 179, [3] = 238 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 126, [3] = 91 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 8, [1] = 50, [2] = 114, [3] = 92 }, [7] = { [0] = 13, [1] = 52, [2] = 114, [3] = 87 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 54, [1] = 34, [2] = 179, [3] = 245 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 50, [1] = 23, [2] = 177, [3] = 244 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 47, [1] = 18, [2] = 179, [3] = 238 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 25, [1] = 56, [2] = 111, [3] = 96 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 12, [1] = 51, [2] = 110, [3] = 91 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 9, [1] = 51, [2] = 115, [3] = 93 }, [7] = { [0] = 26, [1] = 65, [2] = 115, [3] = 100 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 48, [1] = 21, [2] = 173, [3] = 242 }, [3] = { [0] = 51, [1] = 24, [2] = 177, [3] = 245 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 53, [1] = 27, [2] = 183, [3] = 238 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 48, [1] = 19, [2] = 179, [3] = 239 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 26, [1] = 57, [2] = 112, [3] = 97 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 111, [3] = 91 }, [4] = { [0] = 9, [1] = 47, [2] = 111, [3] = 89 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 10, [1] = 52, [2] = 116, [3] = 94 }, [7] = { [0] = 13, [1] = 52, [2] = 116, [3] = 87 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 56, [1] = 36, [2] = 181, [3] = 247 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 48, [1] = 21, [2] = 173, [3] = 242 }, [3] = { [0] = 52, [1] = 25, [2] = 177, [3] = 246 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 48, [1] = 19, [2] = 179, [3] = 239 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 31, [1] = 62, [2] = 117, [3] = 102 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 12, [1] = 51, [2] = 118, [3] = 91 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 11, [1] = 53, [2] = 117, [3] = 95 }, [7] = { [0] = 14, [1] = 53, [2] = 117, [3] = 88 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 57, [1] = 37, [2] = 182, [3] = 248 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 49, [1] = 22, [2] = 174, [3] = 243 }, [3] = { [0] = 53, [1] = 26, [2] = 177, [3] = 247 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 48, [1] = 19, [2] = 183, [3] = 239 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 32, [1] = 63, [2] = 118, [3] = 103 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 126, [3] = 91 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 15, [1] = 54, [2] = 119, [3] = 89 } })[R[81]][R[52]] })
    if R[81] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 58, [1] = 38, [2] = 183, [3] = 249 })[R[52]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 59, [1] = 39, [2] = 184, [3] = 250 })[R[52]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[52]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 58, [1] = 38, [2] = 183, [3] = 249 })[R[52]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 59, [1] = 39, [2] = 184, [3] = 250 })[R[52]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[52]] })
        for i = 1, game.initial_units() do
          R[82] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 56, [1] = 36, [2] = 181, [3] = 247 }, [1] = { [0] = 43, [1] = 23, [2] = 168, [3] = 234 }, [2] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 } })[R[82]][R[52]], ({ [0] = { [0] = 14, [1] = 52, [2] = 107, [3] = 90 }, [1] = { [0] = 23, [1] = 61, [2] = 116, [3] = 99 }, [2] = { [0] = 26, [1] = 64, [2] = 119, [3] = 102 } })[R[82]][R[52]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[52]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[52]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[52]], ({ [0] = 34, [1] = 65, [2] = 120, [3] = 105 })[R[52]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[52]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[52]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[52]], ({ [0] = 34, [1] = 65, [2] = 120, [3] = 105 })[R[52]] })
        for i = 1, game.initial_units() do
          R[83] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 49, [1] = 22, [2] = 164, [3] = 239 }, [1] = { [0] = 51, [1] = 24, [2] = 166, [3] = 241 }, [2] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 } })[R[83]][R[52]], ({ [0] = { [0] = 28, [1] = 59, [2] = 114, [3] = 99 }, [1] = { [0] = 30, [1] = 61, [2] = 116, [3] = 101 }, [2] = { [0] = 22, [1] = 53, [2] = 108, [3] = 93 } })[R[83]][R[52]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[84] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 40, [1] = 13, [2] = 165, [3] = 234 }, [1] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [2] = { [0] = 58, [1] = 31, [2] = 183, [3] = 252 } })[R[84]][R[52]], ({ [0] = { [0] = 5, [1] = 44, [2] = 107, [3] = 87 }, [1] = { [0] = 21, [1] = 60, [2] = 123, [3] = 103 }, [2] = { [0] = 14, [1] = 53, [2] = 116, [3] = 96 } })[R[84]][R[52]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 3 then
      game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 178, [3] = 247 })[R[52]], ({ [0] = 19, [1] = 58, [2] = 111, [3] = 98 })[R[52]] })
      game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 178, [3] = 248 })[R[52]], ({ [0] = 19, [1] = 58, [2] = 112, [3] = 98 })[R[52]] })
      game.create_tube({ ({ [0] = 55, [1] = 28, [2] = 178, [3] = 249 })[R[52]], ({ [0] = 19, [1] = 58, [2] = 118, [3] = 98 })[R[52]] })
      game.create_tube({ ({ [0] = 56, [1] = 29, [2] = 178, [3] = 250 })[R[52]], ({ [0] = 15, [1] = 54, [2] = 126, [3] = 94 })[R[52]] })
      game.create_tube({ ({ [0] = 56, [1] = 29, [2] = 179, [3] = 250 })[R[52]], ({ [0] = 19, [1] = 58, [2] = 112, [3] = 98 })[R[52]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 179, [3] = 251 })[R[52]], ({ [0] = 15, [1] = 54, [2] = 118, [3] = 94 })[R[52]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 179, [3] = 251 })[R[52]], ({ [0] = 16, [1] = 55, [2] = 126, [3] = 95 })[R[52]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[52]], ({ [0] = 17, [1] = 56, [2] = 112, [3] = 96 })[R[52]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[52]], ({ [0] = 18, [1] = 57, [2] = 118, [3] = 97 })[R[52]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[52]], ({ [0] = 19, [1] = 58, [2] = 126, [3] = 98 })[R[52]] })
      game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 181, [3] = 252 })[R[52]], ({ [0] = 19, [1] = 58, [2] = 117, [3] = 98 })[R[52]] })
      game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 181, [3] = 252 })[R[52]], ({ [0] = 20, [1] = 59, [2] = 118, [3] = 99 })[R[52]] })
      if R[52] == 0 then
        if game.initial_units() == 0 then
          game.create_tube({ 58, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 58, 21 })
          for i = 1, game.initial_units() do
            R[85] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 51, [1] = 52, [2] = 39 })[R[85]], ({ [0] = 15, [1] = 22, [2] = 19 })[R[85]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[52] == 1 then
        if game.initial_units() == 0 then
          game.create_tube({ 31, 60 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 31, 60 })
          for i = 1, game.initial_units() do
            R[86] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 24, [1] = 25, [2] = 12 })[R[86]], ({ [0] = 54, [1] = 61, [2] = 58 })[R[86]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[52] == 2 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
          for i = 1, game.initial_units() do
            R[87] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 176, [1] = 167, [2] = 175 })[R[87]], ({ [0] = 109, [1] = 117, [2] = 112 })[R[87]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[52] == 3 then
        if game.initial_units() == 0 then
          game.create_tube({ 252, 100 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 252, 100 })
          for i = 1, game.initial_units() do
            R[88] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 245, [1] = 246, [2] = 233 })[R[88]], ({ [0] = 94, [1] = 101, [2] = 98 })[R[88]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[52]", R[52])
      end
    elseif R[81] == 4 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[52]], ({ [0] = 9, [1] = 47, [2] = 111, [3] = 89 })[R[52]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[52]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[52]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[52]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[52]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[52]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[52]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[52]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[52]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[52]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[52]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[52]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[52]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 17, [1] = 55, [2] = 119, [3] = 97 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 18, [1] = 56, [2] = 120, [3] = 98 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[52]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[52]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[52]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[52]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 13, [1] = 51, [2] = 115, [3] = 93 })[R[52]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 14, [1] = 52, [2] = 116, [3] = 94 })[R[52]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[52]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[52]] })
        for i = 1, game.initial_units() do
          R[89] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [1] = { [0] = 36, [1] = 13, [2] = 167, [3] = 232 }, [2] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 } })[R[89]][R[52]], ({ [0] = { [0] = 7, [1] = 45, [2] = 109, [3] = 87 }, [1] = { [0] = 15, [1] = 53, [2] = 117, [3] = 95 }, [2] = { [0] = 10, [1] = 48, [2] = 112, [3] = 90 } })[R[89]][R[52]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[52]], ({ [0] = 9, [1] = 47, [2] = 111, [3] = 89 })[R[52]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[52]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[52]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[52]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[52]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[52]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[52]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[52]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[52]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[52]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[52]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[52]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[52]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 17, [1] = 55, [2] = 119, [3] = 97 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 18, [1] = 56, [2] = 120, [3] = 98 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[52]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[52]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[52]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[52]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 13, [1] = 51, [2] = 115, [3] = 93 })[R[52]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 14, [1] = 52, [2] = 116, [3] = 94 })[R[52]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[52]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[52]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[52]], ({ [0] = 20, [1] = 62, [2] = 121, [3] = 98 })[R[52]] })
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[52]], ({ [0] = 21, [1] = 63, [2] = 122, [3] = 99 })[R[52]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[52]], ({ [0] = 20, [1] = 62, [2] = 121, [3] = 98 })[R[52]] })
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[52]], ({ [0] = 21, [1] = 63, [2] = 122, [3] = 99 })[R[52]] })
        for i = 1, game.initial_units() do
          R[90] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [1] = { [0] = 33, [1] = 7, [2] = 163, [3] = 218 }, [2] = { [0] = 55, [1] = 29, [2] = 185, [3] = 240 } })[R[90]][R[52]], ({ [0] = { [0] = 27, [1] = 69, [2] = 128, [3] = 105 }, [1] = { [0] = 14, [1] = 56, [2] = 115, [3] = 92 }, [2] = { [0] = 27, [1] = 69, [2] = 128, [3] = 105 } })[R[90]][R[52]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 52, [1] = 25, [2] = 184, [3] = 246 })[R[52]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[52]] })
        game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 185, [3] = 247 })[R[52]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[52]] })
        game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 186, [3] = 248 })[R[52]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[52]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 52, [1] = 25, [2] = 184, [3] = 246 })[R[52]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[52]] })
        game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 185, [3] = 247 })[R[52]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[52]] })
        game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 186, [3] = 248 })[R[52]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[52]] })
        for i = 1, game.initial_units() do
          R[91] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 33, [1] = 6, [2] = 165, [3] = 227 }, [1] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [2] = { [0] = 59, [1] = 32, [2] = 191, [3] = 253 } })[R[91]][R[52]], ({ [0] = { [0] = 3, [1] = 45, [2] = 109, [3] = 87 }, [1] = { [0] = 1, [1] = 43, [2] = 107, [3] = 85 }, [2] = { [0] = 16, [1] = 58, [2] = 122, [3] = 100 } })[R[91]][R[52]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 7 then
      game.create_tube({ ({ [0] = 48, [1] = 19, [2] = 184, [3] = 239 })[R[52]], ({ [0] = 16, [1] = 55, [2] = 119, [3] = 90 })[R[52]] })
      game.create_tube({ ({ [0] = 48, [1] = 19, [2] = 185, [3] = 239 })[R[52]], ({ [0] = 17, [1] = 56, [2] = 119, [3] = 91 })[R[52]] })
      if R[52] == 0 then
        if game.initial_units() == 0 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
          for i = 1, game.initial_units() do
            R[92] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 46, [1] = 52, [2] = 40 })[R[92]], ({ [0] = 9, [1] = 9, [2] = 30 })[R[92]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[52] == 1 then
        if game.initial_units() == 0 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
          for i = 1, game.initial_units() do
            R[93] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 17, [1] = 23, [2] = 11 })[R[93]], ({ [0] = 48, [1] = 48, [2] = 69 })[R[93]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[52] == 2 then
        if game.initial_units() == 0 then
          game.create_tube({ 186, 119 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 186, 119 })
          for i = 1, game.initial_units() do
            R[94] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 165, [1] = 170, [2] = 191 })[R[94]], ({ [0] = 109, [1] = 107, [2] = 122 })[R[94]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[52] == 3 then
        if game.initial_units() == 0 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
          for i = 1, game.initial_units() do
            R[95] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 237, [1] = 243, [2] = 231 })[R[95]], ({ [0] = 83, [1] = 83, [2] = 104 })[R[95]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[52]", R[52])
      end
    else
      unseen("R[81]", R[81])
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 193, 89 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 190, 124 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 71, 34 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 45, 57 } }
    R[0] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[0]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[0]] } }
    R[1] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[1]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[1]] } }
    R[2] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[2]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[2]] } }
    R[3] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[3]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 69 })[R[3]] } }
    R[4] = draw_avoid(8, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[4]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[4]] } }
    R[5] = draw_avoid(8, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[5]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[5]] } }
    R[6] = draw_avoid(8, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[6]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[6]] } }
    R[7] = draw_avoid(8, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[7]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 69 })[R[7]] } }
    R[8] = draw_avoid(8, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[8]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[8]] } }
    R[9] = draw_avoid(8, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[9]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[9]] } }
    R[10] = draw_avoid(8, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[10]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[10]] } }
    R[11] = draw_avoid(8, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[11]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 69 })[R[11]] } }
    R[12] = draw_avoid(8, { R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[12]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[12]] } }
    R[13] = draw_avoid(8, { R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[13]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[13]] } }
    R[14] = draw_avoid(8, { R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[14]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[14]] } }
    R[15] = draw_avoid(8, { R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[15]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 69 })[R[15]] } }
    R[16] = draw_avoid(8, { R[12], R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[16]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[16]] } }
    R[17] = draw_avoid(8, { R[13], R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[17]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[17]] } }
    R[18] = draw_avoid(8, { R[14], R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[18]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[18]] } }
    R[19] = draw_avoid(8, { R[15], R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[19]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 69 })[R[19]] } }
    pick(4, 4, { 20, 51, 52, 96 })
    R[21] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 50, [1] = 23, [2] = 172, [3] = 244 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 48, [1] = 19, [2] = 170, [3] = 239 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 6, [1] = 45, [2] = 108, [3] = 88 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 20, [1] = 59, [2] = 111, [3] = 94 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 50, [1] = 23, [2] = 172, [3] = 244 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 48, [1] = 19, [2] = 170, [3] = 239 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 6, [1] = 45, [2] = 108, [3] = 88 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 20, [1] = 59, [2] = 111, [3] = 94 } })[R[21]][R[20]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 39, [1] = 12, [2] = 164, [3] = 233 }, [3] = { [0] = 58, [1] = 31, [2] = 172, [3] = 252 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 41, [1] = 12, [2] = 179, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 11, [1] = 42, [2] = 97, [3] = 82 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 23, [1] = 62, [2] = 126, [3] = 102 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    if R[21] == 0 or R[21] == 1 or R[21] == 2 or R[21] == 5 or R[21] == 6 or R[21] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 62, [1] = 42, [2] = 187, [3] = 253 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 42, [1] = 15, [2] = 167, [3] = 236 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 48, [1] = 21, [2] = 180, [3] = 242 }, [7] = { [0] = 41, [1] = 12, [2] = 180, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 18, [1] = 49, [2] = 104, [3] = 89 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [5] = { [0] = 23, [1] = 65, [2] = 124, [3] = 101 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[21] == 0 then
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
      elseif R[21] == 1 then
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
      elseif R[21] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[20]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[20]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[20]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[20]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[20]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[20]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[21]", R[21])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 39, [1] = 19, [2] = 164, [3] = 230 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 39, [1] = 12, [2] = 171, [3] = 233 }, [7] = { [0] = 57, [1] = 28, [2] = 171, [3] = 248 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 28, [1] = 59, [2] = 114, [3] = 99 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 25, [1] = 64, [2] = 119, [3] = 99 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[21] == 2 or R[21] == 5 or R[21] == 6 or R[21] == 7 then
      elseif R[21] == 0 or R[21] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 } })[R[21]][R[20]], ({ [0] = { [0] = 27, [1] = 65, [2] = 120, [3] = 103 }, [1] = { [0] = 36, [1] = 67, [2] = 122, [3] = 107 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[21]", R[21])
      end
    elseif R[21] == 3 or R[21] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 } })[R[21]][R[20]], ({ [3] = { [0] = 23, [1] = 62, [2] = 110, [3] = 102 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[21] == 3 then
        if R[20] == 0 then
          if LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 45, 12 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 45, 12 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 45, 12 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[20] == 1 then
          if LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 18, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 18, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 18, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[20] == 2 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 183, 122 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 183, 122 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 183, 122 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[20] == 3 then
          if LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 239, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 239, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 239, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[20]", R[20])
        end
      elseif R[21] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 122, [3] = 100 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 122, [3] = 100 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 122, [3] = 100 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[21]", R[21])
      end
    else
      unseen("R[21]", R[21])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 39, [1] = 19, [2] = 164, [3] = 230 }, [1] = { [0] = 48, [1] = 21, [2] = 163, [3] = 238 }, [2] = { [0] = 59, [1] = 32, [2] = 184, [3] = 253 }, [3] = { [0] = 51, [1] = 24, [2] = 164, [3] = 245 }, [4] = { [0] = 33, [1] = 10, [2] = 164, [3] = 229 }, [5] = { [0] = 34, [1] = 8, [2] = 164, [3] = 219 }, [6] = { [0] = 31, [1] = 4, [2] = 163, [3] = 225 }, [7] = { [0] = 49, [1] = 20, [2] = 163, [3] = 240 } })[R[21]][R[20]], ({ [0] = { [0] = 29, [1] = 67, [2] = 122, [3] = 105 }, [1] = { [0] = 33, [1] = 64, [2] = 119, [3] = 104 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 6, [1] = 45, [2] = 114, [3] = 85 }, [4] = { [0] = 12, [1] = 50, [2] = 114, [3] = 92 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 29, [1] = 68, [2] = 119, [3] = 103 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 46, [1] = 26, [2] = 171, [3] = 237 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 40, [1] = 13, [2] = 182, [3] = 234 }, [4] = { [0] = 51, [1] = 28, [2] = 182, [3] = 247 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 59, [1] = 30, [2] = 170, [3] = 250 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 15, [1] = 54, [2] = 117, [3] = 97 }, [3] = { [0] = 13, [1] = 52, [2] = 118, [3] = 92 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 9, [1] = 51, [2] = 110, [3] = 87 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 20, [1] = 59, [2] = 124, [3] = 94 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 43, [1] = 16, [2] = 184, [3] = 237 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 17, [1] = 48, [2] = 103, [3] = 88 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 9, [1] = 48, [2] = 118, [3] = 88 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[21] == 0 then
    elseif R[21] == 1 then
    elseif R[21] == 2 then
    elseif R[21] == 3 then
      if R[20] == 2 then
      elseif R[20] == 0 or R[20] == 1 or R[20] == 3 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 60, [1] = 33, [3] = 254 })[R[20]], ({ [0] = 13, [1] = 52, [3] = 92 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 58, [1] = 31, [3] = 252 })[R[20]], ({ [0] = 9, [1] = 48, [3] = 88 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[20]", R[20])
      end
    elseif R[21] == 4 then
    elseif R[21] == 5 then
    elseif R[21] == 6 then
    elseif R[21] == 7 then
    else
      unseen("R[21]", R[21])
    end
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 46, [1] = 19, [2] = 176, [3] = 240 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 24, [1] = 63, [2] = 126, [3] = 103 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 46, [1] = 19, [2] = 176, [3] = 240 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 24, [1] = 63, [2] = 126, [3] = 103 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[20] == 0 then
      if R[21] == 0 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 44, 16 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 44, 16 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 55, 22 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 41, 16 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 41, 13 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 44, 16 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 55, 22 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 41, 16 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 41, 13 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 41, 16 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 41, 13 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 1 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 47, 19 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 50, 19 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 47, 19 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 50, 13 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 53, 10 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 47, 19 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 50, 19 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 50, 13 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 53, 10 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 50, 13 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 53, 10 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 55, 13 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 55, 13 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 37, 16 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 55, 19 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 51, 20 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 55, 13 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 37, 16 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 55, 19 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 51, 20 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 55, 19 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 51, 20 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 3 then
        if LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 40, 13 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 46, 24 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 40, 13 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 40, 13 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 46, 24 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 53, 16 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 53, 16 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 45, 24 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 46, 20 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 48, 11 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 53, 16 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 45, 24 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 46, 20 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 48, 11 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 46, 20 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 48, 11 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 52, 11 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 52, 11 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 40, 19 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 39, 8 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 48, 16 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 52, 11 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 40, 19 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 39, 8 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 48, 16 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 39, 8 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 48, 16 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 36, 18 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 36, 18 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 51, 5 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 43, 15 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 52, 12 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 36, 18 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 51, 5 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 43, 15 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 52, 12 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 43, 15 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 52, 12 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 59, 22 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 59, 22 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 58, 14 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 43, 20 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 38, 17 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 59, 22 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 58, 14 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 43, 20 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 38, 17 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 43, 20 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 38, 17 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[21]", R[21])
      end
    elseif R[20] == 1 then
      if R[21] == 0 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 24, 54 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 24, 54 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 35, 60 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 21, 54 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 21, 51 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 24, 54 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 35, 60 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 21, 54 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 21, 51 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 21, 54 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 21, 51 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 1 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 20, 50 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 23, 50 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 20, 50 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 23, 44 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 26, 41 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 20, 50 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 23, 50 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 23, 44 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 26, 41 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 23, 44 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 26, 41 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 28, 52 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 28, 52 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 10, 55 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 28, 58 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 24, 59 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 28, 52 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 10, 55 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 28, 58 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 24, 59 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 28, 58 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 24, 59 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 3 then
        if LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 13, 52 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 19, 63 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 13, 52 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 13, 52 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 19, 63 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 30, 54 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 30, 54 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 22, 62 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 23, 58 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 25, 49 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 30, 54 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 22, 62 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 23, 58 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 25, 49 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 23, 58 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 25, 49 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 26, 53 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 26, 53 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 14, 61 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 13, 50 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 22, 58 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 26, 53 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 14, 61 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 13, 50 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 22, 58 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 13, 50 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 22, 58 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 9, 60 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 9, 60 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 16, 57 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 25, 54 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 9, 60 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 16, 57 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 25, 54 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 16, 57 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 25, 54 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 30, 61 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 30, 61 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 14, 59 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 9, 56 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 30, 61 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 14, 59 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 9, 56 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 14, 59 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 9, 56 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[21]", R[21])
      end
    elseif R[20] == 2 then
      if R[21] == 0 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 169, 109 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 169, 109 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 180, 115 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 166, 109 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 166, 106 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 169, 109 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 180, 115 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 166, 109 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 166, 106 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 166, 109 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 166, 106 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 1 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 162, 105 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 165, 105 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 162, 105 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 165, 99 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 168, 96 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 162, 105 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 165, 105 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 165, 99 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 168, 96 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 165, 99 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 168, 96 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 180, 115 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 180, 115 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 162, 118 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 180, 121 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 176, 122 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 180, 115 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 162, 118 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 180, 121 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 176, 122 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 180, 121 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 176, 122 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 3 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 184, 118 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 184, 118 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 176, 126 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 177, 122 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 179, 113 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 184, 118 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 176, 126 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 177, 122 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 179, 113 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 177, 122 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 179, 113 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 184, 118 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 184, 118 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 176, 126 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 177, 122 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 179, 113 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 184, 118 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 176, 126 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 177, 122 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 179, 113 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 177, 122 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 179, 113 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 182, 112 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 182, 112 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 170, 120 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 169, 109 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 178, 117 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 182, 112 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 170, 120 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 169, 109 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 178, 117 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 169, 109 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 178, 117 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 168, 124 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 168, 124 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 183, 111 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 175, 121 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 184, 118 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 168, 124 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 183, 111 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 175, 121 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 184, 118 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 175, 121 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 184, 118 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 168, 124 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 168, 124 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 183, 111 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 175, 121 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 184, 118 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 168, 124 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 183, 111 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 175, 121 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 184, 118 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 175, 121 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 184, 118 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[21]", R[21])
      end
    elseif R[20] == 3 then
      if R[21] == 0 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 235, 92 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 235, 92 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 246, 98 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 232, 92 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 232, 89 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 235, 92 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 246, 98 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 232, 92 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 232, 89 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 232, 92 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 232, 89 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 1 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 237, 90 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 240, 90 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 237, 90 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 240, 84 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 243, 81 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 237, 90 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 240, 90 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 240, 84 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 243, 81 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 240, 84 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 243, 81 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 249, 95 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 249, 95 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 231, 98 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 249, 101 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 245, 102 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 249, 95 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 231, 98 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 249, 101 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 245, 102 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 249, 101 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 245, 102 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 3 then
        if LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 240, 103 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 240, 103 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 249, 96 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 249, 96 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 241, 104 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 242, 100 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 244, 91 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 249, 96 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 241, 104 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 242, 100 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 244, 91 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 242, 100 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 244, 91 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 237, 89 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 237, 89 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 225, 97 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 224, 86 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 233, 94 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 237, 89 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 225, 97 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 224, 86 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 233, 94 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 224, 86 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 233, 94 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 230, 102 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 230, 102 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 245, 89 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 237, 99 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 246, 96 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 230, 102 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 245, 89 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 237, 99 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 246, 96 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 237, 99 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 246, 96 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[21] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 250, 96 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 250, 96 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 249, 88 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 234, 94 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 229, 91 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 250, 96 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 249, 88 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 234, 94 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 229, 91 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 234, 94 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 229, 91 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[21]", R[21])
      end
    else
      unseen("R[20]", R[20])
    end
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 62, [1] = 42, [2] = 187, [3] = 253 }, [1] = { [0] = 56, [1] = 29, [2] = 171, [3] = 246 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 50, [1] = 23, [2] = 185, [3] = 244 }, [4] = { [0] = 54, [1] = 31, [2] = 185, [3] = 250 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 52, [1] = 23, [2] = 184, [3] = 243 } })[R[21]][R[20]], ({ [0] = { [0] = 24, [1] = 62, [2] = 117, [3] = 100 }, [1] = { [0] = 23, [1] = 54, [2] = 109, [3] = 94 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 10, [1] = 49, [2] = 109, [3] = 89 }, [4] = { [0] = 7, [1] = 45, [2] = 109, [3] = 87 }, [5] = { [0] = 25, [1] = 67, [2] = 126, [3] = 103 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 19, [1] = 58, [2] = 121, [3] = 93 } })[R[21]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 22, [2] = 167, [3] = 233 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 42, [1] = 15, [2] = 167, [3] = 236 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 19, [1] = 58, [2] = 112, [3] = 98 }, [4] = { [0] = 10, [1] = 48, [2] = 112, [3] = 90 }, [5] = { [0] = 14, [1] = 56, [2] = 115, [3] = 92 }, [6] = { [0] = 7, [1] = 49, [2] = 113, [3] = 91 }, [7] = { [0] = 16, [1] = 55, [2] = 113, [3] = 90 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 43, [1] = 23, [2] = 168, [3] = 234 }, [1] = { [0] = 51, [1] = 24, [2] = 166, [3] = 241 }, [2] = { [0] = 43, [1] = 16, [2] = 168, [3] = 237 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 20, [1] = 59, [2] = 113, [3] = 99 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 15, [1] = 57, [2] = 116, [3] = 93 }, [6] = { [0] = 8, [1] = 50, [2] = 114, [3] = 92 }, [7] = { [0] = 17, [1] = 56, [2] = 114, [3] = 91 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 52, [1] = 25, [2] = 167, [3] = 242 }, [2] = { [0] = 44, [1] = 17, [2] = 169, [3] = 238 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 21, [1] = 60, [2] = 114, [3] = 100 }, [4] = { [0] = 12, [1] = 50, [2] = 114, [3] = 92 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 9, [1] = 51, [2] = 115, [3] = 93 }, [7] = { [0] = 18, [1] = 57, [2] = 115, [3] = 92 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 25, [2] = 170, [3] = 236 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 43, [1] = 16, [2] = 172, [3] = 237 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 8, [1] = 47, [2] = 110, [3] = 90 }, [3] = { [0] = 19, [1] = 58, [2] = 115, [3] = 98 }, [4] = { [0] = 13, [1] = 51, [2] = 115, [3] = 93 }, [5] = { [0] = 20, [1] = 62, [2] = 121, [3] = 98 }, [6] = { [0] = 10, [1] = 52, [2] = 116, [3] = 94 }, [7] = { [0] = 19, [1] = 58, [2] = 116, [3] = 93 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 26, [2] = 171, [3] = 237 }, [1] = { [0] = 54, [1] = 27, [2] = 169, [3] = 244 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 9, [1] = 48, [2] = 111, [3] = 91 }, [3] = { [0] = 15, [1] = 54, [2] = 116, [3] = 94 }, [4] = { [0] = 14, [1] = 52, [2] = 116, [3] = 94 }, [5] = { [0] = 21, [1] = 63, [2] = 122, [3] = 99 }, [6] = { [0] = 11, [1] = 53, [2] = 117, [3] = 95 }, [7] = { [0] = 20, [1] = 59, [2] = 117, [3] = 94 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 27, [2] = 172, [3] = 238 }, [1] = { [0] = 55, [1] = 28, [2] = 170, [3] = 245 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 41, [1] = 14, [2] = 173, [3] = 235 }, [7] = { [0] = 41, [1] = 12, [2] = 173, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 10, [1] = 49, [2] = 112, [3] = 92 }, [3] = { [0] = 16, [1] = 55, [2] = 120, [3] = 95 }, [4] = { [0] = 18, [1] = 56, [2] = 120, [3] = 98 }, [5] = { [0] = 22, [1] = 64, [2] = 123, [3] = 100 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 21, [1] = 60, [2] = 111, [3] = 95 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 28, [2] = 173, [3] = 239 }, [1] = { [0] = 56, [1] = 29, [2] = 171, [3] = 246 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 47, [1] = 21, [2] = 177, [3] = 232 }, [6] = { [0] = 42, [1] = 15, [2] = 174, [3] = 236 }, [7] = { [0] = 41, [1] = 12, [2] = 174, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 17, [1] = 56, [2] = 121, [3] = 96 }, [4] = { [0] = 19, [1] = 57, [2] = 121, [3] = 99 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 22, [1] = 61, [2] = 111, [3] = 96 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 47, [1] = 21, [2] = 177, [3] = 232 }, [6] = { [0] = 42, [1] = 15, [2] = 174, [3] = 236 }, [7] = { [0] = 41, [1] = 12, [2] = 174, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 15, [1] = 53, [2] = 108, [3] = 91 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 12, [1] = 51, [2] = 114, [3] = 94 }, [3] = { [0] = 18, [1] = 57, [2] = 122, [3] = 97 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 23, [1] = 62, [2] = 119, [3] = 97 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 41, [1] = 12, [2] = 175, [3] = 232 } })[R[21]][R[20]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 14, [1] = 45, [2] = 100, [3] = 85 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 19, [1] = 58, [2] = 123, [3] = 98 }, [4] = { [0] = 21, [1] = 59, [2] = 123, [3] = 101 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 24, [1] = 63, [2] = 111, [3] = 98 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 45, [1] = 18, [2] = 172, [3] = 239 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 44, [1] = 15, [2] = 175, [3] = 235 } })[R[21]][R[20]], ({ [0] = { [0] = 17, [1] = 55, [2] = 110, [3] = 93 }, [1] = { [0] = 15, [1] = 46, [2] = 101, [3] = 86 }, [2] = { [0] = 14, [1] = 53, [2] = 116, [3] = 96 }, [3] = { [0] = 15, [1] = 54, [2] = 124, [3] = 94 }, [4] = { [0] = 22, [1] = 60, [2] = 124, [3] = 102 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 45, [1] = 18, [2] = 175, [3] = 239 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 49, [1] = 23, [2] = 179, [3] = 234 }, [6] = { [0] = 44, [1] = 17, [2] = 176, [3] = 238 }, [7] = { [0] = 44, [1] = 15, [2] = 176, [3] = 235 } })[R[21]][R[20]], ({ [0] = { [0] = 18, [1] = 56, [2] = 111, [3] = 94 }, [1] = { [0] = 16, [1] = 47, [2] = 102, [3] = 87 }, [2] = { [0] = 15, [1] = 54, [2] = 117, [3] = 97 }, [3] = { [0] = 19, [1] = 58, [2] = 110, [3] = 98 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 46, [1] = 19, [2] = 175, [3] = 240 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 49, [1] = 23, [2] = 179, [3] = 234 }, [6] = { [0] = 44, [1] = 17, [2] = 176, [3] = 238 }, [7] = { [0] = 45, [1] = 16, [2] = 176, [3] = 236 } })[R[21]][R[20]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 47, [1] = 20, [2] = 175, [3] = 241 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [6] = { [0] = 45, [1] = 18, [2] = 177, [3] = 239 }, [7] = { [0] = 45, [1] = 16, [2] = 177, [3] = 236 } })[R[21]][R[20]], ({ [0] = { [0] = 23, [1] = 61, [2] = 116, [3] = 99 }, [1] = { [0] = 21, [1] = 52, [2] = 107, [3] = 92 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 19, [1] = 58, [2] = 126, [3] = 98 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 46, [1] = 19, [2] = 171, [3] = 240 }, [3] = { [0] = 48, [1] = 21, [2] = 176, [3] = 242 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [6] = { [0] = 45, [1] = 18, [2] = 177, [3] = 239 }, [7] = { [0] = 46, [1] = 17, [2] = 177, [3] = 237 } })[R[21]][R[20]], ({ [0] = { [0] = 24, [1] = 62, [2] = 117, [3] = 100 }, [1] = { [0] = 22, [1] = 53, [2] = 108, [3] = 93 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 110, [3] = 91 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 46, [1] = 19, [2] = 171, [3] = 240 }, [3] = { [0] = 48, [1] = 21, [2] = 176, [3] = 242 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 51, [1] = 25, [2] = 181, [3] = 236 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 46, [1] = 17, [2] = 179, [3] = 237 } })[R[21]][R[20]], ({ [0] = { [0] = 25, [1] = 63, [2] = 118, [3] = 101 }, [1] = { [0] = 23, [1] = 54, [2] = 109, [3] = 94 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 7, [1] = 49, [2] = 113, [3] = 91 }, [7] = { [0] = 26, [1] = 65, [2] = 113, [3] = 100 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 53, [1] = 33, [2] = 178, [3] = 244 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 49, [1] = 22, [2] = 176, [3] = 243 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 51, [1] = 25, [2] = 181, [3] = 236 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 47, [1] = 18, [2] = 179, [3] = 238 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 126, [3] = 91 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 8, [1] = 50, [2] = 114, [3] = 92 }, [7] = { [0] = 13, [1] = 52, [2] = 114, [3] = 87 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 54, [1] = 34, [2] = 179, [3] = 245 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 50, [1] = 23, [2] = 177, [3] = 244 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 47, [1] = 18, [2] = 179, [3] = 238 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 25, [1] = 56, [2] = 111, [3] = 96 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 12, [1] = 51, [2] = 110, [3] = 91 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 9, [1] = 51, [2] = 115, [3] = 93 }, [7] = { [0] = 26, [1] = 65, [2] = 115, [3] = 100 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 48, [1] = 21, [2] = 173, [3] = 242 }, [3] = { [0] = 51, [1] = 24, [2] = 177, [3] = 245 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 53, [1] = 27, [2] = 183, [3] = 238 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 48, [1] = 19, [2] = 179, [3] = 239 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 26, [1] = 57, [2] = 112, [3] = 97 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 111, [3] = 91 }, [4] = { [0] = 9, [1] = 47, [2] = 111, [3] = 89 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 10, [1] = 52, [2] = 116, [3] = 94 }, [7] = { [0] = 13, [1] = 52, [2] = 116, [3] = 87 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 56, [1] = 36, [2] = 181, [3] = 247 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 48, [1] = 21, [2] = 173, [3] = 242 }, [3] = { [0] = 52, [1] = 25, [2] = 177, [3] = 246 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 48, [1] = 19, [2] = 179, [3] = 239 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 31, [1] = 62, [2] = 117, [3] = 102 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 12, [1] = 51, [2] = 118, [3] = 91 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 11, [1] = 53, [2] = 117, [3] = 95 }, [7] = { [0] = 14, [1] = 53, [2] = 117, [3] = 88 } })[R[21]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 57, [1] = 37, [2] = 182, [3] = 248 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 49, [1] = 22, [2] = 174, [3] = 243 }, [3] = { [0] = 53, [1] = 26, [2] = 177, [3] = 247 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 48, [1] = 19, [2] = 183, [3] = 239 } })[R[21]][R[20]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 32, [1] = 63, [2] = 118, [3] = 103 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 126, [3] = 91 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 15, [1] = 54, [2] = 119, [3] = 89 } })[R[21]][R[20]] })
    if R[21] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 58, [1] = 38, [2] = 183, [3] = 249 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 59, [1] = 39, [2] = 184, [3] = 250 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 58, [1] = 38, [2] = 183, [3] = 249 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 59, [1] = 39, [2] = 184, [3] = 250 })[R[20]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[20]] })
        for i = 1, game.initial_units() do
          R[97] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 56, [1] = 36, [2] = 181, [3] = 247 }, [1] = { [0] = 43, [1] = 23, [2] = 168, [3] = 234 }, [2] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 } })[R[97]][R[20]], ({ [0] = { [0] = 14, [1] = 52, [2] = 107, [3] = 90 }, [1] = { [0] = 23, [1] = 61, [2] = 116, [3] = 99 }, [2] = { [0] = 26, [1] = 64, [2] = 119, [3] = 102 } })[R[97]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 34, [1] = 65, [2] = 120, [3] = 105 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[20]], ({ [0] = 34, [1] = 65, [2] = 120, [3] = 105 })[R[20]] })
        for i = 1, game.initial_units() do
          R[98] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 49, [1] = 22, [2] = 164, [3] = 239 }, [1] = { [0] = 51, [1] = 24, [2] = 166, [3] = 241 }, [2] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 } })[R[98]][R[20]], ({ [0] = { [0] = 28, [1] = 59, [2] = 114, [3] = 99 }, [1] = { [0] = 30, [1] = 61, [2] = 116, [3] = 101 }, [2] = { [0] = 22, [1] = 53, [2] = 108, [3] = 93 } })[R[98]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[99] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 40, [1] = 13, [2] = 165, [3] = 234 }, [1] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [2] = { [0] = 58, [1] = 31, [2] = 183, [3] = 252 } })[R[99]][R[20]], ({ [0] = { [0] = 5, [1] = 44, [2] = 107, [3] = 87 }, [1] = { [0] = 21, [1] = 60, [2] = 123, [3] = 103 }, [2] = { [0] = 14, [1] = 53, [2] = 116, [3] = 96 } })[R[99]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 3 then
      game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 178, [3] = 247 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 111, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 178, [3] = 248 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 112, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 55, [1] = 28, [2] = 178, [3] = 249 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 118, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 56, [1] = 29, [2] = 178, [3] = 250 })[R[20]], ({ [0] = 15, [1] = 54, [2] = 126, [3] = 94 })[R[20]] })
      game.create_tube({ ({ [0] = 56, [1] = 29, [2] = 179, [3] = 250 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 112, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 179, [3] = 251 })[R[20]], ({ [0] = 15, [1] = 54, [2] = 118, [3] = 94 })[R[20]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 179, [3] = 251 })[R[20]], ({ [0] = 16, [1] = 55, [2] = 126, [3] = 95 })[R[20]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[20]], ({ [0] = 17, [1] = 56, [2] = 112, [3] = 96 })[R[20]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[20]], ({ [0] = 18, [1] = 57, [2] = 118, [3] = 97 })[R[20]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 126, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 181, [3] = 252 })[R[20]], ({ [0] = 19, [1] = 58, [2] = 117, [3] = 98 })[R[20]] })
      game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 181, [3] = 252 })[R[20]], ({ [0] = 20, [1] = 59, [2] = 118, [3] = 99 })[R[20]] })
      if R[20] == 0 then
        if game.initial_units() == 0 then
          game.create_tube({ 58, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 58, 21 })
          for i = 1, game.initial_units() do
            R[100] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 51, [1] = 52, [2] = 39 })[R[100]], ({ [0] = 15, [1] = 22, [2] = 19 })[R[100]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 1 then
        if game.initial_units() == 0 then
          game.create_tube({ 31, 60 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 31, 60 })
          for i = 1, game.initial_units() do
            R[101] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 24, [1] = 25, [2] = 12 })[R[101]], ({ [0] = 54, [1] = 61, [2] = 58 })[R[101]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 2 then
        if game.initial_units() == 0 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
          for i = 1, game.initial_units() do
            R[102] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 176, [1] = 167, [2] = 175 })[R[102]], ({ [0] = 109, [1] = 117, [2] = 112 })[R[102]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 3 then
        if game.initial_units() == 0 then
          game.create_tube({ 252, 100 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 252, 100 })
          for i = 1, game.initial_units() do
            R[103] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 245, [1] = 246, [2] = 233 })[R[103]], ({ [0] = 94, [1] = 101, [2] = 98 })[R[103]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[20]", R[20])
      end
    elseif R[21] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 9, [1] = 47, [2] = 111, [3] = 89 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 17, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 18, [1] = 56, [2] = 120, [3] = 98 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 13, [1] = 51, [2] = 115, [3] = 93 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 14, [1] = 52, [2] = 116, [3] = 94 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 9, [1] = 47, [2] = 111, [3] = 89 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 17, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 18, [1] = 56, [2] = 120, [3] = 98 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[20]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[20]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 13, [1] = 51, [2] = 115, [3] = 93 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 14, [1] = 52, [2] = 116, [3] = 94 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[20]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[20]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[20]] })
        for i = 1, game.initial_units() do
          R[104] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [1] = { [0] = 36, [1] = 13, [2] = 167, [3] = 232 }, [2] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 } })[R[104]][R[20]], ({ [0] = { [0] = 7, [1] = 45, [2] = 109, [3] = 87 }, [1] = { [0] = 15, [1] = 53, [2] = 117, [3] = 95 }, [2] = { [0] = 10, [1] = 48, [2] = 112, [3] = 90 } })[R[104]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 20, [1] = 62, [2] = 121, [3] = 98 })[R[20]] })
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 21, [1] = 63, [2] = 122, [3] = 99 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 20, [1] = 62, [2] = 121, [3] = 98 })[R[20]] })
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 21, [1] = 63, [2] = 122, [3] = 99 })[R[20]] })
        for i = 1, game.initial_units() do
          R[105] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [1] = { [0] = 33, [1] = 7, [2] = 163, [3] = 218 }, [2] = { [0] = 55, [1] = 29, [2] = 185, [3] = 240 } })[R[105]][R[20]], ({ [0] = { [0] = 27, [1] = 69, [2] = 128, [3] = 105 }, [1] = { [0] = 14, [1] = 56, [2] = 115, [3] = 92 }, [2] = { [0] = 27, [1] = 69, [2] = 128, [3] = 105 } })[R[105]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 52, [1] = 25, [2] = 184, [3] = 246 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 185, [3] = 247 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 186, [3] = 248 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 52, [1] = 25, [2] = 184, [3] = 246 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 185, [3] = 247 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 186, [3] = 248 })[R[20]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[20]] })
        for i = 1, game.initial_units() do
          R[106] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 33, [1] = 6, [2] = 165, [3] = 227 }, [1] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [2] = { [0] = 59, [1] = 32, [2] = 191, [3] = 253 } })[R[106]][R[20]], ({ [0] = { [0] = 3, [1] = 45, [2] = 109, [3] = 87 }, [1] = { [0] = 1, [1] = 43, [2] = 107, [3] = 85 }, [2] = { [0] = 16, [1] = 58, [2] = 122, [3] = 100 } })[R[106]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[21] == 7 then
      game.create_tube({ ({ [0] = 48, [1] = 19, [2] = 184, [3] = 239 })[R[20]], ({ [0] = 16, [1] = 55, [2] = 119, [3] = 90 })[R[20]] })
      game.create_tube({ ({ [0] = 48, [1] = 19, [2] = 185, [3] = 239 })[R[20]], ({ [0] = 17, [1] = 56, [2] = 119, [3] = 91 })[R[20]] })
      if R[20] == 0 then
        if game.initial_units() == 0 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
          for i = 1, game.initial_units() do
            R[107] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 46, [1] = 52, [2] = 40 })[R[107]], ({ [0] = 9, [1] = 9, [2] = 30 })[R[107]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 1 then
        if game.initial_units() == 0 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
          for i = 1, game.initial_units() do
            R[108] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 17, [1] = 23, [2] = 11 })[R[108]], ({ [0] = 48, [1] = 48, [2] = 69 })[R[108]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 2 then
        if game.initial_units() == 0 then
          game.create_tube({ 186, 119 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 186, 119 })
          for i = 1, game.initial_units() do
            R[109] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 165, [1] = 170, [2] = 191 })[R[109]], ({ [0] = 109, [1] = 107, [2] = 122 })[R[109]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[20] == 3 then
        if game.initial_units() == 0 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
          for i = 1, game.initial_units() do
            R[110] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 237, [1] = 243, [2] = 231 })[R[110]], ({ [0] = 83, [1] = 83, [2] = 104 })[R[110]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[20]", R[20])
      end
    else
      unseen("R[21]", R[21])
    end
    R[36] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 50, [1] = 47, [2] = 45, [3] = 50, [4] = 41, [5] = 44, [6] = 38, [7] = 48 }, [1] = { [0] = 30, [1] = 20, [2] = 18, [3] = 23, [4] = 18, [5] = 18, [6] = 11, [7] = 19 }, [2] = { [0] = 175, [1] = 162, [2] = 170, [3] = 172, [4] = 172, [5] = 174, [6] = 170, [7] = 170 }, [3] = { [0] = 241, [1] = 237, [2] = 239, [3] = 244, [4] = 237, [5] = 229, [6] = 232, [7] = 239 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 6, [3] = 19, [4] = 16, [5] = 18, [6] = 5, [7] = 20 }, [1] = { [0] = 58, [1] = 55, [2] = 45, [3] = 58, [4] = 54, [5] = 60, [6] = 47, [7] = 59 }, [2] = { [0] = 113, [1] = 110, [2] = 108, [3] = 118, [4] = 118, [5] = 119, [6] = 111, [7] = 111 }, [3] = { [0] = 96, [1] = 95, [2] = 88, [3] = 98, [4] = 96, [5] = 96, [6] = 89, [7] = 94 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 50, [1] = 47, [2] = 45, [3] = 50, [4] = 41, [5] = 44, [6] = 38, [7] = 48 }, [1] = { [0] = 30, [1] = 20, [2] = 18, [3] = 23, [4] = 18, [5] = 18, [6] = 11, [7] = 19 }, [2] = { [0] = 175, [1] = 162, [2] = 170, [3] = 172, [4] = 172, [5] = 174, [6] = 170, [7] = 170 }, [3] = { [0] = 241, [1] = 237, [2] = 239, [3] = 244, [4] = 237, [5] = 229, [6] = 232, [7] = 239 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 6, [3] = 19, [4] = 16, [5] = 18, [6] = 5, [7] = 20 }, [1] = { [0] = 58, [1] = 55, [2] = 45, [3] = 58, [4] = 54, [5] = 60, [6] = 47, [7] = 59 }, [2] = { [0] = 113, [1] = 110, [2] = 108, [3] = 118, [4] = 118, [5] = 119, [6] = 111, [7] = 111 }, [3] = { [0] = 96, [1] = 95, [2] = 88, [3] = 98, [4] = 96, [5] = 96, [6] = 89, [7] = 94 } })[R[51]][R[36]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 50, [1] = 57, [2] = 39, [3] = 58, [4] = 41, [5] = 44, [6] = 47, [7] = 41 }, [1] = { [0] = 30, [1] = 30, [2] = 12, [3] = 31, [4] = 18, [5] = 18, [6] = 20, [7] = 12 }, [2] = { [0] = 175, [1] = 172, [2] = 164, [3] = 172, [4] = 172, [5] = 174, [6] = 179, [7] = 179 }, [3] = { [0] = 241, [1] = 247, [2] = 233, [3] = 252, [4] = 237, [5] = 229, [6] = 241, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 13, [1] = 11, [2] = 11, [3] = 23, [4] = 24, [5] = 24, [6] = 5, [7] = 26 }, [1] = { [0] = 51, [1] = 42, [2] = 50, [3] = 62, [4] = 62, [5] = 66, [6] = 47, [7] = 65 }, [2] = { [0] = 106, [1] = 97, [2] = 113, [3] = 126, [4] = 126, [5] = 125, [6] = 111, [7] = 111 }, [3] = { [0] = 89, [1] = 82, [2] = 93, [3] = 102, [4] = 104, [5] = 102, [6] = 89, [7] = 100 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    if R[36] == 0 or R[36] == 1 or R[36] == 2 or R[36] == 5 or R[36] == 6 or R[36] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 62, [1] = 58, [2] = 42, [5] = 54, [6] = 48, [7] = 41 }, [1] = { [0] = 42, [1] = 31, [2] = 15, [5] = 28, [6] = 21, [7] = 12 }, [2] = { [0] = 187, [1] = 173, [2] = 167, [5] = 184, [6] = 180, [7] = 180 }, [3] = { [0] = 253, [1] = 248, [2] = 236, [5] = 239, [6] = 242, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 18, [2] = 17, [5] = 23, [6] = 13, [7] = 13 }, [1] = { [0] = 58, [1] = 49, [2] = 56, [5] = 65, [6] = 55, [7] = 52 }, [2] = { [0] = 113, [1] = 104, [2] = 119, [5] = 124, [6] = 119, [7] = 119 }, [3] = { [0] = 96, [1] = 89, [2] = 99, [5] = 101, [6] = 97, [7] = 87 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[36] == 0 then
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
      elseif R[36] == 1 then
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
      elseif R[36] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[51]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[51]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[51]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[36] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[51]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[51]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[51]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[36] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[36] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[51]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[51]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[51]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[36]", R[36])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 39, [1] = 58, [2] = 51, [5] = 44, [6] = 39, [7] = 57 }, [1] = { [0] = 19, [1] = 31, [2] = 24, [5] = 18, [6] = 12, [7] = 28 }, [2] = { [0] = 164, [1] = 173, [2] = 176, [5] = 174, [6] = 171, [7] = 171 }, [3] = { [0] = 230, [1] = 248, [2] = 245, [5] = 229, [6] = 233, [7] = 248 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 28, [2] = 17, [5] = 11, [6] = 13, [7] = 25 }, [1] = { [0] = 58, [1] = 59, [2] = 56, [5] = 53, [6] = 55, [7] = 64 }, [2] = { [0] = 113, [1] = 114, [2] = 119, [5] = 112, [6] = 119, [7] = 119 }, [3] = { [0] = 96, [1] = 99, [2] = 99, [5] = 89, [6] = 97, [7] = 99 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[36] == 2 or R[36] == 5 or R[36] == 6 or R[36] == 7 then
      elseif R[36] == 0 or R[36] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 50, [1] = 57 }, [1] = { [0] = 30, [1] = 30 }, [2] = { [0] = 175, [1] = 172 }, [3] = { [0] = 241, [1] = 247 } })[R[51]][R[36]], ({ [0] = { [0] = 27, [1] = 36 }, [1] = { [0] = 65, [1] = 67 }, [2] = { [0] = 120, [1] = 122 }, [3] = { [0] = 103, [1] = 107 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[36]", R[36])
      end
    elseif R[36] == 3 or R[36] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [3] = 42, [4] = 41 }, [1] = { [3] = 15, [4] = 18 }, [2] = { [3] = 172, [4] = 172 }, [3] = { [3] = 236, [4] = 237 } })[R[51]][R[36]], ({ [0] = { [3] = 23, [4] = 8 }, [1] = { [3] = 62, [4] = 46 }, [2] = { [3] = 110, [4] = 110 }, [3] = { [3] = 102, [4] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[36] == 3 then
        if R[51] == 0 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 45, 12 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 45, 12 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 45, 12 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[51] == 1 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 18, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 18, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 18, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[51] == 2 then
          if LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 183, 122 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 183, 122 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          elseif LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 183, 122 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[51] == 3 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 239, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 239, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 239, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[51]", R[51])
        end
      elseif R[36] == 4 then
        if LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 20, [1] = 58, [2] = 122, [3] = 100 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 20, [1] = 58, [2] = 122, [3] = 100 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[2].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 20, [1] = 58, [2] = 122, [3] = 100 })[R[51]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[36]", R[36])
      end
    else
      unseen("R[36]", R[36])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 39, [1] = 48, [2] = 59, [3] = 51, [4] = 33, [5] = 34, [6] = 31, [7] = 49 }, [1] = { [0] = 19, [1] = 21, [2] = 32, [3] = 24, [4] = 10, [5] = 8, [6] = 4, [7] = 20 }, [2] = { [0] = 164, [1] = 163, [2] = 184, [3] = 164, [4] = 164, [5] = 164, [6] = 163, [7] = 163 }, [3] = { [0] = 230, [1] = 238, [2] = 253, [3] = 245, [4] = 229, [5] = 219, [6] = 225, [7] = 240 } })[R[51]][R[36]], ({ [0] = { [0] = 29, [1] = 33, [2] = 11, [3] = 6, [4] = 12, [5] = 18, [6] = 13, [7] = 29 }, [1] = { [0] = 67, [1] = 64, [2] = 50, [3] = 45, [4] = 50, [5] = 60, [6] = 55, [7] = 68 }, [2] = { [0] = 122, [1] = 119, [2] = 113, [3] = 114, [4] = 114, [5] = 119, [6] = 119, [7] = 119 }, [3] = { [0] = 105, [1] = 104, [2] = 93, [3] = 85, [4] = 92, [5] = 96, [6] = 97, [7] = 103 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 46, [1] = 47, [2] = 55, [3] = 40, [4] = 51, [5] = 52, [6] = 38, [7] = 59 }, [1] = { [0] = 26, [1] = 20, [2] = 28, [3] = 13, [4] = 28, [5] = 26, [6] = 11, [7] = 30 }, [2] = { [0] = 171, [1] = 162, [2] = 180, [3] = 182, [4] = 182, [5] = 182, [6] = 170, [7] = 170 }, [3] = { [0] = 237, [1] = 237, [2] = 249, [3] = 234, [4] = 247, [5] = 237, [6] = 232, [7] = 250 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 19, [2] = 15, [3] = 13, [4] = 16, [5] = 9, [6] = 18, [7] = 20 }, [1] = { [0] = 54, [1] = 50, [2] = 54, [3] = 52, [4] = 54, [5] = 51, [6] = 60, [7] = 59 }, [2] = { [0] = 109, [1] = 105, [2] = 117, [3] = 118, [4] = 118, [5] = 110, [6] = 124, [7] = 124 }, [3] = { [0] = 92, [1] = 90, [2] = 97, [3] = 92, [4] = 96, [5] = 87, [6] = 102, [7] = 94 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 44, [1] = 47, [2] = 55, [3] = 43, [4] = 53, [5] = 52, [6] = 36, [7] = 59 }, [1] = { [0] = 24, [1] = 20, [2] = 28, [3] = 16, [4] = 30, [5] = 26, [6] = 9, [7] = 30 }, [2] = { [0] = 169, [1] = 162, [2] = 180, [3] = 184, [4] = 184, [5] = 182, [6] = 168, [7] = 168 }, [3] = { [0] = 235, [1] = 237, [2] = 249, [3] = 237, [4] = 249, [5] = 237, [6] = 230, [7] = 250 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 17, [2] = 13, [3] = 9, [4] = 16, [5] = 11, [6] = 18, [7] = 22 }, [1] = { [0] = 54, [1] = 48, [2] = 52, [3] = 48, [4] = 54, [5] = 53, [6] = 60, [7] = 61 }, [2] = { [0] = 109, [1] = 103, [2] = 115, [3] = 118, [4] = 118, [5] = 112, [6] = 124, [7] = 124 }, [3] = { [0] = 92, [1] = 88, [2] = 95, [3] = 88, [4] = 96, [5] = 89, [6] = 102, [7] = 96 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 55, [1] = 50, [2] = 37, [3] = 60, [4] = 45, [5] = 40, [6] = 51, [7] = 58 }, [1] = { [0] = 35, [1] = 23, [2] = 10, [3] = 33, [4] = 22, [5] = 14, [6] = 24, [7] = 29 }, [2] = { [0] = 180, [1] = 165, [2] = 162, [3] = 176, [4] = 176, [5] = 170, [6] = 183, [7] = 183 }, [3] = { [0] = 246, [1] = 240, [2] = 231, [3] = 254, [4] = 241, [5] = 225, [6] = 245, [7] = 249 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 19, [2] = 16, [3] = 13, [4] = 24, [5] = 19, [6] = 5, [7] = 14 }, [1] = { [0] = 60, [1] = 50, [2] = 55, [3] = 52, [4] = 62, [5] = 61, [6] = 47, [7] = 53 }, [2] = { [0] = 115, [1] = 105, [2] = 118, [3] = 126, [4] = 126, [5] = 120, [6] = 111, [7] = 111 }, [3] = { [0] = 98, [1] = 90, [2] = 98, [3] = 92, [4] = 104, [5] = 97, [6] = 89, [7] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 55, [1] = 50, [2] = 37, [3] = 58, [4] = 45, [5] = 40, [6] = 51, [7] = 58 }, [1] = { [0] = 35, [1] = 23, [2] = 10, [3] = 31, [4] = 22, [5] = 14, [6] = 24, [7] = 29 }, [2] = { [0] = 180, [1] = 165, [2] = 162, [3] = 176, [4] = 176, [5] = 170, [6] = 183, [7] = 183 }, [3] = { [0] = 246, [1] = 240, [2] = 231, [3] = 252, [4] = 241, [5] = 225, [6] = 245, [7] = 249 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 19, [2] = 16, [3] = 9, [4] = 24, [5] = 19, [6] = 5, [7] = 14 }, [1] = { [0] = 60, [1] = 50, [2] = 55, [3] = 48, [4] = 62, [5] = 61, [6] = 47, [7] = 53 }, [2] = { [0] = 115, [1] = 105, [2] = 118, [3] = 126, [4] = 126, [5] = 120, [6] = 111, [7] = 111 }, [3] = { [0] = 98, [1] = 90, [2] = 98, [3] = 88, [4] = 104, [5] = 97, [6] = 89, [7] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 44, [1] = 47, [2] = 55, [3] = 46, [4] = 53, [5] = 52, [6] = 36, [7] = 59 }, [1] = { [0] = 24, [1] = 20, [2] = 28, [3] = 19, [4] = 30, [5] = 26, [6] = 9, [7] = 30 }, [2] = { [0] = 169, [1] = 162, [2] = 180, [3] = 184, [4] = 184, [5] = 182, [6] = 168, [7] = 168 }, [3] = { [0] = 235, [1] = 237, [2] = 249, [3] = 240, [4] = 249, [5] = 237, [6] = 230, [7] = 250 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 19, [2] = 13, [3] = 24, [4] = 16, [5] = 11, [6] = 18, [7] = 22 }, [1] = { [0] = 54, [1] = 50, [2] = 52, [3] = 63, [4] = 54, [5] = 53, [6] = 60, [7] = 61 }, [2] = { [0] = 109, [1] = 105, [2] = 115, [3] = 118, [4] = 118, [5] = 112, [6] = 124, [7] = 124 }, [3] = { [0] = 92, [1] = 90, [2] = 95, [3] = 103, [4] = 96, [5] = 89, [6] = 102, [7] = 96 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [3] = { [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 44, [1] = 50, [2] = 55, [3] = 46, [4] = 53, [5] = 52, [6] = 36, [7] = 59 }, [1] = { [0] = 24, [1] = 23, [2] = 28, [3] = 19, [4] = 30, [5] = 26, [6] = 9, [7] = 30 }, [2] = { [0] = 169, [1] = 165, [2] = 180, [3] = 184, [4] = 184, [5] = 182, [6] = 168, [7] = 168 }, [3] = { [0] = 235, [1] = 240, [2] = 249, [3] = 240, [4] = 249, [5] = 237, [6] = 230, [7] = 250 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 19, [2] = 13, [3] = 24, [4] = 16, [5] = 11, [6] = 18, [7] = 22 }, [1] = { [0] = 54, [1] = 50, [2] = 52, [3] = 63, [4] = 54, [5] = 53, [6] = 60, [7] = 61 }, [2] = { [0] = 109, [1] = 105, [2] = 115, [3] = 118, [4] = 118, [5] = 112, [6] = 124, [7] = 124 }, [3] = { [0] = 92, [1] = 90, [2] = 95, [3] = 103, [4] = 96, [5] = 89, [6] = 102, [7] = 96 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [3] = { [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 55, [1] = 47, [2] = 37, [3] = 40, [4] = 45, [5] = 40, [6] = 51, [7] = 58 }, [1] = { [0] = 35, [1] = 20, [2] = 10, [3] = 13, [4] = 22, [5] = 14, [6] = 24, [7] = 29 }, [2] = { [0] = 180, [1] = 162, [2] = 162, [3] = 176, [4] = 176, [5] = 170, [6] = 183, [7] = 183 }, [3] = { [0] = 246, [1] = 237, [2] = 231, [3] = 234, [4] = 241, [5] = 225, [6] = 245, [7] = 249 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 19, [2] = 16, [3] = 13, [4] = 24, [5] = 19, [6] = 5, [7] = 14 }, [1] = { [0] = 60, [1] = 50, [2] = 55, [3] = 52, [4] = 62, [5] = 61, [6] = 47, [7] = 53 }, [2] = { [0] = 115, [1] = 105, [2] = 118, [3] = 126, [4] = 126, [5] = 120, [6] = 111, [7] = 111 }, [3] = { [0] = 98, [1] = 90, [2] = 98, [3] = 92, [4] = 104, [5] = 97, [6] = 89, [7] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 50, [2] = 55, [3] = 40, [4] = 46, [5] = 39, [6] = 43, [7] = 43 }, [1] = { [0] = 21, [1] = 23, [2] = 28, [3] = 13, [4] = 23, [5] = 13, [6] = 16, [7] = 14 }, [2] = { [0] = 166, [1] = 165, [2] = 180, [3] = 177, [4] = 177, [5] = 169, [6] = 175, [7] = 175 }, [3] = { [0] = 232, [1] = 240, [2] = 249, [3] = 234, [4] = 242, [5] = 224, [6] = 237, [7] = 234 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 13, [2] = 19, [3] = 13, [4] = 20, [5] = 8, [6] = 15, [7] = 20 }, [1] = { [0] = 54, [1] = 44, [2] = 58, [3] = 52, [4] = 58, [5] = 50, [6] = 57, [7] = 59 }, [2] = { [0] = 109, [1] = 99, [2] = 121, [3] = 122, [4] = 122, [5] = 109, [6] = 121, [7] = 121 }, [3] = { [0] = 92, [1] = 84, [2] = 101, [3] = 92, [4] = 100, [5] = 86, [6] = 99, [7] = 94 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 53, [2] = 51, [3] = 46, [4] = 48, [5] = 48, [6] = 52, [7] = 38 }, [1] = { [0] = 21, [1] = 26, [2] = 24, [3] = 19, [4] = 25, [5] = 22, [6] = 25, [7] = 9 }, [2] = { [0] = 166, [1] = 168, [2] = 176, [3] = 179, [4] = 179, [5] = 178, [6] = 184, [7] = 184 }, [3] = { [0] = 232, [1] = 243, [2] = 245, [3] = 240, [4] = 244, [5] = 233, [6] = 246, [7] = 229 } })[R[51]][R[36]], ({ [0] = { [0] = 13, [1] = 10, [2] = 20, [3] = 24, [4] = 11, [5] = 16, [6] = 12, [7] = 17 }, [1] = { [0] = 51, [1] = 41, [2] = 59, [3] = 63, [4] = 49, [5] = 58, [6] = 54, [7] = 56 }, [2] = { [0] = 106, [1] = 96, [2] = 122, [3] = 113, [4] = 113, [5] = 117, [6] = 118, [7] = 118 }, [3] = { [0] = 89, [1] = 81, [2] = 102, [3] = 103, [4] = 91, [5] = 94, [6] = 96, [7] = 91 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 55, [1] = 50, [2] = 37, [3] = 60, [4] = 45, [5] = 40, [6] = 51, [7] = 58 }, [1] = { [0] = 35, [1] = 23, [2] = 10, [3] = 33, [4] = 22, [5] = 14, [6] = 24, [7] = 29 }, [2] = { [0] = 180, [1] = 165, [2] = 162, [3] = 176, [4] = 176, [5] = 170, [6] = 183, [7] = 183 }, [3] = { [0] = 246, [1] = 240, [2] = 231, [3] = 254, [4] = 241, [5] = 225, [6] = 245, [7] = 249 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 19, [2] = 16, [3] = 13, [4] = 24, [5] = 19, [6] = 5, [7] = 14 }, [1] = { [0] = 60, [1] = 50, [2] = 55, [3] = 52, [4] = 62, [5] = 61, [6] = 47, [7] = 53 }, [2] = { [0] = 115, [1] = 105, [2] = 118, [3] = 126, [4] = 126, [5] = 120, [6] = 111, [7] = 111 }, [3] = { [0] = 98, [1] = 90, [2] = 98, [3] = 92, [4] = 104, [5] = 97, [6] = 89, [7] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 55, [1] = 50, [2] = 37, [3] = 58, [4] = 45, [5] = 40, [6] = 51, [7] = 58 }, [1] = { [0] = 35, [1] = 23, [2] = 10, [3] = 31, [4] = 22, [5] = 14, [6] = 24, [7] = 29 }, [2] = { [0] = 180, [1] = 165, [2] = 162, [3] = 176, [4] = 176, [5] = 170, [6] = 183, [7] = 183 }, [3] = { [0] = 246, [1] = 240, [2] = 231, [3] = 252, [4] = 241, [5] = 225, [6] = 245, [7] = 249 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 19, [2] = 16, [3] = 9, [4] = 24, [5] = 19, [6] = 5, [7] = 14 }, [1] = { [0] = 60, [1] = 50, [2] = 55, [3] = 48, [4] = 62, [5] = 61, [6] = 47, [7] = 53 }, [2] = { [0] = 115, [1] = 105, [2] = 118, [3] = 126, [4] = 126, [5] = 120, [6] = 111, [7] = 111 }, [3] = { [0] = 98, [1] = 90, [2] = 98, [3] = 88, [4] = 104, [5] = 97, [6] = 89, [7] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 44, [1] = 47, [2] = 55, [3] = 46, [4] = 53, [5] = 52, [6] = 36, [7] = 59 }, [1] = { [0] = 24, [1] = 20, [2] = 28, [3] = 19, [4] = 30, [5] = 26, [6] = 9, [7] = 30 }, [2] = { [0] = 169, [1] = 162, [2] = 180, [3] = 184, [4] = 184, [5] = 182, [6] = 168, [7] = 168 }, [3] = { [0] = 235, [1] = 237, [2] = 249, [3] = 240, [4] = 249, [5] = 237, [6] = 230, [7] = 250 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 19, [2] = 13, [3] = 24, [4] = 16, [5] = 11, [6] = 18, [7] = 22 }, [1] = { [0] = 54, [1] = 50, [2] = 52, [3] = 63, [4] = 54, [5] = 53, [6] = 60, [7] = 61 }, [2] = { [0] = 109, [1] = 105, [2] = 115, [3] = 118, [4] = 118, [5] = 112, [6] = 124, [7] = 124 }, [3] = { [0] = 92, [1] = 90, [2] = 95, [3] = 103, [4] = 96, [5] = 89, [6] = 102, [7] = 96 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 55, [1] = 50, [2] = 37, [3] = 46, [4] = 45, [5] = 40, [6] = 51, [7] = 58 }, [1] = { [0] = 35, [1] = 23, [2] = 10, [3] = 19, [4] = 22, [5] = 14, [6] = 24, [7] = 29 }, [2] = { [0] = 180, [1] = 165, [2] = 162, [3] = 176, [4] = 176, [5] = 170, [6] = 183, [7] = 183 }, [3] = { [0] = 246, [1] = 240, [2] = 231, [3] = 240, [4] = 241, [5] = 225, [6] = 245, [7] = 249 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 19, [2] = 16, [3] = 24, [4] = 24, [5] = 19, [6] = 5, [7] = 14 }, [1] = { [0] = 60, [1] = 50, [2] = 55, [3] = 63, [4] = 62, [5] = 61, [6] = 47, [7] = 53 }, [2] = { [0] = 115, [1] = 105, [2] = 118, [3] = 126, [4] = 126, [5] = 120, [6] = 111, [7] = 111 }, [3] = { [0] = 98, [1] = 90, [2] = 98, [3] = 103, [4] = 104, [5] = 97, [6] = 89, [7] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 50, [2] = 55, [3] = 40, [4] = 46, [5] = 39, [6] = 43, [7] = 43 }, [1] = { [0] = 21, [1] = 23, [2] = 28, [3] = 13, [4] = 23, [5] = 13, [6] = 16, [7] = 14 }, [2] = { [0] = 166, [1] = 165, [2] = 180, [3] = 177, [4] = 177, [5] = 169, [6] = 175, [7] = 175 }, [3] = { [0] = 232, [1] = 240, [2] = 249, [3] = 234, [4] = 242, [5] = 224, [6] = 237, [7] = 234 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 13, [2] = 19, [3] = 13, [4] = 20, [5] = 8, [6] = 15, [7] = 20 }, [1] = { [0] = 54, [1] = 44, [2] = 58, [3] = 52, [4] = 58, [5] = 50, [6] = 57, [7] = 59 }, [2] = { [0] = 109, [1] = 99, [2] = 121, [3] = 122, [4] = 122, [5] = 109, [6] = 121, [7] = 121 }, [3] = { [0] = 92, [1] = 84, [2] = 101, [3] = 92, [4] = 100, [5] = 86, [6] = 99, [7] = 94 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 53, [2] = 51, [3] = 46, [4] = 48, [5] = 48, [6] = 52, [7] = 38 }, [1] = { [0] = 21, [1] = 26, [2] = 24, [3] = 19, [4] = 25, [5] = 22, [6] = 25, [7] = 9 }, [2] = { [0] = 166, [1] = 168, [2] = 176, [3] = 179, [4] = 179, [5] = 178, [6] = 184, [7] = 184 }, [3] = { [0] = 232, [1] = 243, [2] = 245, [3] = 240, [4] = 244, [5] = 233, [6] = 246, [7] = 229 } })[R[51]][R[36]], ({ [0] = { [0] = 13, [1] = 10, [2] = 20, [3] = 24, [4] = 11, [5] = 16, [6] = 12, [7] = 17 }, [1] = { [0] = 51, [1] = 41, [2] = 59, [3] = 63, [4] = 49, [5] = 58, [6] = 54, [7] = 56 }, [2] = { [0] = 106, [1] = 96, [2] = 122, [3] = 113, [4] = 113, [5] = 117, [6] = 118, [7] = 118 }, [3] = { [0] = 89, [1] = 81, [2] = 102, [3] = 103, [4] = 91, [5] = 94, [6] = 96, [7] = 91 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 55, [1] = 50, [2] = 37, [3] = 60, [4] = 45, [5] = 40, [6] = 51, [7] = 58 }, [1] = { [0] = 35, [1] = 23, [2] = 10, [3] = 33, [4] = 22, [5] = 14, [6] = 24, [7] = 29 }, [2] = { [0] = 180, [1] = 165, [2] = 162, [3] = 176, [4] = 176, [5] = 170, [6] = 183, [7] = 183 }, [3] = { [0] = 246, [1] = 240, [2] = 231, [3] = 254, [4] = 241, [5] = 225, [6] = 245, [7] = 249 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 19, [2] = 16, [3] = 13, [4] = 24, [5] = 19, [6] = 5, [7] = 14 }, [1] = { [0] = 60, [1] = 50, [2] = 55, [3] = 52, [4] = 62, [5] = 61, [6] = 47, [7] = 53 }, [2] = { [0] = 115, [1] = 105, [2] = 118, [3] = 126, [4] = 126, [5] = 120, [6] = 111, [7] = 111 }, [3] = { [0] = 98, [1] = 90, [2] = 98, [3] = 92, [4] = 104, [5] = 97, [6] = 89, [7] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 55, [1] = 50, [2] = 37, [3] = 58, [4] = 45, [5] = 40, [6] = 51, [7] = 58 }, [1] = { [0] = 35, [1] = 23, [2] = 10, [3] = 31, [4] = 22, [5] = 14, [6] = 24, [7] = 29 }, [2] = { [0] = 180, [1] = 165, [2] = 162, [3] = 176, [4] = 176, [5] = 170, [6] = 183, [7] = 183 }, [3] = { [0] = 246, [1] = 240, [2] = 231, [3] = 252, [4] = 241, [5] = 225, [6] = 245, [7] = 249 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 19, [2] = 16, [3] = 9, [4] = 24, [5] = 19, [6] = 5, [7] = 14 }, [1] = { [0] = 60, [1] = 50, [2] = 55, [3] = 48, [4] = 62, [5] = 61, [6] = 47, [7] = 53 }, [2] = { [0] = 115, [1] = 105, [2] = 118, [3] = 126, [4] = 126, [5] = 120, [6] = 111, [7] = 111 }, [3] = { [0] = 98, [1] = 90, [2] = 98, [3] = 88, [4] = 104, [5] = 97, [6] = 89, [7] = 88 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 50, [2] = 55, [3] = 46, [4] = 46, [5] = 39, [6] = 43, [7] = 43 }, [1] = { [0] = 21, [1] = 23, [2] = 28, [3] = 19, [4] = 23, [5] = 13, [6] = 16, [7] = 14 }, [2] = { [0] = 166, [1] = 165, [2] = 180, [3] = 177, [4] = 177, [5] = 169, [6] = 175, [7] = 175 }, [3] = { [0] = 232, [1] = 240, [2] = 249, [3] = 240, [4] = 242, [5] = 224, [6] = 237, [7] = 234 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 13, [2] = 19, [3] = 24, [4] = 20, [5] = 8, [6] = 15, [7] = 20 }, [1] = { [0] = 54, [1] = 44, [2] = 58, [3] = 63, [4] = 58, [5] = 50, [6] = 57, [7] = 59 }, [2] = { [0] = 109, [1] = 99, [2] = 121, [3] = 122, [4] = 122, [5] = 109, [6] = 121, [7] = 121 }, [3] = { [0] = 92, [1] = 84, [2] = 101, [3] = 103, [4] = 100, [5] = 86, [6] = 99, [7] = 94 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" } })[R[51]][R[36]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 53, [2] = 51, [3] = 46, [4] = 48, [5] = 48, [6] = 52, [7] = 38 }, [1] = { [0] = 21, [1] = 26, [2] = 24, [3] = 19, [4] = 25, [5] = 22, [6] = 25, [7] = 9 }, [2] = { [0] = 166, [1] = 168, [2] = 176, [3] = 179, [4] = 179, [5] = 178, [6] = 184, [7] = 184 }, [3] = { [0] = 232, [1] = 243, [2] = 245, [3] = 240, [4] = 244, [5] = 233, [6] = 246, [7] = 229 } })[R[51]][R[36]], ({ [0] = { [0] = 13, [1] = 10, [2] = 20, [3] = 24, [4] = 11, [5] = 16, [6] = 12, [7] = 17 }, [1] = { [0] = 51, [1] = 41, [2] = 59, [3] = 63, [4] = 49, [5] = 58, [6] = 54, [7] = 56 }, [2] = { [0] = 106, [1] = 96, [2] = 122, [3] = 113, [4] = 113, [5] = 117, [6] = 118, [7] = 118 }, [3] = { [0] = 89, [1] = 81, [2] = 102, [3] = 103, [4] = 91, [5] = 94, [6] = 96, [7] = 91 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 62, [1] = 56, [2] = 47, [3] = 50, [4] = 54, [5] = 40, [6] = 52, [7] = 52 }, [1] = { [0] = 42, [1] = 29, [2] = 20, [3] = 23, [4] = 31, [5] = 14, [6] = 25, [7] = 23 }, [2] = { [0] = 187, [1] = 171, [2] = 172, [3] = 185, [4] = 185, [5] = 170, [6] = 184, [7] = 184 }, [3] = { [0] = 253, [1] = 246, [2] = 241, [3] = 244, [4] = 250, [5] = 225, [6] = 246, [7] = 243 } })[R[51]][R[36]], ({ [0] = { [0] = 24, [1] = 23, [2] = 13, [3] = 10, [4] = 7, [5] = 25, [6] = 15, [7] = 19 }, [1] = { [0] = 62, [1] = 54, [2] = 52, [3] = 49, [4] = 45, [5] = 67, [6] = 57, [7] = 58 }, [2] = { [0] = 117, [1] = 109, [2] = 115, [3] = 109, [4] = 109, [5] = 126, [6] = 121, [7] = 121 }, [3] = { [0] = 100, [1] = 94, [2] = 95, [3] = 89, [4] = 87, [5] = 103, [6] = 99, [7] = 93 } })[R[51]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 50, [2] = 42, [3] = 42, [4] = 41, [5] = 44, [6] = 38, [7] = 41 }, [1] = { [0] = 22, [1] = 23, [2] = 15, [3] = 15, [4] = 18, [5] = 18, [6] = 11, [7] = 12 }, [2] = { [0] = 167, [1] = 165, [2] = 167, [3] = 172, [4] = 172, [5] = 174, [6] = 170, [7] = 170 }, [3] = { [0] = 233, [1] = 240, [2] = 236, [3] = 236, [4] = 237, [5] = 229, [6] = 232, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 11, [3] = 19, [4] = 10, [5] = 14, [6] = 7, [7] = 16 }, [1] = { [0] = 58, [1] = 55, [2] = 50, [3] = 58, [4] = 48, [5] = 56, [6] = 49, [7] = 55 }, [2] = { [0] = 113, [1] = 110, [2] = 113, [3] = 112, [4] = 112, [5] = 115, [6] = 113, [7] = 113 }, [3] = { [0] = 96, [1] = 95, [2] = 93, [3] = 98, [4] = 90, [5] = 92, [6] = 91, [7] = 90 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 43, [1] = 51, [2] = 43, [3] = 42, [4] = 41, [5] = 44, [6] = 38, [7] = 41 }, [1] = { [0] = 23, [1] = 24, [2] = 16, [3] = 15, [4] = 18, [5] = 18, [6] = 11, [7] = 12 }, [2] = { [0] = 168, [1] = 166, [2] = 168, [3] = 172, [4] = 172, [5] = 174, [6] = 170, [7] = 170 }, [3] = { [0] = 234, [1] = 241, [2] = 237, [3] = 236, [4] = 237, [5] = 229, [6] = 232, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 11, [3] = 20, [4] = 11, [5] = 15, [6] = 8, [7] = 17 }, [1] = { [0] = 58, [1] = 55, [2] = 50, [3] = 59, [4] = 49, [5] = 57, [6] = 50, [7] = 56 }, [2] = { [0] = 113, [1] = 110, [2] = 113, [3] = 113, [4] = 113, [5] = 116, [6] = 114, [7] = 114 }, [3] = { [0] = 96, [1] = 95, [2] = 93, [3] = 99, [4] = 91, [5] = 93, [6] = 92, [7] = 91 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 44, [1] = 52, [2] = 44, [3] = 42, [4] = 41, [5] = 44, [6] = 38, [7] = 41 }, [1] = { [0] = 24, [1] = 25, [2] = 17, [3] = 15, [4] = 18, [5] = 18, [6] = 11, [7] = 12 }, [2] = { [0] = 169, [1] = 167, [2] = 169, [3] = 172, [4] = 172, [5] = 174, [6] = 170, [7] = 170 }, [3] = { [0] = 235, [1] = 242, [2] = 238, [3] = 236, [4] = 237, [5] = 229, [6] = 232, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 11, [3] = 21, [4] = 12, [5] = 16, [6] = 9, [7] = 18 }, [1] = { [0] = 58, [1] = 55, [2] = 50, [3] = 60, [4] = 50, [5] = 58, [6] = 51, [7] = 57 }, [2] = { [0] = 113, [1] = 110, [2] = 113, [3] = 114, [4] = 114, [5] = 117, [6] = 115, [7] = 115 }, [3] = { [0] = 96, [1] = 95, [2] = 93, [3] = 100, [4] = 92, [5] = 94, [6] = 93, [7] = 92 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 53, [2] = 45, [3] = 43, [4] = 41, [5] = 44, [6] = 38, [7] = 41 }, [1] = { [0] = 25, [1] = 26, [2] = 18, [3] = 16, [4] = 18, [5] = 18, [6] = 11, [7] = 12 }, [2] = { [0] = 170, [1] = 168, [2] = 170, [3] = 172, [4] = 172, [5] = 174, [6] = 170, [7] = 170 }, [3] = { [0] = 236, [1] = 243, [2] = 239, [3] = 237, [4] = 237, [5] = 229, [6] = 232, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 8, [3] = 19, [4] = 13, [5] = 20, [6] = 10, [7] = 19 }, [1] = { [0] = 58, [1] = 55, [2] = 47, [3] = 58, [4] = 51, [5] = 62, [6] = 52, [7] = 58 }, [2] = { [0] = 113, [1] = 110, [2] = 110, [3] = 115, [4] = 115, [5] = 121, [6] = 116, [7] = 116 }, [3] = { [0] = 96, [1] = 95, [2] = 90, [3] = 98, [4] = 93, [5] = 98, [6] = 94, [7] = 93 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 54, [2] = 45, [3] = 44, [4] = 41, [5] = 44, [6] = 38, [7] = 41 }, [1] = { [0] = 26, [1] = 27, [2] = 18, [3] = 17, [4] = 18, [5] = 18, [6] = 11, [7] = 12 }, [2] = { [0] = 171, [1] = 169, [2] = 170, [3] = 172, [4] = 172, [5] = 174, [6] = 170, [7] = 170 }, [3] = { [0] = 237, [1] = 244, [2] = 239, [3] = 238, [4] = 237, [5] = 229, [6] = 232, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 9, [3] = 15, [4] = 14, [5] = 21, [6] = 11, [7] = 20 }, [1] = { [0] = 58, [1] = 55, [2] = 48, [3] = 54, [4] = 52, [5] = 63, [6] = 53, [7] = 59 }, [2] = { [0] = 113, [1] = 110, [2] = 111, [3] = 116, [4] = 116, [5] = 122, [6] = 117, [7] = 117 }, [3] = { [0] = 96, [1] = 95, [2] = 91, [3] = 94, [4] = 94, [5] = 99, [6] = 95, [7] = 94 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 55, [2] = 45, [3] = 44, [4] = 41, [5] = 44, [6] = 41, [7] = 41 }, [1] = { [0] = 27, [1] = 28, [2] = 18, [3] = 17, [4] = 18, [5] = 18, [6] = 14, [7] = 12 }, [2] = { [0] = 172, [1] = 170, [2] = 170, [3] = 172, [4] = 172, [5] = 174, [6] = 173, [7] = 173 }, [3] = { [0] = 238, [1] = 245, [2] = 239, [3] = 238, [4] = 237, [5] = 229, [6] = 235, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 10, [3] = 16, [4] = 18, [5] = 22, [6] = 5, [7] = 21 }, [1] = { [0] = 58, [1] = 55, [2] = 49, [3] = 55, [4] = 56, [5] = 64, [6] = 47, [7] = 60 }, [2] = { [0] = 113, [1] = 110, [2] = 112, [3] = 120, [4] = 120, [5] = 123, [6] = 111, [7] = 111 }, [3] = { [0] = 96, [1] = 95, [2] = 92, [3] = 95, [4] = 98, [5] = 100, [6] = 89, [7] = 95 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 56, [2] = 45, [3] = 44, [4] = 41, [5] = 47, [6] = 42, [7] = 41 }, [1] = { [0] = 28, [1] = 29, [2] = 18, [3] = 17, [4] = 18, [5] = 21, [6] = 15, [7] = 12 }, [2] = { [0] = 173, [1] = 171, [2] = 170, [3] = 172, [4] = 172, [5] = 177, [6] = 174, [7] = 174 }, [3] = { [0] = 239, [1] = 246, [2] = 239, [3] = 238, [4] = 237, [5] = 232, [6] = 236, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 11, [3] = 17, [4] = 19, [5] = 18, [6] = 5, [7] = 22 }, [1] = { [0] = 58, [1] = 55, [2] = 50, [3] = 56, [4] = 57, [5] = 60, [6] = 47, [7] = 61 }, [2] = { [0] = 113, [1] = 110, [2] = 113, [3] = 121, [4] = 121, [5] = 119, [6] = 111, [7] = 111 }, [3] = { [0] = 96, [1] = 95, [2] = 93, [3] = 96, [4] = 99, [5] = 96, [6] = 89, [7] = 96 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 57, [2] = 45, [3] = 44, [4] = 41, [5] = 47, [6] = 42, [7] = 41 }, [1] = { [0] = 30, [1] = 30, [2] = 18, [3] = 17, [4] = 18, [5] = 21, [6] = 15, [7] = 12 }, [2] = { [0] = 175, [1] = 172, [2] = 170, [3] = 172, [4] = 172, [5] = 177, [6] = 174, [7] = 174 }, [3] = { [0] = 241, [1] = 247, [2] = 239, [3] = 238, [4] = 237, [5] = 232, [6] = 236, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 15, [1] = 13, [2] = 12, [3] = 18, [4] = 20, [5] = 24, [6] = 13, [7] = 23 }, [1] = { [0] = 53, [1] = 44, [2] = 51, [3] = 57, [4] = 58, [5] = 66, [6] = 55, [7] = 62 }, [2] = { [0] = 108, [1] = 99, [2] = 114, [3] = 122, [4] = 122, [5] = 125, [6] = 119, [7] = 119 }, [3] = { [0] = 91, [1] = 84, [2] = 94, [3] = 97, [4] = 100, [5] = 102, [6] = 97, [7] = 97 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 57, [2] = 45, [3] = 44, [4] = 41, [5] = 48, [6] = 43, [7] = 41 }, [1] = { [0] = 30, [1] = 30, [2] = 18, [3] = 17, [4] = 18, [5] = 22, [6] = 16, [7] = 12 }, [2] = { [0] = 175, [1] = 172, [2] = 170, [3] = 172, [4] = 172, [5] = 178, [6] = 175, [7] = 175 }, [3] = { [0] = 241, [1] = 247, [2] = 239, [3] = 238, [4] = 237, [5] = 233, [6] = 237, [7] = 232 } })[R[51]][R[36]], ({ [0] = { [0] = 16, [1] = 14, [2] = 13, [3] = 19, [4] = 21, [5] = 18, [6] = 5, [7] = 24 }, [1] = { [0] = 54, [1] = 45, [2] = 52, [3] = 58, [4] = 59, [5] = 60, [6] = 47, [7] = 63 }, [2] = { [0] = 109, [1] = 100, [2] = 115, [3] = 123, [4] = 123, [5] = 119, [6] = 111, [7] = 111 }, [3] = { [0] = 92, [1] = 85, [2] = 95, [3] = 98, [4] = 101, [5] = 96, [6] = 89, [7] = 98 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 57, [2] = 45, [3] = 45, [4] = 41, [5] = 48, [6] = 43, [7] = 44 }, [1] = { [0] = 30, [1] = 30, [2] = 18, [3] = 18, [4] = 18, [5] = 22, [6] = 16, [7] = 15 }, [2] = { [0] = 175, [1] = 172, [2] = 170, [3] = 172, [4] = 172, [5] = 178, [6] = 175, [7] = 175 }, [3] = { [0] = 241, [1] = 247, [2] = 239, [3] = 239, [4] = 237, [5] = 233, [6] = 237, [7] = 235 } })[R[51]][R[36]], ({ [0] = { [0] = 17, [1] = 15, [2] = 14, [3] = 15, [4] = 22, [5] = 24, [6] = 13, [7] = 13 }, [1] = { [0] = 55, [1] = 46, [2] = 53, [3] = 54, [4] = 60, [5] = 66, [6] = 55, [7] = 52 }, [2] = { [0] = 110, [1] = 101, [2] = 116, [3] = 124, [4] = 124, [5] = 125, [6] = 119, [7] = 119 }, [3] = { [0] = 93, [1] = 86, [2] = 96, [3] = 94, [4] = 102, [5] = 102, [6] = 97, [7] = 87 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 57, [2] = 45, [3] = 45, [4] = 44, [5] = 49, [6] = 44, [7] = 44 }, [1] = { [0] = 30, [1] = 30, [2] = 18, [3] = 18, [4] = 21, [5] = 23, [6] = 17, [7] = 15 }, [2] = { [0] = 175, [1] = 172, [2] = 170, [3] = 175, [4] = 175, [5] = 179, [6] = 176, [7] = 176 }, [3] = { [0] = 241, [1] = 247, [2] = 239, [3] = 239, [4] = 240, [5] = 234, [6] = 238, [7] = 235 } })[R[51]][R[36]], ({ [0] = { [0] = 18, [1] = 16, [2] = 15, [3] = 19, [4] = 8, [5] = 18, [6] = 5, [7] = 26 }, [1] = { [0] = 56, [1] = 47, [2] = 54, [3] = 58, [4] = 46, [5] = 60, [6] = 47, [7] = 65 }, [2] = { [0] = 111, [1] = 102, [2] = 117, [3] = 110, [4] = 110, [5] = 119, [6] = 111, [7] = 111 }, [3] = { [0] = 94, [1] = 87, [2] = 97, [3] = 98, [4] = 88, [5] = 96, [6] = 89, [7] = 100 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 57, [2] = 45, [3] = 46, [4] = 44, [5] = 49, [6] = 44, [7] = 45 }, [1] = { [0] = 30, [1] = 30, [2] = 18, [3] = 19, [4] = 21, [5] = 23, [6] = 17, [7] = 16 }, [2] = { [0] = 175, [1] = 172, [2] = 170, [3] = 175, [4] = 175, [5] = 179, [6] = 176, [7] = 176 }, [3] = { [0] = 241, [1] = 247, [2] = 239, [3] = 240, [4] = 240, [5] = 234, [6] = 238, [7] = 236 } })[R[51]][R[36]], ({ [0] = { [0] = 22, [1] = 24, [2] = 16, [3] = 19, [4] = 16, [5] = 24, [6] = 13, [7] = 13 }, [1] = { [0] = 60, [1] = 55, [2] = 55, [3] = 58, [4] = 54, [5] = 66, [6] = 55, [7] = 52 }, [2] = { [0] = 115, [1] = 110, [2] = 118, [3] = 118, [4] = 118, [5] = 125, [6] = 119, [7] = 119 }, [3] = { [0] = 98, [1] = 95, [2] = 98, [3] = 98, [4] = 96, [5] = 102, [6] = 97, [7] = 87 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 58, [2] = 45, [3] = 47, [4] = 44, [5] = 50, [6] = 45, [7] = 45 }, [1] = { [0] = 30, [1] = 31, [2] = 18, [3] = 20, [4] = 21, [5] = 24, [6] = 18, [7] = 16 }, [2] = { [0] = 175, [1] = 173, [2] = 170, [3] = 175, [4] = 175, [5] = 180, [6] = 177, [7] = 177 }, [3] = { [0] = 241, [1] = 248, [2] = 239, [3] = 241, [4] = 240, [5] = 235, [6] = 239, [7] = 236 } })[R[51]][R[36]], ({ [0] = { [0] = 23, [1] = 21, [2] = 17, [3] = 19, [4] = 24, [5] = 18, [6] = 5, [7] = 26 }, [1] = { [0] = 61, [1] = 52, [2] = 56, [3] = 58, [4] = 62, [5] = 60, [6] = 47, [7] = 65 }, [2] = { [0] = 116, [1] = 107, [2] = 119, [3] = 126, [4] = 126, [5] = 119, [6] = 111, [7] = 111 }, [3] = { [0] = 99, [1] = 92, [2] = 99, [3] = 98, [4] = 104, [5] = 96, [6] = 89, [7] = 100 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 58, [2] = 46, [3] = 48, [4] = 45, [5] = 50, [6] = 45, [7] = 46 }, [1] = { [0] = 30, [1] = 31, [2] = 19, [3] = 21, [4] = 22, [5] = 24, [6] = 18, [7] = 17 }, [2] = { [0] = 175, [1] = 173, [2] = 171, [3] = 176, [4] = 176, [5] = 180, [6] = 177, [7] = 177 }, [3] = { [0] = 241, [1] = 248, [2] = 240, [3] = 242, [4] = 241, [5] = 235, [6] = 239, [7] = 237 } })[R[51]][R[36]], ({ [0] = { [0] = 24, [1] = 22, [2] = 11, [3] = 12, [4] = 8, [5] = 24, [6] = 13, [7] = 13 }, [1] = { [0] = 62, [1] = 53, [2] = 50, [3] = 51, [4] = 46, [5] = 66, [6] = 55, [7] = 52 }, [2] = { [0] = 117, [1] = 108, [2] = 113, [3] = 110, [4] = 110, [5] = 125, [6] = 119, [7] = 119 }, [3] = { [0] = 100, [1] = 93, [2] = 93, [3] = 91, [4] = 88, [5] = 102, [6] = 97, [7] = 87 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 58, [2] = 46, [3] = 48, [4] = 45, [5] = 51, [6] = 47, [7] = 46 }, [1] = { [0] = 30, [1] = 31, [2] = 19, [3] = 21, [4] = 22, [5] = 25, [6] = 20, [7] = 17 }, [2] = { [0] = 175, [1] = 173, [2] = 171, [3] = 176, [4] = 176, [5] = 181, [6] = 179, [7] = 179 }, [3] = { [0] = 241, [1] = 248, [2] = 240, [3] = 242, [4] = 241, [5] = 236, [6] = 241, [7] = 237 } })[R[51]][R[36]], ({ [0] = { [0] = 25, [1] = 23, [2] = 17, [3] = 19, [4] = 16, [5] = 18, [6] = 7, [7] = 26 }, [1] = { [0] = 63, [1] = 54, [2] = 56, [3] = 58, [4] = 54, [5] = 60, [6] = 49, [7] = 65 }, [2] = { [0] = 118, [1] = 109, [2] = 119, [3] = 118, [4] = 118, [5] = 119, [6] = 113, [7] = 113 }, [3] = { [0] = 101, [1] = 94, [2] = 99, [3] = 98, [4] = 96, [5] = 96, [6] = 91, [7] = 100 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 53, [1] = 58, [2] = 47, [3] = 49, [4] = 45, [5] = 51, [6] = 47, [7] = 47 }, [1] = { [0] = 33, [1] = 31, [2] = 20, [3] = 22, [4] = 22, [5] = 25, [6] = 20, [7] = 18 }, [2] = { [0] = 178, [1] = 173, [2] = 172, [3] = 176, [4] = 176, [5] = 181, [6] = 179, [7] = 179 }, [3] = { [0] = 244, [1] = 248, [2] = 241, [3] = 243, [4] = 241, [5] = 236, [6] = 241, [7] = 238 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 24, [2] = 11, [3] = 12, [4] = 24, [5] = 24, [6] = 8, [7] = 13 }, [1] = { [0] = 58, [1] = 55, [2] = 50, [3] = 51, [4] = 62, [5] = 66, [6] = 50, [7] = 52 }, [2] = { [0] = 113, [1] = 110, [2] = 113, [3] = 126, [4] = 126, [5] = 125, [6] = 114, [7] = 114 }, [3] = { [0] = 96, [1] = 95, [2] = 93, [3] = 91, [4] = 104, [5] = 102, [6] = 92, [7] = 87 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 54, [1] = 58, [2] = 47, [3] = 50, [4] = 46, [5] = 52, [6] = 47, [7] = 47 }, [1] = { [0] = 34, [1] = 31, [2] = 20, [3] = 23, [4] = 23, [5] = 26, [6] = 20, [7] = 18 }, [2] = { [0] = 179, [1] = 173, [2] = 172, [3] = 177, [4] = 177, [5] = 182, [6] = 179, [7] = 179 }, [3] = { [0] = 245, [1] = 248, [2] = 241, [3] = 244, [4] = 242, [5] = 237, [6] = 241, [7] = 238 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 25, [2] = 17, [3] = 12, [4] = 8, [5] = 18, [6] = 9, [7] = 26 }, [1] = { [0] = 58, [1] = 56, [2] = 56, [3] = 51, [4] = 46, [5] = 60, [6] = 51, [7] = 65 }, [2] = { [0] = 113, [1] = 111, [2] = 119, [3] = 110, [4] = 110, [5] = 119, [6] = 115, [7] = 115 }, [3] = { [0] = 96, [1] = 96, [2] = 99, [3] = 91, [4] = 88, [5] = 96, [6] = 93, [7] = 100 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 55, [1] = 58, [2] = 48, [3] = 51, [4] = 46, [5] = 53, [6] = 47, [7] = 48 }, [1] = { [0] = 35, [1] = 31, [2] = 21, [3] = 24, [4] = 23, [5] = 27, [6] = 20, [7] = 19 }, [2] = { [0] = 180, [1] = 173, [2] = 173, [3] = 177, [4] = 177, [5] = 183, [6] = 179, [7] = 179 }, [3] = { [0] = 246, [1] = 248, [2] = 242, [3] = 245, [4] = 242, [5] = 238, [6] = 241, [7] = 239 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 26, [2] = 11, [3] = 12, [4] = 9, [5] = 18, [6] = 10, [7] = 13 }, [1] = { [0] = 58, [1] = 57, [2] = 50, [3] = 51, [4] = 47, [5] = 60, [6] = 52, [7] = 52 }, [2] = { [0] = 113, [1] = 112, [2] = 113, [3] = 111, [4] = 111, [5] = 119, [6] = 116, [7] = 116 }, [3] = { [0] = 96, [1] = 97, [2] = 93, [3] = 91, [4] = 89, [5] = 96, [6] = 94, [7] = 87 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 56, [1] = 58, [2] = 48, [3] = 52, [4] = 46, [5] = 54, [6] = 47, [7] = 48 }, [1] = { [0] = 36, [1] = 31, [2] = 21, [3] = 25, [4] = 23, [5] = 28, [6] = 20, [7] = 19 }, [2] = { [0] = 181, [1] = 173, [2] = 173, [3] = 177, [4] = 177, [5] = 184, [6] = 179, [7] = 179 }, [3] = { [0] = 247, [1] = 248, [2] = 242, [3] = 246, [4] = 242, [5] = 239, [6] = 241, [7] = 239 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 31, [2] = 17, [3] = 12, [4] = 16, [5] = 18, [6] = 11, [7] = 14 }, [1] = { [0] = 58, [1] = 62, [2] = 56, [3] = 51, [4] = 54, [5] = 60, [6] = 53, [7] = 53 }, [2] = { [0] = 113, [1] = 117, [2] = 119, [3] = 118, [4] = 118, [5] = 119, [6] = 117, [7] = 117 }, [3] = { [0] = 96, [1] = 102, [2] = 99, [3] = 91, [4] = 96, [5] = 96, [6] = 95, [7] = 88 } })[R[51]][R[36]] })
    game.create_tube({ ({ [0] = { [0] = 57, [1] = 58, [2] = 49, [3] = 53, [4] = 46, [5] = 54, [6] = 51, [7] = 48 }, [1] = { [0] = 37, [1] = 31, [2] = 22, [3] = 26, [4] = 23, [5] = 28, [6] = 24, [7] = 19 }, [2] = { [0] = 182, [1] = 173, [2] = 174, [3] = 177, [4] = 177, [5] = 184, [6] = 183, [7] = 183 }, [3] = { [0] = 248, [1] = 248, [2] = 243, [3] = 247, [4] = 242, [5] = 239, [6] = 245, [7] = 239 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 32, [2] = 11, [3] = 12, [4] = 24, [5] = 19, [6] = 13, [7] = 15 }, [1] = { [0] = 58, [1] = 63, [2] = 50, [3] = 51, [4] = 62, [5] = 61, [6] = 55, [7] = 54 }, [2] = { [0] = 113, [1] = 118, [2] = 113, [3] = 126, [4] = 126, [5] = 120, [6] = 119, [7] = 119 }, [3] = { [0] = 96, [1] = 103, [2] = 93, [3] = 91, [4] = 104, [5] = 97, [6] = 97, [7] = 89 } })[R[51]][R[36]] })
    if R[36] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 58, [1] = 38, [2] = 183, [3] = 249 })[R[51]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 59, [1] = 39, [2] = 184, [3] = 250 })[R[51]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[51]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 58, [1] = 38, [2] = 183, [3] = 249 })[R[51]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 59, [1] = 39, [2] = 184, [3] = 250 })[R[51]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[51]] })
        for i = 1, game.initial_units() do
          R[111] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 56, [1] = 36, [2] = 181, [3] = 247 }, [1] = { [0] = 43, [1] = 23, [2] = 168, [3] = 234 }, [2] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 } })[R[111]][R[51]], ({ [0] = { [0] = 14, [1] = 52, [2] = 107, [3] = 90 }, [1] = { [0] = 23, [1] = 61, [2] = 116, [3] = 99 }, [2] = { [0] = 26, [1] = 64, [2] = 119, [3] = 102 } })[R[111]][R[51]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[51]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[51]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[51]], ({ [0] = 34, [1] = 65, [2] = 120, [3] = 105 })[R[51]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[51]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[51]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[51]], ({ [0] = 34, [1] = 65, [2] = 120, [3] = 105 })[R[51]] })
        for i = 1, game.initial_units() do
          R[112] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 49, [1] = 22, [2] = 164, [3] = 239 }, [1] = { [0] = 51, [1] = 24, [2] = 166, [3] = 241 }, [2] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 } })[R[112]][R[51]], ({ [0] = { [0] = 28, [1] = 59, [2] = 114, [3] = 99 }, [1] = { [0] = 30, [1] = 61, [2] = 116, [3] = 101 }, [2] = { [0] = 22, [1] = 53, [2] = 108, [3] = 93 } })[R[112]][R[51]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[113] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 40, [1] = 13, [2] = 165, [3] = 234 }, [1] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [2] = { [0] = 58, [1] = 31, [2] = 183, [3] = 252 } })[R[113]][R[51]], ({ [0] = { [0] = 5, [1] = 44, [2] = 107, [3] = 87 }, [1] = { [0] = 21, [1] = 60, [2] = 123, [3] = 103 }, [2] = { [0] = 14, [1] = 53, [2] = 116, [3] = 96 } })[R[113]][R[51]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 3 then
      game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 178, [3] = 247 })[R[51]], ({ [0] = 19, [1] = 58, [2] = 111, [3] = 98 })[R[51]] })
      game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 178, [3] = 248 })[R[51]], ({ [0] = 19, [1] = 58, [2] = 112, [3] = 98 })[R[51]] })
      game.create_tube({ ({ [0] = 55, [1] = 28, [2] = 178, [3] = 249 })[R[51]], ({ [0] = 19, [1] = 58, [2] = 118, [3] = 98 })[R[51]] })
      game.create_tube({ ({ [0] = 56, [1] = 29, [2] = 178, [3] = 250 })[R[51]], ({ [0] = 15, [1] = 54, [2] = 126, [3] = 94 })[R[51]] })
      game.create_tube({ ({ [0] = 56, [1] = 29, [2] = 179, [3] = 250 })[R[51]], ({ [0] = 19, [1] = 58, [2] = 112, [3] = 98 })[R[51]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 179, [3] = 251 })[R[51]], ({ [0] = 15, [1] = 54, [2] = 118, [3] = 94 })[R[51]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 179, [3] = 251 })[R[51]], ({ [0] = 16, [1] = 55, [2] = 126, [3] = 95 })[R[51]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[51]], ({ [0] = 17, [1] = 56, [2] = 112, [3] = 96 })[R[51]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[51]], ({ [0] = 18, [1] = 57, [2] = 118, [3] = 97 })[R[51]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[51]], ({ [0] = 19, [1] = 58, [2] = 126, [3] = 98 })[R[51]] })
      game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 181, [3] = 252 })[R[51]], ({ [0] = 19, [1] = 58, [2] = 117, [3] = 98 })[R[51]] })
      game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 181, [3] = 252 })[R[51]], ({ [0] = 20, [1] = 59, [2] = 118, [3] = 99 })[R[51]] })
      if R[51] == 0 then
        if game.initial_units() == 0 then
          game.create_tube({ 58, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 58, 21 })
          for i = 1, game.initial_units() do
            R[114] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 51, [1] = 52, [2] = 39 })[R[114]], ({ [0] = 15, [1] = 22, [2] = 19 })[R[114]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[51] == 1 then
        if game.initial_units() == 0 then
          game.create_tube({ 31, 60 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 31, 60 })
          for i = 1, game.initial_units() do
            R[115] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 24, [1] = 25, [2] = 12 })[R[115]], ({ [0] = 54, [1] = 61, [2] = 58 })[R[115]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[51] == 2 then
        if game.initial_units() == 0 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
          for i = 1, game.initial_units() do
            R[116] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 176, [1] = 167, [2] = 175 })[R[116]], ({ [0] = 109, [1] = 117, [2] = 112 })[R[116]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[51] == 3 then
        if game.initial_units() == 0 then
          game.create_tube({ 252, 100 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 252, 100 })
          for i = 1, game.initial_units() do
            R[117] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 245, [1] = 246, [2] = 233 })[R[117]], ({ [0] = 94, [1] = 101, [2] = 98 })[R[117]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[51]", R[51])
      end
    elseif R[36] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[51]], ({ [0] = 9, [1] = 47, [2] = 111, [3] = 89 })[R[51]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[51]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[51]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[51]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[51]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[51]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[51]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[51]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[51]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[51]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[51]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[51]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[51]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 17, [1] = 55, [2] = 119, [3] = 97 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 18, [1] = 56, [2] = 120, [3] = 98 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[51]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[51]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[51]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[51]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 13, [1] = 51, [2] = 115, [3] = 93 })[R[51]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 14, [1] = 52, [2] = 116, [3] = 94 })[R[51]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[51]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[51]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[51]], ({ [0] = 9, [1] = 47, [2] = 111, [3] = 89 })[R[51]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[51]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[51]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[51]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[51]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[51]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[51]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[51]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[51]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[51]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[51]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[51]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[51]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 17, [1] = 55, [2] = 119, [3] = 97 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 18, [1] = 56, [2] = 120, [3] = 98 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[51]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[51]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[51]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[51]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[51]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[51]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[51]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 13, [1] = 51, [2] = 115, [3] = 93 })[R[51]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 14, [1] = 52, [2] = 116, [3] = 94 })[R[51]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[51]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[51]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[51]] })
        for i = 1, game.initial_units() do
          R[118] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [1] = { [0] = 36, [1] = 13, [2] = 167, [3] = 232 }, [2] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 } })[R[118]][R[51]], ({ [0] = { [0] = 7, [1] = 45, [2] = 109, [3] = 87 }, [1] = { [0] = 15, [1] = 53, [2] = 117, [3] = 95 }, [2] = { [0] = 10, [1] = 48, [2] = 112, [3] = 90 } })[R[118]][R[51]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[51]], ({ [0] = 20, [1] = 62, [2] = 121, [3] = 98 })[R[51]] })
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[51]], ({ [0] = 21, [1] = 63, [2] = 122, [3] = 99 })[R[51]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[51]], ({ [0] = 20, [1] = 62, [2] = 121, [3] = 98 })[R[51]] })
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[51]], ({ [0] = 21, [1] = 63, [2] = 122, [3] = 99 })[R[51]] })
        for i = 1, game.initial_units() do
          R[119] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [1] = { [0] = 33, [1] = 7, [2] = 163, [3] = 218 }, [2] = { [0] = 55, [1] = 29, [2] = 185, [3] = 240 } })[R[119]][R[51]], ({ [0] = { [0] = 27, [1] = 69, [2] = 128, [3] = 105 }, [1] = { [0] = 14, [1] = 56, [2] = 115, [3] = 92 }, [2] = { [0] = 27, [1] = 69, [2] = 128, [3] = 105 } })[R[119]][R[51]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 52, [1] = 25, [2] = 184, [3] = 246 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] })
        game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 185, [3] = 247 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] })
        game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 186, [3] = 248 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 52, [1] = 25, [2] = 184, [3] = 246 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] })
        game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 185, [3] = 247 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] })
        game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 186, [3] = 248 })[R[51]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[51]] })
        for i = 1, game.initial_units() do
          R[120] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 33, [1] = 6, [2] = 165, [3] = 227 }, [1] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [2] = { [0] = 59, [1] = 32, [2] = 191, [3] = 253 } })[R[120]][R[51]], ({ [0] = { [0] = 3, [1] = 45, [2] = 109, [3] = 87 }, [1] = { [0] = 1, [1] = 43, [2] = 107, [3] = 85 }, [2] = { [0] = 16, [1] = 58, [2] = 122, [3] = 100 } })[R[120]][R[51]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[36] == 7 then
      game.create_tube({ ({ [0] = 48, [1] = 19, [2] = 184, [3] = 239 })[R[51]], ({ [0] = 16, [1] = 55, [2] = 119, [3] = 90 })[R[51]] })
      game.create_tube({ ({ [0] = 48, [1] = 19, [2] = 185, [3] = 239 })[R[51]], ({ [0] = 17, [1] = 56, [2] = 119, [3] = 91 })[R[51]] })
      if R[51] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
          for i = 1, game.initial_units() do
            R[121] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 46, [1] = 52, [2] = 40 })[R[121]], ({ [0] = 9, [1] = 9, [2] = 30 })[R[121]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[51] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
          for i = 1, game.initial_units() do
            R[122] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 17, [1] = 23, [2] = 11 })[R[122]], ({ [0] = 48, [1] = 48, [2] = 69 })[R[122]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[51] == 2 then
        if game.initial_units() == 0 then
          game.create_tube({ 186, 119 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 186, 119 })
          for i = 1, game.initial_units() do
            R[123] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 165, [1] = 170, [2] = 191 })[R[123]], ({ [0] = 109, [1] = 107, [2] = 122 })[R[123]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[51] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
          for i = 1, game.initial_units() do
            R[124] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 237, [1] = 243, [2] = 231 })[R[124]], ({ [0] = 83, [1] = 83, [2] = 104 })[R[124]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[51]", R[51])
      end
    else
      unseen("R[36]", R[36])
    end
    R[81] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 50, [1] = 23, [2] = 172, [3] = 244 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 48, [1] = 19, [2] = 170, [3] = 239 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 6, [1] = 45, [2] = 108, [3] = 88 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 20, [1] = 59, [2] = 111, [3] = 94 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 50, [1] = 23, [2] = 172, [3] = 244 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 48, [1] = 19, [2] = 170, [3] = 239 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 6, [1] = 45, [2] = 108, [3] = 88 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 20, [1] = 59, [2] = 111, [3] = 94 } })[R[81]][R[52]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 39, [1] = 12, [2] = 164, [3] = 233 }, [3] = { [0] = 58, [1] = 31, [2] = 172, [3] = 252 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 41, [1] = 12, [2] = 179, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 11, [1] = 42, [2] = 97, [3] = 82 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 23, [1] = 62, [2] = 126, [3] = 102 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    if R[81] == 0 or R[81] == 1 or R[81] == 2 or R[81] == 5 or R[81] == 6 or R[81] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = { [0] = 62, [1] = 42, [2] = 187, [3] = 253 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 42, [1] = 15, [2] = 167, [3] = 236 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 48, [1] = 21, [2] = 180, [3] = 242 }, [7] = { [0] = 41, [1] = 12, [2] = 180, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 18, [1] = 49, [2] = 104, [3] = 89 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [5] = { [0] = 23, [1] = 65, [2] = 124, [3] = 101 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      if R[81] == 0 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 39, [1] = 19, [2] = 164, [3] = 230 })[R[52]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 39, [1] = 19, [2] = 164, [3] = 230 })[R[52]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 39, [1] = 19, [2] = 164, [3] = 230 })[R[52]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[81] == 1 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[52]], ({ [0] = 28, [1] = 59, [2] = 114, [3] = 99 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[52]], ({ [0] = 28, [1] = 59, [2] = 114, [3] = 99 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[52]], ({ [0] = 28, [1] = 59, [2] = 114, [3] = 99 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[81] == 2 then
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
      elseif R[81] == 5 then
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
      elseif R[81] == 6 then
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
      elseif R[81] == 7 then
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
        unseen("R[81]", R[81])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 56, [1] = 29, [2] = 188, [3] = 250 }, [7] = { [0] = 56, [1] = 27, [2] = 188, [3] = 247 } })[R[81]][R[52]], ({ [0] = { [0] = 27, [1] = 65, [2] = 120, [3] = 103 }, [1] = { [0] = 36, [1] = 67, [2] = 122, [3] = 107 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      if R[81] == 2 or R[81] == 5 or R[81] == 6 or R[81] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 39, [1] = 12, [2] = 171, [3] = 233 }, [7] = { [0] = 57, [1] = 28, [2] = 171, [3] = 248 } })[R[81]][R[52]], ({ [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 25, [1] = 64, [2] = 119, [3] = 99 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[81] == 0 or R[81] == 1 then
      else
        unseen("R[81]", R[81])
      end
    elseif R[81] == 3 or R[81] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 } })[R[81]][R[52]], ({ [3] = { [0] = 23, [1] = 62, [2] = 110, [3] = 102 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      if R[81] == 3 then
        if R[52] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
        elseif R[52] == 0 or R[52] == 1 or R[52] == 3 then
        else
          unseen("R[52]", R[52])
        end
      elseif R[81] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[52]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[81]", R[81])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [3] = { [0] = 45, [1] = 18, [2] = 183, [3] = 239 }, [4] = { [0] = 52, [1] = 29, [2] = 183, [3] = 248 } })[R[81]][R[52]], ({ [3] = { [0] = 12, [1] = 51, [2] = 122, [3] = 91 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      if R[81] == 3 then
        if R[52] == 0 then
          if LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[52] == 1 then
          if LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[52] == 2 then
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
        elseif R[52] == 3 then
          if LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[52]", R[52])
        end
      elseif R[81] == 4 then
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
        unseen("R[81]", R[81])
      end
    else
      unseen("R[81]", R[81])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = { [0] = 39, [1] = 19, [2] = 164, [3] = 230 }, [1] = { [0] = 48, [1] = 21, [2] = 163, [3] = 238 }, [2] = { [0] = 59, [1] = 32, [2] = 184, [3] = 253 }, [3] = { [0] = 51, [1] = 24, [2] = 164, [3] = 245 }, [4] = { [0] = 33, [1] = 10, [2] = 164, [3] = 229 }, [5] = { [0] = 34, [1] = 8, [2] = 164, [3] = 219 }, [6] = { [0] = 31, [1] = 4, [2] = 163, [3] = 225 }, [7] = { [0] = 49, [1] = 20, [2] = 163, [3] = 240 } })[R[81]][R[52]], ({ [0] = { [0] = 29, [1] = 67, [2] = 122, [3] = 105 }, [1] = { [0] = 33, [1] = 64, [2] = 119, [3] = 104 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 6, [1] = 45, [2] = 114, [3] = 85 }, [4] = { [0] = 12, [1] = 50, [2] = 114, [3] = 92 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 29, [1] = 68, [2] = 119, [3] = 103 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 46, [1] = 26, [2] = 171, [3] = 237 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 40, [1] = 13, [2] = 182, [3] = 234 }, [4] = { [0] = 51, [1] = 28, [2] = 182, [3] = 247 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 59, [1] = 30, [2] = 170, [3] = 250 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 15, [1] = 54, [2] = 117, [3] = 97 }, [3] = { [0] = 13, [1] = 52, [2] = 118, [3] = 92 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 9, [1] = 51, [2] = 110, [3] = 87 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 20, [1] = 59, [2] = 124, [3] = 94 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 43, [1] = 16, [2] = 184, [3] = 237 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 17, [1] = 48, [2] = 103, [3] = 88 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 9, [1] = 48, [2] = 118, [3] = 88 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[3].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 60, [1] = 33, [2] = 176, [3] = 254 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 31, [2] = 176, [3] = 252 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 9, [1] = 48, [2] = 126, [3] = 88 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 184, [3] = 240 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 24, [1] = 63, [2] = 118, [3] = 103 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 184, [3] = 240 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 24, [1] = 63, [2] = 118, [3] = 103 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 40, [1] = 13, [2] = 176, [3] = 234 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "RoboSurveyor", [3] = "CargoTruck" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 40, [1] = 13, [2] = 177, [3] = 234 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 39, [1] = 13, [2] = 169, [3] = 224 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 43, [1] = 14, [2] = 175, [3] = 234 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 19, [1] = 58, [2] = 121, [3] = 101 }, [3] = { [0] = 13, [1] = 52, [2] = 122, [3] = 92 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 8, [1] = 50, [2] = 109, [3] = 86 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 20, [1] = 59, [2] = 121, [3] = 94 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [3] = { [0] = 46, [1] = 19, [2] = 179, [3] = 240 }, [4] = { [0] = 48, [1] = 25, [2] = 179, [3] = 244 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 38, [1] = 9, [2] = 184, [3] = 229 } })[R[81]][R[52]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 10, [1] = 41, [2] = 96, [3] = 81 }, [2] = { [0] = 20, [1] = 59, [2] = 122, [3] = 102 }, [3] = { [0] = 24, [1] = 63, [2] = 113, [3] = 103 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 12, [1] = 54, [2] = 118, [3] = 96 }, [7] = { [0] = 17, [1] = 56, [2] = 118, [3] = 91 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 60, [1] = 33, [2] = 176, [3] = 254 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 31, [2] = 176, [3] = 252 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 9, [1] = 48, [2] = 126, [3] = 88 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 184, [3] = 240 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 24, [1] = 63, [2] = 118, [3] = 103 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 46, [1] = 19, [2] = 176, [3] = 240 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 24, [1] = 63, [2] = 126, [3] = 103 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "RoboSurveyor", [3] = "CargoTruck" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 40, [1] = 13, [2] = 177, [3] = 234 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 39, [1] = 13, [2] = 169, [3] = 224 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 43, [1] = 14, [2] = 175, [3] = 234 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 19, [1] = 58, [2] = 121, [3] = 101 }, [3] = { [0] = 13, [1] = 52, [2] = 122, [3] = 92 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 8, [1] = 50, [2] = 109, [3] = 86 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 20, [1] = 59, [2] = 121, [3] = 94 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [3] = { [0] = 46, [1] = 19, [2] = 179, [3] = 240 }, [4] = { [0] = 48, [1] = 25, [2] = 179, [3] = 244 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 38, [1] = 9, [2] = 184, [3] = 229 } })[R[81]][R[52]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 10, [1] = 41, [2] = 96, [3] = 81 }, [2] = { [0] = 20, [1] = 59, [2] = 122, [3] = 102 }, [3] = { [0] = 24, [1] = 63, [2] = 113, [3] = 103 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 12, [1] = 54, [2] = 118, [3] = 96 }, [7] = { [0] = 17, [1] = 56, [2] = 118, [3] = 91 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 60, [1] = 33, [2] = 176, [3] = 254 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 31, [2] = 176, [3] = 252 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 9, [1] = 48, [2] = 126, [3] = 88 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboSurveyor", [3] = "ConVec" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 177, [3] = 240 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 39, [1] = 13, [2] = 169, [3] = 224 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 43, [1] = 14, [2] = 175, [3] = 234 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 19, [1] = 58, [2] = 121, [3] = 101 }, [3] = { [0] = 24, [1] = 63, [2] = 122, [3] = 103 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 8, [1] = 50, [2] = 109, [3] = 86 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 20, [1] = 59, [2] = 121, [3] = 94 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[81]][R[52]], player = players[3], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [3] = { [0] = 46, [1] = 19, [2] = 179, [3] = 240 }, [4] = { [0] = 48, [1] = 25, [2] = 179, [3] = 244 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 38, [1] = 9, [2] = 184, [3] = 229 } })[R[81]][R[52]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 10, [1] = 41, [2] = 96, [3] = 81 }, [2] = { [0] = 20, [1] = 59, [2] = 122, [3] = 102 }, [3] = { [0] = 24, [1] = 63, [2] = 113, [3] = 103 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 12, [1] = 54, [2] = 118, [3] = 96 }, [7] = { [0] = 17, [1] = 56, [2] = 118, [3] = 91 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 62, [1] = 42, [2] = 187, [3] = 253 }, [1] = { [0] = 56, [1] = 29, [2] = 171, [3] = 246 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 50, [1] = 23, [2] = 185, [3] = 244 }, [4] = { [0] = 54, [1] = 31, [2] = 185, [3] = 250 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 52, [1] = 23, [2] = 184, [3] = 243 } })[R[81]][R[52]], ({ [0] = { [0] = 24, [1] = 62, [2] = 117, [3] = 100 }, [1] = { [0] = 23, [1] = 54, [2] = 109, [3] = 94 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 10, [1] = 49, [2] = 109, [3] = 89 }, [4] = { [0] = 7, [1] = 45, [2] = 109, [3] = 87 }, [5] = { [0] = 25, [1] = 67, [2] = 126, [3] = 103 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 19, [1] = 58, [2] = 121, [3] = 93 } })[R[81]][R[52]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 22, [2] = 167, [3] = 233 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 42, [1] = 15, [2] = 167, [3] = 236 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 19, [1] = 58, [2] = 112, [3] = 98 }, [4] = { [0] = 10, [1] = 48, [2] = 112, [3] = 90 }, [5] = { [0] = 14, [1] = 56, [2] = 115, [3] = 92 }, [6] = { [0] = 7, [1] = 49, [2] = 113, [3] = 91 }, [7] = { [0] = 16, [1] = 55, [2] = 113, [3] = 90 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 43, [1] = 23, [2] = 168, [3] = 234 }, [1] = { [0] = 51, [1] = 24, [2] = 166, [3] = 241 }, [2] = { [0] = 43, [1] = 16, [2] = 168, [3] = 237 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 20, [1] = 59, [2] = 113, [3] = 99 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 15, [1] = 57, [2] = 116, [3] = 93 }, [6] = { [0] = 8, [1] = 50, [2] = 114, [3] = 92 }, [7] = { [0] = 17, [1] = 56, [2] = 114, [3] = 91 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 52, [1] = 25, [2] = 167, [3] = 242 }, [2] = { [0] = 44, [1] = 17, [2] = 169, [3] = 238 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 21, [1] = 60, [2] = 114, [3] = 100 }, [4] = { [0] = 12, [1] = 50, [2] = 114, [3] = 92 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 9, [1] = 51, [2] = 115, [3] = 93 }, [7] = { [0] = 18, [1] = 57, [2] = 115, [3] = 92 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 25, [2] = 170, [3] = 236 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 43, [1] = 16, [2] = 172, [3] = 237 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 8, [1] = 47, [2] = 110, [3] = 90 }, [3] = { [0] = 19, [1] = 58, [2] = 115, [3] = 98 }, [4] = { [0] = 13, [1] = 51, [2] = 115, [3] = 93 }, [5] = { [0] = 20, [1] = 62, [2] = 121, [3] = 98 }, [6] = { [0] = 10, [1] = 52, [2] = 116, [3] = 94 }, [7] = { [0] = 19, [1] = 58, [2] = 116, [3] = 93 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 26, [2] = 171, [3] = 237 }, [1] = { [0] = 54, [1] = 27, [2] = 169, [3] = 244 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 9, [1] = 48, [2] = 111, [3] = 91 }, [3] = { [0] = 15, [1] = 54, [2] = 116, [3] = 94 }, [4] = { [0] = 14, [1] = 52, [2] = 116, [3] = 94 }, [5] = { [0] = 21, [1] = 63, [2] = 122, [3] = 99 }, [6] = { [0] = 11, [1] = 53, [2] = 117, [3] = 95 }, [7] = { [0] = 20, [1] = 59, [2] = 117, [3] = 94 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 27, [2] = 172, [3] = 238 }, [1] = { [0] = 55, [1] = 28, [2] = 170, [3] = 245 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 41, [1] = 14, [2] = 173, [3] = 235 }, [7] = { [0] = 41, [1] = 12, [2] = 173, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 10, [1] = 49, [2] = 112, [3] = 92 }, [3] = { [0] = 16, [1] = 55, [2] = 120, [3] = 95 }, [4] = { [0] = 18, [1] = 56, [2] = 120, [3] = 98 }, [5] = { [0] = 22, [1] = 64, [2] = 123, [3] = 100 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 21, [1] = 60, [2] = 111, [3] = 95 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 28, [2] = 173, [3] = 239 }, [1] = { [0] = 56, [1] = 29, [2] = 171, [3] = 246 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 47, [1] = 21, [2] = 177, [3] = 232 }, [6] = { [0] = 42, [1] = 15, [2] = 174, [3] = 236 }, [7] = { [0] = 41, [1] = 12, [2] = 174, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 17, [1] = 56, [2] = 121, [3] = 96 }, [4] = { [0] = 19, [1] = 57, [2] = 121, [3] = 99 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 22, [1] = 61, [2] = 111, [3] = 96 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 47, [1] = 21, [2] = 177, [3] = 232 }, [6] = { [0] = 42, [1] = 15, [2] = 174, [3] = 236 }, [7] = { [0] = 41, [1] = 12, [2] = 174, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 15, [1] = 53, [2] = 108, [3] = 91 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 12, [1] = 51, [2] = 114, [3] = 94 }, [3] = { [0] = 18, [1] = 57, [2] = 122, [3] = 97 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 23, [1] = 62, [2] = 119, [3] = 97 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 41, [1] = 12, [2] = 175, [3] = 232 } })[R[81]][R[52]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 14, [1] = 45, [2] = 100, [3] = 85 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 19, [1] = 58, [2] = 123, [3] = 98 }, [4] = { [0] = 21, [1] = 59, [2] = 123, [3] = 101 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 24, [1] = 63, [2] = 111, [3] = 98 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 45, [1] = 18, [2] = 172, [3] = 239 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 44, [1] = 15, [2] = 175, [3] = 235 } })[R[81]][R[52]], ({ [0] = { [0] = 17, [1] = 55, [2] = 110, [3] = 93 }, [1] = { [0] = 15, [1] = 46, [2] = 101, [3] = 86 }, [2] = { [0] = 14, [1] = 53, [2] = 116, [3] = 96 }, [3] = { [0] = 15, [1] = 54, [2] = 124, [3] = 94 }, [4] = { [0] = 22, [1] = 60, [2] = 124, [3] = 102 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 45, [1] = 18, [2] = 175, [3] = 239 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 49, [1] = 23, [2] = 179, [3] = 234 }, [6] = { [0] = 44, [1] = 17, [2] = 176, [3] = 238 }, [7] = { [0] = 44, [1] = 15, [2] = 176, [3] = 235 } })[R[81]][R[52]], ({ [0] = { [0] = 18, [1] = 56, [2] = 111, [3] = 94 }, [1] = { [0] = 16, [1] = 47, [2] = 102, [3] = 87 }, [2] = { [0] = 15, [1] = 54, [2] = 117, [3] = 97 }, [3] = { [0] = 19, [1] = 58, [2] = 110, [3] = 98 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 46, [1] = 19, [2] = 175, [3] = 240 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 49, [1] = 23, [2] = 179, [3] = 234 }, [6] = { [0] = 44, [1] = 17, [2] = 176, [3] = 238 }, [7] = { [0] = 45, [1] = 16, [2] = 176, [3] = 236 } })[R[81]][R[52]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 47, [1] = 20, [2] = 175, [3] = 241 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [6] = { [0] = 45, [1] = 18, [2] = 177, [3] = 239 }, [7] = { [0] = 45, [1] = 16, [2] = 177, [3] = 236 } })[R[81]][R[52]], ({ [0] = { [0] = 23, [1] = 61, [2] = 116, [3] = 99 }, [1] = { [0] = 21, [1] = 52, [2] = 107, [3] = 92 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 19, [1] = 58, [2] = 126, [3] = 98 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 46, [1] = 19, [2] = 171, [3] = 240 }, [3] = { [0] = 48, [1] = 21, [2] = 176, [3] = 242 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [6] = { [0] = 45, [1] = 18, [2] = 177, [3] = 239 }, [7] = { [0] = 46, [1] = 17, [2] = 177, [3] = 237 } })[R[81]][R[52]], ({ [0] = { [0] = 24, [1] = 62, [2] = 117, [3] = 100 }, [1] = { [0] = 22, [1] = 53, [2] = 108, [3] = 93 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 110, [3] = 91 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 46, [1] = 19, [2] = 171, [3] = 240 }, [3] = { [0] = 48, [1] = 21, [2] = 176, [3] = 242 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 51, [1] = 25, [2] = 181, [3] = 236 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 46, [1] = 17, [2] = 179, [3] = 237 } })[R[81]][R[52]], ({ [0] = { [0] = 25, [1] = 63, [2] = 118, [3] = 101 }, [1] = { [0] = 23, [1] = 54, [2] = 109, [3] = 94 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 7, [1] = 49, [2] = 113, [3] = 91 }, [7] = { [0] = 26, [1] = 65, [2] = 113, [3] = 100 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 53, [1] = 33, [2] = 178, [3] = 244 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 49, [1] = 22, [2] = 176, [3] = 243 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 51, [1] = 25, [2] = 181, [3] = 236 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 47, [1] = 18, [2] = 179, [3] = 238 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 126, [3] = 91 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 8, [1] = 50, [2] = 114, [3] = 92 }, [7] = { [0] = 13, [1] = 52, [2] = 114, [3] = 87 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 54, [1] = 34, [2] = 179, [3] = 245 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 50, [1] = 23, [2] = 177, [3] = 244 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 47, [1] = 18, [2] = 179, [3] = 238 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 25, [1] = 56, [2] = 111, [3] = 96 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 12, [1] = 51, [2] = 110, [3] = 91 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 9, [1] = 51, [2] = 115, [3] = 93 }, [7] = { [0] = 26, [1] = 65, [2] = 115, [3] = 100 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 48, [1] = 21, [2] = 173, [3] = 242 }, [3] = { [0] = 51, [1] = 24, [2] = 177, [3] = 245 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 53, [1] = 27, [2] = 183, [3] = 238 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 48, [1] = 19, [2] = 179, [3] = 239 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 26, [1] = 57, [2] = 112, [3] = 97 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 111, [3] = 91 }, [4] = { [0] = 9, [1] = 47, [2] = 111, [3] = 89 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 10, [1] = 52, [2] = 116, [3] = 94 }, [7] = { [0] = 13, [1] = 52, [2] = 116, [3] = 87 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 56, [1] = 36, [2] = 181, [3] = 247 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 48, [1] = 21, [2] = 173, [3] = 242 }, [3] = { [0] = 52, [1] = 25, [2] = 177, [3] = 246 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 48, [1] = 19, [2] = 179, [3] = 239 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 31, [1] = 62, [2] = 117, [3] = 102 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 12, [1] = 51, [2] = 118, [3] = 91 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 11, [1] = 53, [2] = 117, [3] = 95 }, [7] = { [0] = 14, [1] = 53, [2] = 117, [3] = 88 } })[R[81]][R[52]] })
    game.create_tube({ ({ [0] = { [0] = 57, [1] = 37, [2] = 182, [3] = 248 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 49, [1] = 22, [2] = 174, [3] = 243 }, [3] = { [0] = 53, [1] = 26, [2] = 177, [3] = 247 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 48, [1] = 19, [2] = 183, [3] = 239 } })[R[81]][R[52]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 32, [1] = 63, [2] = 118, [3] = 103 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 126, [3] = 91 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 15, [1] = 54, [2] = 119, [3] = 89 } })[R[81]][R[52]] })
    if R[81] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 58, [1] = 38, [2] = 183, [3] = 249 })[R[52]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 59, [1] = 39, [2] = 184, [3] = 250 })[R[52]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[52]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 58, [1] = 38, [2] = 183, [3] = 249 })[R[52]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 59, [1] = 39, [2] = 184, [3] = 250 })[R[52]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[52]] })
        for i = 1, game.initial_units() do
          R[125] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 56, [1] = 36, [2] = 181, [3] = 247 }, [1] = { [0] = 43, [1] = 23, [2] = 168, [3] = 234 }, [2] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 } })[R[125]][R[52]], ({ [0] = { [0] = 14, [1] = 52, [2] = 107, [3] = 90 }, [1] = { [0] = 23, [1] = 61, [2] = 116, [3] = 99 }, [2] = { [0] = 26, [1] = 64, [2] = 119, [3] = 102 } })[R[125]][R[52]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[52]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[52]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[52]], ({ [0] = 34, [1] = 65, [2] = 120, [3] = 105 })[R[52]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[52]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[52]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[52]], ({ [0] = 34, [1] = 65, [2] = 120, [3] = 105 })[R[52]] })
        for i = 1, game.initial_units() do
          R[126] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 49, [1] = 22, [2] = 164, [3] = 239 }, [1] = { [0] = 51, [1] = 24, [2] = 166, [3] = 241 }, [2] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 } })[R[126]][R[52]], ({ [0] = { [0] = 28, [1] = 59, [2] = 114, [3] = 99 }, [1] = { [0] = 30, [1] = 61, [2] = 116, [3] = 101 }, [2] = { [0] = 22, [1] = 53, [2] = 108, [3] = 93 } })[R[126]][R[52]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[127] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 40, [1] = 13, [2] = 165, [3] = 234 }, [1] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [2] = { [0] = 58, [1] = 31, [2] = 183, [3] = 252 } })[R[127]][R[52]], ({ [0] = { [0] = 5, [1] = 44, [2] = 107, [3] = 87 }, [1] = { [0] = 21, [1] = 60, [2] = 123, [3] = 103 }, [2] = { [0] = 14, [1] = 53, [2] = 116, [3] = 96 } })[R[127]][R[52]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 3 then
      game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 178, [3] = 247 })[R[52]], ({ [0] = 19, [1] = 58, [2] = 111, [3] = 98 })[R[52]] })
      game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 178, [3] = 248 })[R[52]], ({ [0] = 19, [1] = 58, [2] = 112, [3] = 98 })[R[52]] })
      game.create_tube({ ({ [0] = 55, [1] = 28, [2] = 178, [3] = 249 })[R[52]], ({ [0] = 19, [1] = 58, [2] = 118, [3] = 98 })[R[52]] })
      game.create_tube({ ({ [0] = 56, [1] = 29, [2] = 178, [3] = 250 })[R[52]], ({ [0] = 15, [1] = 54, [2] = 126, [3] = 94 })[R[52]] })
      game.create_tube({ ({ [0] = 56, [1] = 29, [2] = 179, [3] = 250 })[R[52]], ({ [0] = 19, [1] = 58, [2] = 112, [3] = 98 })[R[52]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 179, [3] = 251 })[R[52]], ({ [0] = 15, [1] = 54, [2] = 118, [3] = 94 })[R[52]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 179, [3] = 251 })[R[52]], ({ [0] = 16, [1] = 55, [2] = 126, [3] = 95 })[R[52]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[52]], ({ [0] = 17, [1] = 56, [2] = 112, [3] = 96 })[R[52]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[52]], ({ [0] = 18, [1] = 57, [2] = 118, [3] = 97 })[R[52]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[52]], ({ [0] = 19, [1] = 58, [2] = 126, [3] = 98 })[R[52]] })
      game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 181, [3] = 252 })[R[52]], ({ [0] = 19, [1] = 58, [2] = 117, [3] = 98 })[R[52]] })
      game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 181, [3] = 252 })[R[52]], ({ [0] = 20, [1] = 59, [2] = 118, [3] = 99 })[R[52]] })
      if R[52] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 58, 21 })
          for i = 1, game.initial_units() do
            R[128] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 51, [1] = 52, [2] = 39 })[R[128]], ({ [0] = 15, [1] = 22, [2] = 19 })[R[128]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 58, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[52] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 31, 60 })
          for i = 1, game.initial_units() do
            R[129] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 24, [1] = 25, [2] = 12 })[R[129]], ({ [0] = 54, [1] = 61, [2] = 58 })[R[129]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 31, 60 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[52] == 2 then
        if game.initial_units() == 0 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
          for i = 1, game.initial_units() do
            R[130] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 176, [1] = 167, [2] = 175 })[R[130]], ({ [0] = 109, [1] = 117, [2] = 112 })[R[130]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[52] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 252, 100 })
          for i = 1, game.initial_units() do
            R[131] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 245, [1] = 246, [2] = 233 })[R[131]], ({ [0] = 94, [1] = 101, [2] = 98 })[R[131]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 252, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[52]", R[52])
      end
    elseif R[81] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[52]], ({ [0] = 9, [1] = 47, [2] = 111, [3] = 89 })[R[52]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[52]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[52]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[52]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[52]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[52]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[52]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[52]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[52]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[52]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[52]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[52]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[52]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 17, [1] = 55, [2] = 119, [3] = 97 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 18, [1] = 56, [2] = 120, [3] = 98 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[52]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[52]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[52]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[52]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 13, [1] = 51, [2] = 115, [3] = 93 })[R[52]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 14, [1] = 52, [2] = 116, [3] = 94 })[R[52]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[52]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[52]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[52]], ({ [0] = 9, [1] = 47, [2] = 111, [3] = 89 })[R[52]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[52]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[52]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[52]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[52]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[52]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[52]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[52]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[52]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[52]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[52]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[52]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[52]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 17, [1] = 55, [2] = 119, [3] = 97 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 18, [1] = 56, [2] = 120, [3] = 98 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[52]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[52]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[52]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[52]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[52]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[52]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[52]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 13, [1] = 51, [2] = 115, [3] = 93 })[R[52]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 14, [1] = 52, [2] = 116, [3] = 94 })[R[52]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[52]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[52]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[52]] })
        for i = 1, game.initial_units() do
          R[132] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [1] = { [0] = 36, [1] = 13, [2] = 167, [3] = 232 }, [2] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 } })[R[132]][R[52]], ({ [0] = { [0] = 7, [1] = 45, [2] = 109, [3] = 87 }, [1] = { [0] = 15, [1] = 53, [2] = 117, [3] = 95 }, [2] = { [0] = 10, [1] = 48, [2] = 112, [3] = 90 } })[R[132]][R[52]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[52]], ({ [0] = 20, [1] = 62, [2] = 121, [3] = 98 })[R[52]] })
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[52]], ({ [0] = 21, [1] = 63, [2] = 122, [3] = 99 })[R[52]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[52]], ({ [0] = 20, [1] = 62, [2] = 121, [3] = 98 })[R[52]] })
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[52]], ({ [0] = 21, [1] = 63, [2] = 122, [3] = 99 })[R[52]] })
        for i = 1, game.initial_units() do
          R[133] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [1] = { [0] = 33, [1] = 7, [2] = 163, [3] = 218 }, [2] = { [0] = 55, [1] = 29, [2] = 185, [3] = 240 } })[R[133]][R[52]], ({ [0] = { [0] = 27, [1] = 69, [2] = 128, [3] = 105 }, [1] = { [0] = 14, [1] = 56, [2] = 115, [3] = 92 }, [2] = { [0] = 27, [1] = 69, [2] = 128, [3] = 105 } })[R[133]][R[52]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 52, [1] = 25, [2] = 184, [3] = 246 })[R[52]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[52]] })
        game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 185, [3] = 247 })[R[52]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[52]] })
        game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 186, [3] = 248 })[R[52]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[52]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 52, [1] = 25, [2] = 184, [3] = 246 })[R[52]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[52]] })
        game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 185, [3] = 247 })[R[52]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[52]] })
        game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 186, [3] = 248 })[R[52]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[52]] })
        for i = 1, game.initial_units() do
          R[134] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 33, [1] = 6, [2] = 165, [3] = 227 }, [1] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [2] = { [0] = 59, [1] = 32, [2] = 191, [3] = 253 } })[R[134]][R[52]], ({ [0] = { [0] = 3, [1] = 45, [2] = 109, [3] = 87 }, [1] = { [0] = 1, [1] = 43, [2] = 107, [3] = 85 }, [2] = { [0] = 16, [1] = 58, [2] = 122, [3] = 100 } })[R[134]][R[52]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 7 then
      game.create_tube({ ({ [0] = 48, [1] = 19, [2] = 184, [3] = 239 })[R[52]], ({ [0] = 16, [1] = 55, [2] = 119, [3] = 90 })[R[52]] })
      game.create_tube({ ({ [0] = 48, [1] = 19, [2] = 185, [3] = 239 })[R[52]], ({ [0] = 17, [1] = 56, [2] = 119, [3] = 91 })[R[52]] })
      if R[52] == 0 then
        if game.initial_units() == 0 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
          for i = 1, game.initial_units() do
            R[135] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 46, [1] = 52, [2] = 40 })[R[135]], ({ [0] = 9, [1] = 9, [2] = 30 })[R[135]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[52] == 1 then
        if game.initial_units() == 0 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
          for i = 1, game.initial_units() do
            R[136] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 17, [1] = 23, [2] = 11 })[R[136]], ({ [0] = 48, [1] = 48, [2] = 69 })[R[136]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[52] == 2 then
        if game.initial_units() == 0 then
          game.create_tube({ 186, 119 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 186, 119 })
          for i = 1, game.initial_units() do
            R[137] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 165, [1] = 170, [2] = 191 })[R[137]], ({ [0] = 109, [1] = 107, [2] = 122 })[R[137]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[52] == 3 then
        if game.initial_units() == 0 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
          for i = 1, game.initial_units() do
            R[138] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 237, [1] = 243, [2] = 231 })[R[138]], ({ [0] = 83, [1] = 83, [2] = 104 })[R[138]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[52]", R[52])
      end
    else
      unseen("R[81]", R[81])
    end
    R[139] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 50, [1] = 23, [2] = 172, [3] = 244 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 48, [1] = 19, [2] = 170, [3] = 239 } })[R[139]][R[96]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 6, [1] = 45, [2] = 108, [3] = 88 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 20, [1] = 59, [2] = 111, [3] = 94 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
    players[4]:center_view({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 50, [1] = 23, [2] = 172, [3] = 244 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 48, [1] = 19, [2] = 170, [3] = 239 } })[R[139]][R[96]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 6, [1] = 45, [2] = 108, [3] = 88 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 20, [1] = 59, [2] = 111, [3] = 94 } })[R[139]][R[96]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 39, [1] = 12, [2] = 164, [3] = 233 }, [3] = { [0] = 58, [1] = 31, [2] = 172, [3] = 252 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 41, [1] = 12, [2] = 179, [3] = 232 } })[R[139]][R[96]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 11, [1] = 42, [2] = 97, [3] = 82 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 23, [1] = 62, [2] = 126, [3] = 102 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
    if R[139] == 0 or R[139] == 1 or R[139] == 2 or R[139] == 5 or R[139] == 6 or R[139] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = { [0] = 62, [1] = 42, [2] = 187, [3] = 253 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 42, [1] = 15, [2] = 167, [3] = 236 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 48, [1] = 21, [2] = 180, [3] = 242 }, [7] = { [0] = 41, [1] = 12, [2] = 180, [3] = 232 } })[R[139]][R[96]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 18, [1] = 49, [2] = 104, [3] = 89 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [5] = { [0] = 23, [1] = 65, [2] = 124, [3] = 101 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      if R[139] == 0 then
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
      elseif R[139] == 1 then
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
      elseif R[139] == 2 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[96]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[96]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[96]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[96]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 51, [1] = 24, [2] = 176, [3] = 245 })[R[96]], ({ [0] = 11, [1] = 50, [2] = 113, [3] = 93 })[R[96]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[139] == 5 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[96]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[96]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[96]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[96]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[96]], ({ [0] = 16, [1] = 58, [2] = 117, [3] = 94 })[R[96]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[139] == 6 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[96]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[96]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[96]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[96]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 56, [1] = 29, [2] = 188, [3] = 250 })[R[96]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[96]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[139] == 7 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[96]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[96]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[96]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[96]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 56, [1] = 27, [2] = 188, [3] = 247 })[R[96]], ({ [0] = 13, [1] = 52, [2] = 119, [3] = 87 })[R[96]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[139]", R[139])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = { [0] = 39, [1] = 19, [2] = 164, [3] = 230 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 39, [1] = 12, [2] = 171, [3] = 233 }, [7] = { [0] = 57, [1] = 28, [2] = 171, [3] = 248 } })[R[139]][R[96]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 28, [1] = 59, [2] = 114, [3] = 99 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 25, [1] = 64, [2] = 119, [3] = 99 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      if R[139] == 2 or R[139] == 5 or R[139] == 6 or R[139] == 7 then
      elseif R[139] == 0 or R[139] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 } })[R[139]][R[96]], ({ [0] = { [0] = 27, [1] = 65, [2] = 120, [3] = 103 }, [1] = { [0] = 36, [1] = 67, [2] = 122, [3] = 107 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[139]", R[139])
      end
    elseif R[139] == 3 or R[139] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 } })[R[139]][R[96]], ({ [3] = { [0] = 23, [1] = 62, [2] = 110, [3] = 102 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      if R[139] == 3 then
        if R[96] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { 183, 112 }, direction = "East", lights = false, exact = true }[1]
        elseif R[96] == 0 or R[96] == 1 or R[96] == 3 then
        else
          unseen("R[96]", R[96])
        end
      elseif R[139] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[96]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[96]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[139]", R[139])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [3] = { [0] = 45, [1] = 18, [2] = 183, [3] = 239 }, [4] = { [0] = 52, [1] = 29, [2] = 183, [3] = 248 } })[R[139]][R[96]], ({ [3] = { [0] = 12, [1] = 51, [2] = 122, [3] = 91 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      if R[139] == 3 then
        if R[96] == 0 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { 56, 12 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif R[96] == 1 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { 29, 51 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif R[96] == 2 then
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
        elseif R[96] == 3 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { 250, 91 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        else
          unseen("R[96]", R[96])
        end
      elseif R[139] == 4 then
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
        unseen("R[139]", R[139])
      end
    else
      unseen("R[139]", R[139])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = { [0] = 39, [1] = 19, [2] = 164, [3] = 230 }, [1] = { [0] = 48, [1] = 21, [2] = 163, [3] = 238 }, [2] = { [0] = 59, [1] = 32, [2] = 184, [3] = 253 }, [3] = { [0] = 51, [1] = 24, [2] = 164, [3] = 245 }, [4] = { [0] = 33, [1] = 10, [2] = 164, [3] = 229 }, [5] = { [0] = 34, [1] = 8, [2] = 164, [3] = 219 }, [6] = { [0] = 31, [1] = 4, [2] = 163, [3] = 225 }, [7] = { [0] = 49, [1] = 20, [2] = 163, [3] = 240 } })[R[139]][R[96]], ({ [0] = { [0] = 29, [1] = 67, [2] = 122, [3] = 105 }, [1] = { [0] = 33, [1] = 64, [2] = 119, [3] = 104 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 6, [1] = 45, [2] = 114, [3] = 85 }, [4] = { [0] = 12, [1] = 50, [2] = 114, [3] = 92 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 29, [1] = 68, [2] = 119, [3] = 103 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 46, [1] = 26, [2] = 171, [3] = 237 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 40, [1] = 13, [2] = 182, [3] = 234 }, [4] = { [0] = 51, [1] = 28, [2] = 182, [3] = 247 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 59, [1] = 30, [2] = 170, [3] = 250 } })[R[139]][R[96]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 15, [1] = 54, [2] = 117, [3] = 97 }, [3] = { [0] = 13, [1] = 52, [2] = 118, [3] = 92 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 9, [1] = 51, [2] = 110, [3] = 87 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 20, [1] = 59, [2] = 124, [3] = 94 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 43, [1] = 16, [2] = 184, [3] = 237 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[139]][R[96]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 17, [1] = 48, [2] = 103, [3] = 88 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 9, [1] = 48, [2] = 118, [3] = 88 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[4].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[139]][R[96]], player = players[4], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 60, [1] = 33, [2] = 176, [3] = 254 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[139]][R[96]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[139]][R[96]], player = players[4], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 31, [2] = 176, [3] = 252 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[139]][R[96]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 9, [1] = 48, [2] = 126, [3] = 88 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[139]][R[96]], player = players[4], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 184, [3] = 240 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[139]][R[96]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 24, [1] = 63, [2] = 118, [3] = 103 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[139]][R[96]], player = players[4], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 184, [3] = 240 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[139]][R[96]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 24, [1] = 63, [2] = 118, [3] = 103 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[139]][R[96]], player = players[4], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 40, [1] = 13, [2] = 176, [3] = 234 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[139]][R[96]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "RoboSurveyor", [3] = "CargoTruck" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[139]][R[96]], player = players[4], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 40, [1] = 13, [2] = 177, [3] = 234 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 39, [1] = 13, [2] = 169, [3] = 224 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 43, [1] = 14, [2] = 175, [3] = 234 } })[R[139]][R[96]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 19, [1] = 58, [2] = 121, [3] = 101 }, [3] = { [0] = 13, [1] = 52, [2] = 122, [3] = 92 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 8, [1] = 50, [2] = 109, [3] = 86 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 20, [1] = 59, [2] = 121, [3] = 94 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[139]][R[96]], player = players[4], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [3] = { [0] = 46, [1] = 19, [2] = 179, [3] = 240 }, [4] = { [0] = 48, [1] = 25, [2] = 179, [3] = 244 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 38, [1] = 9, [2] = 184, [3] = 229 } })[R[139]][R[96]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 10, [1] = 41, [2] = 96, [3] = 81 }, [2] = { [0] = 20, [1] = 59, [2] = 122, [3] = 102 }, [3] = { [0] = 24, [1] = 63, [2] = 113, [3] = 103 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 12, [1] = 54, [2] = 118, [3] = 96 }, [7] = { [0] = 17, [1] = 56, [2] = 118, [3] = 91 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[4].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[139]][R[96]], player = players[4], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 60, [1] = 33, [2] = 176, [3] = 254 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[139]][R[96]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[139]][R[96]], player = players[4], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 31, [2] = 176, [3] = 252 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[139]][R[96]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 9, [1] = 48, [2] = 126, [3] = 88 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [1] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [2] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" } })[R[139]][R[96]], player = players[4], at = { ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 47, [1] = 20, [2] = 162, [3] = 237 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 184, [3] = 240 }, [4] = { [0] = 53, [1] = 30, [2] = 184, [3] = 249 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 36, [1] = 9, [2] = 168, [3] = 230 }, [7] = { [0] = 59, [1] = 30, [2] = 168, [3] = 250 } })[R[139]][R[96]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 24, [1] = 63, [2] = 118, [3] = 103 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 11, [1] = 53, [2] = 112, [3] = 89 }, [6] = { [0] = 18, [1] = 60, [2] = 124, [3] = 102 }, [7] = { [0] = 22, [1] = 61, [2] = 124, [3] = 96 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 46, [1] = 19, [2] = 176, [3] = 240 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[139]][R[96]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 24, [1] = 63, [2] = 126, [3] = 103 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "RoboSurveyor", [3] = "CargoTruck" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[139]][R[96]], player = players[4], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 40, [1] = 13, [2] = 177, [3] = 234 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 39, [1] = 13, [2] = 169, [3] = 224 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 43, [1] = 14, [2] = 175, [3] = 234 } })[R[139]][R[96]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 19, [1] = 58, [2] = 121, [3] = 101 }, [3] = { [0] = 13, [1] = 52, [2] = 122, [3] = 92 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 8, [1] = 50, [2] = 109, [3] = 86 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 20, [1] = 59, [2] = 121, [3] = 94 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[139]][R[96]], player = players[4], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [3] = { [0] = 46, [1] = 19, [2] = 179, [3] = 240 }, [4] = { [0] = 48, [1] = 25, [2] = 179, [3] = 244 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 38, [1] = 9, [2] = 184, [3] = 229 } })[R[139]][R[96]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 10, [1] = 41, [2] = 96, [3] = 81 }, [2] = { [0] = 20, [1] = 59, [2] = 122, [3] = 102 }, [3] = { [0] = 24, [1] = 63, [2] = 113, [3] = 103 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 12, [1] = 54, [2] = 118, [3] = 96 }, [7] = { [0] = 17, [1] = 56, [2] = 118, [3] = 91 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[4].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[139]][R[96]], player = players[4], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 60, [1] = 33, [2] = 176, [3] = 254 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[139]][R[96]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 13, [1] = 52, [2] = 126, [3] = 92 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [1] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [2] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [3] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor" }, [4] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [5] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [6] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" }, [7] = { [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "ConVec" } })[R[139]][R[96]], player = players[4], at = { ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 37, [1] = 10, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 31, [2] = 176, [3] = 252 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 58, [1] = 29, [2] = 183, [3] = 249 } })[R[139]][R[96]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 19, [1] = 50, [2] = 105, [3] = 90 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 9, [1] = 48, [2] = 126, [3] = 88 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 14, [1] = 53, [2] = 111, [3] = 88 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [1] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [2] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboSurveyor", [3] = "ConVec" }, [4] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [5] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [6] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" }, [7] = { [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "RoboSurveyor" } })[R[139]][R[96]], player = players[4], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 55, [1] = 28, [2] = 180, [3] = 249 }, [3] = { [0] = 46, [1] = 19, [2] = 177, [3] = 240 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 39, [1] = 13, [2] = 169, [3] = 224 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 43, [1] = 14, [2] = 175, [3] = 234 } })[R[139]][R[96]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 19, [1] = 58, [2] = 121, [3] = 101 }, [3] = { [0] = 24, [1] = 63, [2] = 122, [3] = 103 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 8, [1] = 50, [2] = 109, [3] = 86 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 20, [1] = 59, [2] = 121, [3] = 94 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec" }, [4] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [5] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" } })[R[139]][R[96]], player = players[4], at = { ({ [0] = { [0] = 41, [1] = 21, [2] = 166, [3] = 232 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 51, [1] = 24, [2] = 176, [3] = 245 }, [3] = { [0] = 46, [1] = 19, [2] = 179, [3] = 240 }, [4] = { [0] = 48, [1] = 25, [2] = 179, [3] = 244 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 38, [1] = 9, [2] = 184, [3] = 229 } })[R[139]][R[96]], ({ [0] = { [0] = 13, [1] = 51, [2] = 106, [3] = 89 }, [1] = { [0] = 10, [1] = 41, [2] = 96, [3] = 81 }, [2] = { [0] = 20, [1] = 59, [2] = 122, [3] = 102 }, [3] = { [0] = 24, [1] = 63, [2] = 113, [3] = 103 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 12, [1] = 54, [2] = 118, [3] = 96 }, [7] = { [0] = 17, [1] = 56, [2] = 118, [3] = 91 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = { [0] = 62, [1] = 42, [2] = 187, [3] = 253 }, [1] = { [0] = 56, [1] = 29, [2] = 171, [3] = 246 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 50, [1] = 23, [2] = 185, [3] = 244 }, [4] = { [0] = 54, [1] = 31, [2] = 185, [3] = 250 }, [5] = { [0] = 40, [1] = 14, [2] = 170, [3] = 225 }, [6] = { [0] = 52, [1] = 25, [2] = 184, [3] = 246 }, [7] = { [0] = 52, [1] = 23, [2] = 184, [3] = 243 } })[R[139]][R[96]], ({ [0] = { [0] = 24, [1] = 62, [2] = 117, [3] = 100 }, [1] = { [0] = 23, [1] = 54, [2] = 109, [3] = 94 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 10, [1] = 49, [2] = 109, [3] = 89 }, [4] = { [0] = 7, [1] = 45, [2] = 109, [3] = 87 }, [5] = { [0] = 25, [1] = 67, [2] = 126, [3] = 103 }, [6] = { [0] = 15, [1] = 57, [2] = 121, [3] = 99 }, [7] = { [0] = 19, [1] = 58, [2] = 121, [3] = 93 } })[R[139]][R[96]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 22, [2] = 167, [3] = 233 }, [1] = { [0] = 50, [1] = 23, [2] = 165, [3] = 240 }, [2] = { [0] = 42, [1] = 15, [2] = 167, [3] = 236 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[139]][R[96]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 19, [1] = 58, [2] = 112, [3] = 98 }, [4] = { [0] = 10, [1] = 48, [2] = 112, [3] = 90 }, [5] = { [0] = 14, [1] = 56, [2] = 115, [3] = 92 }, [6] = { [0] = 7, [1] = 49, [2] = 113, [3] = 91 }, [7] = { [0] = 16, [1] = 55, [2] = 113, [3] = 90 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 43, [1] = 23, [2] = 168, [3] = 234 }, [1] = { [0] = 51, [1] = 24, [2] = 166, [3] = 241 }, [2] = { [0] = 43, [1] = 16, [2] = 168, [3] = 237 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[139]][R[96]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 20, [1] = 59, [2] = 113, [3] = 99 }, [4] = { [0] = 11, [1] = 49, [2] = 113, [3] = 91 }, [5] = { [0] = 15, [1] = 57, [2] = 116, [3] = 93 }, [6] = { [0] = 8, [1] = 50, [2] = 114, [3] = 92 }, [7] = { [0] = 17, [1] = 56, [2] = 114, [3] = 91 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 44, [1] = 24, [2] = 169, [3] = 235 }, [1] = { [0] = 52, [1] = 25, [2] = 167, [3] = 242 }, [2] = { [0] = 44, [1] = 17, [2] = 169, [3] = 238 }, [3] = { [0] = 42, [1] = 15, [2] = 172, [3] = 236 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[139]][R[96]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 21, [1] = 60, [2] = 114, [3] = 100 }, [4] = { [0] = 12, [1] = 50, [2] = 114, [3] = 92 }, [5] = { [0] = 16, [1] = 58, [2] = 117, [3] = 94 }, [6] = { [0] = 9, [1] = 51, [2] = 115, [3] = 93 }, [7] = { [0] = 18, [1] = 57, [2] = 115, [3] = 92 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 25, [2] = 170, [3] = 236 }, [1] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 43, [1] = 16, [2] = 172, [3] = 237 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[139]][R[96]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 8, [1] = 47, [2] = 110, [3] = 90 }, [3] = { [0] = 19, [1] = 58, [2] = 115, [3] = 98 }, [4] = { [0] = 13, [1] = 51, [2] = 115, [3] = 93 }, [5] = { [0] = 20, [1] = 62, [2] = 121, [3] = 98 }, [6] = { [0] = 10, [1] = 52, [2] = 116, [3] = 94 }, [7] = { [0] = 19, [1] = 58, [2] = 116, [3] = 93 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 26, [2] = 171, [3] = 237 }, [1] = { [0] = 54, [1] = 27, [2] = 169, [3] = 244 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [7] = { [0] = 41, [1] = 12, [2] = 170, [3] = 232 } })[R[139]][R[96]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 9, [1] = 48, [2] = 111, [3] = 91 }, [3] = { [0] = 15, [1] = 54, [2] = 116, [3] = 94 }, [4] = { [0] = 14, [1] = 52, [2] = 116, [3] = 94 }, [5] = { [0] = 21, [1] = 63, [2] = 122, [3] = 99 }, [6] = { [0] = 11, [1] = 53, [2] = 117, [3] = 95 }, [7] = { [0] = 20, [1] = 59, [2] = 117, [3] = 94 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 27, [2] = 172, [3] = 238 }, [1] = { [0] = 55, [1] = 28, [2] = 170, [3] = 245 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 44, [1] = 18, [2] = 174, [3] = 229 }, [6] = { [0] = 41, [1] = 14, [2] = 173, [3] = 235 }, [7] = { [0] = 41, [1] = 12, [2] = 173, [3] = 232 } })[R[139]][R[96]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 10, [1] = 49, [2] = 112, [3] = 92 }, [3] = { [0] = 16, [1] = 55, [2] = 120, [3] = 95 }, [4] = { [0] = 18, [1] = 56, [2] = 120, [3] = 98 }, [5] = { [0] = 22, [1] = 64, [2] = 123, [3] = 100 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 21, [1] = 60, [2] = 111, [3] = 95 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 28, [2] = 173, [3] = 239 }, [1] = { [0] = 56, [1] = 29, [2] = 171, [3] = 246 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 47, [1] = 21, [2] = 177, [3] = 232 }, [6] = { [0] = 42, [1] = 15, [2] = 174, [3] = 236 }, [7] = { [0] = 41, [1] = 12, [2] = 174, [3] = 232 } })[R[139]][R[96]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 17, [1] = 56, [2] = 121, [3] = 96 }, [4] = { [0] = 19, [1] = 57, [2] = 121, [3] = 99 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 22, [1] = 61, [2] = 111, [3] = 96 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 47, [1] = 21, [2] = 177, [3] = 232 }, [6] = { [0] = 42, [1] = 15, [2] = 174, [3] = 236 }, [7] = { [0] = 41, [1] = 12, [2] = 174, [3] = 232 } })[R[139]][R[96]], ({ [0] = { [0] = 15, [1] = 53, [2] = 108, [3] = 91 }, [1] = { [0] = 13, [1] = 44, [2] = 99, [3] = 84 }, [2] = { [0] = 12, [1] = 51, [2] = 114, [3] = 94 }, [3] = { [0] = 18, [1] = 57, [2] = 122, [3] = 97 }, [4] = { [0] = 20, [1] = 58, [2] = 122, [3] = 100 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 23, [1] = 62, [2] = 119, [3] = 97 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 44, [1] = 17, [2] = 172, [3] = 238 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 41, [1] = 12, [2] = 175, [3] = 232 } })[R[139]][R[96]], ({ [0] = { [0] = 16, [1] = 54, [2] = 109, [3] = 92 }, [1] = { [0] = 14, [1] = 45, [2] = 100, [3] = 85 }, [2] = { [0] = 13, [1] = 52, [2] = 115, [3] = 95 }, [3] = { [0] = 19, [1] = 58, [2] = 123, [3] = 98 }, [4] = { [0] = 21, [1] = 59, [2] = 123, [3] = 101 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 24, [1] = 63, [2] = 111, [3] = 98 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 45, [1] = 18, [2] = 172, [3] = 239 }, [4] = { [0] = 41, [1] = 18, [2] = 172, [3] = 237 }, [5] = { [0] = 48, [1] = 22, [2] = 178, [3] = 233 }, [6] = { [0] = 43, [1] = 16, [2] = 175, [3] = 237 }, [7] = { [0] = 44, [1] = 15, [2] = 175, [3] = 235 } })[R[139]][R[96]], ({ [0] = { [0] = 17, [1] = 55, [2] = 110, [3] = 93 }, [1] = { [0] = 15, [1] = 46, [2] = 101, [3] = 86 }, [2] = { [0] = 14, [1] = 53, [2] = 116, [3] = 96 }, [3] = { [0] = 15, [1] = 54, [2] = 124, [3] = 94 }, [4] = { [0] = 22, [1] = 60, [2] = 124, [3] = 102 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 45, [1] = 18, [2] = 175, [3] = 239 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 49, [1] = 23, [2] = 179, [3] = 234 }, [6] = { [0] = 44, [1] = 17, [2] = 176, [3] = 238 }, [7] = { [0] = 44, [1] = 15, [2] = 176, [3] = 235 } })[R[139]][R[96]], ({ [0] = { [0] = 18, [1] = 56, [2] = 111, [3] = 94 }, [1] = { [0] = 16, [1] = 47, [2] = 102, [3] = 87 }, [2] = { [0] = 15, [1] = 54, [2] = 117, [3] = 97 }, [3] = { [0] = 19, [1] = 58, [2] = 110, [3] = 98 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 57, [1] = 30, [2] = 172, [3] = 247 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 46, [1] = 19, [2] = 175, [3] = 240 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 49, [1] = 23, [2] = 179, [3] = 234 }, [6] = { [0] = 44, [1] = 17, [2] = 176, [3] = 238 }, [7] = { [0] = 45, [1] = 16, [2] = 176, [3] = 236 } })[R[139]][R[96]], ({ [0] = { [0] = 22, [1] = 60, [2] = 115, [3] = 98 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 16, [1] = 55, [2] = 118, [3] = 98 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [3] = { [0] = 47, [1] = 20, [2] = 175, [3] = 241 }, [4] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 }, [5] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [6] = { [0] = 45, [1] = 18, [2] = 177, [3] = 239 }, [7] = { [0] = 45, [1] = 16, [2] = 177, [3] = 236 } })[R[139]][R[96]], ({ [0] = { [0] = 23, [1] = 61, [2] = 116, [3] = 99 }, [1] = { [0] = 21, [1] = 52, [2] = 107, [3] = 92 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 19, [1] = 58, [2] = 126, [3] = 98 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 5, [1] = 47, [2] = 111, [3] = 89 }, [7] = { [0] = 26, [1] = 65, [2] = 111, [3] = 100 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 46, [1] = 19, [2] = 171, [3] = 240 }, [3] = { [0] = 48, [1] = 21, [2] = 176, [3] = 242 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [6] = { [0] = 45, [1] = 18, [2] = 177, [3] = 239 }, [7] = { [0] = 46, [1] = 17, [2] = 177, [3] = 237 } })[R[139]][R[96]], ({ [0] = { [0] = 24, [1] = 62, [2] = 117, [3] = 100 }, [1] = { [0] = 22, [1] = 53, [2] = 108, [3] = 93 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 110, [3] = 91 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 13, [1] = 52, [2] = 119, [3] = 87 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 50, [1] = 30, [2] = 175, [3] = 241 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 46, [1] = 19, [2] = 171, [3] = 240 }, [3] = { [0] = 48, [1] = 21, [2] = 176, [3] = 242 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 51, [1] = 25, [2] = 181, [3] = 236 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 46, [1] = 17, [2] = 179, [3] = 237 } })[R[139]][R[96]], ({ [0] = { [0] = 25, [1] = 63, [2] = 118, [3] = 101 }, [1] = { [0] = 23, [1] = 54, [2] = 109, [3] = 94 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 19, [1] = 58, [2] = 118, [3] = 98 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 7, [1] = 49, [2] = 113, [3] = 91 }, [7] = { [0] = 26, [1] = 65, [2] = 113, [3] = 100 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 53, [1] = 33, [2] = 178, [3] = 244 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 49, [1] = 22, [2] = 176, [3] = 243 }, [4] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [5] = { [0] = 51, [1] = 25, [2] = 181, [3] = 236 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 47, [1] = 18, [2] = 179, [3] = 238 } })[R[139]][R[96]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 24, [1] = 55, [2] = 110, [3] = 95 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 126, [3] = 91 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 24, [1] = 66, [2] = 125, [3] = 102 }, [6] = { [0] = 8, [1] = 50, [2] = 114, [3] = 92 }, [7] = { [0] = 13, [1] = 52, [2] = 114, [3] = 87 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 54, [1] = 34, [2] = 179, [3] = 245 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 47, [1] = 20, [2] = 172, [3] = 241 }, [3] = { [0] = 50, [1] = 23, [2] = 177, [3] = 244 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 52, [1] = 26, [2] = 182, [3] = 237 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 47, [1] = 18, [2] = 179, [3] = 238 } })[R[139]][R[96]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 25, [1] = 56, [2] = 111, [3] = 96 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 12, [1] = 51, [2] = 110, [3] = 91 }, [4] = { [0] = 8, [1] = 46, [2] = 110, [3] = 88 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 9, [1] = 51, [2] = 115, [3] = 93 }, [7] = { [0] = 26, [1] = 65, [2] = 115, [3] = 100 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 48, [1] = 21, [2] = 173, [3] = 242 }, [3] = { [0] = 51, [1] = 24, [2] = 177, [3] = 245 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 53, [1] = 27, [2] = 183, [3] = 238 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 48, [1] = 19, [2] = 179, [3] = 239 } })[R[139]][R[96]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 26, [1] = 57, [2] = 112, [3] = 97 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 111, [3] = 91 }, [4] = { [0] = 9, [1] = 47, [2] = 111, [3] = 89 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 10, [1] = 52, [2] = 116, [3] = 94 }, [7] = { [0] = 13, [1] = 52, [2] = 116, [3] = 87 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 56, [1] = 36, [2] = 181, [3] = 247 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 48, [1] = 21, [2] = 173, [3] = 242 }, [3] = { [0] = 52, [1] = 25, [2] = 177, [3] = 246 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 47, [1] = 20, [2] = 179, [3] = 241 }, [7] = { [0] = 48, [1] = 19, [2] = 179, [3] = 239 } })[R[139]][R[96]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 31, [1] = 62, [2] = 117, [3] = 102 }, [2] = { [0] = 17, [1] = 56, [2] = 119, [3] = 99 }, [3] = { [0] = 12, [1] = 51, [2] = 118, [3] = 91 }, [4] = { [0] = 16, [1] = 54, [2] = 118, [3] = 96 }, [5] = { [0] = 18, [1] = 60, [2] = 119, [3] = 96 }, [6] = { [0] = 11, [1] = 53, [2] = 117, [3] = 95 }, [7] = { [0] = 14, [1] = 53, [2] = 117, [3] = 88 } })[R[139]][R[96]] })
    game.create_tube({ ({ [0] = { [0] = 57, [1] = 37, [2] = 182, [3] = 248 }, [1] = { [0] = 58, [1] = 31, [2] = 173, [3] = 248 }, [2] = { [0] = 49, [1] = 22, [2] = 174, [3] = 243 }, [3] = { [0] = 53, [1] = 26, [2] = 177, [3] = 247 }, [4] = { [0] = 46, [1] = 23, [2] = 177, [3] = 242 }, [5] = { [0] = 54, [1] = 28, [2] = 184, [3] = 239 }, [6] = { [0] = 51, [1] = 24, [2] = 183, [3] = 245 }, [7] = { [0] = 48, [1] = 19, [2] = 183, [3] = 239 } })[R[139]][R[96]], ({ [0] = { [0] = 20, [1] = 58, [2] = 113, [3] = 96 }, [1] = { [0] = 32, [1] = 63, [2] = 118, [3] = 103 }, [2] = { [0] = 11, [1] = 50, [2] = 113, [3] = 93 }, [3] = { [0] = 12, [1] = 51, [2] = 126, [3] = 91 }, [4] = { [0] = 24, [1] = 62, [2] = 126, [3] = 104 }, [5] = { [0] = 19, [1] = 61, [2] = 120, [3] = 97 }, [6] = { [0] = 13, [1] = 55, [2] = 119, [3] = 97 }, [7] = { [0] = 15, [1] = 54, [2] = 119, [3] = 89 } })[R[139]][R[96]] })
    if R[139] == 0 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 58, [1] = 38, [2] = 183, [3] = 249 })[R[96]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[96]] })
        game.create_tube({ ({ [0] = 59, [1] = 39, [2] = 184, [3] = 250 })[R[96]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[96]] })
        for i = 1, game.initial_units() do
          R[140] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 56, [1] = 36, [2] = 181, [3] = 247 }, [1] = { [0] = 43, [1] = 23, [2] = 168, [3] = 234 }, [2] = { [0] = 55, [1] = 35, [2] = 180, [3] = 246 } })[R[140]][R[96]], ({ [0] = { [0] = 14, [1] = 52, [2] = 107, [3] = 90 }, [1] = { [0] = 23, [1] = 61, [2] = 116, [3] = 99 }, [2] = { [0] = 26, [1] = 64, [2] = 119, [3] = 102 } })[R[140]][R[96]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 58, [1] = 38, [2] = 183, [3] = 249 })[R[96]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[96]] })
        game.create_tube({ ({ [0] = 59, [1] = 39, [2] = 184, [3] = 250 })[R[96]], ({ [0] = 20, [1] = 58, [2] = 113, [3] = 96 })[R[96]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[139] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[96]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[96]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[96]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[96]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[96]], ({ [0] = 34, [1] = 65, [2] = 120, [3] = 105 })[R[96]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[96]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[96]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[96]], ({ [0] = 33, [1] = 64, [2] = 119, [3] = 104 })[R[96]] })
        game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 173, [3] = 248 })[R[96]], ({ [0] = 34, [1] = 65, [2] = 120, [3] = 105 })[R[96]] })
        for i = 1, game.initial_units() do
          R[141] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 49, [1] = 22, [2] = 164, [3] = 239 }, [1] = { [0] = 51, [1] = 24, [2] = 166, [3] = 241 }, [2] = { [0] = 53, [1] = 26, [2] = 168, [3] = 243 } })[R[141]][R[96]], ({ [0] = { [0] = 28, [1] = 59, [2] = 114, [3] = 99 }, [1] = { [0] = 30, [1] = 61, [2] = 116, [3] = 101 }, [2] = { [0] = 22, [1] = 53, [2] = 108, [3] = 93 } })[R[141]][R[96]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[139] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[142] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 40, [1] = 13, [2] = 165, [3] = 234 }, [1] = { [0] = 45, [1] = 18, [2] = 170, [3] = 239 }, [2] = { [0] = 58, [1] = 31, [2] = 183, [3] = 252 } })[R[142]][R[96]], ({ [0] = { [0] = 5, [1] = 44, [2] = 107, [3] = 87 }, [1] = { [0] = 21, [1] = 60, [2] = 123, [3] = 103 }, [2] = { [0] = 14, [1] = 53, [2] = 116, [3] = 96 } })[R[142]][R[96]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[139] == 3 then
      game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 178, [3] = 247 })[R[96]], ({ [0] = 19, [1] = 58, [2] = 111, [3] = 98 })[R[96]] })
      game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 178, [3] = 248 })[R[96]], ({ [0] = 19, [1] = 58, [2] = 112, [3] = 98 })[R[96]] })
      game.create_tube({ ({ [0] = 55, [1] = 28, [2] = 178, [3] = 249 })[R[96]], ({ [0] = 19, [1] = 58, [2] = 118, [3] = 98 })[R[96]] })
      game.create_tube({ ({ [0] = 56, [1] = 29, [2] = 178, [3] = 250 })[R[96]], ({ [0] = 15, [1] = 54, [2] = 126, [3] = 94 })[R[96]] })
      game.create_tube({ ({ [0] = 56, [1] = 29, [2] = 179, [3] = 250 })[R[96]], ({ [0] = 19, [1] = 58, [2] = 112, [3] = 98 })[R[96]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 179, [3] = 251 })[R[96]], ({ [0] = 15, [1] = 54, [2] = 118, [3] = 94 })[R[96]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 179, [3] = 251 })[R[96]], ({ [0] = 16, [1] = 55, [2] = 126, [3] = 95 })[R[96]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[96]], ({ [0] = 17, [1] = 56, [2] = 112, [3] = 96 })[R[96]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[96]], ({ [0] = 18, [1] = 57, [2] = 118, [3] = 97 })[R[96]] })
      game.create_tube({ ({ [0] = 57, [1] = 30, [2] = 180, [3] = 251 })[R[96]], ({ [0] = 19, [1] = 58, [2] = 126, [3] = 98 })[R[96]] })
      game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 181, [3] = 252 })[R[96]], ({ [0] = 19, [1] = 58, [2] = 117, [3] = 98 })[R[96]] })
      game.create_tube({ ({ [0] = 58, [1] = 31, [2] = 181, [3] = 252 })[R[96]], ({ [0] = 20, [1] = 59, [2] = 118, [3] = 99 })[R[96]] })
      if R[96] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 58, 21 })
          for i = 1, game.initial_units() do
            R[143] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 51, [1] = 52, [2] = 39 })[R[143]], ({ [0] = 15, [1] = 22, [2] = 19 })[R[143]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 58, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[96] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 31, 60 })
          for i = 1, game.initial_units() do
            R[144] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 24, [1] = 25, [2] = 12 })[R[144]], ({ [0] = 54, [1] = 61, [2] = 58 })[R[144]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 31, 60 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[96] == 2 then
        if game.initial_units() == 0 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 181, 119 })
          game.create_tube({ 181, 120 })
          game.create_tube({ 181, 125 })
          game.create_tube({ 181, 126 })
          game.create_tube({ 182, 117 })
          game.create_tube({ 182, 125 })
          game.create_tube({ 183, 115 })
          game.create_tube({ 183, 116 })
          game.create_tube({ 183, 117 })
          game.create_tube({ 183, 125 })
          for i = 1, game.initial_units() do
            R[145] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 176, [1] = 167, [2] = 175 })[R[145]], ({ [0] = 109, [1] = 117, [2] = 112 })[R[145]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[96] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 252, 100 })
          for i = 1, game.initial_units() do
            R[146] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 245, [1] = 246, [2] = 233 })[R[146]], ({ [0] = 94, [1] = 101, [2] = 98 })[R[146]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          game.create_tube({ 252, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[96]", R[96])
      end
    elseif R[139] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[96]], ({ [0] = 9, [1] = 47, [2] = 111, [3] = 89 })[R[96]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[96]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[96]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[96]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[96]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[96]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[96]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[96]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[96]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[96]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[96]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[96]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[96]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[96]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[96]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[96]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[96]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[96]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[96]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[96]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[96]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[96]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[96]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[96]], ({ [0] = 17, [1] = 55, [2] = 119, [3] = 97 })[R[96]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[96]], ({ [0] = 18, [1] = 56, [2] = 120, [3] = 98 })[R[96]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[96]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[96]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[96]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[96]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[96]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[96]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[96]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[96]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[96]], ({ [0] = 13, [1] = 51, [2] = 115, [3] = 93 })[R[96]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[96]], ({ [0] = 14, [1] = 52, [2] = 116, [3] = 94 })[R[96]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[96]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[96]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[96]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[96]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[96]], ({ [0] = 9, [1] = 47, [2] = 111, [3] = 89 })[R[96]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[96]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[96]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[96]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[96]] })
        game.create_tube({ ({ [0] = 47, [1] = 24, [2] = 178, [3] = 243 })[R[96]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[96]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[96]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[96]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[96]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[96]] })
        game.create_tube({ ({ [0] = 48, [1] = 25, [2] = 179, [3] = 244 })[R[96]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[96]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[96]], ({ [0] = 10, [1] = 48, [2] = 112, [3] = 90 })[R[96]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[96]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[96]] })
        game.create_tube({ ({ [0] = 49, [1] = 26, [2] = 180, [3] = 245 })[R[96]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[96]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[96]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[96]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[96]], ({ [0] = 16, [1] = 54, [2] = 118, [3] = 96 })[R[96]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[96]], ({ [0] = 17, [1] = 55, [2] = 119, [3] = 97 })[R[96]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[96]], ({ [0] = 18, [1] = 56, [2] = 120, [3] = 98 })[R[96]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[96]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[96]] })
        game.create_tube({ ({ [0] = 50, [1] = 27, [2] = 181, [3] = 246 })[R[96]], ({ [0] = 24, [1] = 62, [2] = 126, [3] = 104 })[R[96]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[96]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[96]] })
        game.create_tube({ ({ [0] = 51, [1] = 28, [2] = 182, [3] = 247 })[R[96]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[96]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[96]], ({ [0] = 13, [1] = 51, [2] = 115, [3] = 93 })[R[96]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[96]], ({ [0] = 14, [1] = 52, [2] = 116, [3] = 94 })[R[96]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[96]], ({ [0] = 15, [1] = 53, [2] = 117, [3] = 95 })[R[96]] })
        game.create_tube({ ({ [0] = 52, [1] = 29, [2] = 183, [3] = 248 })[R[96]], ({ [0] = 23, [1] = 61, [2] = 125, [3] = 103 })[R[96]] })
        for i = 1, game.initial_units() do
          R[147] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 45, [1] = 22, [2] = 176, [3] = 241 }, [1] = { [0] = 36, [1] = 13, [2] = 167, [3] = 232 }, [2] = { [0] = 44, [1] = 21, [2] = 175, [3] = 240 } })[R[147]][R[96]], ({ [0] = { [0] = 7, [1] = 45, [2] = 109, [3] = 87 }, [1] = { [0] = 15, [1] = 53, [2] = 117, [3] = 95 }, [2] = { [0] = 10, [1] = 48, [2] = 112, [3] = 90 } })[R[147]][R[96]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[139] == 5 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[96]], ({ [0] = 20, [1] = 62, [2] = 121, [3] = 98 })[R[96]] })
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[96]], ({ [0] = 21, [1] = 63, [2] = 122, [3] = 99 })[R[96]] })
        for i = 1, game.initial_units() do
          R[148] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 50, [1] = 24, [2] = 180, [3] = 235 }, [1] = { [0] = 33, [1] = 7, [2] = 163, [3] = 218 }, [2] = { [0] = 55, [1] = 29, [2] = 185, [3] = 240 } })[R[148]][R[96]], ({ [0] = { [0] = 27, [1] = 69, [2] = 128, [3] = 105 }, [1] = { [0] = 14, [1] = 56, [2] = 115, [3] = 92 }, [2] = { [0] = 27, [1] = 69, [2] = 128, [3] = 105 } })[R[148]][R[96]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[96]], ({ [0] = 20, [1] = 62, [2] = 121, [3] = 98 })[R[96]] })
        game.create_tube({ ({ [0] = 54, [1] = 28, [2] = 184, [3] = 239 })[R[96]], ({ [0] = 21, [1] = 63, [2] = 122, [3] = 99 })[R[96]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[139] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 52, [1] = 25, [2] = 184, [3] = 246 })[R[96]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[96]] })
        game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 185, [3] = 247 })[R[96]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[96]] })
        game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 186, [3] = 248 })[R[96]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[96]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 52, [1] = 25, [2] = 184, [3] = 246 })[R[96]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[96]] })
        game.create_tube({ ({ [0] = 53, [1] = 26, [2] = 185, [3] = 247 })[R[96]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[96]] })
        game.create_tube({ ({ [0] = 54, [1] = 27, [2] = 186, [3] = 248 })[R[96]], ({ [0] = 13, [1] = 55, [2] = 119, [3] = 97 })[R[96]] })
        for i = 1, game.initial_units() do
          R[149] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 33, [1] = 6, [2] = 165, [3] = 227 }, [1] = { [0] = 38, [1] = 11, [2] = 170, [3] = 232 }, [2] = { [0] = 59, [1] = 32, [2] = 191, [3] = 253 } })[R[149]][R[96]], ({ [0] = { [0] = 3, [1] = 45, [2] = 109, [3] = 87 }, [1] = { [0] = 1, [1] = 43, [2] = 107, [3] = 85 }, [2] = { [0] = 16, [1] = 58, [2] = 122, [3] = 100 } })[R[149]][R[96]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[139] == 7 then
      game.create_tube({ ({ [0] = 48, [1] = 19, [2] = 184, [3] = 239 })[R[96]], ({ [0] = 16, [1] = 55, [2] = 119, [3] = 90 })[R[96]] })
      game.create_tube({ ({ [0] = 48, [1] = 19, [2] = 185, [3] = 239 })[R[96]], ({ [0] = 17, [1] = 56, [2] = 119, [3] = 91 })[R[96]] })
      if R[96] == 0 then
        if game.initial_units() == 0 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 48, 18 })
          game.create_tube({ 48, 22 })
          game.create_tube({ 48, 23 })
          game.create_tube({ 48, 24 })
          game.create_tube({ 48, 25 })
          game.create_tube({ 48, 26 })
          game.create_tube({ 49, 13 })
          game.create_tube({ 49, 26 })
          game.create_tube({ 50, 13 })
          game.create_tube({ 50, 26 })
          game.create_tube({ 51, 13 })
          game.create_tube({ 51, 26 })
          game.create_tube({ 52, 13 })
          game.create_tube({ 52, 26 })
          game.create_tube({ 53, 13 })
          game.create_tube({ 53, 26 })
          game.create_tube({ 54, 13 })
          game.create_tube({ 54, 26 })
          game.create_tube({ 56, 15 })
          game.create_tube({ 56, 16 })
          game.create_tube({ 56, 17 })
          game.create_tube({ 56, 18 })
          game.create_tube({ 56, 19 })
          game.create_tube({ 56, 20 })
          game.create_tube({ 56, 21 })
          game.create_tube({ 56, 22 })
          game.create_tube({ 56, 23 })
          for i = 1, game.initial_units() do
            R[150] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 46, [1] = 52, [2] = 40 })[R[150]], ({ [0] = 9, [1] = 9, [2] = 30 })[R[150]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[96] == 1 then
        if game.initial_units() == 0 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 19, 57 })
          game.create_tube({ 19, 61 })
          game.create_tube({ 19, 62 })
          game.create_tube({ 19, 63 })
          game.create_tube({ 19, 64 })
          game.create_tube({ 19, 65 })
          game.create_tube({ 20, 52 })
          game.create_tube({ 20, 65 })
          game.create_tube({ 21, 52 })
          game.create_tube({ 21, 65 })
          game.create_tube({ 22, 52 })
          game.create_tube({ 22, 65 })
          game.create_tube({ 23, 52 })
          game.create_tube({ 23, 65 })
          game.create_tube({ 24, 52 })
          game.create_tube({ 24, 65 })
          game.create_tube({ 25, 52 })
          game.create_tube({ 25, 65 })
          game.create_tube({ 27, 54 })
          game.create_tube({ 27, 55 })
          game.create_tube({ 27, 56 })
          game.create_tube({ 27, 57 })
          game.create_tube({ 27, 58 })
          game.create_tube({ 27, 59 })
          game.create_tube({ 27, 60 })
          game.create_tube({ 27, 61 })
          game.create_tube({ 27, 62 })
          for i = 1, game.initial_units() do
            R[151] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 17, [1] = 23, [2] = 11 })[R[151]], ({ [0] = 48, [1] = 48, [2] = 69 })[R[151]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[96] == 2 then
        if game.initial_units() == 0 then
          game.create_tube({ 186, 119 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 186, 119 })
          for i = 1, game.initial_units() do
            R[152] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 165, [1] = 170, [2] = 191 })[R[152]], ({ [0] = 109, [1] = 107, [2] = 122 })[R[152]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[96] == 3 then
        if game.initial_units() == 0 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_tube({ 239, 92 })
          game.create_tube({ 239, 96 })
          game.create_tube({ 239, 97 })
          game.create_tube({ 239, 98 })
          game.create_tube({ 239, 99 })
          game.create_tube({ 239, 100 })
          game.create_tube({ 240, 87 })
          game.create_tube({ 240, 100 })
          game.create_tube({ 241, 87 })
          game.create_tube({ 241, 100 })
          game.create_tube({ 242, 87 })
          game.create_tube({ 242, 100 })
          game.create_tube({ 243, 87 })
          game.create_tube({ 243, 100 })
          game.create_tube({ 244, 87 })
          game.create_tube({ 244, 100 })
          game.create_tube({ 245, 87 })
          game.create_tube({ 245, 100 })
          game.create_tube({ 247, 89 })
          game.create_tube({ 247, 90 })
          game.create_tube({ 247, 91 })
          game.create_tube({ 247, 92 })
          game.create_tube({ 247, 93 })
          game.create_tube({ 247, 94 })
          game.create_tube({ 247, 95 })
          game.create_tube({ 247, 96 })
          game.create_tube({ 247, 97 })
          for i = 1, game.initial_units() do
            R[153] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 237, [1] = 243, [2] = 231 })[R[153]], ({ [0] = 83, [1] = 83, [2] = 104 })[R[153]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[96]", R[96])
      end
    else
      unseen("R[139]", R[139])
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
  local t2 = trigger.midas{time = 25000}
  mission.victory(t2, "Have the most ore in storage at Mark 250", {one_shot = true})
  if game.disasters_enabled() then
    trigger.time{min = 18000, max = 22000, one_shot = false, on = Meteor}  -- after 180 to 220 marks
    trigger.time{min = 12000, max = 18000, one_shot = false, on = Vortex}  -- after 120 to 180 marks
  end
  return true
end
