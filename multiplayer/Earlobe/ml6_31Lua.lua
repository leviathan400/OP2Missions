-- ml6_31Lua.lua  -  6 Player, LastOne, 'Earlobe' map. (Lua)
--
-- Converted by op2dll from ml6_31.dll ("6 Player, LastOne, 'Earlobe' map."): its setup replayed. `on_init` makes the original's
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
local DoDisaster

function DoDisaster(t)
  local r1 = game.rand(4)
  local r2 = game.rand(128)
  local r3 = game.rand(128)
  if r1 < 1 then
    game.create_earthquake({ r2 + 1, r3 + 1 }, 1)
  elseif r1 < 2 then
    local r4 = game.rand(128)
    local r5 = game.rand(128)
    game.create_lightning({ r2 + 1, r3 + 1 }, { r4 + 1, r5 + 1 }, 10)
  elseif r1 < 3 then
    local r4 = game.rand(128)
    local r5 = game.rand(128)
    game.create_tornado({ r2 + 1, r3 + 1 }, { r4 + 1, r5 + 1 }, 10)
  else
    game.create_meteor({ r2 + 1, r3 + 1 }, 1)
  end
  t:destroy()
  trigger.time{min = 8000, max = 16000, one_shot = false, on = DoDisaster}  -- after 80 to 160 marks
end

