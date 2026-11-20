-- mu2_02Lua.lua  -  2 Player, LandRush, 'Great Divide' map. (Lua)
--
-- Converted by op2dll from mu2_02.dll ("2 Player, LandRush, 'Great Divide' map."): its setup replayed. `on_init` makes the original's
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
local BigQuake, Meteor

function BigQuake(t)
  game.create_earthquake({ 57, 21 }, 4)
end

function Meteor(t)
  local r1 = game.rand(62)
  local r2 = game.rand(128)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
end

function on_init()
  local n = game.num_players()
  pick(7, 2, { 0, 1 })
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 20, [1] = 31, [2] = 41, [3] = 47, [4] = 56, [5] = 67, [6] = 86 })[R[0]], ({ [0] = 22, [1] = 8, [2] = 50, [3] = 33, [4] = 41, [5] = 46, [6] = 56 })[R[0]] } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 20, [1] = 31, [2] = 41, [3] = 47, [4] = 56, [5] = 67, [6] = 86 })[R[1]], ({ [0] = 22, [1] = 8, [2] = 50, [3] = 33, [4] = 41, [5] = 46, [6] = 56 })[R[1]] } }
  pick(7, 2, { 2, 3 })
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 75, [1] = 74, [2] = 113, [3] = 61, [4] = 71, [5] = 100, [6] = 80 })[R[2]], ({ [0] = 29, [1] = 48, [2] = 56, [3] = 7, [4] = 19, [5] = 25, [6] = 8 })[R[2]] } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 75, [1] = 74, [2] = 113, [3] = 61, [4] = 71, [5] = 100, [6] = 80 })[R[3]], ({ [0] = 29, [1] = 48, [2] = 56, [3] = 7, [4] = 19, [5] = 25, [6] = 8 })[R[3]] } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 105, 5 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 5, 34 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 108, 22 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 25, 57 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 8, 32 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 95, 18 } }
  pick(2, 2, { 4, 5 })
  R[6] = game.rand(8)
  players[1]:center_view({ ({ [0] = 34, [1] = 85 })[R[5]], ({ [0] = 27, [1] = 39 })[R[5]] })
  U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 34, [1] = 85 })[R[5]], ({ [0] = 27, [1] = 39 })[R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 34, [1] = 85 }, [1] = { [0] = 33, [1] = 84 }, [2] = { [0] = 32, [1] = 83 }, [3] = { [0] = 33, [1] = 84 }, [4] = { [0] = 34, [1] = 85 }, [5] = { [0] = 35, [1] = 86 }, [6] = { [0] = 36, [1] = 87 }, [7] = { [0] = 35, [1] = 86 } })[R[6]][R[5]], ({ [0] = { [0] = 29, [1] = 41 }, [1] = { [0] = 28, [1] = 40 }, [2] = { [0] = 27, [1] = 39 }, [3] = { [0] = 26, [1] = 38 }, [4] = { [0] = 25, [1] = 37 }, [5] = { [0] = 26, [1] = 38 }, [6] = { [0] = 27, [1] = 39 }, [7] = { [0] = 28, [1] = 40 } })[R[6]][R[5]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 33, [1] = 84 }, [1] = { [0] = 31, [1] = 82 }, [2] = { [0] = 31, [1] = 82 }, [3] = { [0] = 31, [1] = 82 }, [4] = { [0] = 33, [1] = 84 }, [5] = { [0] = 37, [1] = 88 }, [6] = { [0] = 37, [1] = 88 }, [7] = { [0] = 37, [1] = 88 } })[R[6]][R[5]], ({ [0] = { [0] = 31, [1] = 43 }, [1] = { [0] = 28, [1] = 40 }, [2] = { [0] = 26, [1] = 38 }, [3] = { [0] = 26, [1] = 38 }, [4] = { [0] = 23, [1] = 35 }, [5] = { [0] = 26, [1] = 38 }, [6] = { [0] = 26, [1] = 38 }, [7] = { [0] = 28, [1] = 40 } })[R[6]][R[5]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 35, [1] = 86 }, [1] = { [0] = 33, [1] = 84 }, [2] = { [0] = 31, [1] = 82 }, [3] = { [0] = 33, [1] = 84 }, [4] = { [0] = 35, [1] = 86 }, [5] = { [0] = 35, [1] = 86 }, [6] = { [0] = 37, [1] = 88 }, [7] = { [0] = 35, [1] = 86 } })[R[6]][R[5]], ({ [0] = { [0] = 31, [1] = 43 }, [1] = { [0] = 30, [1] = 42 }, [2] = { [0] = 28, [1] = 40 }, [3] = { [0] = 24, [1] = 36 }, [4] = { [0] = 23, [1] = 35 }, [5] = { [0] = 24, [1] = 36 }, [6] = { [0] = 28, [1] = 40 }, [7] = { [0] = 30, [1] = 42 } })[R[6]][R[5]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 33, [1] = 84 }, [1] = { [0] = 30, [1] = 81 }, [2] = { [0] = 29, [1] = 80 }, [3] = { [0] = 30, [1] = 81 }, [4] = { [0] = 33, [1] = 84 }, [5] = { [0] = 38, [1] = 89 }, [6] = { [0] = 39, [1] = 90 }, [7] = { [0] = 38, [1] = 89 } })[R[6]][R[5]], ({ [0] = { [0] = 33, [1] = 45 }, [1] = { [0] = 29, [1] = 41 }, [2] = { [0] = 26, [1] = 38 }, [3] = { [0] = 25, [1] = 37 }, [4] = { [0] = 21, [1] = 33 }, [5] = { [0] = 25, [1] = 37 }, [6] = { [0] = 26, [1] = 38 }, [7] = { [0] = 29, [1] = 41 } })[R[6]][R[5]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 35, [1] = 86 }, [1] = { [0] = 32, [1] = 83 }, [2] = { [0] = 29, [1] = 80 }, [3] = { [0] = 32, [1] = 83 }, [4] = { [0] = 35, [1] = 86 }, [5] = { [0] = 36, [1] = 87 }, [6] = { [0] = 39, [1] = 90 }, [7] = { [0] = 36, [1] = 87 } })[R[6]][R[5]], ({ [0] = { [0] = 33, [1] = 45 }, [1] = { [0] = 31, [1] = 43 }, [2] = { [0] = 28, [1] = 40 }, [3] = { [0] = 23, [1] = 35 }, [4] = { [0] = 21, [1] = 33 }, [5] = { [0] = 23, [1] = 35 }, [6] = { [0] = 28, [1] = 40 }, [7] = { [0] = 31, [1] = 43 } })[R[6]][R[5]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 33, [1] = 84 }, [1] = { [0] = 29, [1] = 80 }, [2] = { [0] = 27, [1] = 78 }, [3] = { [0] = 29, [1] = 80 }, [4] = { [0] = 33, [1] = 84 }, [5] = { [0] = 39, [1] = 90 }, [6] = { [0] = 41, [1] = 92 }, [7] = { [0] = 39, [1] = 90 } })[R[6]][R[5]], ({ [0] = { [0] = 35, [1] = 47 }, [1] = { [0] = 30, [1] = 42 }, [2] = { [0] = 26, [1] = 38 }, [3] = { [0] = 24, [1] = 36 }, [4] = { [0] = 19, [1] = 31 }, [5] = { [0] = 24, [1] = 36 }, [6] = { [0] = 26, [1] = 38 }, [7] = { [0] = 30, [1] = 42 } })[R[6]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 35, [1] = 86 }, [1] = { [0] = 31, [1] = 82 }, [2] = { [0] = 27, [1] = 78 }, [3] = { [0] = 31, [1] = 82 }, [4] = { [0] = 35, [1] = 86 }, [5] = { [0] = 37, [1] = 88 }, [6] = { [0] = 41, [1] = 92 }, [7] = { [0] = 37, [1] = 88 } })[R[6]][R[5]], ({ [0] = { [0] = 35, [1] = 47 }, [1] = { [0] = 32, [1] = 44 }, [2] = { [0] = 28, [1] = 40 }, [3] = { [0] = 22, [1] = 34 }, [4] = { [0] = 19, [1] = 31 }, [5] = { [0] = 22, [1] = 34 }, [6] = { [0] = 28, [1] = 40 }, [7] = { [0] = 32, [1] = 44 } })[R[6]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 34, [1] = 85 }, [1] = { [0] = 29, [1] = 80 }, [2] = { [0] = 26, [1] = 77 }, [3] = { [0] = 29, [1] = 80 }, [4] = { [0] = 34, [1] = 85 }, [5] = { [0] = 39, [1] = 90 }, [6] = { [0] = 42, [1] = 93 }, [7] = { [0] = 39, [1] = 90 } })[R[6]][R[5]], ({ [0] = { [0] = 37, [1] = 49 }, [1] = { [0] = 32, [1] = 44 }, [2] = { [0] = 27, [1] = 39 }, [3] = { [0] = 22, [1] = 34 }, [4] = { [0] = 17, [1] = 29 }, [5] = { [0] = 22, [1] = 34 }, [6] = { [0] = 27, [1] = 39 }, [7] = { [0] = 32, [1] = 44 } })[R[6]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("Food", 1000)
  U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = { [0] = 33, [1] = 84 }, [1] = { [0] = 27, [1] = 78 }, [2] = { [0] = 25, [1] = 76 }, [3] = { [0] = 27, [1] = 78 }, [4] = { [0] = 33, [1] = 84 }, [5] = { [0] = 41, [1] = 92 }, [6] = { [0] = 43, [1] = 94 }, [7] = { [0] = 41, [1] = 92 } })[R[6]][R[5]], ({ [0] = { [0] = 39, [1] = 51 }, [1] = { [0] = 32, [1] = 44 }, [2] = { [0] = 26, [1] = 38 }, [3] = { [0] = 22, [1] = 34 }, [4] = { [0] = 15, [1] = 27 }, [5] = { [0] = 22, [1] = 34 }, [6] = { [0] = 26, [1] = 38 }, [7] = { [0] = 32, [1] = 44 } })[R[6]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 35, [1] = 86 }, [1] = { [0] = 29, [1] = 80 }, [2] = { [0] = 25, [1] = 76 }, [3] = { [0] = 29, [1] = 80 }, [4] = { [0] = 35, [1] = 86 }, [5] = { [0] = 39, [1] = 90 }, [6] = { [0] = 43, [1] = 94 }, [7] = { [0] = 39, [1] = 90 } })[R[6]][R[5]], ({ [0] = { [0] = 39, [1] = 51 }, [1] = { [0] = 34, [1] = 46 }, [2] = { [0] = 28, [1] = 40 }, [3] = { [0] = 20, [1] = 32 }, [4] = { [0] = 15, [1] = 27 }, [5] = { [0] = 20, [1] = 32 }, [6] = { [0] = 28, [1] = 40 }, [7] = { [0] = 34, [1] = 46 } })[R[6]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if game.initial_units() == 0 then
  elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
    for i = 1, game.initial_units() do
      R[7] = game.rand(4)
      if R[6] == 0 then
        if R[5] == 0 then
          if R[7] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 28 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 28 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[7] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 28 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 28 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[7] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 37 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 37 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[7] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 37 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 37 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[7]", R[7])
          end
        elseif R[5] == 1 then
          if R[7] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 40 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 40 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[7] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 40 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 40 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[7] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 49 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 49 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[7] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 49 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 49 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[7]", R[7])
          end
        else
          unseen("R[5]", R[5])
        end
      elseif R[6] == 1 then
        if R[7] == 0 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 26 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 26 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 38 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 38 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 1 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 35, 30 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 35, 30 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 86, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 86, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 2 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 29 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 29 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 41 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 41 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 3 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 35 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 35 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 47 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 47 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[7]", R[7])
        end
      elseif R[6] == 2 then
        if R[7] == 0 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 32, 24 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 32, 24 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 83, 36 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 83, 36 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 1 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 24 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 24 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 36 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 36 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 2 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 32, 30 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 32, 30 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 83, 42 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 83, 42 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 3 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 30 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 30 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 42 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 42 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[7]", R[7])
        end
      elseif R[6] == 3 then
        if R[7] == 0 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 28 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 28 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 40 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 40 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 1 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 35, 24 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 35, 24 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 86, 36 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 86, 36 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 2 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 25 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 25 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 3 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 19 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 19 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 31 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 31 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[7]", R[7])
        end
      elseif R[6] == 4 then
        if R[5] == 0 then
          if R[7] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 26 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 26 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[7] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 26 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 26 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[7] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 17 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 17 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[7] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 17 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 17 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[7]", R[7])
          end
        elseif R[5] == 1 then
          if R[7] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 38 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 38 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[7] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 38 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 38 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[7] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 29 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 29 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[7] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 29 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 29 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[7]", R[7])
          end
        else
          unseen("R[5]", R[5])
        end
      elseif R[6] == 5 then
        if R[7] == 0 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 28 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 28 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 40 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 40 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 1 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 24 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 24 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 84, 36 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 84, 36 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 2 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 25 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 25 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 3 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 19 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 19 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 31 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 31 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[7]", R[7])
        end
      elseif R[6] == 6 then
        if R[7] == 0 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 36, 24 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 36, 24 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 87, 36 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 87, 36 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 1 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 24 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 24 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 36 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 36 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 2 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 36, 30 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 36, 30 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 87, 42 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 87, 42 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 3 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 30 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 30 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 42 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 42 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[7]", R[7])
        end
      elseif R[6] == 7 then
        if R[7] == 0 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 26 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 26 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 38 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 38 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 1 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 30 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 30 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 84, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 84, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 2 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 29 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 29 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 41 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 41 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 3 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 35 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 35 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 47 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 47 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[7]", R[7])
        end
      else
        unseen("R[6]", R[6])
      end
      U[#U]:set_lights(true)
    end
  else
    unseen("game.initial_units()", game.initial_units())
  end
  R[8] = game.rand(8)
  players[2]:center_view({ ({ [0] = 85, [1] = 34 })[R[5]], ({ [0] = 39, [1] = 27 })[R[5]] })
  U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 85, [1] = 34 })[R[5]], ({ [0] = 39, [1] = 27 })[R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 85, [1] = 34 }, [1] = { [0] = 84, [1] = 33 }, [2] = { [0] = 83, [1] = 32 }, [3] = { [0] = 84, [1] = 33 }, [4] = { [0] = 85, [1] = 34 }, [5] = { [0] = 86, [1] = 35 }, [6] = { [0] = 87, [1] = 36 }, [7] = { [0] = 86, [1] = 35 } })[R[8]][R[5]], ({ [0] = { [0] = 41, [1] = 29 }, [1] = { [0] = 40, [1] = 28 }, [2] = { [0] = 39, [1] = 27 }, [3] = { [0] = 38, [1] = 26 }, [4] = { [0] = 37, [1] = 25 }, [5] = { [0] = 38, [1] = 26 }, [6] = { [0] = 39, [1] = 27 }, [7] = { [0] = 40, [1] = 28 } })[R[8]][R[5]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 84, [1] = 33 }, [1] = { [0] = 82, [1] = 31 }, [2] = { [0] = 82, [1] = 31 }, [3] = { [0] = 82, [1] = 31 }, [4] = { [0] = 84, [1] = 33 }, [5] = { [0] = 88, [1] = 37 }, [6] = { [0] = 88, [1] = 37 }, [7] = { [0] = 88, [1] = 37 } })[R[8]][R[5]], ({ [0] = { [0] = 43, [1] = 31 }, [1] = { [0] = 40, [1] = 28 }, [2] = { [0] = 38, [1] = 26 }, [3] = { [0] = 38, [1] = 26 }, [4] = { [0] = 35, [1] = 23 }, [5] = { [0] = 38, [1] = 26 }, [6] = { [0] = 38, [1] = 26 }, [7] = { [0] = 40, [1] = 28 } })[R[8]][R[5]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 86, [1] = 35 }, [1] = { [0] = 84, [1] = 33 }, [2] = { [0] = 82, [1] = 31 }, [3] = { [0] = 84, [1] = 33 }, [4] = { [0] = 86, [1] = 35 }, [5] = { [0] = 86, [1] = 35 }, [6] = { [0] = 88, [1] = 37 }, [7] = { [0] = 86, [1] = 35 } })[R[8]][R[5]], ({ [0] = { [0] = 43, [1] = 31 }, [1] = { [0] = 42, [1] = 30 }, [2] = { [0] = 40, [1] = 28 }, [3] = { [0] = 36, [1] = 24 }, [4] = { [0] = 35, [1] = 23 }, [5] = { [0] = 36, [1] = 24 }, [6] = { [0] = 40, [1] = 28 }, [7] = { [0] = 42, [1] = 30 } })[R[8]][R[5]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 84, [1] = 33 }, [1] = { [0] = 81, [1] = 30 }, [2] = { [0] = 80, [1] = 29 }, [3] = { [0] = 81, [1] = 30 }, [4] = { [0] = 84, [1] = 33 }, [5] = { [0] = 89, [1] = 38 }, [6] = { [0] = 90, [1] = 39 }, [7] = { [0] = 89, [1] = 38 } })[R[8]][R[5]], ({ [0] = { [0] = 45, [1] = 33 }, [1] = { [0] = 41, [1] = 29 }, [2] = { [0] = 38, [1] = 26 }, [3] = { [0] = 37, [1] = 25 }, [4] = { [0] = 33, [1] = 21 }, [5] = { [0] = 37, [1] = 25 }, [6] = { [0] = 38, [1] = 26 }, [7] = { [0] = 41, [1] = 29 } })[R[8]][R[5]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 86, [1] = 35 }, [1] = { [0] = 83, [1] = 32 }, [2] = { [0] = 80, [1] = 29 }, [3] = { [0] = 83, [1] = 32 }, [4] = { [0] = 86, [1] = 35 }, [5] = { [0] = 87, [1] = 36 }, [6] = { [0] = 90, [1] = 39 }, [7] = { [0] = 87, [1] = 36 } })[R[8]][R[5]], ({ [0] = { [0] = 45, [1] = 33 }, [1] = { [0] = 43, [1] = 31 }, [2] = { [0] = 40, [1] = 28 }, [3] = { [0] = 35, [1] = 23 }, [4] = { [0] = 33, [1] = 21 }, [5] = { [0] = 35, [1] = 23 }, [6] = { [0] = 40, [1] = 28 }, [7] = { [0] = 43, [1] = 31 } })[R[8]][R[5]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 84, [1] = 33 }, [1] = { [0] = 80, [1] = 29 }, [2] = { [0] = 78, [1] = 27 }, [3] = { [0] = 80, [1] = 29 }, [4] = { [0] = 84, [1] = 33 }, [5] = { [0] = 90, [1] = 39 }, [6] = { [0] = 92, [1] = 41 }, [7] = { [0] = 90, [1] = 39 } })[R[8]][R[5]], ({ [0] = { [0] = 47, [1] = 35 }, [1] = { [0] = 42, [1] = 30 }, [2] = { [0] = 38, [1] = 26 }, [3] = { [0] = 36, [1] = 24 }, [4] = { [0] = 31, [1] = 19 }, [5] = { [0] = 36, [1] = 24 }, [6] = { [0] = 38, [1] = 26 }, [7] = { [0] = 42, [1] = 30 } })[R[8]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 86, [1] = 35 }, [1] = { [0] = 82, [1] = 31 }, [2] = { [0] = 78, [1] = 27 }, [3] = { [0] = 82, [1] = 31 }, [4] = { [0] = 86, [1] = 35 }, [5] = { [0] = 88, [1] = 37 }, [6] = { [0] = 92, [1] = 41 }, [7] = { [0] = 88, [1] = 37 } })[R[8]][R[5]], ({ [0] = { [0] = 47, [1] = 35 }, [1] = { [0] = 44, [1] = 32 }, [2] = { [0] = 40, [1] = 28 }, [3] = { [0] = 34, [1] = 22 }, [4] = { [0] = 31, [1] = 19 }, [5] = { [0] = 34, [1] = 22 }, [6] = { [0] = 40, [1] = 28 }, [7] = { [0] = 44, [1] = 32 } })[R[8]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 85, [1] = 34 }, [1] = { [0] = 80, [1] = 29 }, [2] = { [0] = 77, [1] = 26 }, [3] = { [0] = 80, [1] = 29 }, [4] = { [0] = 85, [1] = 34 }, [5] = { [0] = 90, [1] = 39 }, [6] = { [0] = 93, [1] = 42 }, [7] = { [0] = 90, [1] = 39 } })[R[8]][R[5]], ({ [0] = { [0] = 49, [1] = 37 }, [1] = { [0] = 44, [1] = 32 }, [2] = { [0] = 39, [1] = 27 }, [3] = { [0] = 34, [1] = 22 }, [4] = { [0] = 29, [1] = 17 }, [5] = { [0] = 34, [1] = 22 }, [6] = { [0] = 39, [1] = 27 }, [7] = { [0] = 44, [1] = 32 } })[R[8]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("Food", 1000)
  U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = { [0] = 84, [1] = 33 }, [1] = { [0] = 78, [1] = 27 }, [2] = { [0] = 76, [1] = 25 }, [3] = { [0] = 78, [1] = 27 }, [4] = { [0] = 84, [1] = 33 }, [5] = { [0] = 92, [1] = 41 }, [6] = { [0] = 94, [1] = 43 }, [7] = { [0] = 92, [1] = 41 } })[R[8]][R[5]], ({ [0] = { [0] = 51, [1] = 39 }, [1] = { [0] = 44, [1] = 32 }, [2] = { [0] = 38, [1] = 26 }, [3] = { [0] = 34, [1] = 22 }, [4] = { [0] = 27, [1] = 15 }, [5] = { [0] = 34, [1] = 22 }, [6] = { [0] = 38, [1] = 26 }, [7] = { [0] = 44, [1] = 32 } })[R[8]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 86, [1] = 35 }, [1] = { [0] = 80, [1] = 29 }, [2] = { [0] = 76, [1] = 25 }, [3] = { [0] = 80, [1] = 29 }, [4] = { [0] = 86, [1] = 35 }, [5] = { [0] = 90, [1] = 39 }, [6] = { [0] = 94, [1] = 43 }, [7] = { [0] = 90, [1] = 39 } })[R[8]][R[5]], ({ [0] = { [0] = 51, [1] = 39 }, [1] = { [0] = 46, [1] = 34 }, [2] = { [0] = 40, [1] = 28 }, [3] = { [0] = 32, [1] = 20 }, [4] = { [0] = 27, [1] = 15 }, [5] = { [0] = 32, [1] = 20 }, [6] = { [0] = 40, [1] = 28 }, [7] = { [0] = 46, [1] = 34 } })[R[8]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if game.initial_units() == 0 then
  elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
    for i = 1, game.initial_units() do
      R[9] = game.rand(4)
      if R[8] == 0 then
        if R[5] == 0 then
          if R[9] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 40 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 40 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[9] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 40 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 40 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[9] == 2 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 49 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 49 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[9] == 3 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 49 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 49 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[5] == 1 then
          if R[9] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 28 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 28 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[9] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 28 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 28 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[9] == 2 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 37 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 37 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[9] == 3 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 37 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 37 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[9]", R[9])
          end
        else
          unseen("R[5]", R[5])
        end
      elseif R[8] == 1 then
        if R[9] == 0 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 38 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 38 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 26 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 26 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 1 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 86, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 86, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 35, 30 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 35, 30 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 2 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 41 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 41 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 29 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 29 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 3 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 47 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 47 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 35 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 35 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[9]", R[9])
        end
      elseif R[8] == 2 then
        if R[9] == 0 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 83, 36 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 83, 36 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 32, 24 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 32, 24 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 1 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 36 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 36 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 24 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 24 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 2 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 83, 42 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 83, 42 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 32, 30 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 32, 30 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 3 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 42 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 42 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 30 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 30 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[9]", R[9])
        end
      elseif R[8] == 3 then
        if R[9] == 0 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 40 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 40 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 28 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 28 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 1 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 86, 36 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 86, 36 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 35, 24 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 35, 24 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 2 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 25 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 25 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 3 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 31 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 31 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 19 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 19 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[9]", R[9])
        end
      elseif R[8] == 4 then
        if R[5] == 0 then
          if R[9] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 38 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 38 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[9] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 38 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 38 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[9] == 2 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 29 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 29 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[9] == 3 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 29 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 29 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[5] == 1 then
          if R[9] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 26 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 26 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[9] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 26 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 26 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[9] == 2 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 17 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 17 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[9] == 3 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 17 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 17 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[9]", R[9])
          end
        else
          unseen("R[5]", R[5])
        end
      elseif R[8] == 5 then
        if R[9] == 0 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 40 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 40 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 28 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 28 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 1 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 36 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 36 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 24 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 24 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 2 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 25 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 25 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 3 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 31 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 31 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 19 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 19 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[9]", R[9])
        end
      elseif R[8] == 6 then
        if R[9] == 0 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 36 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 36 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 36, 24 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 36, 24 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 1 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 36 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 36 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 24 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 24 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 2 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 42 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 42 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 36, 30 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 36, 30 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 3 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 42 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 42 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 30 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 30 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[9]", R[9])
        end
      elseif R[8] == 7 then
        if R[9] == 0 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 38 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 38 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 26 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 26 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 1 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 30 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 30 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 2 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 41 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 41 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 29 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 29 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[9] == 3 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 47 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 47 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 35 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 35 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[9]", R[9])
        end
      else
        unseen("R[8]", R[8])
      end
      U[#U]:set_lights(true)
    end
  else
    unseen("game.initial_units()", game.initial_units())
  end
  players[1]:mark_research(3303)
  players[1].workers = 30 - 4 * LEVEL_OF[players[1].difficulty]
  players[1].scientists = 16 - 3 * LEVEL_OF[players[1].difficulty]
  players[1].kids = ({ [0] = 24, [1] = 21, [2] = 22 })[LEVEL_OF[players[1].difficulty]]
  players[1].food = 5000 - 1500 * LEVEL_OF[players[1].difficulty]
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
  players[2].workers = 30 - 4 * LEVEL_OF[players[2].difficulty]
  players[2].scientists = 16 - 3 * LEVEL_OF[players[2].difficulty]
  players[2].kids = ({ [0] = 24, [1] = 21, [2] = 22 })[LEVEL_OF[players[2].difficulty]]
  players[2].food = 5000 - 1500 * LEVEL_OF[players[2].difficulty]
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

  -- The win.
  -- Land Rush: Last One Standing, switched on once every player has settled (a working Command Center)
  -- or is out of the rush (fewer than 5 colonists, or no vehicles). A player's first such moment frees
  -- their morale when the lobby left it free.
  local last_one = trigger.one_player_left{enabled = false}
  local victory = mission.victory(last_one, "Eliminate your opponents.", {one_shot = true, enabled = false})
  local settled, count = {}, 0
  for id = 1, n do
    local function settle()
      if settled[id] then return end
      settled[id] = true
      count = count + 1
      if game.uses_morale() then game.free_morale(id) end
      if count == n and not last_one.enabled then
        last_one:enable()
        victory:enable()
        game.message("New Objective", 122)
      end
    end
    trigger.operational{type = "CommandCenter", compare = ">=", count = 1, player = id, on = settle}
    trigger.resource{resource = "Colonists", compare = "<", amount = 5, player = id, one_shot = true, on = settle}
    trigger.vehicle_count{compare = "<", count = 1, player = id, one_shot = true, on = settle}
  end
  if game.disasters_enabled() then
    trigger.time{min = 5000, max = 10000, one_shot = false, on = Meteor}  -- after 50 to 100 marks
    trigger.time{min = 18000, max = 30000, on = BigQuake}  -- after 180 to 300 marks
  end
  return true
end
