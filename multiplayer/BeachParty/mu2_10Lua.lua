-- mu2_10Lua.lua  -  2 Player, LandRush, 'Beach Party' map. (Lua)
--
-- Converted by op2dll from mu2_10.dll ("2 Player, LandRush, 'Beach Party' map."): its setup replayed. `on_init` makes the original's
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
local Meteors

function Meteors(t)
  local r1 = game.rand(127)
  local r2 = game.rand(128)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
end

function on_init()
  local n = game.num_players()
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 62, 99 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 76, 103 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 66, 119 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 49, 117 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 103, 53 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 13, 39 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 27, 22 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 116, 17 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 81, 23 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 44, 10 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 50, 53 } }
  pick(2, 2, { 0, 1 })
  R[2] = game.rand(8)
  players[1]:center_view({ ({ [0] = 102, [1] = 30 })[R[1]], ({ [0] = 90, [1] = 81 })[R[1]] })
  U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 102, [1] = 30 })[R[1]], ({ [0] = 90, [1] = 81 })[R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[2]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 102, [1] = 30 }, [1] = { [0] = 101, [1] = 29 }, [2] = { [0] = 100, [1] = 28 }, [3] = { [0] = 101, [1] = 29 }, [4] = { [0] = 102, [1] = 30 }, [5] = { [0] = 103, [1] = 31 }, [6] = { [0] = 104, [1] = 32 }, [7] = { [0] = 103, [1] = 31 } })[R[2]][R[1]], ({ [0] = { [0] = 92, [1] = 83 }, [1] = { [0] = 91, [1] = 82 }, [2] = { [0] = 90, [1] = 81 }, [3] = { [0] = 89, [1] = 80 }, [4] = { [0] = 88, [1] = 79 }, [5] = { [0] = 89, [1] = 80 }, [6] = { [0] = 90, [1] = 81 }, [7] = { [0] = 91, [1] = 82 } })[R[2]][R[1]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[2]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 101, [1] = 29 }, [1] = { [0] = 99, [1] = 27 }, [2] = { [0] = 99, [1] = 27 }, [3] = { [0] = 99, [1] = 27 }, [4] = { [0] = 101, [1] = 29 }, [5] = { [0] = 105, [1] = 33 }, [6] = { [0] = 105, [1] = 33 }, [7] = { [0] = 105, [1] = 33 } })[R[2]][R[1]], ({ [0] = { [0] = 94, [1] = 85 }, [1] = { [0] = 91, [1] = 82 }, [2] = { [0] = 89, [1] = 80 }, [3] = { [0] = 89, [1] = 80 }, [4] = { [0] = 86, [1] = 77 }, [5] = { [0] = 89, [1] = 80 }, [6] = { [0] = 89, [1] = 80 }, [7] = { [0] = 91, [1] = 82 } })[R[2]][R[1]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[2]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 103, [1] = 31 }, [1] = { [0] = 101, [1] = 29 }, [2] = { [0] = 99, [1] = 27 }, [3] = { [0] = 101, [1] = 29 }, [4] = { [0] = 103, [1] = 31 }, [5] = { [0] = 103, [1] = 31 }, [6] = { [0] = 105, [1] = 33 }, [7] = { [0] = 103, [1] = 31 } })[R[2]][R[1]], ({ [0] = { [0] = 94, [1] = 85 }, [1] = { [0] = 93, [1] = 84 }, [2] = { [0] = 91, [1] = 82 }, [3] = { [0] = 87, [1] = 78 }, [4] = { [0] = 86, [1] = 77 }, [5] = { [0] = 87, [1] = 78 }, [6] = { [0] = 91, [1] = 82 }, [7] = { [0] = 93, [1] = 84 } })[R[2]][R[1]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[2]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 101, [1] = 29 }, [1] = { [0] = 98, [1] = 26 }, [2] = { [0] = 97, [1] = 25 }, [3] = { [0] = 98, [1] = 26 }, [4] = { [0] = 101, [1] = 29 }, [5] = { [0] = 106, [1] = 34 }, [6] = { [0] = 107, [1] = 35 }, [7] = { [0] = 106, [1] = 34 } })[R[2]][R[1]], ({ [0] = { [0] = 96, [1] = 87 }, [1] = { [0] = 92, [1] = 83 }, [2] = { [0] = 89, [1] = 80 }, [3] = { [0] = 88, [1] = 79 }, [4] = { [0] = 84, [1] = 75 }, [5] = { [0] = 88, [1] = 79 }, [6] = { [0] = 89, [1] = 80 }, [7] = { [0] = 92, [1] = 83 } })[R[2]][R[1]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[2]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 103, [1] = 31 }, [1] = { [0] = 100, [1] = 28 }, [2] = { [0] = 97, [1] = 25 }, [3] = { [0] = 100, [1] = 28 }, [4] = { [0] = 103, [1] = 31 }, [5] = { [0] = 104, [1] = 32 }, [6] = { [0] = 107, [1] = 35 }, [7] = { [0] = 104, [1] = 32 } })[R[2]][R[1]], ({ [0] = { [0] = 96, [1] = 87 }, [1] = { [0] = 94, [1] = 85 }, [2] = { [0] = 91, [1] = 82 }, [3] = { [0] = 86, [1] = 77 }, [4] = { [0] = 84, [1] = 75 }, [5] = { [0] = 86, [1] = 77 }, [6] = { [0] = 91, [1] = 82 }, [7] = { [0] = 94, [1] = 85 } })[R[2]][R[1]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[2]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 101, [1] = 29 }, [1] = { [0] = 97, [1] = 25 }, [2] = { [0] = 95, [1] = 23 }, [3] = { [0] = 97, [1] = 25 }, [4] = { [0] = 101, [1] = 29 }, [5] = { [0] = 107, [1] = 35 }, [6] = { [0] = 109, [1] = 37 }, [7] = { [0] = 107, [1] = 35 } })[R[2]][R[1]], ({ [0] = { [0] = 98, [1] = 89 }, [1] = { [0] = 93, [1] = 84 }, [2] = { [0] = 89, [1] = 80 }, [3] = { [0] = 87, [1] = 78 }, [4] = { [0] = 82, [1] = 73 }, [5] = { [0] = 87, [1] = 78 }, [6] = { [0] = 89, [1] = 80 }, [7] = { [0] = 93, [1] = 84 } })[R[2]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[2]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 103, [1] = 31 }, [1] = { [0] = 99, [1] = 27 }, [2] = { [0] = 95, [1] = 23 }, [3] = { [0] = 99, [1] = 27 }, [4] = { [0] = 103, [1] = 31 }, [5] = { [0] = 105, [1] = 33 }, [6] = { [0] = 109, [1] = 37 }, [7] = { [0] = 105, [1] = 33 } })[R[2]][R[1]], ({ [0] = { [0] = 98, [1] = 89 }, [1] = { [0] = 95, [1] = 86 }, [2] = { [0] = 91, [1] = 82 }, [3] = { [0] = 85, [1] = 76 }, [4] = { [0] = 82, [1] = 73 }, [5] = { [0] = 85, [1] = 76 }, [6] = { [0] = 91, [1] = 82 }, [7] = { [0] = 95, [1] = 86 } })[R[2]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[2]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 102, [1] = 30 }, [1] = { [0] = 97, [1] = 25 }, [2] = { [0] = 94, [1] = 22 }, [3] = { [0] = 97, [1] = 25 }, [4] = { [0] = 102, [1] = 30 }, [5] = { [0] = 107, [1] = 35 }, [6] = { [0] = 110, [1] = 38 }, [7] = { [0] = 107, [1] = 35 } })[R[2]][R[1]], ({ [0] = { [0] = 100, [1] = 91 }, [1] = { [0] = 95, [1] = 86 }, [2] = { [0] = 90, [1] = 81 }, [3] = { [0] = 85, [1] = 76 }, [4] = { [0] = 80, [1] = 71 }, [5] = { [0] = 85, [1] = 76 }, [6] = { [0] = 90, [1] = 81 }, [7] = { [0] = 95, [1] = 86 } })[R[2]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[2]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("Food", 1000)
  U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = { [0] = 101, [1] = 29 }, [1] = { [0] = 95, [1] = 23 }, [2] = { [0] = 93, [1] = 21 }, [3] = { [0] = 95, [1] = 23 }, [4] = { [0] = 101, [1] = 29 }, [5] = { [0] = 109, [1] = 37 }, [6] = { [0] = 111, [1] = 39 }, [7] = { [0] = 109, [1] = 37 } })[R[2]][R[1]], ({ [0] = { [0] = 102, [1] = 93 }, [1] = { [0] = 95, [1] = 86 }, [2] = { [0] = 89, [1] = 80 }, [3] = { [0] = 85, [1] = 76 }, [4] = { [0] = 78, [1] = 69 }, [5] = { [0] = 85, [1] = 76 }, [6] = { [0] = 89, [1] = 80 }, [7] = { [0] = 95, [1] = 86 } })[R[2]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[2]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 103, [1] = 31 }, [1] = { [0] = 97, [1] = 25 }, [2] = { [0] = 93, [1] = 21 }, [3] = { [0] = 97, [1] = 25 }, [4] = { [0] = 103, [1] = 31 }, [5] = { [0] = 107, [1] = 35 }, [6] = { [0] = 111, [1] = 39 }, [7] = { [0] = 107, [1] = 35 } })[R[2]][R[1]], ({ [0] = { [0] = 102, [1] = 93 }, [1] = { [0] = 97, [1] = 88 }, [2] = { [0] = 91, [1] = 82 }, [3] = { [0] = 83, [1] = 74 }, [4] = { [0] = 78, [1] = 69 }, [5] = { [0] = 83, [1] = 74 }, [6] = { [0] = 91, [1] = 82 }, [7] = { [0] = 97, [1] = 88 } })[R[2]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[2]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if game.initial_units() == 0 then
  elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
    for i = 1, game.initial_units() do
      R[3] = game.rand(4)
      if R[2] == 0 then
        if R[1] == 0 then
          if R[3] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 99, 91 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 99, 91 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[3] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 99, 91 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 99, 91 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[3] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 100 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 100 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[3] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 100 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 100 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[3]", R[3])
          end
        elseif R[1] == 1 then
          if R[3] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 82 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 82 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[3] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 82 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 82 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[3] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 91 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 91 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[3] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 91 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 91 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[3]", R[3])
          end
        else
          unseen("R[1]", R[1])
        end
      elseif R[2] == 1 then
        if R[3] == 0 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 99, 89 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 99, 89 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 80 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 80 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 1 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 93 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 93 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 84 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 84 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 2 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 95, 92 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 95, 92 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 23, 83 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 23, 83 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 3 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 99, 98 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 99, 98 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 89 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 89 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        else
          unseen("R[3]", R[3])
        end
      elseif R[2] == 2 then
        if R[3] == 0 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 87 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 87 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 28, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 28, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 1 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 95, 87 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 95, 87 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 23, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 23, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 2 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 93 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 93 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 28, 84 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 28, 84 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 3 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 95, 93 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 95, 93 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 23, 84 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 23, 84 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        else
          unseen("R[3]", R[3])
        end
      elseif R[2] == 3 then
        if R[3] == 0 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 99, 91 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 99, 91 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 82 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 82 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 1 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 87 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 87 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 78 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 31, 78 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 2 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 95, 88 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 95, 88 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 23, 79 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 23, 79 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 3 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 99, 82 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 99, 82 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 73 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 73 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        else
          unseen("R[3]", R[3])
        end
      elseif R[2] == 4 then
        if R[1] == 0 then
          if R[3] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 99, 89 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 99, 89 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[3] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 99, 89 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 99, 89 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[3] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 80 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 80 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[3] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 80 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 80 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[3]", R[3])
          end
        elseif R[1] == 1 then
          if R[3] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 80 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 80 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[3] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 80 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 27, 80 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[3] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 71 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 71 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[3] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 71 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 71 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[3]", R[3])
          end
        else
          unseen("R[1]", R[1])
        end
      elseif R[2] == 5 then
        if R[3] == 0 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 91 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 91 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 82 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 82 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 1 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 87 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 87 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 29, 78 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 29, 78 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 2 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 88 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 88 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 79 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 79 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 3 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 82 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 82 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 73 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 73 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        else
          unseen("R[3]", R[3])
        end
      elseif R[2] == 6 then
        if R[3] == 0 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 104, 87 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 104, 87 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 32, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 32, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 1 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 87 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 87 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 2 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 104, 93 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 104, 93 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 32, 84 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 32, 84 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 3 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 93 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 93 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 84 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 84 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        else
          unseen("R[3]", R[3])
        end
      elseif R[2] == 7 then
        if R[3] == 0 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 89 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 89 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 80 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 80 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 1 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 93 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 93 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 29, 84 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 29, 84 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 2 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 92 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 92 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 83 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 83 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[3] == 3 then
          if R[1] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 98 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 98 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 89 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 33, 89 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        else
          unseen("R[3]", R[3])
        end
      else
        unseen("R[2]", R[2])
      end
      U[#U]:set_lights(true)
    end
  else
    unseen("game.initial_units()", game.initial_units())
  end
  R[4] = game.rand(8)
  players[2]:center_view({ ({ [0] = 30, [1] = 102 })[R[1]], ({ [0] = 81, [1] = 90 })[R[1]] })
  U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 30, [1] = 102 })[R[1]], ({ [0] = 81, [1] = 90 })[R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 30, [1] = 102 }, [1] = { [0] = 29, [1] = 101 }, [2] = { [0] = 28, [1] = 100 }, [3] = { [0] = 29, [1] = 101 }, [4] = { [0] = 30, [1] = 102 }, [5] = { [0] = 31, [1] = 103 }, [6] = { [0] = 32, [1] = 104 }, [7] = { [0] = 31, [1] = 103 } })[R[4]][R[1]], ({ [0] = { [0] = 83, [1] = 92 }, [1] = { [0] = 82, [1] = 91 }, [2] = { [0] = 81, [1] = 90 }, [3] = { [0] = 80, [1] = 89 }, [4] = { [0] = 79, [1] = 88 }, [5] = { [0] = 80, [1] = 89 }, [6] = { [0] = 81, [1] = 90 }, [7] = { [0] = 82, [1] = 91 } })[R[4]][R[1]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 101 }, [1] = { [0] = 27, [1] = 99 }, [2] = { [0] = 27, [1] = 99 }, [3] = { [0] = 27, [1] = 99 }, [4] = { [0] = 29, [1] = 101 }, [5] = { [0] = 33, [1] = 105 }, [6] = { [0] = 33, [1] = 105 }, [7] = { [0] = 33, [1] = 105 } })[R[4]][R[1]], ({ [0] = { [0] = 85, [1] = 94 }, [1] = { [0] = 82, [1] = 91 }, [2] = { [0] = 80, [1] = 89 }, [3] = { [0] = 80, [1] = 89 }, [4] = { [0] = 77, [1] = 86 }, [5] = { [0] = 80, [1] = 89 }, [6] = { [0] = 80, [1] = 89 }, [7] = { [0] = 82, [1] = 91 } })[R[4]][R[1]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 103 }, [1] = { [0] = 29, [1] = 101 }, [2] = { [0] = 27, [1] = 99 }, [3] = { [0] = 29, [1] = 101 }, [4] = { [0] = 31, [1] = 103 }, [5] = { [0] = 31, [1] = 103 }, [6] = { [0] = 33, [1] = 105 }, [7] = { [0] = 31, [1] = 103 } })[R[4]][R[1]], ({ [0] = { [0] = 85, [1] = 94 }, [1] = { [0] = 84, [1] = 93 }, [2] = { [0] = 82, [1] = 91 }, [3] = { [0] = 78, [1] = 87 }, [4] = { [0] = 77, [1] = 86 }, [5] = { [0] = 78, [1] = 87 }, [6] = { [0] = 82, [1] = 91 }, [7] = { [0] = 84, [1] = 93 } })[R[4]][R[1]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 101 }, [1] = { [0] = 26, [1] = 98 }, [2] = { [0] = 25, [1] = 97 }, [3] = { [0] = 26, [1] = 98 }, [4] = { [0] = 29, [1] = 101 }, [5] = { [0] = 34, [1] = 106 }, [6] = { [0] = 35, [1] = 107 }, [7] = { [0] = 34, [1] = 106 } })[R[4]][R[1]], ({ [0] = { [0] = 87, [1] = 96 }, [1] = { [0] = 83, [1] = 92 }, [2] = { [0] = 80, [1] = 89 }, [3] = { [0] = 79, [1] = 88 }, [4] = { [0] = 75, [1] = 84 }, [5] = { [0] = 79, [1] = 88 }, [6] = { [0] = 80, [1] = 89 }, [7] = { [0] = 83, [1] = 92 } })[R[4]][R[1]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 103 }, [1] = { [0] = 28, [1] = 100 }, [2] = { [0] = 25, [1] = 97 }, [3] = { [0] = 28, [1] = 100 }, [4] = { [0] = 31, [1] = 103 }, [5] = { [0] = 32, [1] = 104 }, [6] = { [0] = 35, [1] = 107 }, [7] = { [0] = 32, [1] = 104 } })[R[4]][R[1]], ({ [0] = { [0] = 87, [1] = 96 }, [1] = { [0] = 85, [1] = 94 }, [2] = { [0] = 82, [1] = 91 }, [3] = { [0] = 77, [1] = 86 }, [4] = { [0] = 75, [1] = 84 }, [5] = { [0] = 77, [1] = 86 }, [6] = { [0] = 82, [1] = 91 }, [7] = { [0] = 85, [1] = 94 } })[R[4]][R[1]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 101 }, [1] = { [0] = 25, [1] = 97 }, [2] = { [0] = 23, [1] = 95 }, [3] = { [0] = 25, [1] = 97 }, [4] = { [0] = 29, [1] = 101 }, [5] = { [0] = 35, [1] = 107 }, [6] = { [0] = 37, [1] = 109 }, [7] = { [0] = 35, [1] = 107 } })[R[4]][R[1]], ({ [0] = { [0] = 89, [1] = 98 }, [1] = { [0] = 84, [1] = 93 }, [2] = { [0] = 80, [1] = 89 }, [3] = { [0] = 78, [1] = 87 }, [4] = { [0] = 73, [1] = 82 }, [5] = { [0] = 78, [1] = 87 }, [6] = { [0] = 80, [1] = 89 }, [7] = { [0] = 84, [1] = 93 } })[R[4]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 103 }, [1] = { [0] = 27, [1] = 99 }, [2] = { [0] = 23, [1] = 95 }, [3] = { [0] = 27, [1] = 99 }, [4] = { [0] = 31, [1] = 103 }, [5] = { [0] = 33, [1] = 105 }, [6] = { [0] = 37, [1] = 109 }, [7] = { [0] = 33, [1] = 105 } })[R[4]][R[1]], ({ [0] = { [0] = 89, [1] = 98 }, [1] = { [0] = 86, [1] = 95 }, [2] = { [0] = 82, [1] = 91 }, [3] = { [0] = 76, [1] = 85 }, [4] = { [0] = 73, [1] = 82 }, [5] = { [0] = 76, [1] = 85 }, [6] = { [0] = 82, [1] = 91 }, [7] = { [0] = 86, [1] = 95 } })[R[4]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 30, [1] = 102 }, [1] = { [0] = 25, [1] = 97 }, [2] = { [0] = 22, [1] = 94 }, [3] = { [0] = 25, [1] = 97 }, [4] = { [0] = 30, [1] = 102 }, [5] = { [0] = 35, [1] = 107 }, [6] = { [0] = 38, [1] = 110 }, [7] = { [0] = 35, [1] = 107 } })[R[4]][R[1]], ({ [0] = { [0] = 91, [1] = 100 }, [1] = { [0] = 86, [1] = 95 }, [2] = { [0] = 81, [1] = 90 }, [3] = { [0] = 76, [1] = 85 }, [4] = { [0] = 71, [1] = 80 }, [5] = { [0] = 76, [1] = 85 }, [6] = { [0] = 81, [1] = 90 }, [7] = { [0] = 86, [1] = 95 } })[R[4]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("Food", 1000)
  U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 101 }, [1] = { [0] = 23, [1] = 95 }, [2] = { [0] = 21, [1] = 93 }, [3] = { [0] = 23, [1] = 95 }, [4] = { [0] = 29, [1] = 101 }, [5] = { [0] = 37, [1] = 109 }, [6] = { [0] = 39, [1] = 111 }, [7] = { [0] = 37, [1] = 109 } })[R[4]][R[1]], ({ [0] = { [0] = 93, [1] = 102 }, [1] = { [0] = 86, [1] = 95 }, [2] = { [0] = 80, [1] = 89 }, [3] = { [0] = 76, [1] = 85 }, [4] = { [0] = 69, [1] = 78 }, [5] = { [0] = 76, [1] = 85 }, [6] = { [0] = 80, [1] = 89 }, [7] = { [0] = 86, [1] = 95 } })[R[4]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 103 }, [1] = { [0] = 25, [1] = 97 }, [2] = { [0] = 21, [1] = 93 }, [3] = { [0] = 25, [1] = 97 }, [4] = { [0] = 31, [1] = 103 }, [5] = { [0] = 35, [1] = 107 }, [6] = { [0] = 39, [1] = 111 }, [7] = { [0] = 35, [1] = 107 } })[R[4]][R[1]], ({ [0] = { [0] = 93, [1] = 102 }, [1] = { [0] = 88, [1] = 97 }, [2] = { [0] = 82, [1] = 91 }, [3] = { [0] = 74, [1] = 83 }, [4] = { [0] = 69, [1] = 78 }, [5] = { [0] = 74, [1] = 83 }, [6] = { [0] = 82, [1] = 91 }, [7] = { [0] = 88, [1] = 97 } })[R[4]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if game.initial_units() == 0 then
  elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
    for i = 1, game.initial_units() do
      R[5] = game.rand(4)
      if R[4] == 0 then
        if R[1] == 0 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 82 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 82 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 82 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 82 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 91 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 91 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 91 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 91 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[1] == 1 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 91 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 91 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 91 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 91 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 100 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 100 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 100 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 100 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[1]", R[1])
        end
      elseif R[4] == 1 then
        if R[5] == 0 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 80 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 80 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 89 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 89 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 1 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 84 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 84 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 93 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 93 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 2 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 83 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 83 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 92 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 92 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 3 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 89 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 89 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 98 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 98 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        else
          unseen("R[5]", R[5])
        end
      elseif R[4] == 2 then
        if R[5] == 0 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 28, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 28, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 87 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 87 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 1 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 87 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 87 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 2 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 28, 84 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 28, 84 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 93 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 93 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 3 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 84 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 84 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 93 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 93 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        else
          unseen("R[5]", R[5])
        end
      elseif R[4] == 3 then
        if R[5] == 0 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 82 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 82 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 91 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 91 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 1 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 78 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 31, 78 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 87 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 87 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 2 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 79 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 79 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 88 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 88 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 3 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 73 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 73 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 82 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 82 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        else
          unseen("R[5]", R[5])
        end
      elseif R[4] == 4 then
        if R[1] == 0 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 80 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 80 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 80 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 80 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 71 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 71 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 71 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 71 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[1] == 1 then
          if R[5] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 89 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 89 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 89 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 99, 89 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 80 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 80 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 80 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 80 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[1]", R[1])
        end
      elseif R[4] == 5 then
        if R[5] == 0 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 82 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 82 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 91 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 91 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 1 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 29, 78 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 29, 78 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 87 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 87 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 2 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 79 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 79 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 88 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 88 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 3 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 73 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 73 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 82 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 82 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        else
          unseen("R[5]", R[5])
        end
      elseif R[4] == 6 then
        if R[5] == 0 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 32, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 32, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 87 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 87 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 1 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 87 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 87 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 2 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 32, 84 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 32, 84 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 93 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 93 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 3 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 84 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 84 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 93 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 93 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        else
          unseen("R[5]", R[5])
        end
      elseif R[4] == 7 then
        if R[5] == 0 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 80 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 80 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 89 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 89 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 1 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 29, 84 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 29, 84 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 93 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 93 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 2 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 83 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 83 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 92 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 92 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 3 then
          if R[1] == 0 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 89 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 33, 89 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          elseif R[1] == 1 then
            if (players[2].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 98 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[2].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 98 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
            end
          else
            unseen("R[1]", R[1])
          end
        else
          unseen("R[5]", R[5])
        end
      else
        unseen("R[4]", R[4])
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
    trigger.time{min = 3600, max = 7200, one_shot = false, on = Meteors}  -- after 36 to 72 marks
  end
  return true
end