function on_init()
  local n = game.num_players()
  if n == 2 then
    game.set_cell_type({ 24, 87 }, 6)
    game.initial_set_tile({ 24, 87 }, 1531)
    game.set_cell_type({ 24, 88 }, 6)
    game.initial_set_tile({ 24, 88 }, 1533)
    game.set_cell_type({ 25, 87 }, 6)
    game.initial_set_tile({ 25, 87 }, 1532)
    game.set_cell_type({ 25, 88 }, 6)
    game.initial_set_tile({ 25, 88 }, 1534)
    game.set_cell_type({ 29, 42 }, 6)
    game.initial_set_tile({ 29, 42 }, 1531)
    game.set_cell_type({ 29, 43 }, 6)
    game.initial_set_tile({ 29, 43 }, 1533)
    game.set_cell_type({ 30, 42 }, 6)
    game.initial_set_tile({ 30, 42 }, 1532)
    game.set_cell_type({ 30, 43 }, 6)
    game.initial_set_tile({ 30, 43 }, 1534)
    game.set_cell_type({ 77, 99 }, 6)
    game.initial_set_tile({ 77, 99 }, 1531)
    game.set_cell_type({ 77, 100 }, 6)
    game.initial_set_tile({ 77, 100 }, 1533)
    game.set_cell_type({ 78, 99 }, 6)
    game.initial_set_tile({ 78, 99 }, 1532)
    game.set_cell_type({ 78, 100 }, 6)
    game.initial_set_tile({ 78, 100 }, 1534)
    game.set_cell_type({ 115, 82 }, 6)
    game.initial_set_tile({ 115, 82 }, 1531)
    game.set_cell_type({ 115, 83 }, 6)
    game.initial_set_tile({ 115, 83 }, 1533)
    game.set_cell_type({ 116, 82 }, 6)
    game.initial_set_tile({ 116, 82 }, 1532)
    game.set_cell_type({ 116, 83 }, 6)
    game.initial_set_tile({ 116, 83 }, 1534)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 69, 41 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 38, 54 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 41, 82 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 73, 91 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 94, 79 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 94, 48 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 80, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 89, 14 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 125, 7 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 114, 12 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 116, 23 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 39 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 108, 55 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 114, 65 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 126, 81 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 87, 61 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 81, 44 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 66, 52 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 76, 64 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 71, 78 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 89, 94 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 116 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 115, 106 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 118, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 59, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 50, 108 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 55, 95 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 45, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 51, 54 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 24, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 4, 84 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 13, 120 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 8, 94 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 6, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 7, 43 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 4, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 4, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 23, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 49, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 37, 36 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 33, 23 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 53, 10 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 54, 84 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 61, 78 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 91, 65 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 85, 14 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 95, 119 } }
    R[0] = game.rand(6)
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 25, [1] = 68, [2] = 110, [3] = 111, [4] = 73, [5] = 34 })[R[0]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[0]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 3 or R[0] == 4 or R[0] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [3] = 105, [4] = 67, [5] = 28 })[R[0]], ({ [3] = 88, [4] = 107, [5] = 94 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[0] == 0 or R[0] == 1 or R[0] == 2 then
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[0]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 19, [1] = 62, [2] = 104, [3] = 105, [4] = 67, [5] = 28 })[R[0]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 3 or R[0] == 4 or R[0] == 5 then
    elseif R[0] == 0 or R[0] == 1 or R[0] == 2 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 19, [1] = 62, [2] = 104 })[R[0]], ({ [0] = 47, [1] = 26, [2] = 36 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 20, [1] = 63, [2] = 105, [3] = 106, [4] = 68, [5] = 29 })[R[0]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 4 then
      elseif game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 8 then
        elseif game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[1]:center_view({ ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[0]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[0]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 29, [1] = 67, [2] = 101, [3] = 99, [4] = 73, [5] = 36 })[R[0]], ({ [0] = 52, [1] = 35, [2] = 44, [3] = 80, [4] = 97, [5] = 87 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 111, [1] = 73, [2] = 34, [3] = 25, [4] = 68, [5] = 110 })[R[0]], ({ [0] = 84, [1] = 103, [2] = 90, [3] = 50, [4] = 29, [5] = 39 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = 110, [1] = 72, [2] = 33, [3] = 24, [4] = 67, [5] = 109 })[R[0]], ({ [0] = 88, [1] = 107, [2] = 94, [3] = 47, [4] = 26, [5] = 36 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 3 or R[0] == 4 or R[0] == 5 then
    elseif R[0] == 0 or R[0] == 1 or R[0] == 2 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 105, [1] = 67, [2] = 28 })[R[0]], ({ [0] = 88, [1] = 107, [2] = 94 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 110, [1] = 72, [2] = 33, [3] = 24, [4] = 67, [5] = 109 })[R[0]], ({ [0] = 91, [1] = 110, [2] = 97, [3] = 44, [4] = 23, [5] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 105, [1] = 67, [2] = 28, [3] = 19, [4] = 62, [5] = 104 })[R[0]], ({ [0] = 91, [1] = 110, [2] = 97, [3] = 44, [4] = 23, [5] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 3 or R[0] == 4 or R[0] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [3] = 19, [4] = 62, [5] = 104 })[R[0]], ({ [3] = 47, [4] = 26, [5] = 36 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[0] == 0 or R[0] == 1 or R[0] == 2 then
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 106, [1] = 68, [2] = 29, [3] = 20, [4] = 63, [5] = 105 })[R[0]], ({ [0] = 84, [1] = 103, [2] = 90, [3] = 50, [4] = 29, [5] = 39 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 4 then
      elseif game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 8 then
        elseif game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 69, [2] = 30, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[2]:center_view({ ({ [0] = 110, [1] = 72, [2] = 33, [3] = 24, [4] = 67, [5] = 109 })[R[0]], ({ [0] = 88, [1] = 107, [2] = 94, [3] = 47, [4] = 26, [5] = 36 })[R[0]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 99, [1] = 73, [2] = 36, [3] = 29, [4] = 67, [5] = 101 })[R[0]], ({ [0] = 80, [1] = 97, [2] = 87, [3] = 52, [4] = 35, [5] = 44 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    game.set_cell_type({ 24, 87 }, 6)
    game.initial_set_tile({ 24, 87 }, 1531)
    game.set_cell_type({ 24, 88 }, 6)
    game.initial_set_tile({ 24, 88 }, 1533)
    game.set_cell_type({ 25, 87 }, 6)
    game.initial_set_tile({ 25, 87 }, 1532)
    game.set_cell_type({ 25, 88 }, 6)
    game.initial_set_tile({ 25, 88 }, 1534)
    game.set_cell_type({ 29, 42 }, 6)
    game.initial_set_tile({ 29, 42 }, 1531)
    game.set_cell_type({ 29, 43 }, 6)
    game.initial_set_tile({ 29, 43 }, 1533)
    game.set_cell_type({ 30, 42 }, 6)
    game.initial_set_tile({ 30, 42 }, 1532)
    game.set_cell_type({ 30, 43 }, 6)
    game.initial_set_tile({ 30, 43 }, 1534)
    game.set_cell_type({ 77, 99 }, 6)
    game.initial_set_tile({ 77, 99 }, 1531)
    game.set_cell_type({ 77, 100 }, 6)
    game.initial_set_tile({ 77, 100 }, 1533)
    game.set_cell_type({ 78, 99 }, 6)
    game.initial_set_tile({ 78, 99 }, 1532)
    game.set_cell_type({ 78, 100 }, 6)
    game.initial_set_tile({ 78, 100 }, 1534)
    game.set_cell_type({ 115, 82 }, 6)
    game.initial_set_tile({ 115, 82 }, 1531)
    game.set_cell_type({ 115, 83 }, 6)
    game.initial_set_tile({ 115, 83 }, 1533)
    game.set_cell_type({ 116, 82 }, 6)
    game.initial_set_tile({ 116, 82 }, 1532)
    game.set_cell_type({ 116, 83 }, 6)
    game.initial_set_tile({ 116, 83 }, 1534)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 69, 41 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 38, 54 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 41, 82 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 73, 91 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 94, 79 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 94, 48 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 80, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 89, 14 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 125, 7 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 114, 12 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 116, 23 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 39 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 108, 55 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 114, 65 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 126, 81 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 87, 61 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 81, 44 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 66, 52 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 76, 64 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 71, 78 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 89, 94 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 116 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 115, 106 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 118, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 59, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 50, 108 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 55, 95 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 45, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 51, 54 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 24, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 4, 84 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 13, 120 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 8, 94 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 6, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 7, 43 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 4, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 4, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 23, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 49, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 37, 36 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 33, 23 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 53, 10 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 54, 84 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 61, 78 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 91, 65 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 85, 14 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 95, 119 } }
    R[0] = game.rand(6)
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 25, [1] = 68, [2] = 110, [3] = 111, [4] = 73, [5] = 34 })[R[0]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[0]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 1 or R[0] == 2 then
    elseif R[0] == 3 or R[0] == 4 or R[0] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [3] = 105, [4] = 67, [5] = 28 })[R[0]], ({ [3] = 88, [4] = 107, [5] = 94 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[0]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 19, [1] = 62, [2] = 104, [3] = 105, [4] = 67, [5] = 28 })[R[0]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 1 or R[0] == 2 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 19, [1] = 62, [2] = 104 })[R[0]], ({ [0] = 47, [1] = 26, [2] = 36 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[0] == 3 or R[0] == 4 or R[0] == 5 then
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 20, [1] = 63, [2] = 105, [3] = 106, [4] = 68, [5] = 29 })[R[0]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 8 then
        elseif game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif game.initial_units() == 4 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[1]:center_view({ ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[0]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[0]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 29, [1] = 67, [2] = 101, [3] = 99, [4] = 73, [5] = 36 })[R[0]], ({ [0] = 52, [1] = 35, [2] = 44, [3] = 80, [4] = 97, [5] = 87 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 110, [1] = 111, [2] = 73, [3] = 34, [4] = 25, [5] = 68 })[R[0]], ({ [0] = 39, [1] = 84, [2] = 103, [3] = 90, [4] = 50, [5] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = 109, [1] = 110, [2] = 72, [3] = 33, [4] = 24, [5] = 67 })[R[0]], ({ [0] = 36, [1] = 88, [2] = 107, [3] = 94, [4] = 47, [5] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 4 or R[0] == 5 then
    elseif R[0] == 1 or R[0] == 2 or R[0] == 3 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [1] = 105, [2] = 67, [3] = 28 })[R[0]], ({ [1] = 88, [2] = 107, [3] = 94 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 109, [1] = 110, [2] = 72, [3] = 33, [4] = 24, [5] = 67 })[R[0]], ({ [0] = 33, [1] = 91, [2] = 110, [3] = 97, [4] = 44, [5] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 104, [1] = 105, [2] = 67, [3] = 28, [4] = 19, [5] = 62 })[R[0]], ({ [0] = 33, [1] = 91, [2] = 110, [3] = 97, [4] = 44, [5] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 4 or R[0] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 104, [4] = 19, [5] = 62 })[R[0]], ({ [0] = 36, [4] = 47, [5] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[0] == 1 or R[0] == 2 or R[0] == 3 then
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 105, [1] = 106, [2] = 68, [3] = 29, [4] = 20, [5] = 63 })[R[0]], ({ [0] = 39, [1] = 84, [2] = 103, [3] = 90, [4] = 50, [5] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 8 then
        elseif game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 107, [1] = 107, [2] = 69, [3] = 30, [4] = 22, [5] = 65 })[R[0]], ({ [0] = 35, [1] = 86, [2] = 105, [3] = 92, [4] = 46, [5] = 25 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif game.initial_units() == 4 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[2]:center_view({ ({ [0] = 109, [1] = 110, [2] = 72, [3] = 33, [4] = 24, [5] = 67 })[R[0]], ({ [0] = 36, [1] = 88, [2] = 107, [3] = 94, [4] = 47, [5] = 26 })[R[0]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 101, [1] = 99, [2] = 73, [3] = 36, [4] = 29, [5] = 67 })[R[0]], ({ [0] = 44, [1] = 80, [2] = 97, [3] = 87, [4] = 52, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 73, [1] = 34, [2] = 25, [3] = 68, [4] = 110, [5] = 111 })[R[0]], ({ [0] = 103, [1] = 90, [2] = 50, [3] = 29, [4] = 39, [5] = 84 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = 72, [1] = 33, [2] = 24, [3] = 67, [4] = 109, [5] = 110 })[R[0]], ({ [0] = 107, [1] = 94, [2] = 47, [3] = 26, [4] = 36, [5] = 88 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 1 or R[0] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 67, [1] = 28, [5] = 105 })[R[0]], ({ [0] = 107, [1] = 94, [5] = 88 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[0] == 2 or R[0] == 3 or R[0] == 4 then
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 72, [1] = 33, [2] = 24, [3] = 67, [4] = 109, [5] = 110 })[R[0]], ({ [0] = 110, [1] = 97, [2] = 44, [3] = 23, [4] = 33, [5] = 91 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 67, [1] = 28, [2] = 19, [3] = 62, [4] = 104, [5] = 105 })[R[0]], ({ [0] = 110, [1] = 97, [2] = 44, [3] = 23, [4] = 33, [5] = 91 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 1 or R[0] == 5 then
    elseif R[0] == 2 or R[0] == 3 or R[0] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [2] = 19, [3] = 62, [4] = 104 })[R[0]], ({ [2] = 47, [3] = 26, [4] = 36 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 68, [1] = 29, [2] = 20, [3] = 63, [4] = 105, [5] = 106 })[R[0]], ({ [0] = 103, [1] = 90, [2] = 50, [3] = 29, [4] = 39, [5] = 84 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 8 then
        elseif game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif game.initial_units() == 4 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[3]:center_view({ ({ [0] = 72, [1] = 33, [2] = 24, [3] = 67, [4] = 109, [5] = 110 })[R[0]], ({ [0] = 107, [1] = 94, [2] = 47, [3] = 26, [4] = 36, [5] = 88 })[R[0]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 73, [1] = 36, [2] = 29, [3] = 67, [4] = 101, [5] = 99 })[R[0]], ({ [0] = 97, [1] = 87, [2] = 52, [3] = 35, [4] = 44, [5] = 80 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    game.set_cell_type({ 24, 87 }, 6)
    game.initial_set_tile({ 24, 87 }, 1531)
    game.set_cell_type({ 24, 88 }, 6)
    game.initial_set_tile({ 24, 88 }, 1533)
    game.set_cell_type({ 25, 87 }, 6)
    game.initial_set_tile({ 25, 87 }, 1532)
    game.set_cell_type({ 25, 88 }, 6)
    game.initial_set_tile({ 25, 88 }, 1534)
    game.set_cell_type({ 29, 42 }, 6)
    game.initial_set_tile({ 29, 42 }, 1531)
    game.set_cell_type({ 29, 43 }, 6)
    game.initial_set_tile({ 29, 43 }, 1533)
    game.set_cell_type({ 30, 42 }, 6)
    game.initial_set_tile({ 30, 42 }, 1532)
    game.set_cell_type({ 30, 43 }, 6)
    game.initial_set_tile({ 30, 43 }, 1534)
    game.set_cell_type({ 77, 99 }, 6)
    game.initial_set_tile({ 77, 99 }, 1531)
    game.set_cell_type({ 77, 100 }, 6)
    game.initial_set_tile({ 77, 100 }, 1533)
    game.set_cell_type({ 78, 99 }, 6)
    game.initial_set_tile({ 78, 99 }, 1532)
    game.set_cell_type({ 78, 100 }, 6)
    game.initial_set_tile({ 78, 100 }, 1534)
    game.set_cell_type({ 115, 82 }, 6)
    game.initial_set_tile({ 115, 82 }, 1531)
    game.set_cell_type({ 115, 83 }, 6)
    game.initial_set_tile({ 115, 83 }, 1533)
    game.set_cell_type({ 116, 82 }, 6)
    game.initial_set_tile({ 116, 82 }, 1532)
    game.set_cell_type({ 116, 83 }, 6)
    game.initial_set_tile({ 116, 83 }, 1534)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 69, 41 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 38, 54 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 41, 82 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 73, 91 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 94, 79 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 94, 48 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 80, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 89, 14 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 125, 7 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 114, 12 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 116, 23 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 39 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 108, 55 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 114, 65 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 126, 81 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 87, 61 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 81, 44 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 66, 52 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 76, 64 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 71, 78 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 89, 94 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 116 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 115, 106 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 118, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 59, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 50, 108 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 55, 95 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 45, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 51, 54 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 24, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 4, 84 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 13, 120 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 8, 94 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 6, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 7, 43 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 4, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 4, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 23, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 49, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 37, 36 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 33, 23 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 53, 10 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 54, 84 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 61, 78 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 91, 65 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 85, 14 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 95, 119 } }
    R[1] = game.rand(1)
    R[0] = game.rand(6)
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 25, [1] = 68, [2] = 110, [3] = 111, [4] = 73, [5] = 34 })[R[0]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[0]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 3 or R[0] == 4 or R[0] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [3] = 105, [4] = 67, [5] = 28 })[R[0]], ({ [3] = 88, [4] = 107, [5] = 94 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[0] == 0 or R[0] == 1 or R[0] == 2 then
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[0]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 19, [1] = 62, [2] = 104, [3] = 105, [4] = 67, [5] = 28 })[R[0]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 3 or R[0] == 4 or R[0] == 5 then
    elseif R[0] == 0 or R[0] == 1 or R[0] == 2 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 19, [1] = 62, [2] = 104 })[R[0]], ({ [0] = 47, [1] = 26, [2] = 36 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 20, [1] = 63, [2] = 105, [3] = 106, [4] = 68, [5] = 29 })[R[0]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 4 then
      elseif game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 8 then
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[1]:center_view({ ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[0]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[0]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 29, [1] = 67, [2] = 101, [3] = 99, [4] = 73, [5] = 36 })[R[0]], ({ [0] = 52, [1] = 35, [2] = 44, [3] = 80, [4] = 97, [5] = 87 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 73, [1] = 34, [2] = 25, [3] = 68, [4] = 110, [5] = 111 })[R[0]], ({ [0] = 103, [1] = 90, [2] = 50, [3] = 29, [4] = 39, [5] = 84 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = 72, [1] = 33, [2] = 24, [3] = 67, [4] = 109, [5] = 110 })[R[0]], ({ [0] = 107, [1] = 94, [2] = 47, [3] = 26, [4] = 36, [5] = 88 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 2 or R[0] == 3 or R[0] == 4 then
    elseif R[0] == 0 or R[0] == 1 or R[0] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 67, [1] = 28, [5] = 105 })[R[0]], ({ [0] = 107, [1] = 94, [5] = 88 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 72, [1] = 33, [2] = 24, [3] = 67, [4] = 109, [5] = 110 })[R[0]], ({ [0] = 110, [1] = 97, [2] = 44, [3] = 23, [4] = 33, [5] = 91 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 67, [1] = 28, [2] = 19, [3] = 62, [4] = 104, [5] = 105 })[R[0]], ({ [0] = 110, [1] = 97, [2] = 44, [3] = 23, [4] = 33, [5] = 91 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 2 or R[0] == 3 or R[0] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [2] = 19, [3] = 62, [4] = 104 })[R[0]], ({ [2] = 47, [3] = 26, [4] = 36 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[0] == 0 or R[0] == 1 or R[0] == 5 then
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 68, [1] = 29, [2] = 20, [3] = 63, [4] = 105, [5] = 106 })[R[0]], ({ [0] = 103, [1] = 90, [2] = 50, [3] = 29, [4] = 39, [5] = 84 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 4 then
      elseif game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 69, [1] = 30, [2] = 22, [3] = 65, [4] = 107, [5] = 107 })[R[0]], ({ [0] = 105, [1] = 92, [2] = 46, [3] = 25, [4] = 35, [5] = 86 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 8 then
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[2]:center_view({ ({ [0] = 72, [1] = 33, [2] = 24, [3] = 67, [4] = 109, [5] = 110 })[R[0]], ({ [0] = 107, [1] = 94, [2] = 47, [3] = 26, [4] = 36, [5] = 88 })[R[0]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 73, [1] = 36, [2] = 29, [3] = 67, [4] = 101, [5] = 99 })[R[0]], ({ [0] = 97, [1] = 87, [2] = 52, [3] = 35, [4] = 44, [5] = 80 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 111, [1] = 73, [2] = 34, [3] = 25, [4] = 68, [5] = 110 })[R[0]], ({ [0] = 84, [1] = 103, [2] = 90, [3] = 50, [4] = 29, [5] = 39 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = 110, [1] = 72, [2] = 33, [3] = 24, [4] = 67, [5] = 109 })[R[0]], ({ [0] = 88, [1] = 107, [2] = 94, [3] = 47, [4] = 26, [5] = 36 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 3 or R[0] == 4 or R[0] == 5 then
    elseif R[0] == 0 or R[0] == 1 or R[0] == 2 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 105, [1] = 67, [2] = 28 })[R[0]], ({ [0] = 88, [1] = 107, [2] = 94 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 110, [1] = 72, [2] = 33, [3] = 24, [4] = 67, [5] = 109 })[R[0]], ({ [0] = 91, [1] = 110, [2] = 97, [3] = 44, [4] = 23, [5] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 105, [1] = 67, [2] = 28, [3] = 19, [4] = 62, [5] = 104 })[R[0]], ({ [0] = 91, [1] = 110, [2] = 97, [3] = 44, [4] = 23, [5] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 3 or R[0] == 4 or R[0] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [3] = 19, [4] = 62, [5] = 104 })[R[0]], ({ [3] = 47, [4] = 26, [5] = 36 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[0] == 0 or R[0] == 1 or R[0] == 2 then
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 106, [1] = 68, [2] = 29, [3] = 20, [4] = 63, [5] = 105 })[R[0]], ({ [0] = 84, [1] = 103, [2] = 90, [3] = 50, [4] = 29, [5] = 39 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 4 then
      elseif game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 107, [1] = 69, [2] = 30, [3] = 22, [4] = 65, [5] = 107 })[R[0]], ({ [0] = 86, [1] = 105, [2] = 92, [3] = 46, [4] = 25, [5] = 35 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 8 then
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[3]:center_view({ ({ [0] = 110, [1] = 72, [2] = 33, [3] = 24, [4] = 67, [5] = 109 })[R[0]], ({ [0] = 88, [1] = 107, [2] = 94, [3] = 47, [4] = 26, [5] = 36 })[R[0]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 99, [1] = 73, [2] = 36, [3] = 29, [4] = 67, [5] = 101 })[R[0]], ({ [0] = 80, [1] = 97, [2] = 87, [3] = 52, [4] = 35, [5] = 44 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 68, [1] = 110, [2] = 111, [3] = 73, [4] = 34, [5] = 25 })[R[0]], ({ [0] = 29, [1] = 39, [2] = 84, [3] = 103, [4] = 90, [5] = 50 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = 67, [1] = 109, [2] = 110, [3] = 72, [4] = 33, [5] = 24 })[R[0]], ({ [0] = 26, [1] = 36, [2] = 88, [3] = 107, [4] = 94, [5] = 47 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 2 or R[0] == 3 or R[0] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [2] = 105, [3] = 67, [4] = 28 })[R[0]], ({ [2] = 88, [3] = 107, [4] = 94 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[0] == 0 or R[0] == 1 or R[0] == 5 then
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 67, [1] = 109, [2] = 110, [3] = 72, [4] = 33, [5] = 24 })[R[0]], ({ [0] = 23, [1] = 33, [2] = 91, [3] = 110, [4] = 97, [5] = 44 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 62, [1] = 104, [2] = 105, [3] = 67, [4] = 28, [5] = 19 })[R[0]], ({ [0] = 23, [1] = 33, [2] = 91, [3] = 110, [4] = 97, [5] = 44 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 2 or R[0] == 3 or R[0] == 4 then
    elseif R[0] == 0 or R[0] == 1 or R[0] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 62, [1] = 104, [5] = 19 })[R[0]], ({ [0] = 26, [1] = 36, [5] = 47 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 63, [1] = 105, [2] = 106, [3] = 68, [4] = 29, [5] = 20 })[R[0]], ({ [0] = 29, [1] = 39, [2] = 84, [3] = 103, [4] = 90, [5] = 50 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 4 then
      elseif game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 65, [1] = 107, [2] = 107, [3] = 69, [4] = 30, [5] = 22 })[R[0]], ({ [0] = 25, [1] = 35, [2] = 86, [3] = 105, [4] = 92, [5] = 46 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 8 then
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[4]:center_view({ ({ [0] = 67, [1] = 109, [2] = 110, [3] = 72, [4] = 33, [5] = 24 })[R[0]], ({ [0] = 26, [1] = 36, [2] = 88, [3] = 107, [4] = 94, [5] = 47 })[R[0]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [0] = 67, [1] = 101, [2] = 99, [3] = 73, [4] = 36, [5] = 29 })[R[0]], ({ [0] = 35, [1] = 44, [2] = 80, [3] = 97, [4] = 87, [5] = 52 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    game.set_cell_type({ 24, 87 }, 6)
    game.initial_set_tile({ 24, 87 }, 1531)
    game.set_cell_type({ 24, 88 }, 6)
    game.initial_set_tile({ 24, 88 }, 1533)
    game.set_cell_type({ 25, 87 }, 6)
    game.initial_set_tile({ 25, 87 }, 1532)
    game.set_cell_type({ 25, 88 }, 6)
    game.initial_set_tile({ 25, 88 }, 1534)
    game.set_cell_type({ 29, 42 }, 6)
    game.initial_set_tile({ 29, 42 }, 1531)
    game.set_cell_type({ 29, 43 }, 6)
    game.initial_set_tile({ 29, 43 }, 1533)
    game.set_cell_type({ 30, 42 }, 6)
    game.initial_set_tile({ 30, 42 }, 1532)
    game.set_cell_type({ 30, 43 }, 6)
    game.initial_set_tile({ 30, 43 }, 1534)
    game.set_cell_type({ 77, 99 }, 6)
    game.initial_set_tile({ 77, 99 }, 1531)
    game.set_cell_type({ 77, 100 }, 6)
    game.initial_set_tile({ 77, 100 }, 1533)
    game.set_cell_type({ 78, 99 }, 6)
    game.initial_set_tile({ 78, 99 }, 1532)
    game.set_cell_type({ 78, 100 }, 6)
    game.initial_set_tile({ 78, 100 }, 1534)
    game.set_cell_type({ 115, 82 }, 6)
    game.initial_set_tile({ 115, 82 }, 1531)
    game.set_cell_type({ 115, 83 }, 6)
    game.initial_set_tile({ 115, 83 }, 1533)
    game.set_cell_type({ 116, 82 }, 6)
    game.initial_set_tile({ 116, 82 }, 1532)
    game.set_cell_type({ 116, 83 }, 6)
    game.initial_set_tile({ 116, 83 }, 1534)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 69, 41 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 38, 54 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 41, 82 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 73, 91 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 94, 79 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 94, 48 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 80, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 89, 14 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 125, 7 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 114, 12 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 116, 23 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 39 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 108, 55 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 114, 65 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 126, 81 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 87, 61 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 81, 44 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 66, 52 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 76, 64 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 71, 78 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 89, 94 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 116 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 115, 106 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 118, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 59, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 50, 108 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 55, 95 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 45, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 51, 54 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 24, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 4, 84 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 13, 120 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 8, 94 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 6, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 7, 43 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 4, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 4, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 23, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 49, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 37, 36 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 33, 23 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 53, 10 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 54, 84 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 61, 78 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 91, 65 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 85, 14 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 95, 119 } }
    pick(6, 5, { 0, 2, 3, 4, 5 })
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 25, [1] = 68, [2] = 110, [3] = 111, [4] = 73, [5] = 34 })[R[0]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[0]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 3 or R[0] == 4 or R[0] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [3] = 105, [4] = 67, [5] = 28 })[R[0]], ({ [3] = 88, [4] = 107, [5] = 94 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[0] == 0 or R[0] == 1 or R[0] == 2 then
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[0]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 19, [1] = 62, [2] = 104, [3] = 105, [4] = 67, [5] = 28 })[R[0]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 3 or R[0] == 4 or R[0] == 5 then
    elseif R[0] == 0 or R[0] == 1 or R[0] == 2 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 19, [1] = 62, [2] = 104 })[R[0]], ({ [0] = 47, [1] = 26, [2] = 36 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 20, [1] = 63, [2] = 105, [3] = 106, [4] = 68, [5] = 29 })[R[0]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 8 then
        elseif game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif game.initial_units() == 4 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[1]:center_view({ ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[0]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[0]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 29, [1] = 67, [2] = 101, [3] = 99, [4] = 73, [5] = 36 })[R[0]], ({ [0] = 52, [1] = 35, [2] = 44, [3] = 80, [4] = 97, [5] = 87 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 25, [1] = 68, [2] = 110, [3] = 111, [4] = 73, [5] = 34 })[R[2]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[2]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 0 or R[2] == 1 or R[2] == 2 then
    elseif R[2] == 3 or R[2] == 4 or R[2] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [3] = 105, [4] = 67, [5] = 28 })[R[2]], ({ [3] = 88, [4] = 107, [5] = 94 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[2]", R[2])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[2]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 19, [1] = 62, [2] = 104, [3] = 105, [4] = 67, [5] = 28 })[R[2]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 0 or R[2] == 1 or R[2] == 2 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 19, [1] = 62, [2] = 104 })[R[2]], ({ [0] = 47, [1] = 26, [2] = 36 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 3 or R[2] == 4 or R[2] == 5 then
    else
      unseen("R[2]", R[2])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 20, [1] = 63, [2] = 105, [3] = 106, [4] = 68, [5] = 29 })[R[2]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 8 then
        elseif game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif game.initial_units() == 4 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[2]:center_view({ ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[2]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[2]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 29, [1] = 67, [2] = 101, [3] = 99, [4] = 73, [5] = 36 })[R[2]], ({ [0] = 52, [1] = 35, [2] = 44, [3] = 80, [4] = 97, [5] = 87 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 25, [1] = 68, [2] = 110, [3] = 111, [4] = 73, [5] = 34 })[R[3]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[3]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    if R[3] == 0 or R[3] == 1 or R[3] == 2 then
    elseif R[3] == 3 or R[3] == 4 or R[3] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [3] = 105, [4] = 67, [5] = 28 })[R[3]], ({ [3] = 88, [4] = 107, [5] = 94 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[3]", R[3])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[3]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 19, [1] = 62, [2] = 104, [3] = 105, [4] = 67, [5] = 28 })[R[3]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    if R[3] == 0 or R[3] == 1 or R[3] == 2 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 19, [1] = 62, [2] = 104 })[R[3]], ({ [0] = 47, [1] = 26, [2] = 36 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[3] == 3 or R[3] == 4 or R[3] == 5 then
    else
      unseen("R[3]", R[3])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 20, [1] = 63, [2] = 105, [3] = 106, [4] = 68, [5] = 29 })[R[3]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 8 then
        elseif game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif game.initial_units() == 4 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[3]:center_view({ ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[3]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[3]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 29, [1] = 67, [2] = 101, [3] = 99, [4] = 73, [5] = 36 })[R[3]], ({ [0] = 52, [1] = 35, [2] = 44, [3] = 80, [4] = 97, [5] = 87 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 25, [1] = 68, [2] = 110, [3] = 111, [4] = 73, [5] = 34 })[R[4]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[4]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    if R[4] == 3 or R[4] == 4 or R[4] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [3] = 105, [4] = 67, [5] = 28 })[R[4]], ({ [3] = 88, [4] = 107, [5] = 94 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[4] == 0 or R[4] == 1 or R[4] == 2 then
    else
      unseen("R[4]", R[4])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[4]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 19, [1] = 62, [2] = 104, [3] = 105, [4] = 67, [5] = 28 })[R[4]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    if R[4] == 3 or R[4] == 4 or R[4] == 5 then
    elseif R[4] == 0 or R[4] == 1 or R[4] == 2 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 19, [1] = 62, [2] = 104 })[R[4]], ({ [0] = 47, [1] = 26, [2] = 36 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[4]", R[4])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 20, [1] = 63, [2] = 105, [3] = 106, [4] = 68, [5] = 29 })[R[4]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 8 then
        elseif game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif game.initial_units() == 4 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[4]:center_view({ ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[4]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[4]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [0] = 29, [1] = 67, [2] = 101, [3] = 99, [4] = 73, [5] = 36 })[R[4]], ({ [0] = 52, [1] = 35, [2] = 44, [3] = 80, [4] = 97, [5] = 87 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[5], at = { ({ [0] = 25, [1] = 68, [2] = 110, [3] = 111, [4] = 73, [5] = 34 })[R[5]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[5], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[5]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[5] == 0 or R[5] == 1 or R[5] == 2 then
    elseif R[5] == 3 or R[5] == 4 or R[5] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[5], at = { ({ [3] = 105, [4] = 67, [5] = 28 })[R[5]], ({ [3] = 88, [4] = 107, [5] = 94 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[5]", R[5])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[5], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[5]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[5], at = { ({ [0] = 19, [1] = 62, [2] = 104, [3] = 105, [4] = 67, [5] = 28 })[R[5]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[5] == 0 or R[5] == 1 or R[5] == 2 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[5], at = { ({ [0] = 19, [1] = 62, [2] = 104 })[R[5]], ({ [0] = 47, [1] = 26, [2] = 36 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[5] == 3 or R[5] == 4 or R[5] == 5 then
    else
      unseen("R[5]", R[5])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[5], at = { ({ [0] = 20, [1] = 63, [2] = 105, [3] = 106, [4] = 68, [5] = 29 })[R[5]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 8 then
        elseif game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif game.initial_units() == 4 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[5]:center_view({ ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[5]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[5]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[5], at = { ({ [0] = 29, [1] = 67, [2] = 101, [3] = 99, [4] = 73, [5] = 36 })[R[5]], ({ [0] = 52, [1] = 35, [2] = 44, [3] = 80, [4] = 97, [5] = 87 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    game.set_cell_type({ 24, 87 }, 6)
    game.initial_set_tile({ 24, 87 }, 1531)
    game.set_cell_type({ 24, 88 }, 6)
    game.initial_set_tile({ 24, 88 }, 1533)
    game.set_cell_type({ 25, 87 }, 6)
    game.initial_set_tile({ 25, 87 }, 1532)
    game.set_cell_type({ 25, 88 }, 6)
    game.initial_set_tile({ 25, 88 }, 1534)
    game.set_cell_type({ 29, 42 }, 6)
    game.initial_set_tile({ 29, 42 }, 1531)
    game.set_cell_type({ 29, 43 }, 6)
    game.initial_set_tile({ 29, 43 }, 1533)
    game.set_cell_type({ 30, 42 }, 6)
    game.initial_set_tile({ 30, 42 }, 1532)
    game.set_cell_type({ 30, 43 }, 6)
    game.initial_set_tile({ 30, 43 }, 1534)
    game.set_cell_type({ 77, 99 }, 6)
    game.initial_set_tile({ 77, 99 }, 1531)
    game.set_cell_type({ 77, 100 }, 6)
    game.initial_set_tile({ 77, 100 }, 1533)
    game.set_cell_type({ 78, 99 }, 6)
    game.initial_set_tile({ 78, 99 }, 1532)
    game.set_cell_type({ 78, 100 }, 6)
    game.initial_set_tile({ 78, 100 }, 1534)
    game.set_cell_type({ 115, 82 }, 6)
    game.initial_set_tile({ 115, 82 }, 1531)
    game.set_cell_type({ 115, 83 }, 6)
    game.initial_set_tile({ 115, 83 }, 1533)
    game.set_cell_type({ 116, 82 }, 6)
    game.initial_set_tile({ 116, 82 }, 1532)
    game.set_cell_type({ 116, 83 }, 6)
    game.initial_set_tile({ 116, 83 }, 1534)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 69, 41 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 38, 54 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 41, 82 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 73, 91 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 94, 79 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 94, 48 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 80, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 89, 14 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 125, 7 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 114, 12 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 116, 23 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 39 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 108, 55 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 114, 65 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 126, 81 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 87, 61 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 81, 44 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 66, 52 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 76, 64 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 71, 78 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 89, 94 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 116 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 115, 106 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 118, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 59, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 50, 108 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 55, 95 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 45, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 51, 54 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 24, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 4, 84 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 13, 120 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 8, 94 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 6, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 7, 43 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 4, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 4, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 23, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 49, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 37, 36 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 33, 23 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 53, 10 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 54, 84 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 61, 78 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 91, 65 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 85, 14 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 95, 119 } }
    pick(6, 6, { 0, 2, 3, 4, 5, 6 })
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 25, [1] = 68, [2] = 110, [3] = 111, [4] = 73, [5] = 34 })[R[0]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[0]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 1 or R[0] == 2 then
    elseif R[0] == 3 or R[0] == 4 or R[0] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [3] = 105, [4] = 67, [5] = 28 })[R[0]], ({ [3] = 88, [4] = 107, [5] = 94 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[0]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 19, [1] = 62, [2] = 104, [3] = 105, [4] = 67, [5] = 28 })[R[0]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 1 or R[0] == 2 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 19, [1] = 62, [2] = 104 })[R[0]], ({ [0] = 47, [1] = 26, [2] = 36 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[0] == 3 or R[0] == 4 or R[0] == 5 then
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 20, [1] = 63, [2] = 105, [3] = 106, [4] = 68, [5] = 29 })[R[0]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[0]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 8 then
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif game.initial_units() == 4 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[1]:center_view({ ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[0]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[0]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 29, [1] = 67, [2] = 101, [3] = 99, [4] = 73, [5] = 36 })[R[0]], ({ [0] = 52, [1] = 35, [2] = 44, [3] = 80, [4] = 97, [5] = 87 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 25, [1] = 68, [2] = 110, [3] = 111, [4] = 73, [5] = 34 })[R[2]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[2]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 3 or R[2] == 4 or R[2] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [3] = 105, [4] = 67, [5] = 28 })[R[2]], ({ [3] = 88, [4] = 107, [5] = 94 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 0 or R[2] == 1 or R[2] == 2 then
    else
      unseen("R[2]", R[2])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[2]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 19, [1] = 62, [2] = 104, [3] = 105, [4] = 67, [5] = 28 })[R[2]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 3 or R[2] == 4 or R[2] == 5 then
    elseif R[2] == 0 or R[2] == 1 or R[2] == 2 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 19, [1] = 62, [2] = 104 })[R[2]], ({ [0] = 47, [1] = 26, [2] = 36 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[2]", R[2])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 20, [1] = 63, [2] = 105, [3] = 106, [4] = 68, [5] = 29 })[R[2]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[2]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 8 then
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif game.initial_units() == 4 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[2]:center_view({ ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[2]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[2]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 29, [1] = 67, [2] = 101, [3] = 99, [4] = 73, [5] = 36 })[R[2]], ({ [0] = 52, [1] = 35, [2] = 44, [3] = 80, [4] = 97, [5] = 87 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 25, [1] = 68, [2] = 110, [3] = 111, [4] = 73, [5] = 34 })[R[3]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[3]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    if R[3] == 0 or R[3] == 1 or R[3] == 2 then
    elseif R[3] == 3 or R[3] == 4 or R[3] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [3] = 105, [4] = 67, [5] = 28 })[R[3]], ({ [3] = 88, [4] = 107, [5] = 94 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[3]", R[3])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[3]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 19, [1] = 62, [2] = 104, [3] = 105, [4] = 67, [5] = 28 })[R[3]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    if R[3] == 0 or R[3] == 1 or R[3] == 2 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 19, [1] = 62, [2] = 104 })[R[3]], ({ [0] = 47, [1] = 26, [2] = 36 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[3] == 3 or R[3] == 4 or R[3] == 5 then
    else
      unseen("R[3]", R[3])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 20, [1] = 63, [2] = 105, [3] = 106, [4] = 68, [5] = 29 })[R[3]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[3]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 8 then
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif game.initial_units() == 4 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[3]:center_view({ ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[3]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[3]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 29, [1] = 67, [2] = 101, [3] = 99, [4] = 73, [5] = 36 })[R[3]], ({ [0] = 52, [1] = 35, [2] = 44, [3] = 80, [4] = 97, [5] = 87 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 25, [1] = 68, [2] = 110, [3] = 111, [4] = 73, [5] = 34 })[R[4]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[4]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    if R[4] == 3 or R[4] == 4 or R[4] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [3] = 105, [4] = 67, [5] = 28 })[R[4]], ({ [3] = 88, [4] = 107, [5] = 94 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[4] == 0 or R[4] == 1 or R[4] == 2 then
    else
      unseen("R[4]", R[4])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[4]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 19, [1] = 62, [2] = 104, [3] = 105, [4] = 67, [5] = 28 })[R[4]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    if R[4] == 3 or R[4] == 4 or R[4] == 5 then
    elseif R[4] == 0 or R[4] == 1 or R[4] == 2 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 19, [1] = 62, [2] = 104 })[R[4]], ({ [0] = 47, [1] = 26, [2] = 36 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[4]", R[4])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 20, [1] = 63, [2] = 105, [3] = 106, [4] = 68, [5] = 29 })[R[4]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[4]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 8 then
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif game.initial_units() == 4 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[4]:center_view({ ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[4]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[4]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [0] = 29, [1] = 67, [2] = 101, [3] = 99, [4] = 73, [5] = 36 })[R[4]], ({ [0] = 52, [1] = 35, [2] = 44, [3] = 80, [4] = 97, [5] = 87 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[5], at = { ({ [0] = 25, [1] = 68, [2] = 110, [3] = 111, [4] = 73, [5] = 34 })[R[5]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[5], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[5]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[5] == 3 or R[5] == 4 or R[5] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[5], at = { ({ [3] = 105, [4] = 67, [5] = 28 })[R[5]], ({ [3] = 88, [4] = 107, [5] = 94 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[5] == 0 or R[5] == 1 or R[5] == 2 then
    else
      unseen("R[5]", R[5])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[5], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[5]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[5], at = { ({ [0] = 19, [1] = 62, [2] = 104, [3] = 105, [4] = 67, [5] = 28 })[R[5]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[5] == 3 or R[5] == 4 or R[5] == 5 then
    elseif R[5] == 0 or R[5] == 1 or R[5] == 2 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[5], at = { ({ [0] = 19, [1] = 62, [2] = 104 })[R[5]], ({ [0] = 47, [1] = 26, [2] = 36 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[5]", R[5])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[5], at = { ({ [0] = 20, [1] = 63, [2] = 105, [3] = 106, [4] = 68, [5] = 29 })[R[5]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[5]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 8 then
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif game.initial_units() == 4 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[5]:center_view({ ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[5]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[5]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[5], at = { ({ [0] = 29, [1] = 67, [2] = 101, [3] = 99, [4] = 73, [5] = 36 })[R[5]], ({ [0] = 52, [1] = 35, [2] = 44, [3] = 80, [4] = 97, [5] = 87 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[6], at = { ({ [0] = 25, [1] = 68, [2] = 110, [3] = 111, [4] = 73, [5] = 34 })[R[6]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[6], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[6]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    if R[6] == 0 or R[6] == 1 or R[6] == 2 then
    elseif R[6] == 3 or R[6] == 4 or R[6] == 5 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[6], at = { ({ [3] = 105, [4] = 67, [5] = 28 })[R[6]], ({ [3] = 88, [4] = 107, [5] = 94 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[6]", R[6])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[6], at = { ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[6]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[6], at = { ({ [0] = 19, [1] = 62, [2] = 104, [3] = 105, [4] = 67, [5] = 28 })[R[6]], ({ [0] = 44, [1] = 23, [2] = 33, [3] = 91, [4] = 110, [5] = 97 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    if R[6] == 0 or R[6] == 1 or R[6] == 2 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[6], at = { ({ [0] = 19, [1] = 62, [2] = 104 })[R[6]], ({ [0] = 47, [1] = 26, [2] = 36 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[6] == 3 or R[6] == 4 or R[6] == 5 then
    else
      unseen("R[6]", R[6])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[6], at = { ({ [0] = 20, [1] = 63, [2] = 105, [3] = 106, [4] = 68, [5] = 29 })[R[6]], ({ [0] = 50, [1] = 29, [2] = 39, [3] = 84, [4] = 103, [5] = 90 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
      U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(5, "Tokamak")
        U[#U]:set_factory_cargo(6, "Residence")
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 22, [1] = 65, [2] = 107, [3] = 107, [4] = 69, [5] = 30 })[R[6]], ({ [0] = 46, [1] = 25, [2] = 35, [3] = 86, [4] = 105, [5] = 92 })[R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 8 then
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif game.initial_units() == 4 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    players[6]:center_view({ ({ [0] = 24, [1] = 67, [2] = 109, [3] = 110, [4] = 72, [5] = 33 })[R[6]], ({ [0] = 47, [1] = 26, [2] = 36, [3] = 88, [4] = 107, [5] = 94 })[R[6]] })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[6], at = { ({ [0] = 29, [1] = 67, [2] = 101, [3] = 99, [4] = 73, [5] = 36 })[R[6]], ({ [0] = 52, [1] = 35, [2] = 44, [3] = 80, [4] = 97, [5] = 87 })[R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    trigger.time{min = 8000, max = 16000, one_shot = false, on = DoDisaster}  -- after 80 to 160 marks
  end
  return true
end
