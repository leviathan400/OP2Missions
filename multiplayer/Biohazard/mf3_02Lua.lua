-- mf3_02Lua.lua  -  3 Player, SpaceRace, 'Biohazard' map. (Lua)
--
-- Converted by op2dll from mf3_02.dll ("3 Player, SpaceRace, 'Biohazard' map."): its setup replayed. `on_init` makes the original's
-- draws of the game's random numbers in its order and, from them and the lobby, the same units,
-- beacons, walls and settings in the same order, as the original's setup did in every game
-- sampled (every player count, the lobby's colonies, resource levels, vehicles, day and night,
-- morale and disasters). Anything not converted is listed at the end. Coordinates are the in-game
-- status-bar ones (map file tile + 1).

-- Where lava may flow from an eruption, as areas { x1, y1, x2, y2 }.
local LAVA_POSSIBLE = {
  { 84, 15, 84, 15 }, { 72, 16, 72, 16 }, { 81, 16, 84, 16 }, { 72, 17, 73, 17 }, { 81, 17, 81, 17 }, { 73, 18, 81, 18 },
  { 74, 19, 80, 19 }, { 74, 20, 79, 20 }, { 75, 21, 78, 21 }, { 75, 22, 77, 22 }, { 76, 23, 77, 24 }, { 81, 24, 81, 24 },
  { 77, 25, 81, 25 }, { 77, 26, 80, 26 }, { 77, 27, 79, 28 }, { 77, 29, 78, 29 }, { 78, 30, 78, 34 }, { 77, 35, 78, 35 },
  { 77, 36, 79, 36 }, { 78, 37, 78, 38 }, { 77, 39, 78, 39 }, { 78, 40, 78, 42 }, { 80, 40, 81, 40 }, { 68, 43, 72, 43 },
  { 76, 43, 76, 43 }, { 67, 44, 76, 45 }, { 65, 46, 71, 46 }, { 74, 46, 76, 46 }, { 66, 47, 70, 47 }, { 75, 47, 76, 47 },
  { 67, 48, 69, 48 }, { 67, 49, 68, 49 }, { 66, 50, 68, 51 }, { 64, 52, 68, 52 }, { 65, 53, 68, 53 }, { 67, 54, 68, 57 },
  { 66, 58, 68, 58 }, { 66, 59, 69, 59 }, { 66, 60, 70, 60 }, { 65, 61, 70, 61 }, { 65, 62, 69, 62 }, { 64, 63, 69, 63 },
  { 63, 64, 69, 64 }, { 62, 65, 66, 65 }, { 68, 65, 70, 65 }, { 60, 66, 63, 66 }, { 69, 66, 70, 66 }, { 60, 67, 62, 67 },
  { 70, 67, 71, 67 }, { 60, 68, 61, 68 }, { 71, 68, 71, 68 }, { 59, 69, 60, 70 }, { 71, 69, 72, 71 }, { 58, 71, 60, 71 },
  { 57, 72, 60, 72 }, { 72, 72, 72, 72 }, { 56, 73, 60, 73 }, { 72, 73, 73, 73 }, { 56, 74, 62, 74 }, { 71, 74, 73, 75 },
  { 57, 75, 62, 75 }, { 59, 76, 62, 76 }, { 71, 76, 74, 77 }, { 61, 77, 64, 78 }, { 67, 77, 67, 77 }, { 67, 78, 69, 81 },
  { 71, 78, 75, 78 }, { 62, 79, 64, 80 }, { 71, 79, 76, 81 }, { 78, 80, 78, 82 }, { 63, 81, 64, 81 }, { 69, 82, 69, 82 },
  { 71, 82, 73, 82 }, { 82, 82, 84, 82 }, { 88, 82, 93, 82 }, { 101, 82, 101, 82 }, { 103, 82, 104, 82 }, { 111, 82, 112, 82 },
  { 71, 83, 71, 83 }, { 82, 83, 94, 83 }, { 98, 83, 107, 83 }, { 110, 83, 111, 83 }, { 82, 84, 99, 84 }, { 102, 84, 102, 84 },
  { 104, 84, 111, 84 }, { 82, 85, 96, 85 }, { 108, 85, 110, 85 }, { 84, 86, 92, 86 }, { 109, 86, 110, 90 }, { 86, 87, 91, 87 },
  { 87, 88, 90, 90 }, { 88, 91, 90, 91 }, { 110, 91, 110, 91 }, { 89, 92, 90, 95 }, { 90, 96, 91, 96 }, { 91, 97, 92, 98 },
  { 92, 99, 93, 99 }, { 93, 100, 94, 101 }, { 93, 102, 95, 102 }, { 94, 103, 95, 103 },
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
local BigQuake, LavaCheck, Quake, Storm

function BigQuake(t)
  game.create_earthquake({ 65, 70 }, 4)
end

local LavaCheck_done  -- LavaCheck does nothing more once it has acted
function LavaCheck(t)
  if LavaCheck_done then return end
  local total = 0
  for id = 1, game.num_players() do total = total + players[id].population end
  if total >= 200 then
    game.create_eruption({ 61, 74 }, 200)
    LavaCheck_done = true
  end
end

function Quake(t)
  local r1 = game.rand(5)
  local r2 = game.rand(26)
  local r3 = game.rand(36)
  game.create_earthquake({ r3 + 48, r2 + 6 }, r1)
  -- The original then reads the game (each player's colony, units), which led to nothing in 600 calls: not converted.
end

function Storm(t)
  local r1 = game.rand(4)
  local r2 = game.rand(7)
  local r3 = game.rand(128)
  if r1 == 0 then
    game.create_lightning({ 1, r3 + 1 }, nil, r2 + 10)
  elseif r1 == 1 then
    game.create_lightning({ 129, r3 + 1 }, nil, r2 + 10)
  elseif r1 == 2 then
    game.create_lightning({ r3 + 1, 2 }, nil, r2 + 10)
  else
    game.create_lightning({ r3 + 1, 128 }, nil, r2 + 10)
  end
end

function on_init()
  local n = game.num_players()
  if n == 2 then
    for _, area in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(area) end
    game.set_cell_type({ 68, 120 }, 7)
    game.initial_set_tile({ 68, 120 }, 17)
    game.set_cell_type({ 68, 121 }, 7)
    game.initial_set_tile({ 68, 121 }, 21)
    game.set_cell_type({ 69, 120 }, 7)
    game.initial_set_tile({ 69, 120 }, 18)
    game.set_cell_type({ 69, 121 }, 7)
    game.initial_set_tile({ 69, 121 }, 22)
    game.initial_set_tile({ 62, 73 }, 1095)
    game.initial_set_tile({ 63, 73 }, 1107)
    game.initial_set_tile({ 62, 74 }, 1118)
    game.initial_set_tile({ 63, 74 }, 1129)
    game.initial_set_tile({ 66, 73 }, 1140)
    game.initial_set_tile({ 66, 74 }, 1150)
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 47, 12 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 89, 9 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 52, 69 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 73, 66 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 59, 64 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 67, 82 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 84, 83 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 27, 121 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 14, 88 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 124, 121 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 47, 87 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 25, 100 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 67, 13 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 81, 40 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 71, 72 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 98, 108 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 120, 82 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 71, 35 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 116, 65 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 37, 124 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { 15, 45 } }
    pick(16, 2, { 0, 1 })
    if R[1] == 0 then
      if R[0] == 8 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 56, 61 } }
      elseif R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [2] = 71, [3] = 70, [4] = 77, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [2] = 62, [3] = 83, [4] = 79, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 56, 61 } }
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 1 then
      if R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 15 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 54, 72 } }
      elseif R[0] == 0 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [2] = 71, [3] = 70, [4] = 77, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [2] = 62, [3] = 83, [4] = 79, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 54, 72 } }
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 2 then
      if R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 14 or R[0] == 15 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 71, 62 } }
      elseif R[0] == 0 or R[0] == 1 or R[0] == 3 or R[0] == 4 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [3] = 70, [4] = 77, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [3] = 83, [4] = 79, [6] = 59, [7] = 79 })[R[0]] } }
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 71, 62 } }
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 3 then
      if R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 70, 83 } }
      elseif R[0] == 0 or R[0] == 1 or R[0] == 4 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [4] = 77, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [4] = 79, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 70, 83 } }
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 4 then
      if R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 77, 79 } }
      elseif R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [3] = 70, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [3] = 83, [6] = 59, [7] = 79 })[R[0]] } }
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 77, 79 } }
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 5 then
      if R[0] == 8 or R[0] == 9 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 76, 72 } }
      elseif R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [3] = 70, [4] = 77, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [3] = 83, [4] = 79, [6] = 59, [7] = 79 })[R[0]] } }
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 76, 72 } }
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 6 then
      if R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 65, 59 } }
      elseif R[0] == 0 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [2] = 71, [3] = 70, [4] = 77, [5] = 76, [7] = 61 })[R[0]], ({ [0] = 61, [2] = 62, [3] = 83, [4] = 79, [5] = 72, [7] = 79 })[R[0]] } }
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 65, 59 } }
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 7 then
      if R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 61, 79 } }
      elseif R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [3] = 70, [4] = 77, [5] = 76, [6] = 65 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [3] = 83, [4] = 79, [5] = 72, [6] = 59 })[R[0]] } }
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 61, 79 } }
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 8 then
      if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [3] = 70, [4] = 77, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [3] = 83, [4] = 79, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
      elseif R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 9 then
      if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [3] = 70, [4] = 77, [5] = 76, [6] = 65 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [3] = 83, [4] = 79, [5] = 72, [6] = 59 })[R[0]] } }
      elseif R[0] == 8 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 10 then
      if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [3] = 70, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [3] = 83, [6] = 59, [7] = 79 })[R[0]] } }
      elseif R[0] == 8 or R[0] == 9 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 11 then
      if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 4 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [4] = 77, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [4] = 79, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
      elseif R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 12 then
      if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [3] = 70, [4] = 77, [5] = 76, [6] = 65 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [3] = 83, [4] = 79, [5] = 72, [6] = 59 })[R[0]] } }
      elseif R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 13 then
      if R[0] == 0 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [2] = 71, [3] = 70, [4] = 77, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [2] = 62, [3] = 83, [4] = 79, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
      elseif R[0] == 8 or R[0] == 9 or R[0] == 12 or R[0] == 14 or R[0] == 15 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 14 then
      if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [3] = 70, [4] = 77, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [3] = 83, [4] = 79, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
      elseif R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 15 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 15 then
      if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [3] = 70, [4] = 77, [5] = 76, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [3] = 83, [4] = 79, [5] = 72, [7] = 79 })[R[0]] } }
      elseif R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 then
      else
        unseen("R[0]", R[0])
      end
    else
      unseen("R[1]", R[1])
    end
    R[2] = game.rand(20)
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[2]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[2]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[2]] } }
    R[3] = draw_avoid(20, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[3]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[3]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[3]] } }
    R[4] = draw_avoid(20, { R[3], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[4]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[4]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[4]] } }
    R[5] = draw_avoid(20, { R[4], R[3], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[5]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[5]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[5]] } }
    R[6] = draw_avoid(20, { R[5], R[4], R[3], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[6]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[6]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[6]] } }
    R[7] = draw_avoid(20, { R[6], R[5], R[4], R[3], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[7]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[7]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[7]] } }
    R[8] = draw_avoid(20, { R[7], R[6], R[5], R[4], R[3], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[8]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[8]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[8]] } }
    R[9] = draw_avoid(20, { R[8], R[7], R[6], R[5], R[4], R[3], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[9]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[9]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[9]] } }
    R[10] = draw_avoid(20, { R[9], R[8], R[7], R[6], R[5], R[4], R[3], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[10]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[10]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[10]] } }
    pick(3, 2, { 11, 12 })
    players[1]:ally_with(players[2])
    players[2]:ally_with(players[1])
    R[13] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 17, [1] = 21, [2] = 111 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 17, [1] = 21, [2] = 111 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[13]][R[11]] })
    U[#U + 1] = game.create_unit{ type = "TradeCenter", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 118, [2] = 72 }, [1] = { [0] = 16, [1] = 113, [2] = 67 }, [2] = { [0] = 12, [1] = 109, [2] = 63 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 18, [1] = 115, [2] = 69 }, [7] = { [0] = 12, [1] = 109, [2] = 63 } })[R[13]][R[11]], ({ [0] = { [0] = 17, [1] = 21, [2] = 111 }, [1] = { [0] = 18, [1] = 22, [2] = 112 }, [2] = { [0] = 20, [1] = 24, [2] = 114 }, [3] = { [0] = 23, [1] = 27, [2] = 117 }, [4] = { [0] = 21, [1] = 25, [2] = 115 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 17, [1] = 21, [2] = 111 }, [7] = { [0] = 21, [1] = 25, [2] = 115 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 8, [1] = 105, [2] = 59 }, [3] = { [0] = 27, [1] = 124, [2] = 78 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 7, [1] = 11, [2] = 101 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 30, [1] = 34, [2] = 124 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    if R[13] == 0 or R[13] == 1 or R[13] == 2 or R[13] == 5 or R[13] == 6 or R[13] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 126, [2] = 80 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 11, [1] = 108, [2] = 62 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 21, [1] = 118, [2] = 72 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 14, [1] = 18, [2] = 108 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [5] = { [0] = 27, [1] = 31, [2] = 121 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
      if R[13] == 0 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 6, [1] = 103, [2] = 57 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 6, [1] = 103, [2] = 57 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 6, [1] = 103, [2] = 57 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[13] == 1 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[13] == 2 then
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
      elseif R[13] == 5 then
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
      elseif R[13] == 6 then
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
      elseif R[13] == 7 then
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
        unseen("R[13]", R[13])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 20, [1] = 117, [2] = 71 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 29, [1] = 126, [2] = 80 }, [7] = { [0] = 23, [1] = 120, [2] = 74 } })[R[13]][R[11]], ({ [0] = { [0] = 26, [1] = 30, [2] = 120 }, [1] = { [0] = 32, [1] = 36, [2] = 126 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
      if R[13] == 0 or R[13] == 1 then
      elseif R[13] == 2 or R[13] == 5 or R[13] == 6 or R[13] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [2] = { [0] = 20, [1] = 117, [2] = 71 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 12, [1] = 109, [2] = 63 }, [7] = { [0] = 24, [1] = 121, [2] = 75 } })[R[13]][R[11]], ({ [2] = { [0] = 28, [1] = 32, [2] = 122 }, [5] = { [0] = 15, [1] = 19, [2] = 109 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 27, [1] = 31, [2] = 121 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[13]", R[13])
      end
    elseif R[13] == 3 or R[13] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 } })[R[13]][R[11]], ({ [3] = { [0] = 30, [1] = 34, [2] = 124 }, [4] = { [0] = 15, [1] = 19, [2] = 109 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
      if R[13] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[13] == 3 then
      else
        unseen("R[13]", R[13])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [3] = { [0] = 14, [1] = 111, [2] = 65 }, [4] = { [0] = 25, [1] = 122, [2] = 76 } })[R[13]][R[11]], ({ [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 27, [1] = 31, [2] = 121 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
      if R[13] == 3 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[13] == 4 then
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
        unseen("R[13]", R[13])
      end
    else
      unseen("R[13]", R[13])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 13, [1] = 110, [2] = 64 }, [2] = { [0] = 28, [1] = 125, [2] = 79 }, [3] = { [0] = 20, [1] = 117, [2] = 71 }, [4] = { [0] = 6, [1] = 103, [2] = 57 }, [5] = { [0] = 6, [1] = 103, [2] = 57 }, [6] = { [0] = 4, [1] = 101, [2] = 55 }, [7] = { [0] = 16, [1] = 113, [2] = 67 } })[R[13]][R[11]], ({ [0] = { [0] = 26, [1] = 30, [2] = 120 }, [1] = { [0] = 29, [1] = 33, [2] = 123 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 13, [1] = 17, [2] = 107 }, [4] = { [0] = 19, [1] = 23, [2] = 113 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 31, [1] = 35, [2] = 125 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 13, [1] = 110, [2] = 64 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 9, [1] = 106, [2] = 60 }, [4] = { [0] = 24, [1] = 121, [2] = 75 }, [5] = { [0] = 24, [1] = 121, [2] = 75 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 26, [1] = 123, [2] = 77 } })[R[13]][R[11]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 26, [1] = 30, [2] = 120 }, [3] = { [0] = 20, [1] = 24, [2] = 114 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 13, [1] = 17, [2] = 107 }, [6] = { [0] = 27, [1] = 31, [2] = 121 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 11, [1] = 108, [2] = 62 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 12, [1] = 109, [2] = 63 }, [4] = { [0] = 26, [1] = 123, [2] = 77 }, [5] = { [0] = 24, [1] = 121, [2] = 75 }, [6] = { [0] = 9, [1] = 106, [2] = 60 }, [7] = { [0] = 26, [1] = 123, [2] = 77 } })[R[13]][R[11]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 13, [1] = 17, [2] = 107 }, [2] = { [0] = 24, [1] = 28, [2] = 118 }, [3] = { [0] = 16, [1] = 20, [2] = 110 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 15, [1] = 19, [2] = 109 }, [6] = { [0] = 27, [1] = 31, [2] = 121 }, [7] = { [0] = 24, [1] = 28, [2] = 118 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[13]], player = players[1], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 6, [1] = 103, [2] = 57 }, [3] = { [0] = 29, [1] = 126, [2] = 80 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 25, [1] = 122, [2] = 76 } })[R[13]][R[11]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 20, [1] = 24, [2] = 114 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[13]], player = players[1], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 6, [1] = 103, [2] = 57 }, [3] = { [0] = 27, [1] = 124, [2] = 78 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 25, [1] = 122, [2] = 76 } })[R[13]][R[11]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 16, [1] = 20, [2] = 110 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 6, [1] = 103, [2] = 57 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 25, [1] = 122, [2] = 76 } })[R[13]][R[11]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[13]], player = players[1], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 11, [1] = 108, [2] = 62 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 10, [1] = 107, [2] = 61 } })[R[13]][R[11]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 9, [1] = 13, [2] = 103 }, [2] = { [0] = 30, [1] = 34, [2] = 124 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 27, [1] = 31, [2] = 121 }, [5] = { [0] = 12, [1] = 16, [2] = 106 }, [6] = { [0] = 24, [1] = 28, [2] = 118 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[13]], player = players[1], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 18, [1] = 115, [2] = 69 }, [2] = { [0] = 20, [1] = 117, [2] = 71 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 21, [1] = 118, [2] = 72 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 25, [1] = 122, [2] = 76 }, [7] = { [0] = 5, [1] = 102, [2] = 56 } })[R[13]][R[11]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 6, [1] = 10, [2] = 100 }, [2] = { [0] = 31, [1] = 35, [2] = 125 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 18, [1] = 22, [2] = 112 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 21, [1] = 25, [2] = 115 }, [7] = { [0] = 19, [1] = 23, [2] = 113 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[13]], player = players[1], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 11, [1] = 108, [2] = 62 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 10, [1] = 107, [2] = 61 } })[R[13]][R[11]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 9, [1] = 13, [2] = 103 }, [2] = { [0] = 30, [1] = 34, [2] = 124 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 27, [1] = 31, [2] = 121 }, [5] = { [0] = 12, [1] = 16, [2] = 106 }, [6] = { [0] = 24, [1] = 28, [2] = 118 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[13]], player = players[1], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 18, [1] = 115, [2] = 69 }, [2] = { [0] = 20, [1] = 117, [2] = 71 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 21, [1] = 118, [2] = 72 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 25, [1] = 122, [2] = 76 }, [7] = { [0] = 5, [1] = 102, [2] = 56 } })[R[13]][R[11]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 6, [1] = 10, [2] = 100 }, [2] = { [0] = 31, [1] = 35, [2] = 125 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 18, [1] = 22, [2] = 112 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 21, [1] = 25, [2] = 115 }, [7] = { [0] = 19, [1] = 23, [2] = 113 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 126, [2] = 80 }, [1] = { [0] = 21, [1] = 118, [2] = 72 }, [2] = { [0] = 16, [1] = 113, [2] = 67 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 27, [1] = 124, [2] = 78 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 25, [1] = 122, [2] = 76 }, [7] = { [0] = 19, [1] = 116, [2] = 70 } })[R[13]][R[11]], ({ [0] = { [0] = 23, [1] = 27, [2] = 117 }, [1] = { [0] = 19, [1] = 23, [2] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 118 }, [3] = { [0] = 17, [1] = 21, [2] = 111 }, [4] = { [0] = 14, [1] = 18, [2] = 108 }, [5] = { [0] = 29, [1] = 33, [2] = 123 }, [6] = { [0] = 24, [1] = 28, [2] = 118 }, [7] = { [0] = 21, [1] = 25, [2] = 115 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 9, [1] = 106, [2] = 60 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 11, [1] = 108, [2] = 62 }, [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 17, [1] = 21, [2] = 111 }, [5] = { [0] = 18, [1] = 22, [2] = 112 }, [6] = { [0] = 16, [1] = 20, [2] = 110 }, [7] = { [0] = 18, [1] = 22, [2] = 112 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 10, [1] = 107, [2] = 61 }, [1] = { [0] = 16, [1] = 113, [2] = 67 }, [2] = { [0] = 12, [1] = 109, [2] = 63 }, [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 27, [1] = 31, [2] = 121 }, [4] = { [0] = 18, [1] = 22, [2] = 112 }, [5] = { [0] = 19, [1] = 23, [2] = 113 }, [6] = { [0] = 17, [1] = 21, [2] = 111 }, [7] = { [0] = 19, [1] = 23, [2] = 113 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 11, [1] = 108, [2] = 62 }, [1] = { [0] = 17, [1] = 114, [2] = 68 }, [2] = { [0] = 13, [1] = 110, [2] = 64 }, [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 28, [1] = 32, [2] = 122 }, [4] = { [0] = 19, [1] = 23, [2] = 113 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 18, [1] = 22, [2] = 112 }, [7] = { [0] = 20, [1] = 24, [2] = 114 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 12, [1] = 109, [2] = 63 }, [1] = { [0] = 18, [1] = 115, [2] = 69 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 12, [1] = 109, [2] = 63 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 19, [1] = 23, [2] = 113 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 20, [1] = 24, [2] = 114 }, [5] = { [0] = 24, [1] = 28, [2] = 118 }, [6] = { [0] = 19, [1] = 23, [2] = 113 }, [7] = { [0] = 21, [1] = 25, [2] = 115 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 13, [1] = 110, [2] = 64 }, [1] = { [0] = 19, [1] = 116, [2] = 70 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 20, [1] = 24, [2] = 114 }, [3] = { [0] = 22, [1] = 26, [2] = 116 }, [4] = { [0] = 21, [1] = 25, [2] = 115 }, [5] = { [0] = 25, [1] = 29, [2] = 119 }, [6] = { [0] = 20, [1] = 24, [2] = 114 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 14, [1] = 111, [2] = 65 }, [1] = { [0] = 20, [1] = 117, [2] = 71 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 14, [1] = 111, [2] = 65 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 21, [1] = 25, [2] = 115 }, [3] = { [0] = 23, [1] = 27, [2] = 117 }, [4] = { [0] = 25, [1] = 29, [2] = 119 }, [5] = { [0] = 26, [1] = 30, [2] = 120 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 23, [1] = 27, [2] = 117 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 15, [1] = 112, [2] = 66 }, [1] = { [0] = 21, [1] = 118, [2] = 72 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 19, [1] = 116, [2] = 70 }, [6] = { [0] = 15, [1] = 112, [2] = 66 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 24, [1] = 28, [2] = 118 }, [4] = { [0] = 26, [1] = 30, [2] = 120 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 24, [1] = 28, [2] = 118 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 19, [1] = 116, [2] = 70 }, [6] = { [0] = 15, [1] = 112, [2] = 66 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 14, [1] = 18, [2] = 108 }, [1] = { [0] = 9, [1] = 13, [2] = 103 }, [2] = { [0] = 23, [1] = 27, [2] = 117 }, [3] = { [0] = 25, [1] = 29, [2] = 119 }, [4] = { [0] = 27, [1] = 31, [2] = 121 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 25, [1] = 29, [2] = 119 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 10, [1] = 14, [2] = 104 }, [2] = { [0] = 24, [1] = 28, [2] = 118 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 28, [1] = 32, [2] = 122 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 26, [1] = 30, [2] = 120 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 14, [1] = 111, [2] = 65 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 11, [1] = 108, [2] = 62 } })[R[13]][R[11]], ({ [0] = { [0] = 16, [1] = 20, [2] = 110 }, [1] = { [0] = 11, [1] = 15, [2] = 105 }, [2] = { [0] = 25, [1] = 29, [2] = 119 }, [3] = { [0] = 22, [1] = 26, [2] = 116 }, [4] = { [0] = 29, [1] = 33, [2] = 123 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 14, [1] = 111, [2] = 65 }, [4] = { [0] = 17, [1] = 114, [2] = 68 }, [5] = { [0] = 21, [1] = 118, [2] = 72 }, [6] = { [0] = 17, [1] = 114, [2] = 68 }, [7] = { [0] = 11, [1] = 108, [2] = 62 } })[R[13]][R[11]], ({ [0] = { [0] = 17, [1] = 21, [2] = 111 }, [1] = { [0] = 12, [1] = 16, [2] = 106 }, [2] = { [0] = 26, [1] = 30, [2] = 120 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 15, [1] = 19, [2] = 109 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 17, [1] = 114, [2] = 68 }, [5] = { [0] = 21, [1] = 118, [2] = 72 }, [6] = { [0] = 17, [1] = 114, [2] = 68 }, [7] = { [0] = 12, [1] = 109, [2] = 63 } })[R[13]][R[11]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 16, [1] = 113, [2] = 67 }, [4] = { [0] = 17, [1] = 114, [2] = 68 }, [5] = { [0] = 22, [1] = 119, [2] = 73 }, [6] = { [0] = 18, [1] = 115, [2] = 69 }, [7] = { [0] = 12, [1] = 109, [2] = 63 } })[R[13]][R[11]], ({ [0] = { [0] = 22, [1] = 26, [2] = 116 }, [1] = { [0] = 17, [1] = 21, [2] = 111 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 15, [1] = 112, [2] = 66 }, [3] = { [0] = 17, [1] = 114, [2] = 68 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 22, [1] = 119, [2] = 73 }, [6] = { [0] = 18, [1] = 115, [2] = 69 }, [7] = { [0] = 13, [1] = 110, [2] = 64 } })[R[13]][R[11]], ({ [0] = { [0] = 23, [1] = 27, [2] = 117 }, [1] = { [0] = 18, [1] = 22, [2] = 112 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 15, [1] = 19, [2] = 109 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 15, [1] = 112, [2] = 66 }, [3] = { [0] = 17, [1] = 114, [2] = 68 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 23, [1] = 120, [2] = 74 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 13, [1] = 110, [2] = 64 } })[R[13]][R[11]], ({ [0] = { [0] = 24, [1] = 28, [2] = 118 }, [1] = { [0] = 19, [1] = 23, [2] = 113 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 16, [1] = 20, [2] = 110 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 117, [2] = 71 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 16, [1] = 113, [2] = 67 }, [3] = { [0] = 18, [1] = 115, [2] = 69 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 23, [1] = 120, [2] = 74 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 14, [1] = 111, [2] = 65 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 17, [1] = 21, [2] = 111 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 118, [2] = 72 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 16, [1] = 113, [2] = 67 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 24, [1] = 121, [2] = 75 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 14, [1] = 111, [2] = 65 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 21, [1] = 25, [2] = 115 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 15, [1] = 19, [2] = 109 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 18, [1] = 22, [2] = 112 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 17, [1] = 114, [2] = 68 }, [3] = { [0] = 20, [1] = 117, [2] = 71 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 25, [1] = 122, [2] = 76 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 22, [1] = 26, [2] = 116 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 16, [1] = 20, [2] = 110 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 19, [1] = 23, [2] = 113 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 120, [2] = 74 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 17, [1] = 114, [2] = 68 }, [3] = { [0] = 21, [1] = 118, [2] = 72 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 27, [1] = 31, [2] = 121 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 20, [1] = 24, [2] = 114 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 121, [2] = 75 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 18, [1] = 115, [2] = 69 }, [3] = { [0] = 22, [1] = 119, [2] = 73 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 28, [1] = 32, [2] = 122 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 17, [1] = 21, [2] = 111 } })[R[13]][R[11]] })
    if R[13] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] })
        for i = 1, game.initial_units() do
          R[14] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 120, [2] = 74 }, [1] = { [0] = 25, [1] = 122, [2] = 76 }, [2] = { [0] = 12, [1] = 109, [2] = 63 } })[R[14]][R[11]], ({ [0] = { [0] = 13, [1] = 17, [2] = 107 }, [1] = { [0] = 13, [1] = 17, [2] = 107 }, [2] = { [0] = 24, [1] = 28, [2] = 118 } })[R[14]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[13] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[11]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[11]] })
        for i = 1, game.initial_units() do
          R[15] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 111, [2] = 65 }, [1] = { [0] = 16, [1] = 113, [2] = 67 }, [2] = { [0] = 18, [1] = 115, [2] = 69 } })[R[15]][R[11]], ({ [0] = { [0] = 24, [1] = 28, [2] = 118 }, [1] = { [0] = 33, [1] = 37, [2] = 127 }, [2] = { [0] = 18, [1] = 22, [2] = 112 } })[R[15]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[13] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[16] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 9, [1] = 106, [2] = 60 }, [1] = { [0] = 19, [1] = 116, [2] = 70 }, [2] = { [0] = 14, [1] = 111, [2] = 65 } })[R[16]][R[11]], ({ [0] = { [0] = 16, [1] = 20, [2] = 110 }, [1] = { [0] = 16, [1] = 20, [2] = 110 }, [2] = { [0] = 32, [1] = 36, [2] = 126 } })[R[16]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[13] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[11]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[11]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[11]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[11]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        for i = 1, game.initial_units() do
          R[17] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 116, [2] = 70 }, [1] = { [0] = 21, [1] = 118, [2] = 72 }, [2] = { [0] = 8, [1] = 105, [2] = 59 } })[R[17]][R[11]], ({ [0] = { [0] = 22, [1] = 26, [2] = 116 }, [1] = { [0] = 29, [1] = 33, [2] = 123 }, [2] = { [0] = 26, [1] = 30, [2] = 120 } })[R[17]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[13] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 16, [1] = 20, [2] = 110 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[11]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[11]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[11]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[11]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[11]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 16, [1] = 20, [2] = 110 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[11]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[11]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[11]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[11]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[11]] })
        for i = 1, game.initial_units() do
          R[18] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 115, [2] = 69 }, [1] = { [0] = 11, [1] = 108, [2] = 62 }, [2] = { [0] = 7, [1] = 104, [2] = 58 } })[R[18]][R[11]], ({ [0] = { [0] = 14, [1] = 18, [2] = 108 }, [1] = { [0] = 14, [1] = 18, [2] = 108 }, [2] = { [0] = 23, [1] = 27, [2] = 117 } })[R[18]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[13] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
        for i = 1, game.initial_units() do
          R[19] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 27, [1] = 124, [2] = 78 }, [2] = { [0] = 5, [1] = 102, [2] = 56 } })[R[19]][R[11]], ({ [0] = { [0] = 31, [1] = 35, [2] = 125 }, [1] = { [0] = 31, [1] = 35, [2] = 125 }, [2] = { [0] = 18, [1] = 22, [2] = 112 } })[R[19]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[13] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        for i = 1, game.initial_units() do
          R[20] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 6, [1] = 103, [2] = 57 }, [1] = { [0] = 11, [1] = 108, [2] = 62 }, [2] = { [0] = 34, [1] = 131, [2] = 85 } })[R[20]][R[11]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 10, [1] = 14, [2] = 104 }, [2] = { [0] = 23, [1] = 27, [2] = 117 } })[R[20]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[13] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 13, [1] = 110, [2] = 64 }, [1] = { [0] = 19, [1] = 116, [2] = 70 }, [2] = { [0] = 9, [1] = 106, [2] = 60 } })[R[21]][R[11]], ({ [0] = { [0] = 11, [1] = 15, [2] = 105 }, [1] = { [0] = 11, [1] = 15, [2] = 105 }, [2] = { [0] = 32, [1] = 36, [2] = 126 } })[R[21]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[13]", R[13])
    end
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = ({ [0] = "Bar1", [1] = "Bar1", [2] = "Bar2" })[R[11]], variant = "Random", at = { ({ [0] = 15, [1] = 106, [2] = 51 })[R[11]], ({ [0] = 5, [1] = 5, [2] = 101 })[R[11]] } }
    U[#U + 1] = game.create_unit{ type = "CommonOreMine", player = players[1], at = { ({ [0] = 15, [1] = 106, [2] = 51 })[R[11]], ({ [0] = 5, [1] = 5, [2] = 101 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    R[22] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 17, [1] = 21, [2] = 111 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 17, [1] = 21, [2] = 111 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[22]][R[12]] })
    U[#U + 1] = game.create_unit{ type = "TradeCenter", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 118, [2] = 72 }, [1] = { [0] = 16, [1] = 113, [2] = 67 }, [2] = { [0] = 12, [1] = 109, [2] = 63 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 18, [1] = 115, [2] = 69 }, [7] = { [0] = 12, [1] = 109, [2] = 63 } })[R[22]][R[12]], ({ [0] = { [0] = 17, [1] = 21, [2] = 111 }, [1] = { [0] = 18, [1] = 22, [2] = 112 }, [2] = { [0] = 20, [1] = 24, [2] = 114 }, [3] = { [0] = 23, [1] = 27, [2] = 117 }, [4] = { [0] = 21, [1] = 25, [2] = 115 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 17, [1] = 21, [2] = 111 }, [7] = { [0] = 21, [1] = 25, [2] = 115 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 8, [1] = 105, [2] = 59 }, [3] = { [0] = 27, [1] = 124, [2] = 78 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 7, [1] = 11, [2] = 101 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 30, [1] = 34, [2] = 124 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    if R[22] == 0 or R[22] == 1 or R[22] == 2 or R[22] == 5 or R[22] == 6 or R[22] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 126, [2] = 80 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 11, [1] = 108, [2] = 62 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 21, [1] = 118, [2] = 72 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 14, [1] = 18, [2] = 108 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [5] = { [0] = 27, [1] = 31, [2] = 121 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      if R[22] == 0 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 6, [1] = 103, [2] = 57 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 6, [1] = 103, [2] = 57 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 6, [1] = 103, [2] = 57 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[22] == 1 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[22] == 2 then
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
      elseif R[22] == 5 then
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
      elseif R[22] == 6 then
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
      elseif R[22] == 7 then
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
        unseen("R[22]", R[22])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 20, [1] = 117, [2] = 71 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 29, [1] = 126, [2] = 80 }, [7] = { [0] = 23, [1] = 120, [2] = 74 } })[R[22]][R[12]], ({ [0] = { [0] = 26, [1] = 30, [2] = 120 }, [1] = { [0] = 32, [1] = 36, [2] = 126 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      if R[22] == 2 or R[22] == 5 or R[22] == 6 or R[22] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [2] = { [0] = 20, [1] = 117, [2] = 71 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 12, [1] = 109, [2] = 63 }, [7] = { [0] = 24, [1] = 121, [2] = 75 } })[R[22]][R[12]], ({ [2] = { [0] = 28, [1] = 32, [2] = 122 }, [5] = { [0] = 15, [1] = 19, [2] = 109 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 27, [1] = 31, [2] = 121 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[22] == 0 or R[22] == 1 then
      else
        unseen("R[22]", R[22])
      end
    elseif R[22] == 3 or R[22] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 } })[R[22]][R[12]], ({ [3] = { [0] = 30, [1] = 34, [2] = 124 }, [4] = { [0] = 15, [1] = 19, [2] = 109 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      if R[22] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[22] == 3 then
      else
        unseen("R[22]", R[22])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [3] = { [0] = 14, [1] = 111, [2] = 65 }, [4] = { [0] = 25, [1] = 122, [2] = 76 } })[R[22]][R[12]], ({ [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 27, [1] = 31, [2] = 121 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      if R[22] == 3 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[22] == 4 then
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
        unseen("R[22]", R[22])
      end
    else
      unseen("R[22]", R[22])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 13, [1] = 110, [2] = 64 }, [2] = { [0] = 28, [1] = 125, [2] = 79 }, [3] = { [0] = 20, [1] = 117, [2] = 71 }, [4] = { [0] = 6, [1] = 103, [2] = 57 }, [5] = { [0] = 6, [1] = 103, [2] = 57 }, [6] = { [0] = 4, [1] = 101, [2] = 55 }, [7] = { [0] = 16, [1] = 113, [2] = 67 } })[R[22]][R[12]], ({ [0] = { [0] = 26, [1] = 30, [2] = 120 }, [1] = { [0] = 29, [1] = 33, [2] = 123 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 13, [1] = 17, [2] = 107 }, [4] = { [0] = 19, [1] = 23, [2] = 113 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 31, [1] = 35, [2] = 125 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 13, [1] = 110, [2] = 64 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 9, [1] = 106, [2] = 60 }, [4] = { [0] = 24, [1] = 121, [2] = 75 }, [5] = { [0] = 24, [1] = 121, [2] = 75 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 26, [1] = 123, [2] = 77 } })[R[22]][R[12]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 26, [1] = 30, [2] = 120 }, [3] = { [0] = 20, [1] = 24, [2] = 114 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 13, [1] = 17, [2] = 107 }, [6] = { [0] = 27, [1] = 31, [2] = 121 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 11, [1] = 108, [2] = 62 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 12, [1] = 109, [2] = 63 }, [4] = { [0] = 26, [1] = 123, [2] = 77 }, [5] = { [0] = 24, [1] = 121, [2] = 75 }, [6] = { [0] = 9, [1] = 106, [2] = 60 }, [7] = { [0] = 26, [1] = 123, [2] = 77 } })[R[22]][R[12]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 13, [1] = 17, [2] = 107 }, [2] = { [0] = 24, [1] = 28, [2] = 118 }, [3] = { [0] = 16, [1] = 20, [2] = 110 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 15, [1] = 19, [2] = 109 }, [6] = { [0] = 27, [1] = 31, [2] = 121 }, [7] = { [0] = 24, [1] = 28, [2] = 118 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[22]], player = players[2], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 6, [1] = 103, [2] = 57 }, [3] = { [0] = 29, [1] = 126, [2] = 80 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 25, [1] = 122, [2] = 76 } })[R[22]][R[12]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 20, [1] = 24, [2] = 114 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[22]], player = players[2], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 6, [1] = 103, [2] = 57 }, [3] = { [0] = 27, [1] = 124, [2] = 78 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 25, [1] = 122, [2] = 76 } })[R[22]][R[12]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 16, [1] = 20, [2] = 110 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 6, [1] = 103, [2] = 57 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 25, [1] = 122, [2] = 76 } })[R[22]][R[12]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[22]], player = players[2], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 11, [1] = 108, [2] = 62 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 10, [1] = 107, [2] = 61 } })[R[22]][R[12]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 9, [1] = 13, [2] = 103 }, [2] = { [0] = 30, [1] = 34, [2] = 124 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 27, [1] = 31, [2] = 121 }, [5] = { [0] = 12, [1] = 16, [2] = 106 }, [6] = { [0] = 24, [1] = 28, [2] = 118 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[22]], player = players[2], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 18, [1] = 115, [2] = 69 }, [2] = { [0] = 20, [1] = 117, [2] = 71 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 21, [1] = 118, [2] = 72 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 25, [1] = 122, [2] = 76 }, [7] = { [0] = 5, [1] = 102, [2] = 56 } })[R[22]][R[12]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 6, [1] = 10, [2] = 100 }, [2] = { [0] = 31, [1] = 35, [2] = 125 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 18, [1] = 22, [2] = 112 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 21, [1] = 25, [2] = 115 }, [7] = { [0] = 19, [1] = 23, [2] = 113 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[22]], player = players[2], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 11, [1] = 108, [2] = 62 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 10, [1] = 107, [2] = 61 } })[R[22]][R[12]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 9, [1] = 13, [2] = 103 }, [2] = { [0] = 30, [1] = 34, [2] = 124 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 27, [1] = 31, [2] = 121 }, [5] = { [0] = 12, [1] = 16, [2] = 106 }, [6] = { [0] = 24, [1] = 28, [2] = 118 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[22]], player = players[2], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 18, [1] = 115, [2] = 69 }, [2] = { [0] = 20, [1] = 117, [2] = 71 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 21, [1] = 118, [2] = 72 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 25, [1] = 122, [2] = 76 }, [7] = { [0] = 5, [1] = 102, [2] = 56 } })[R[22]][R[12]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 6, [1] = 10, [2] = 100 }, [2] = { [0] = 31, [1] = 35, [2] = 125 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 18, [1] = 22, [2] = 112 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 21, [1] = 25, [2] = 115 }, [7] = { [0] = 19, [1] = 23, [2] = 113 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 126, [2] = 80 }, [1] = { [0] = 21, [1] = 118, [2] = 72 }, [2] = { [0] = 16, [1] = 113, [2] = 67 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 27, [1] = 124, [2] = 78 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 25, [1] = 122, [2] = 76 }, [7] = { [0] = 19, [1] = 116, [2] = 70 } })[R[22]][R[12]], ({ [0] = { [0] = 23, [1] = 27, [2] = 117 }, [1] = { [0] = 19, [1] = 23, [2] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 118 }, [3] = { [0] = 17, [1] = 21, [2] = 111 }, [4] = { [0] = 14, [1] = 18, [2] = 108 }, [5] = { [0] = 29, [1] = 33, [2] = 123 }, [6] = { [0] = 24, [1] = 28, [2] = 118 }, [7] = { [0] = 21, [1] = 25, [2] = 115 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 9, [1] = 106, [2] = 60 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 11, [1] = 108, [2] = 62 }, [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 17, [1] = 21, [2] = 111 }, [5] = { [0] = 18, [1] = 22, [2] = 112 }, [6] = { [0] = 16, [1] = 20, [2] = 110 }, [7] = { [0] = 18, [1] = 22, [2] = 112 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 10, [1] = 107, [2] = 61 }, [1] = { [0] = 16, [1] = 113, [2] = 67 }, [2] = { [0] = 12, [1] = 109, [2] = 63 }, [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 27, [1] = 31, [2] = 121 }, [4] = { [0] = 18, [1] = 22, [2] = 112 }, [5] = { [0] = 19, [1] = 23, [2] = 113 }, [6] = { [0] = 17, [1] = 21, [2] = 111 }, [7] = { [0] = 19, [1] = 23, [2] = 113 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 11, [1] = 108, [2] = 62 }, [1] = { [0] = 17, [1] = 114, [2] = 68 }, [2] = { [0] = 13, [1] = 110, [2] = 64 }, [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 28, [1] = 32, [2] = 122 }, [4] = { [0] = 19, [1] = 23, [2] = 113 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 18, [1] = 22, [2] = 112 }, [7] = { [0] = 20, [1] = 24, [2] = 114 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 12, [1] = 109, [2] = 63 }, [1] = { [0] = 18, [1] = 115, [2] = 69 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 12, [1] = 109, [2] = 63 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 19, [1] = 23, [2] = 113 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 20, [1] = 24, [2] = 114 }, [5] = { [0] = 24, [1] = 28, [2] = 118 }, [6] = { [0] = 19, [1] = 23, [2] = 113 }, [7] = { [0] = 21, [1] = 25, [2] = 115 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 13, [1] = 110, [2] = 64 }, [1] = { [0] = 19, [1] = 116, [2] = 70 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 20, [1] = 24, [2] = 114 }, [3] = { [0] = 22, [1] = 26, [2] = 116 }, [4] = { [0] = 21, [1] = 25, [2] = 115 }, [5] = { [0] = 25, [1] = 29, [2] = 119 }, [6] = { [0] = 20, [1] = 24, [2] = 114 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 14, [1] = 111, [2] = 65 }, [1] = { [0] = 20, [1] = 117, [2] = 71 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 14, [1] = 111, [2] = 65 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 21, [1] = 25, [2] = 115 }, [3] = { [0] = 23, [1] = 27, [2] = 117 }, [4] = { [0] = 25, [1] = 29, [2] = 119 }, [5] = { [0] = 26, [1] = 30, [2] = 120 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 23, [1] = 27, [2] = 117 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 15, [1] = 112, [2] = 66 }, [1] = { [0] = 21, [1] = 118, [2] = 72 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 19, [1] = 116, [2] = 70 }, [6] = { [0] = 15, [1] = 112, [2] = 66 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 24, [1] = 28, [2] = 118 }, [4] = { [0] = 26, [1] = 30, [2] = 120 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 24, [1] = 28, [2] = 118 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 19, [1] = 116, [2] = 70 }, [6] = { [0] = 15, [1] = 112, [2] = 66 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 14, [1] = 18, [2] = 108 }, [1] = { [0] = 9, [1] = 13, [2] = 103 }, [2] = { [0] = 23, [1] = 27, [2] = 117 }, [3] = { [0] = 25, [1] = 29, [2] = 119 }, [4] = { [0] = 27, [1] = 31, [2] = 121 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 25, [1] = 29, [2] = 119 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 10, [1] = 14, [2] = 104 }, [2] = { [0] = 24, [1] = 28, [2] = 118 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 28, [1] = 32, [2] = 122 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 26, [1] = 30, [2] = 120 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 14, [1] = 111, [2] = 65 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 11, [1] = 108, [2] = 62 } })[R[22]][R[12]], ({ [0] = { [0] = 16, [1] = 20, [2] = 110 }, [1] = { [0] = 11, [1] = 15, [2] = 105 }, [2] = { [0] = 25, [1] = 29, [2] = 119 }, [3] = { [0] = 22, [1] = 26, [2] = 116 }, [4] = { [0] = 29, [1] = 33, [2] = 123 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 14, [1] = 111, [2] = 65 }, [4] = { [0] = 17, [1] = 114, [2] = 68 }, [5] = { [0] = 21, [1] = 118, [2] = 72 }, [6] = { [0] = 17, [1] = 114, [2] = 68 }, [7] = { [0] = 11, [1] = 108, [2] = 62 } })[R[22]][R[12]], ({ [0] = { [0] = 17, [1] = 21, [2] = 111 }, [1] = { [0] = 12, [1] = 16, [2] = 106 }, [2] = { [0] = 26, [1] = 30, [2] = 120 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 15, [1] = 19, [2] = 109 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 17, [1] = 114, [2] = 68 }, [5] = { [0] = 21, [1] = 118, [2] = 72 }, [6] = { [0] = 17, [1] = 114, [2] = 68 }, [7] = { [0] = 12, [1] = 109, [2] = 63 } })[R[22]][R[12]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 16, [1] = 113, [2] = 67 }, [4] = { [0] = 17, [1] = 114, [2] = 68 }, [5] = { [0] = 22, [1] = 119, [2] = 73 }, [6] = { [0] = 18, [1] = 115, [2] = 69 }, [7] = { [0] = 12, [1] = 109, [2] = 63 } })[R[22]][R[12]], ({ [0] = { [0] = 22, [1] = 26, [2] = 116 }, [1] = { [0] = 17, [1] = 21, [2] = 111 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 15, [1] = 112, [2] = 66 }, [3] = { [0] = 17, [1] = 114, [2] = 68 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 22, [1] = 119, [2] = 73 }, [6] = { [0] = 18, [1] = 115, [2] = 69 }, [7] = { [0] = 13, [1] = 110, [2] = 64 } })[R[22]][R[12]], ({ [0] = { [0] = 23, [1] = 27, [2] = 117 }, [1] = { [0] = 18, [1] = 22, [2] = 112 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 15, [1] = 19, [2] = 109 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 15, [1] = 112, [2] = 66 }, [3] = { [0] = 17, [1] = 114, [2] = 68 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 23, [1] = 120, [2] = 74 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 13, [1] = 110, [2] = 64 } })[R[22]][R[12]], ({ [0] = { [0] = 24, [1] = 28, [2] = 118 }, [1] = { [0] = 19, [1] = 23, [2] = 113 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 16, [1] = 20, [2] = 110 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 117, [2] = 71 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 16, [1] = 113, [2] = 67 }, [3] = { [0] = 18, [1] = 115, [2] = 69 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 23, [1] = 120, [2] = 74 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 14, [1] = 111, [2] = 65 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 17, [1] = 21, [2] = 111 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 118, [2] = 72 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 16, [1] = 113, [2] = 67 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 24, [1] = 121, [2] = 75 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 14, [1] = 111, [2] = 65 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 21, [1] = 25, [2] = 115 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 15, [1] = 19, [2] = 109 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 18, [1] = 22, [2] = 112 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 17, [1] = 114, [2] = 68 }, [3] = { [0] = 20, [1] = 117, [2] = 71 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 25, [1] = 122, [2] = 76 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 22, [1] = 26, [2] = 116 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 16, [1] = 20, [2] = 110 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 19, [1] = 23, [2] = 113 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 120, [2] = 74 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 17, [1] = 114, [2] = 68 }, [3] = { [0] = 21, [1] = 118, [2] = 72 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 27, [1] = 31, [2] = 121 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 20, [1] = 24, [2] = 114 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 121, [2] = 75 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 18, [1] = 115, [2] = 69 }, [3] = { [0] = 22, [1] = 119, [2] = 73 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 28, [1] = 32, [2] = 122 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 17, [1] = 21, [2] = 111 } })[R[22]][R[12]] })
    if R[22] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] })
        for i = 1, game.initial_units() do
          R[23] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 120, [2] = 74 }, [1] = { [0] = 25, [1] = 122, [2] = 76 }, [2] = { [0] = 12, [1] = 109, [2] = 63 } })[R[23]][R[12]], ({ [0] = { [0] = 13, [1] = 17, [2] = 107 }, [1] = { [0] = 13, [1] = 17, [2] = 107 }, [2] = { [0] = 24, [1] = 28, [2] = 118 } })[R[23]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[22] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[12]] })
        for i = 1, game.initial_units() do
          R[24] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 111, [2] = 65 }, [1] = { [0] = 16, [1] = 113, [2] = 67 }, [2] = { [0] = 18, [1] = 115, [2] = 69 } })[R[24]][R[12]], ({ [0] = { [0] = 24, [1] = 28, [2] = 118 }, [1] = { [0] = 33, [1] = 37, [2] = 127 }, [2] = { [0] = 18, [1] = 22, [2] = 112 } })[R[24]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[22] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[25] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 9, [1] = 106, [2] = 60 }, [1] = { [0] = 19, [1] = 116, [2] = 70 }, [2] = { [0] = 14, [1] = 111, [2] = 65 } })[R[25]][R[12]], ({ [0] = { [0] = 16, [1] = 20, [2] = 110 }, [1] = { [0] = 16, [1] = 20, [2] = 110 }, [2] = { [0] = 32, [1] = 36, [2] = 126 } })[R[25]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[22] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[12]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[12]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[12]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[12]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        for i = 1, game.initial_units() do
          R[26] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 116, [2] = 70 }, [1] = { [0] = 21, [1] = 118, [2] = 72 }, [2] = { [0] = 8, [1] = 105, [2] = 59 } })[R[26]][R[12]], ({ [0] = { [0] = 22, [1] = 26, [2] = 116 }, [1] = { [0] = 29, [1] = 33, [2] = 123 }, [2] = { [0] = 26, [1] = 30, [2] = 120 } })[R[26]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[22] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 16, [1] = 20, [2] = 110 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[12]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[12]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[12]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[12]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 16, [1] = 20, [2] = 110 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[12]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[12]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[12]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[12]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[12]] })
        for i = 1, game.initial_units() do
          R[27] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 115, [2] = 69 }, [1] = { [0] = 11, [1] = 108, [2] = 62 }, [2] = { [0] = 7, [1] = 104, [2] = 58 } })[R[27]][R[12]], ({ [0] = { [0] = 14, [1] = 18, [2] = 108 }, [1] = { [0] = 14, [1] = 18, [2] = 108 }, [2] = { [0] = 23, [1] = 27, [2] = 117 } })[R[27]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[22] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
        for i = 1, game.initial_units() do
          R[28] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 27, [1] = 124, [2] = 78 }, [2] = { [0] = 5, [1] = 102, [2] = 56 } })[R[28]][R[12]], ({ [0] = { [0] = 31, [1] = 35, [2] = 125 }, [1] = { [0] = 31, [1] = 35, [2] = 125 }, [2] = { [0] = 18, [1] = 22, [2] = 112 } })[R[28]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[22] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 6, [1] = 103, [2] = 57 }, [1] = { [0] = 11, [1] = 108, [2] = 62 }, [2] = { [0] = 34, [1] = 131, [2] = 85 } })[R[29]][R[12]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 10, [1] = 14, [2] = 104 }, [2] = { [0] = 23, [1] = 27, [2] = 117 } })[R[29]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[22] == 7 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 13, [1] = 110, [2] = 64 }, [1] = { [0] = 19, [1] = 116, [2] = 70 }, [2] = { [0] = 9, [1] = 106, [2] = 60 } })[R[30]][R[12]], ({ [0] = { [0] = 11, [1] = 15, [2] = 105 }, [1] = { [0] = 11, [1] = 15, [2] = 105 }, [2] = { [0] = 32, [1] = 36, [2] = 126 } })[R[30]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[22]", R[22])
    end
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = ({ [0] = "Bar1", [1] = "Bar1", [2] = "Bar2" })[R[12]], variant = "Random", at = { ({ [0] = 15, [1] = 106, [2] = 51 })[R[12]], ({ [0] = 5, [1] = 5, [2] = 101 })[R[12]] } }
    U[#U + 1] = game.create_unit{ type = "CommonOreMine", player = players[2], at = { ({ [0] = 15, [1] = 106, [2] = 51 })[R[12]], ({ [0] = 5, [1] = 5, [2] = 101 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:mark_research(3303)
    players[1].workers = 28 - 3 * LEVEL_OF[players[1].difficulty]
    players[1].scientists = 20 - 3 * LEVEL_OF[players[1].difficulty]
    players[1].kids = 18 - 2 * LEVEL_OF[players[1].difficulty]
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
    players[2].workers = 28 - 3 * LEVEL_OF[players[2].difficulty]
    players[2].scientists = 20 - 3 * LEVEL_OF[players[2].difficulty]
    players[2].kids = 18 - 2 * LEVEL_OF[players[2].difficulty]
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
    game.set_cell_type({ 68, 120 }, 7)
    game.initial_set_tile({ 68, 120 }, 17)
    game.set_cell_type({ 68, 121 }, 7)
    game.initial_set_tile({ 68, 121 }, 21)
    game.set_cell_type({ 69, 120 }, 7)
    game.initial_set_tile({ 69, 120 }, 18)
    game.set_cell_type({ 69, 121 }, 7)
    game.initial_set_tile({ 69, 121 }, 22)
    game.initial_set_tile({ 62, 73 }, 1095)
    game.initial_set_tile({ 63, 73 }, 1107)
    game.initial_set_tile({ 62, 74 }, 1118)
    game.initial_set_tile({ 63, 74 }, 1129)
    game.initial_set_tile({ 66, 73 }, 1140)
    game.initial_set_tile({ 66, 74 }, 1150)
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 47, 12 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 89, 9 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 52, 69 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 73, 66 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 59, 64 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 67, 82 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 84, 83 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 27, 121 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 14, 88 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 124, 121 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 47, 87 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 25, 100 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 67, 13 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 81, 40 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 71, 72 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 98, 108 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 120, 82 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 71, 35 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 116, 65 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 37, 124 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { 15, 45 } }
    pick(16, 2, { 0, 1 })
    if R[1] == 0 then
      if R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 56, 61 } }
      elseif R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [1] = 54, [2] = 71, [3] = 70, [4] = 77, [6] = 65, [7] = 61 })[R[0]], ({ [1] = 72, [2] = 62, [3] = 83, [4] = 79, [6] = 59, [7] = 79 })[R[0]] } }
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 56, 61 } }
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 1 then
      if R[0] == 9 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 54, 72 } }
      elseif R[0] == 0 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [2] = 71, [3] = 70, [4] = 77, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [2] = 62, [3] = 83, [4] = 79, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 54, 72 } }
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 2 then
      if R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 71, 62 } }
      elseif R[0] == 0 or R[0] == 1 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [3] = 70, [4] = 77, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [3] = 83, [4] = 79, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 71, 62 } }
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 3 then
      if R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 70, 83 } }
      elseif R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 5 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [5] = 76, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [5] = 72, [7] = 79 })[R[0]] } }
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 70, 83 } }
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 4 then
      if R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 77, 79 } }
      elseif R[0] == 0 or R[0] == 2 or R[0] == 3 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [2] = 71, [3] = 70, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [2] = 62, [3] = 83, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 77, 79 } }
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 5 then
      if R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 76, 72 } }
      elseif R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [3] = 70, [4] = 77, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [3] = 83, [4] = 79, [6] = 59, [7] = 79 })[R[0]] } }
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 76, 72 } }
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 6 then
      if R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 14 or R[0] == 15 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 65, 59 } }
      elseif R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [3] = 70, [4] = 77, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [3] = 83, [4] = 79, [7] = 79 })[R[0]] } }
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 65, 59 } }
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 7 then
      if R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 61, 79 } }
      elseif R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [3] = 70, [4] = 77, [5] = 76, [6] = 65 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [3] = 83, [4] = 79, [5] = 72, [6] = 59 })[R[0]] } }
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 61, 79 } }
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 8 then
      if R[0] == 0 or R[0] == 1 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [3] = 70, [4] = 77, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [3] = 83, [4] = 79, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
      elseif R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 9 then
      if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 4 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [4] = 77, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [4] = 79, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
      elseif R[0] == 8 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 10 then
      if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [3] = 70, [4] = 77, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [3] = 83, [4] = 79, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
      elseif R[0] == 8 or R[0] == 9 or R[0] == 11 or R[0] == 12 or R[0] == 15 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 11 then
      if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [3] = 70, [4] = 77, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [3] = 83, [4] = 79, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
      elseif R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 12 or R[0] == 13 or R[0] == 14 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 12 then
      if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [3] = 70, [4] = 77, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [3] = 83, [4] = 79, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
      elseif R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 13 or R[0] == 14 or R[0] == 15 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 13 then
      if R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [1] = 54, [2] = 71, [3] = 70, [4] = 77, [5] = 76, [6] = 65 })[R[0]], ({ [1] = 72, [2] = 62, [3] = 83, [4] = 79, [5] = 72, [6] = 59 })[R[0]] } }
      elseif R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 14 or R[0] == 15 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 14 then
      if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [3] = 70, [4] = 77, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [3] = 83, [4] = 79, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
      elseif R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 15 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[1] == 15 then
      if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 4 or R[0] == 5 or R[0] == 6 or R[0] == 7 then
        game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 56, [1] = 54, [2] = 71, [4] = 77, [5] = 76, [6] = 65, [7] = 61 })[R[0]], ({ [0] = 61, [1] = 72, [2] = 62, [4] = 79, [5] = 72, [6] = 59, [7] = 79 })[R[0]] } }
      elseif R[0] == 8 or R[0] == 9 or R[0] == 10 or R[0] == 11 or R[0] == 12 or R[0] == 13 or R[0] == 14 then
      else
        unseen("R[0]", R[0])
      end
    else
      unseen("R[1]", R[1])
    end
    R[2] = game.rand(20)
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[2]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[2]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[2]] } }
    R[3] = draw_avoid(20, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[3]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[3]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[3]] } }
    R[4] = draw_avoid(20, { R[3], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[4]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[4]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[4]] } }
    R[5] = draw_avoid(20, { R[4], R[3], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[5]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[5]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[5]] } }
    R[6] = draw_avoid(20, { R[5], R[4], R[3], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[6]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[6]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[6]] } }
    R[7] = draw_avoid(20, { R[6], R[5], R[4], R[3], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[7]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[7]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[7]] } }
    R[8] = draw_avoid(20, { R[7], R[6], R[5], R[4], R[3], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[8]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[8]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[8]] } }
    R[9] = draw_avoid(20, { R[8], R[7], R[6], R[5], R[4], R[3], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[9]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[9]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[9]] } }
    R[10] = draw_avoid(20, { R[9], R[8], R[7], R[6], R[5], R[4], R[3], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = ({ [0] = "Rare", [1] = "Common", [2] = "Rare", [3] = "Rare", [4] = "Rare", [5] = "Common", [6] = "Rare", [7] = "Rare", [8] = "Rare", [9] = "Rare", [10] = "Common", [11] = "Rare", [12] = "Rare", [13] = "Rare", [14] = "Rare", [15] = "Rare", [16] = "Common", [17] = "Rare", [18] = "Common", [19] = "Rare" })[R[10]], yield = "Random", variant = "Random", at = { ({ [0] = 34, [1] = 18, [2] = 18, [3] = 11, [4] = 5, [5] = 99, [6] = 118, [7] = 125, [8] = 110, [9] = 125, [10] = 69, [11] = 55, [12] = 78, [13] = 67, [14] = 106, [15] = 35, [16] = 81, [17] = 87, [18] = 51, [19] = 57 })[R[10]], ({ [0] = 86, [1] = 110, [2] = 75, [3] = 94, [4] = 108, [5] = 92, [6] = 105, [7] = 100, [8] = 83, [9] = 80, [10] = 31, [11] = 15, [12] = 5, [13] = 3, [14] = 4, [15] = 19, [16] = 56, [17] = 71, [18] = 43, [19] = 88 })[R[10]] } }
    pick(3, 3, { 11, 12, 31 })
    players[R[11] + 1]:ally_with(players[R[12] + 1])
    players[R[12] + 1]:ally_with(players[R[11] + 1])
    R[13] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 17, [1] = 21, [2] = 111 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 17, [1] = 21, [2] = 111 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[13]][R[11]] })
    U[#U + 1] = game.create_unit{ type = "TradeCenter", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 118, [2] = 72 }, [1] = { [0] = 16, [1] = 113, [2] = 67 }, [2] = { [0] = 12, [1] = 109, [2] = 63 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 18, [1] = 115, [2] = 69 }, [7] = { [0] = 12, [1] = 109, [2] = 63 } })[R[13]][R[11]], ({ [0] = { [0] = 17, [1] = 21, [2] = 111 }, [1] = { [0] = 18, [1] = 22, [2] = 112 }, [2] = { [0] = 20, [1] = 24, [2] = 114 }, [3] = { [0] = 23, [1] = 27, [2] = 117 }, [4] = { [0] = 21, [1] = 25, [2] = 115 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 17, [1] = 21, [2] = 111 }, [7] = { [0] = 21, [1] = 25, [2] = 115 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 8, [1] = 105, [2] = 59 }, [3] = { [0] = 27, [1] = 124, [2] = 78 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 7, [1] = 11, [2] = 101 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 30, [1] = 34, [2] = 124 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    if R[13] == 0 or R[13] == 1 or R[13] == 2 or R[13] == 5 or R[13] == 6 or R[13] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 126, [2] = 80 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 11, [1] = 108, [2] = 62 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 21, [1] = 118, [2] = 72 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 14, [1] = 18, [2] = 108 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [5] = { [0] = 27, [1] = 31, [2] = 121 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
      if R[13] == 0 then
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
      elseif R[13] == 1 then
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
      elseif R[13] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[13] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[13] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 29, [1] = 126, [2] = 80 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 29, [1] = 126, [2] = 80 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 29, [1] = 126, [2] = 80 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[13] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[13]", R[13])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 6, [1] = 103, [2] = 57 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 20, [1] = 117, [2] = 71 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 12, [1] = 109, [2] = 63 }, [7] = { [0] = 24, [1] = 121, [2] = 75 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 24, [1] = 28, [2] = 118 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [5] = { [0] = 15, [1] = 19, [2] = 109 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 27, [1] = 31, [2] = 121 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
      if R[13] == 2 or R[13] == 5 or R[13] == 6 or R[13] == 7 then
      elseif R[13] == 0 or R[13] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 } })[R[13]][R[11]], ({ [0] = { [0] = 26, [1] = 30, [2] = 120 }, [1] = { [0] = 32, [1] = 36, [2] = 126 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[13]", R[13])
      end
    elseif R[13] == 3 or R[13] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 } })[R[13]][R[11]], ({ [3] = { [0] = 30, [1] = 34, [2] = 124 }, [4] = { [0] = 15, [1] = 19, [2] = 109 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
      if R[13] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[13] == 3 then
      else
        unseen("R[13]", R[13])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [3] = { [0] = 14, [1] = 111, [2] = 65 }, [4] = { [0] = 25, [1] = 122, [2] = 76 } })[R[13]][R[11]], ({ [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 27, [1] = 31, [2] = 121 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
      if R[13] == 3 then
        if LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[13] == 4 then
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
        unseen("R[13]", R[13])
      end
    else
      unseen("R[13]", R[13])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 13, [1] = 110, [2] = 64 }, [2] = { [0] = 28, [1] = 125, [2] = 79 }, [3] = { [0] = 20, [1] = 117, [2] = 71 }, [4] = { [0] = 6, [1] = 103, [2] = 57 }, [5] = { [0] = 6, [1] = 103, [2] = 57 }, [6] = { [0] = 4, [1] = 101, [2] = 55 }, [7] = { [0] = 16, [1] = 113, [2] = 67 } })[R[13]][R[11]], ({ [0] = { [0] = 26, [1] = 30, [2] = 120 }, [1] = { [0] = 29, [1] = 33, [2] = 123 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 13, [1] = 17, [2] = 107 }, [4] = { [0] = 19, [1] = 23, [2] = 113 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 31, [1] = 35, [2] = 125 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 13, [1] = 110, [2] = 64 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 9, [1] = 106, [2] = 60 }, [4] = { [0] = 24, [1] = 121, [2] = 75 }, [5] = { [0] = 24, [1] = 121, [2] = 75 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 26, [1] = 123, [2] = 77 } })[R[13]][R[11]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 26, [1] = 30, [2] = 120 }, [3] = { [0] = 20, [1] = 24, [2] = 114 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 13, [1] = 17, [2] = 107 }, [6] = { [0] = 27, [1] = 31, [2] = 121 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 11, [1] = 108, [2] = 62 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 12, [1] = 109, [2] = 63 }, [4] = { [0] = 26, [1] = 123, [2] = 77 }, [5] = { [0] = 24, [1] = 121, [2] = 75 }, [6] = { [0] = 9, [1] = 106, [2] = 60 }, [7] = { [0] = 26, [1] = 123, [2] = 77 } })[R[13]][R[11]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 13, [1] = 17, [2] = 107 }, [2] = { [0] = 24, [1] = 28, [2] = 118 }, [3] = { [0] = 16, [1] = 20, [2] = 110 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 15, [1] = 19, [2] = 109 }, [6] = { [0] = 27, [1] = 31, [2] = 121 }, [7] = { [0] = 24, [1] = 28, [2] = 118 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[13]], player = players[1], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 6, [1] = 103, [2] = 57 }, [3] = { [0] = 29, [1] = 126, [2] = 80 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 25, [1] = 122, [2] = 76 } })[R[13]][R[11]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 20, [1] = 24, [2] = 114 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[13]], player = players[1], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 6, [1] = 103, [2] = 57 }, [3] = { [0] = 27, [1] = 124, [2] = 78 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 25, [1] = 122, [2] = 76 } })[R[13]][R[11]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 16, [1] = 20, [2] = 110 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 6, [1] = 103, [2] = 57 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 25, [1] = 122, [2] = 76 } })[R[13]][R[11]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[13]], player = players[1], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 11, [1] = 108, [2] = 62 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 10, [1] = 107, [2] = 61 } })[R[13]][R[11]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 9, [1] = 13, [2] = 103 }, [2] = { [0] = 30, [1] = 34, [2] = 124 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 27, [1] = 31, [2] = 121 }, [5] = { [0] = 12, [1] = 16, [2] = 106 }, [6] = { [0] = 24, [1] = 28, [2] = 118 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[13]], player = players[1], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 18, [1] = 115, [2] = 69 }, [2] = { [0] = 20, [1] = 117, [2] = 71 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 21, [1] = 118, [2] = 72 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 25, [1] = 122, [2] = 76 }, [7] = { [0] = 5, [1] = 102, [2] = 56 } })[R[13]][R[11]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 6, [1] = 10, [2] = 100 }, [2] = { [0] = 31, [1] = 35, [2] = 125 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 18, [1] = 22, [2] = 112 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 21, [1] = 25, [2] = 115 }, [7] = { [0] = 19, [1] = 23, [2] = 113 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[13]], player = players[1], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 11, [1] = 108, [2] = 62 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 10, [1] = 107, [2] = 61 } })[R[13]][R[11]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 9, [1] = 13, [2] = 103 }, [2] = { [0] = 30, [1] = 34, [2] = 124 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 27, [1] = 31, [2] = 121 }, [5] = { [0] = 12, [1] = 16, [2] = 106 }, [6] = { [0] = 24, [1] = 28, [2] = 118 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[13]], player = players[1], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 18, [1] = 115, [2] = 69 }, [2] = { [0] = 20, [1] = 117, [2] = 71 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 21, [1] = 118, [2] = 72 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 25, [1] = 122, [2] = 76 }, [7] = { [0] = 5, [1] = 102, [2] = 56 } })[R[13]][R[11]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 6, [1] = 10, [2] = 100 }, [2] = { [0] = 31, [1] = 35, [2] = 125 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 18, [1] = 22, [2] = 112 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 21, [1] = 25, [2] = 115 }, [7] = { [0] = 19, [1] = 23, [2] = 113 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 126, [2] = 80 }, [1] = { [0] = 21, [1] = 118, [2] = 72 }, [2] = { [0] = 16, [1] = 113, [2] = 67 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 27, [1] = 124, [2] = 78 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 25, [1] = 122, [2] = 76 }, [7] = { [0] = 19, [1] = 116, [2] = 70 } })[R[13]][R[11]], ({ [0] = { [0] = 23, [1] = 27, [2] = 117 }, [1] = { [0] = 19, [1] = 23, [2] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 118 }, [3] = { [0] = 17, [1] = 21, [2] = 111 }, [4] = { [0] = 14, [1] = 18, [2] = 108 }, [5] = { [0] = 29, [1] = 33, [2] = 123 }, [6] = { [0] = 24, [1] = 28, [2] = 118 }, [7] = { [0] = 21, [1] = 25, [2] = 115 } })[R[13]][R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 9, [1] = 106, [2] = 60 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 11, [1] = 108, [2] = 62 }, [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 17, [1] = 21, [2] = 111 }, [5] = { [0] = 18, [1] = 22, [2] = 112 }, [6] = { [0] = 16, [1] = 20, [2] = 110 }, [7] = { [0] = 18, [1] = 22, [2] = 112 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 10, [1] = 107, [2] = 61 }, [1] = { [0] = 16, [1] = 113, [2] = 67 }, [2] = { [0] = 12, [1] = 109, [2] = 63 }, [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 27, [1] = 31, [2] = 121 }, [4] = { [0] = 18, [1] = 22, [2] = 112 }, [5] = { [0] = 19, [1] = 23, [2] = 113 }, [6] = { [0] = 17, [1] = 21, [2] = 111 }, [7] = { [0] = 19, [1] = 23, [2] = 113 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 11, [1] = 108, [2] = 62 }, [1] = { [0] = 17, [1] = 114, [2] = 68 }, [2] = { [0] = 13, [1] = 110, [2] = 64 }, [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 28, [1] = 32, [2] = 122 }, [4] = { [0] = 19, [1] = 23, [2] = 113 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 18, [1] = 22, [2] = 112 }, [7] = { [0] = 20, [1] = 24, [2] = 114 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 12, [1] = 109, [2] = 63 }, [1] = { [0] = 18, [1] = 115, [2] = 69 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 12, [1] = 109, [2] = 63 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 19, [1] = 23, [2] = 113 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 20, [1] = 24, [2] = 114 }, [5] = { [0] = 24, [1] = 28, [2] = 118 }, [6] = { [0] = 19, [1] = 23, [2] = 113 }, [7] = { [0] = 21, [1] = 25, [2] = 115 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 13, [1] = 110, [2] = 64 }, [1] = { [0] = 19, [1] = 116, [2] = 70 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 20, [1] = 24, [2] = 114 }, [3] = { [0] = 22, [1] = 26, [2] = 116 }, [4] = { [0] = 21, [1] = 25, [2] = 115 }, [5] = { [0] = 25, [1] = 29, [2] = 119 }, [6] = { [0] = 20, [1] = 24, [2] = 114 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 14, [1] = 111, [2] = 65 }, [1] = { [0] = 20, [1] = 117, [2] = 71 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 14, [1] = 111, [2] = 65 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 21, [1] = 25, [2] = 115 }, [3] = { [0] = 23, [1] = 27, [2] = 117 }, [4] = { [0] = 25, [1] = 29, [2] = 119 }, [5] = { [0] = 26, [1] = 30, [2] = 120 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 23, [1] = 27, [2] = 117 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 15, [1] = 112, [2] = 66 }, [1] = { [0] = 21, [1] = 118, [2] = 72 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 19, [1] = 116, [2] = 70 }, [6] = { [0] = 15, [1] = 112, [2] = 66 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 24, [1] = 28, [2] = 118 }, [4] = { [0] = 26, [1] = 30, [2] = 120 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 24, [1] = 28, [2] = 118 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 19, [1] = 116, [2] = 70 }, [6] = { [0] = 15, [1] = 112, [2] = 66 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 14, [1] = 18, [2] = 108 }, [1] = { [0] = 9, [1] = 13, [2] = 103 }, [2] = { [0] = 23, [1] = 27, [2] = 117 }, [3] = { [0] = 25, [1] = 29, [2] = 119 }, [4] = { [0] = 27, [1] = 31, [2] = 121 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 25, [1] = 29, [2] = 119 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[13]][R[11]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 10, [1] = 14, [2] = 104 }, [2] = { [0] = 24, [1] = 28, [2] = 118 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 28, [1] = 32, [2] = 122 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 26, [1] = 30, [2] = 120 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 14, [1] = 111, [2] = 65 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 11, [1] = 108, [2] = 62 } })[R[13]][R[11]], ({ [0] = { [0] = 16, [1] = 20, [2] = 110 }, [1] = { [0] = 11, [1] = 15, [2] = 105 }, [2] = { [0] = 25, [1] = 29, [2] = 119 }, [3] = { [0] = 22, [1] = 26, [2] = 116 }, [4] = { [0] = 29, [1] = 33, [2] = 123 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 14, [1] = 111, [2] = 65 }, [4] = { [0] = 17, [1] = 114, [2] = 68 }, [5] = { [0] = 21, [1] = 118, [2] = 72 }, [6] = { [0] = 17, [1] = 114, [2] = 68 }, [7] = { [0] = 11, [1] = 108, [2] = 62 } })[R[13]][R[11]], ({ [0] = { [0] = 17, [1] = 21, [2] = 111 }, [1] = { [0] = 12, [1] = 16, [2] = 106 }, [2] = { [0] = 26, [1] = 30, [2] = 120 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 15, [1] = 19, [2] = 109 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 17, [1] = 114, [2] = 68 }, [5] = { [0] = 21, [1] = 118, [2] = 72 }, [6] = { [0] = 17, [1] = 114, [2] = 68 }, [7] = { [0] = 12, [1] = 109, [2] = 63 } })[R[13]][R[11]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 16, [1] = 113, [2] = 67 }, [4] = { [0] = 17, [1] = 114, [2] = 68 }, [5] = { [0] = 22, [1] = 119, [2] = 73 }, [6] = { [0] = 18, [1] = 115, [2] = 69 }, [7] = { [0] = 12, [1] = 109, [2] = 63 } })[R[13]][R[11]], ({ [0] = { [0] = 22, [1] = 26, [2] = 116 }, [1] = { [0] = 17, [1] = 21, [2] = 111 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 15, [1] = 112, [2] = 66 }, [3] = { [0] = 17, [1] = 114, [2] = 68 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 22, [1] = 119, [2] = 73 }, [6] = { [0] = 18, [1] = 115, [2] = 69 }, [7] = { [0] = 13, [1] = 110, [2] = 64 } })[R[13]][R[11]], ({ [0] = { [0] = 23, [1] = 27, [2] = 117 }, [1] = { [0] = 18, [1] = 22, [2] = 112 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 15, [1] = 19, [2] = 109 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 15, [1] = 112, [2] = 66 }, [3] = { [0] = 17, [1] = 114, [2] = 68 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 23, [1] = 120, [2] = 74 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 13, [1] = 110, [2] = 64 } })[R[13]][R[11]], ({ [0] = { [0] = 24, [1] = 28, [2] = 118 }, [1] = { [0] = 19, [1] = 23, [2] = 113 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 16, [1] = 20, [2] = 110 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 117, [2] = 71 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 16, [1] = 113, [2] = 67 }, [3] = { [0] = 18, [1] = 115, [2] = 69 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 23, [1] = 120, [2] = 74 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 14, [1] = 111, [2] = 65 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 17, [1] = 21, [2] = 111 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 118, [2] = 72 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 16, [1] = 113, [2] = 67 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 24, [1] = 121, [2] = 75 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 14, [1] = 111, [2] = 65 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 21, [1] = 25, [2] = 115 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 15, [1] = 19, [2] = 109 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 18, [1] = 22, [2] = 112 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 17, [1] = 114, [2] = 68 }, [3] = { [0] = 20, [1] = 117, [2] = 71 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 25, [1] = 122, [2] = 76 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 22, [1] = 26, [2] = 116 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 16, [1] = 20, [2] = 110 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 19, [1] = 23, [2] = 113 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 120, [2] = 74 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 17, [1] = 114, [2] = 68 }, [3] = { [0] = 21, [1] = 118, [2] = 72 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 27, [1] = 31, [2] = 121 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 20, [1] = 24, [2] = 114 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[13]][R[11]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 121, [2] = 75 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 18, [1] = 115, [2] = 69 }, [3] = { [0] = 22, [1] = 119, [2] = 73 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[13]][R[11]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 28, [1] = 32, [2] = 122 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 17, [1] = 21, [2] = 111 } })[R[13]][R[11]] })
    if R[13] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] })
        for i = 1, game.initial_units() do
          R[32] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 120, [2] = 74 }, [1] = { [0] = 25, [1] = 122, [2] = 76 }, [2] = { [0] = 12, [1] = 109, [2] = 63 } })[R[32]][R[11]], ({ [0] = { [0] = 13, [1] = 17, [2] = 107 }, [1] = { [0] = 13, [1] = 17, [2] = 107 }, [2] = { [0] = 24, [1] = 28, [2] = 118 } })[R[32]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[13] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[11]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[11]] })
        for i = 1, game.initial_units() do
          R[33] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 111, [2] = 65 }, [1] = { [0] = 16, [1] = 113, [2] = 67 }, [2] = { [0] = 18, [1] = 115, [2] = 69 } })[R[33]][R[11]], ({ [0] = { [0] = 24, [1] = 28, [2] = 118 }, [1] = { [0] = 33, [1] = 37, [2] = 127 }, [2] = { [0] = 18, [1] = 22, [2] = 112 } })[R[33]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[13] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[34] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 9, [1] = 106, [2] = 60 }, [1] = { [0] = 19, [1] = 116, [2] = 70 }, [2] = { [0] = 14, [1] = 111, [2] = 65 } })[R[34]][R[11]], ({ [0] = { [0] = 16, [1] = 20, [2] = 110 }, [1] = { [0] = 16, [1] = 20, [2] = 110 }, [2] = { [0] = 32, [1] = 36, [2] = 126 } })[R[34]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[13] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[11]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[11]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[11]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[11]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        for i = 1, game.initial_units() do
          R[35] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 116, [2] = 70 }, [1] = { [0] = 21, [1] = 118, [2] = 72 }, [2] = { [0] = 8, [1] = 105, [2] = 59 } })[R[35]][R[11]], ({ [0] = { [0] = 22, [1] = 26, [2] = 116 }, [1] = { [0] = 29, [1] = 33, [2] = 123 }, [2] = { [0] = 26, [1] = 30, [2] = 120 } })[R[35]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[13] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 16, [1] = 20, [2] = 110 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[11]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[11]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[11]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[11]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[11]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 16, [1] = 20, [2] = 110 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[11]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[11]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[11]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[11]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[11]] })
        for i = 1, game.initial_units() do
          R[36] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 115, [2] = 69 }, [1] = { [0] = 11, [1] = 108, [2] = 62 }, [2] = { [0] = 7, [1] = 104, [2] = 58 } })[R[36]][R[11]], ({ [0] = { [0] = 14, [1] = 18, [2] = 108 }, [1] = { [0] = 14, [1] = 18, [2] = 108 }, [2] = { [0] = 23, [1] = 27, [2] = 117 } })[R[36]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[13] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
        for i = 1, game.initial_units() do
          R[37] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 27, [1] = 124, [2] = 78 }, [2] = { [0] = 5, [1] = 102, [2] = 56 } })[R[37]][R[11]], ({ [0] = { [0] = 31, [1] = 35, [2] = 125 }, [1] = { [0] = 31, [1] = 35, [2] = 125 }, [2] = { [0] = 18, [1] = 22, [2] = 112 } })[R[37]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[13] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 6, [1] = 103, [2] = 57 }, [1] = { [0] = 11, [1] = 108, [2] = 62 }, [2] = { [0] = 34, [1] = 131, [2] = 85 } })[R[38]][R[11]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 10, [1] = 14, [2] = 104 }, [2] = { [0] = 23, [1] = 27, [2] = 117 } })[R[38]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[13] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[11]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[11]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[11]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[11]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[11]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[11]] })
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 13, [1] = 110, [2] = 64 }, [1] = { [0] = 19, [1] = 116, [2] = 70 }, [2] = { [0] = 9, [1] = 106, [2] = 60 } })[R[39]][R[11]], ({ [0] = { [0] = 11, [1] = 15, [2] = 105 }, [1] = { [0] = 11, [1] = 15, [2] = 105 }, [2] = { [0] = 32, [1] = 36, [2] = 126 } })[R[39]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[13]", R[13])
    end
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { ({ [0] = 15, [1] = 106, [2] = 51 })[R[11]], ({ [0] = 5, [1] = 5, [2] = 101 })[R[11]] } }
    U[#U + 1] = game.create_unit{ type = "CommonOreMine", player = players[1], at = { ({ [0] = 15, [1] = 106, [2] = 51 })[R[11]], ({ [0] = 5, [1] = 5, [2] = 101 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    R[22] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 17, [1] = 21, [2] = 111 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 17, [1] = 21, [2] = 111 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[22]][R[12]] })
    U[#U + 1] = game.create_unit{ type = "TradeCenter", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 118, [2] = 72 }, [1] = { [0] = 16, [1] = 113, [2] = 67 }, [2] = { [0] = 12, [1] = 109, [2] = 63 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 18, [1] = 115, [2] = 69 }, [7] = { [0] = 12, [1] = 109, [2] = 63 } })[R[22]][R[12]], ({ [0] = { [0] = 17, [1] = 21, [2] = 111 }, [1] = { [0] = 18, [1] = 22, [2] = 112 }, [2] = { [0] = 20, [1] = 24, [2] = 114 }, [3] = { [0] = 23, [1] = 27, [2] = 117 }, [4] = { [0] = 21, [1] = 25, [2] = 115 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 17, [1] = 21, [2] = 111 }, [7] = { [0] = 21, [1] = 25, [2] = 115 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 8, [1] = 105, [2] = 59 }, [3] = { [0] = 27, [1] = 124, [2] = 78 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 7, [1] = 11, [2] = 101 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 30, [1] = 34, [2] = 124 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    if R[22] == 0 or R[22] == 1 or R[22] == 2 or R[22] == 5 or R[22] == 6 or R[22] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 126, [2] = 80 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 11, [1] = 108, [2] = 62 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 21, [1] = 118, [2] = 72 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 14, [1] = 18, [2] = 108 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [5] = { [0] = 27, [1] = 31, [2] = 121 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      if R[22] == 0 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 6, [1] = 103, [2] = 57 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 6, [1] = 103, [2] = 57 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 6, [1] = 103, [2] = 57 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[22] == 1 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[22] == 2 then
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
      elseif R[22] == 5 then
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
      elseif R[22] == 6 then
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
      elseif R[22] == 7 then
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
        unseen("R[22]", R[22])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 20, [1] = 117, [2] = 71 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 29, [1] = 126, [2] = 80 }, [7] = { [0] = 23, [1] = 120, [2] = 74 } })[R[22]][R[12]], ({ [0] = { [0] = 26, [1] = 30, [2] = 120 }, [1] = { [0] = 32, [1] = 36, [2] = 126 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      if R[22] == 0 or R[22] == 1 then
      elseif R[22] == 2 or R[22] == 5 or R[22] == 6 or R[22] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [2] = { [0] = 20, [1] = 117, [2] = 71 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 12, [1] = 109, [2] = 63 }, [7] = { [0] = 24, [1] = 121, [2] = 75 } })[R[22]][R[12]], ({ [2] = { [0] = 28, [1] = 32, [2] = 122 }, [5] = { [0] = 15, [1] = 19, [2] = 109 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 27, [1] = 31, [2] = 121 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[22]", R[22])
      end
    elseif R[22] == 3 or R[22] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 } })[R[22]][R[12]], ({ [3] = { [0] = 30, [1] = 34, [2] = 124 }, [4] = { [0] = 15, [1] = 19, [2] = 109 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      if R[22] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[22] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 111, [2] = 65 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[22]", R[22])
      end
    else
      unseen("R[22]", R[22])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 13, [1] = 110, [2] = 64 }, [2] = { [0] = 28, [1] = 125, [2] = 79 }, [3] = { [0] = 20, [1] = 117, [2] = 71 }, [4] = { [0] = 6, [1] = 103, [2] = 57 }, [5] = { [0] = 6, [1] = 103, [2] = 57 }, [6] = { [0] = 4, [1] = 101, [2] = 55 }, [7] = { [0] = 16, [1] = 113, [2] = 67 } })[R[22]][R[12]], ({ [0] = { [0] = 26, [1] = 30, [2] = 120 }, [1] = { [0] = 29, [1] = 33, [2] = 123 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 13, [1] = 17, [2] = 107 }, [4] = { [0] = 19, [1] = 23, [2] = 113 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 31, [1] = 35, [2] = 125 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 13, [1] = 110, [2] = 64 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 9, [1] = 106, [2] = 60 }, [4] = { [0] = 24, [1] = 121, [2] = 75 }, [5] = { [0] = 24, [1] = 121, [2] = 75 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 26, [1] = 123, [2] = 77 } })[R[22]][R[12]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 26, [1] = 30, [2] = 120 }, [3] = { [0] = 20, [1] = 24, [2] = 114 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 13, [1] = 17, [2] = 107 }, [6] = { [0] = 27, [1] = 31, [2] = 121 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 11, [1] = 108, [2] = 62 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 12, [1] = 109, [2] = 63 }, [4] = { [0] = 26, [1] = 123, [2] = 77 }, [5] = { [0] = 24, [1] = 121, [2] = 75 }, [6] = { [0] = 9, [1] = 106, [2] = 60 }, [7] = { [0] = 26, [1] = 123, [2] = 77 } })[R[22]][R[12]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 13, [1] = 17, [2] = 107 }, [2] = { [0] = 24, [1] = 28, [2] = 118 }, [3] = { [0] = 16, [1] = 20, [2] = 110 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 15, [1] = 19, [2] = 109 }, [6] = { [0] = 27, [1] = 31, [2] = 121 }, [7] = { [0] = 24, [1] = 28, [2] = 118 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[22]], player = players[2], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 6, [1] = 103, [2] = 57 }, [3] = { [0] = 29, [1] = 126, [2] = 80 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 25, [1] = 122, [2] = 76 } })[R[22]][R[12]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 20, [1] = 24, [2] = 114 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[22]], player = players[2], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 6, [1] = 103, [2] = 57 }, [3] = { [0] = 27, [1] = 124, [2] = 78 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 25, [1] = 122, [2] = 76 } })[R[22]][R[12]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 16, [1] = 20, [2] = 110 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 6, [1] = 103, [2] = 57 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 25, [1] = 122, [2] = 76 } })[R[22]][R[12]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[22]], player = players[2], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 11, [1] = 108, [2] = 62 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 10, [1] = 107, [2] = 61 } })[R[22]][R[12]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 9, [1] = 13, [2] = 103 }, [2] = { [0] = 30, [1] = 34, [2] = 124 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 27, [1] = 31, [2] = 121 }, [5] = { [0] = 12, [1] = 16, [2] = 106 }, [6] = { [0] = 24, [1] = 28, [2] = 118 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[22]], player = players[2], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 18, [1] = 115, [2] = 69 }, [2] = { [0] = 20, [1] = 117, [2] = 71 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 21, [1] = 118, [2] = 72 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 25, [1] = 122, [2] = 76 }, [7] = { [0] = 5, [1] = 102, [2] = 56 } })[R[22]][R[12]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 6, [1] = 10, [2] = 100 }, [2] = { [0] = 31, [1] = 35, [2] = 125 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 18, [1] = 22, [2] = 112 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 21, [1] = 25, [2] = 115 }, [7] = { [0] = 19, [1] = 23, [2] = 113 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[22]], player = players[2], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 11, [1] = 108, [2] = 62 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 10, [1] = 107, [2] = 61 } })[R[22]][R[12]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 9, [1] = 13, [2] = 103 }, [2] = { [0] = 30, [1] = 34, [2] = 124 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 27, [1] = 31, [2] = 121 }, [5] = { [0] = 12, [1] = 16, [2] = 106 }, [6] = { [0] = 24, [1] = 28, [2] = 118 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[22]], player = players[2], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 18, [1] = 115, [2] = 69 }, [2] = { [0] = 20, [1] = 117, [2] = 71 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 21, [1] = 118, [2] = 72 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 25, [1] = 122, [2] = 76 }, [7] = { [0] = 5, [1] = 102, [2] = 56 } })[R[22]][R[12]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 6, [1] = 10, [2] = 100 }, [2] = { [0] = 31, [1] = 35, [2] = 125 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 18, [1] = 22, [2] = 112 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 21, [1] = 25, [2] = 115 }, [7] = { [0] = 19, [1] = 23, [2] = 113 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 126, [2] = 80 }, [1] = { [0] = 21, [1] = 118, [2] = 72 }, [2] = { [0] = 16, [1] = 113, [2] = 67 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 27, [1] = 124, [2] = 78 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 25, [1] = 122, [2] = 76 }, [7] = { [0] = 19, [1] = 116, [2] = 70 } })[R[22]][R[12]], ({ [0] = { [0] = 23, [1] = 27, [2] = 117 }, [1] = { [0] = 19, [1] = 23, [2] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 118 }, [3] = { [0] = 17, [1] = 21, [2] = 111 }, [4] = { [0] = 14, [1] = 18, [2] = 108 }, [5] = { [0] = 29, [1] = 33, [2] = 123 }, [6] = { [0] = 24, [1] = 28, [2] = 118 }, [7] = { [0] = 21, [1] = 25, [2] = 115 } })[R[22]][R[12]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 9, [1] = 106, [2] = 60 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 11, [1] = 108, [2] = 62 }, [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 17, [1] = 21, [2] = 111 }, [5] = { [0] = 18, [1] = 22, [2] = 112 }, [6] = { [0] = 16, [1] = 20, [2] = 110 }, [7] = { [0] = 18, [1] = 22, [2] = 112 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 10, [1] = 107, [2] = 61 }, [1] = { [0] = 16, [1] = 113, [2] = 67 }, [2] = { [0] = 12, [1] = 109, [2] = 63 }, [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 27, [1] = 31, [2] = 121 }, [4] = { [0] = 18, [1] = 22, [2] = 112 }, [5] = { [0] = 19, [1] = 23, [2] = 113 }, [6] = { [0] = 17, [1] = 21, [2] = 111 }, [7] = { [0] = 19, [1] = 23, [2] = 113 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 11, [1] = 108, [2] = 62 }, [1] = { [0] = 17, [1] = 114, [2] = 68 }, [2] = { [0] = 13, [1] = 110, [2] = 64 }, [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 28, [1] = 32, [2] = 122 }, [4] = { [0] = 19, [1] = 23, [2] = 113 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 18, [1] = 22, [2] = 112 }, [7] = { [0] = 20, [1] = 24, [2] = 114 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 12, [1] = 109, [2] = 63 }, [1] = { [0] = 18, [1] = 115, [2] = 69 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 12, [1] = 109, [2] = 63 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 19, [1] = 23, [2] = 113 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 20, [1] = 24, [2] = 114 }, [5] = { [0] = 24, [1] = 28, [2] = 118 }, [6] = { [0] = 19, [1] = 23, [2] = 113 }, [7] = { [0] = 21, [1] = 25, [2] = 115 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 13, [1] = 110, [2] = 64 }, [1] = { [0] = 19, [1] = 116, [2] = 70 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 20, [1] = 24, [2] = 114 }, [3] = { [0] = 22, [1] = 26, [2] = 116 }, [4] = { [0] = 21, [1] = 25, [2] = 115 }, [5] = { [0] = 25, [1] = 29, [2] = 119 }, [6] = { [0] = 20, [1] = 24, [2] = 114 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 14, [1] = 111, [2] = 65 }, [1] = { [0] = 20, [1] = 117, [2] = 71 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 14, [1] = 111, [2] = 65 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 21, [1] = 25, [2] = 115 }, [3] = { [0] = 23, [1] = 27, [2] = 117 }, [4] = { [0] = 25, [1] = 29, [2] = 119 }, [5] = { [0] = 26, [1] = 30, [2] = 120 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 23, [1] = 27, [2] = 117 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 15, [1] = 112, [2] = 66 }, [1] = { [0] = 21, [1] = 118, [2] = 72 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 19, [1] = 116, [2] = 70 }, [6] = { [0] = 15, [1] = 112, [2] = 66 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 24, [1] = 28, [2] = 118 }, [4] = { [0] = 26, [1] = 30, [2] = 120 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 24, [1] = 28, [2] = 118 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 19, [1] = 116, [2] = 70 }, [6] = { [0] = 15, [1] = 112, [2] = 66 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 14, [1] = 18, [2] = 108 }, [1] = { [0] = 9, [1] = 13, [2] = 103 }, [2] = { [0] = 23, [1] = 27, [2] = 117 }, [3] = { [0] = 25, [1] = 29, [2] = 119 }, [4] = { [0] = 27, [1] = 31, [2] = 121 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 25, [1] = 29, [2] = 119 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[22]][R[12]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 10, [1] = 14, [2] = 104 }, [2] = { [0] = 24, [1] = 28, [2] = 118 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 28, [1] = 32, [2] = 122 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 26, [1] = 30, [2] = 120 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 14, [1] = 111, [2] = 65 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 11, [1] = 108, [2] = 62 } })[R[22]][R[12]], ({ [0] = { [0] = 16, [1] = 20, [2] = 110 }, [1] = { [0] = 11, [1] = 15, [2] = 105 }, [2] = { [0] = 25, [1] = 29, [2] = 119 }, [3] = { [0] = 22, [1] = 26, [2] = 116 }, [4] = { [0] = 29, [1] = 33, [2] = 123 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 14, [1] = 111, [2] = 65 }, [4] = { [0] = 17, [1] = 114, [2] = 68 }, [5] = { [0] = 21, [1] = 118, [2] = 72 }, [6] = { [0] = 17, [1] = 114, [2] = 68 }, [7] = { [0] = 11, [1] = 108, [2] = 62 } })[R[22]][R[12]], ({ [0] = { [0] = 17, [1] = 21, [2] = 111 }, [1] = { [0] = 12, [1] = 16, [2] = 106 }, [2] = { [0] = 26, [1] = 30, [2] = 120 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 15, [1] = 19, [2] = 109 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 17, [1] = 114, [2] = 68 }, [5] = { [0] = 21, [1] = 118, [2] = 72 }, [6] = { [0] = 17, [1] = 114, [2] = 68 }, [7] = { [0] = 12, [1] = 109, [2] = 63 } })[R[22]][R[12]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 16, [1] = 113, [2] = 67 }, [4] = { [0] = 17, [1] = 114, [2] = 68 }, [5] = { [0] = 22, [1] = 119, [2] = 73 }, [6] = { [0] = 18, [1] = 115, [2] = 69 }, [7] = { [0] = 12, [1] = 109, [2] = 63 } })[R[22]][R[12]], ({ [0] = { [0] = 22, [1] = 26, [2] = 116 }, [1] = { [0] = 17, [1] = 21, [2] = 111 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 15, [1] = 112, [2] = 66 }, [3] = { [0] = 17, [1] = 114, [2] = 68 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 22, [1] = 119, [2] = 73 }, [6] = { [0] = 18, [1] = 115, [2] = 69 }, [7] = { [0] = 13, [1] = 110, [2] = 64 } })[R[22]][R[12]], ({ [0] = { [0] = 23, [1] = 27, [2] = 117 }, [1] = { [0] = 18, [1] = 22, [2] = 112 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 15, [1] = 19, [2] = 109 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 15, [1] = 112, [2] = 66 }, [3] = { [0] = 17, [1] = 114, [2] = 68 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 23, [1] = 120, [2] = 74 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 13, [1] = 110, [2] = 64 } })[R[22]][R[12]], ({ [0] = { [0] = 24, [1] = 28, [2] = 118 }, [1] = { [0] = 19, [1] = 23, [2] = 113 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 16, [1] = 20, [2] = 110 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 117, [2] = 71 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 16, [1] = 113, [2] = 67 }, [3] = { [0] = 18, [1] = 115, [2] = 69 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 23, [1] = 120, [2] = 74 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 14, [1] = 111, [2] = 65 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 17, [1] = 21, [2] = 111 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 118, [2] = 72 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 16, [1] = 113, [2] = 67 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 24, [1] = 121, [2] = 75 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 14, [1] = 111, [2] = 65 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 21, [1] = 25, [2] = 115 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 15, [1] = 19, [2] = 109 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 18, [1] = 22, [2] = 112 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 17, [1] = 114, [2] = 68 }, [3] = { [0] = 20, [1] = 117, [2] = 71 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 25, [1] = 122, [2] = 76 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 22, [1] = 26, [2] = 116 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 16, [1] = 20, [2] = 110 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 19, [1] = 23, [2] = 113 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 120, [2] = 74 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 17, [1] = 114, [2] = 68 }, [3] = { [0] = 21, [1] = 118, [2] = 72 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 27, [1] = 31, [2] = 121 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 20, [1] = 24, [2] = 114 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[22]][R[12]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 121, [2] = 75 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 18, [1] = 115, [2] = 69 }, [3] = { [0] = 22, [1] = 119, [2] = 73 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[22]][R[12]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 28, [1] = 32, [2] = 122 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 17, [1] = 21, [2] = 111 } })[R[22]][R[12]] })
    if R[22] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] })
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 120, [2] = 74 }, [1] = { [0] = 25, [1] = 122, [2] = 76 }, [2] = { [0] = 12, [1] = 109, [2] = 63 } })[R[40]][R[12]], ({ [0] = { [0] = 13, [1] = 17, [2] = 107 }, [1] = { [0] = 13, [1] = 17, [2] = 107 }, [2] = { [0] = 24, [1] = 28, [2] = 118 } })[R[40]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[22] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[12]] })
        for i = 1, game.initial_units() do
          R[41] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 111, [2] = 65 }, [1] = { [0] = 16, [1] = 113, [2] = 67 }, [2] = { [0] = 18, [1] = 115, [2] = 69 } })[R[41]][R[12]], ({ [0] = { [0] = 24, [1] = 28, [2] = 118 }, [1] = { [0] = 33, [1] = 37, [2] = 127 }, [2] = { [0] = 18, [1] = 22, [2] = 112 } })[R[41]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[22] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 9, [1] = 106, [2] = 60 }, [1] = { [0] = 19, [1] = 116, [2] = 70 }, [2] = { [0] = 14, [1] = 111, [2] = 65 } })[R[42]][R[12]], ({ [0] = { [0] = 16, [1] = 20, [2] = 110 }, [1] = { [0] = 16, [1] = 20, [2] = 110 }, [2] = { [0] = 32, [1] = 36, [2] = 126 } })[R[42]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[22] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[12]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[12]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        for i = 1, game.initial_units() do
          R[43] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 116, [2] = 70 }, [1] = { [0] = 21, [1] = 118, [2] = 72 }, [2] = { [0] = 8, [1] = 105, [2] = 59 } })[R[43]][R[12]], ({ [0] = { [0] = 22, [1] = 26, [2] = 116 }, [1] = { [0] = 29, [1] = 33, [2] = 123 }, [2] = { [0] = 26, [1] = 30, [2] = 120 } })[R[43]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[12]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[12]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[22] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 16, [1] = 20, [2] = 110 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[12]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[12]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[12]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[12]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 16, [1] = 20, [2] = 110 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[12]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[12]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[12]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[12]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[12]] })
        for i = 1, game.initial_units() do
          R[44] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 115, [2] = 69 }, [1] = { [0] = 11, [1] = 108, [2] = 62 }, [2] = { [0] = 7, [1] = 104, [2] = 58 } })[R[44]][R[12]], ({ [0] = { [0] = 14, [1] = 18, [2] = 108 }, [1] = { [0] = 14, [1] = 18, [2] = 108 }, [2] = { [0] = 23, [1] = 27, [2] = 117 } })[R[44]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[22] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
        for i = 1, game.initial_units() do
          R[45] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 27, [1] = 124, [2] = 78 }, [2] = { [0] = 5, [1] = 102, [2] = 56 } })[R[45]][R[12]], ({ [0] = { [0] = 31, [1] = 35, [2] = 125 }, [1] = { [0] = 31, [1] = 35, [2] = 125 }, [2] = { [0] = 18, [1] = 22, [2] = 112 } })[R[45]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[22] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        for i = 1, game.initial_units() do
          R[46] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 6, [1] = 103, [2] = 57 }, [1] = { [0] = 11, [1] = 108, [2] = 62 }, [2] = { [0] = 34, [1] = 131, [2] = 85 } })[R[46]][R[12]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 10, [1] = 14, [2] = 104 }, [2] = { [0] = 23, [1] = 27, [2] = 117 } })[R[46]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[22] == 7 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
        for i = 1, game.initial_units() do
          R[47] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 13, [1] = 110, [2] = 64 }, [1] = { [0] = 19, [1] = 116, [2] = 70 }, [2] = { [0] = 9, [1] = 106, [2] = 60 } })[R[47]][R[12]], ({ [0] = { [0] = 11, [1] = 15, [2] = 105 }, [1] = { [0] = 11, [1] = 15, [2] = 105 }, [2] = { [0] = 32, [1] = 36, [2] = 126 } })[R[47]][R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[12]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[12]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[12]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[12]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[12]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[12]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[22]", R[22])
    end
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { ({ [0] = 15, [1] = 106, [2] = 51 })[R[12]], ({ [0] = 5, [1] = 5, [2] = 101 })[R[12]] } }
    U[#U + 1] = game.create_unit{ type = "CommonOreMine", player = players[2], at = { ({ [0] = 15, [1] = 106, [2] = 51 })[R[12]], ({ [0] = 5, [1] = 5, [2] = 101 })[R[12]] }, direction = "East", lights = false, exact = true }[1]
    R[48] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[48]][R[31]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 17, [1] = 21, [2] = 111 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[48]][R[31]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 17, [1] = 21, [2] = 111 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[48]][R[31]] })
    U[#U + 1] = game.create_unit{ type = "TradeCenter", player = players[3], at = { ({ [0] = { [0] = 21, [1] = 118, [2] = 72 }, [1] = { [0] = 16, [1] = 113, [2] = 67 }, [2] = { [0] = 12, [1] = 109, [2] = 63 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 18, [1] = 115, [2] = 69 }, [7] = { [0] = 12, [1] = 109, [2] = 63 } })[R[48]][R[31]], ({ [0] = { [0] = 17, [1] = 21, [2] = 111 }, [1] = { [0] = 18, [1] = 22, [2] = 112 }, [2] = { [0] = 20, [1] = 24, [2] = 114 }, [3] = { [0] = 23, [1] = 27, [2] = 117 }, [4] = { [0] = 21, [1] = 25, [2] = 115 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 17, [1] = 21, [2] = 111 }, [7] = { [0] = 21, [1] = 25, [2] = 115 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 8, [1] = 105, [2] = 59 }, [3] = { [0] = 27, [1] = 124, [2] = 78 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[48]][R[31]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 7, [1] = 11, [2] = 101 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 30, [1] = 34, [2] = 124 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
    if R[48] == 0 or R[48] == 1 or R[48] == 2 or R[48] == 5 or R[48] == 6 or R[48] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 126, [2] = 80 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 11, [1] = 108, [2] = 62 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 21, [1] = 118, [2] = 72 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[48]][R[31]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 14, [1] = 18, [2] = 108 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [5] = { [0] = 27, [1] = 31, [2] = 121 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
      if R[48] == 0 then
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
      elseif R[48] == 1 then
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
      elseif R[48] == 2 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 117, [2] = 71 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 117, [2] = 71 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 117, [2] = 71 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[48] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[48] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 29, [1] = 126, [2] = 80 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 29, [1] = 126, [2] = 80 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 29, [1] = 126, [2] = 80 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[48] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[48]", R[48])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = { [0] = 6, [1] = 103, [2] = 57 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 20, [1] = 117, [2] = 71 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 12, [1] = 109, [2] = 63 }, [7] = { [0] = 24, [1] = 121, [2] = 75 } })[R[48]][R[31]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 24, [1] = 28, [2] = 118 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [5] = { [0] = 15, [1] = 19, [2] = 109 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 27, [1] = 31, [2] = 121 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
      if R[48] == 2 or R[48] == 5 or R[48] == 6 or R[48] == 7 then
      elseif R[48] == 0 or R[48] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 } })[R[48]][R[31]], ({ [0] = { [0] = 26, [1] = 30, [2] = 120 }, [1] = { [0] = 32, [1] = 36, [2] = 126 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[48]", R[48])
      end
    elseif R[48] == 3 or R[48] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 } })[R[48]][R[31]], ({ [3] = { [0] = 30, [1] = 34, [2] = 124 }, [4] = { [0] = 15, [1] = 19, [2] = 109 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
      if R[48] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 14, [1] = 111, [2] = 65 })[R[31]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[48] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[48]", R[48])
      end
    else
      unseen("R[48]", R[48])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 13, [1] = 110, [2] = 64 }, [2] = { [0] = 28, [1] = 125, [2] = 79 }, [3] = { [0] = 20, [1] = 117, [2] = 71 }, [4] = { [0] = 6, [1] = 103, [2] = 57 }, [5] = { [0] = 6, [1] = 103, [2] = 57 }, [6] = { [0] = 4, [1] = 101, [2] = 55 }, [7] = { [0] = 16, [1] = 113, [2] = 67 } })[R[48]][R[31]], ({ [0] = { [0] = 26, [1] = 30, [2] = 120 }, [1] = { [0] = 29, [1] = 33, [2] = 123 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 13, [1] = 17, [2] = 107 }, [4] = { [0] = 19, [1] = 23, [2] = 113 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 31, [1] = 35, [2] = 125 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 13, [1] = 110, [2] = 64 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 9, [1] = 106, [2] = 60 }, [4] = { [0] = 24, [1] = 121, [2] = 75 }, [5] = { [0] = 24, [1] = 121, [2] = 75 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 26, [1] = 123, [2] = 77 } })[R[48]][R[31]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 26, [1] = 30, [2] = 120 }, [3] = { [0] = 20, [1] = 24, [2] = 114 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 13, [1] = 17, [2] = 107 }, [6] = { [0] = 27, [1] = 31, [2] = 121 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 11, [1] = 108, [2] = 62 }, [1] = { [0] = 12, [1] = 109, [2] = 63 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 12, [1] = 109, [2] = 63 }, [4] = { [0] = 26, [1] = 123, [2] = 77 }, [5] = { [0] = 24, [1] = 121, [2] = 75 }, [6] = { [0] = 9, [1] = 106, [2] = 60 }, [7] = { [0] = 26, [1] = 123, [2] = 77 } })[R[48]][R[31]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 13, [1] = 17, [2] = 107 }, [2] = { [0] = 24, [1] = 28, [2] = 118 }, [3] = { [0] = 16, [1] = 20, [2] = 110 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 15, [1] = 19, [2] = 109 }, [6] = { [0] = 27, [1] = 31, [2] = 121 }, [7] = { [0] = 24, [1] = 28, [2] = 118 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[48]], player = players[3], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 6, [1] = 103, [2] = 57 }, [3] = { [0] = 29, [1] = 126, [2] = 80 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 25, [1] = 122, [2] = 76 } })[R[48]][R[31]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 20, [1] = 24, [2] = 114 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[48]], player = players[3], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 6, [1] = 103, [2] = 57 }, [3] = { [0] = 27, [1] = 124, [2] = 78 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 25, [1] = 122, [2] = 76 } })[R[48]][R[31]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 16, [1] = 20, [2] = 110 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 6, [1] = 103, [2] = 57 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 25, [1] = 122, [2] = 76 } })[R[48]][R[31]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 15, [1] = 19, [2] = 109 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[48]], player = players[3], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 11, [1] = 108, [2] = 62 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 10, [1] = 107, [2] = 61 } })[R[48]][R[31]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 9, [1] = 13, [2] = 103 }, [2] = { [0] = 30, [1] = 34, [2] = 124 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 27, [1] = 31, [2] = 121 }, [5] = { [0] = 12, [1] = 16, [2] = 106 }, [6] = { [0] = 24, [1] = 28, [2] = 118 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[48]], player = players[3], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 18, [1] = 115, [2] = 69 }, [2] = { [0] = 20, [1] = 117, [2] = 71 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 21, [1] = 118, [2] = 72 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 25, [1] = 122, [2] = 76 }, [7] = { [0] = 5, [1] = 102, [2] = 56 } })[R[48]][R[31]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 6, [1] = 10, [2] = 100 }, [2] = { [0] = 31, [1] = 35, [2] = 125 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 18, [1] = 22, [2] = 112 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 21, [1] = 25, [2] = 115 }, [7] = { [0] = 19, [1] = 23, [2] = 113 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[48]], player = players[3], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 24, [1] = 121, [2] = 75 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 11, [1] = 108, [2] = 62 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 10, [1] = 107, [2] = 61 } })[R[48]][R[31]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 9, [1] = 13, [2] = 103 }, [2] = { [0] = 30, [1] = 34, [2] = 124 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 27, [1] = 31, [2] = 121 }, [5] = { [0] = 12, [1] = 16, [2] = 106 }, [6] = { [0] = 24, [1] = 28, [2] = 118 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[48]], player = players[3], at = { ({ [0] = { [0] = 8, [1] = 105, [2] = 59 }, [1] = { [0] = 18, [1] = 115, [2] = 69 }, [2] = { [0] = 20, [1] = 117, [2] = 71 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 21, [1] = 118, [2] = 72 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 25, [1] = 122, [2] = 76 }, [7] = { [0] = 5, [1] = 102, [2] = 56 } })[R[48]][R[31]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 6, [1] = 10, [2] = 100 }, [2] = { [0] = 31, [1] = 35, [2] = 125 }, [3] = { [0] = 31, [1] = 35, [2] = 125 }, [4] = { [0] = 18, [1] = 22, [2] = 112 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 21, [1] = 25, [2] = 115 }, [7] = { [0] = 19, [1] = 23, [2] = 113 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 126, [2] = 80 }, [1] = { [0] = 21, [1] = 118, [2] = 72 }, [2] = { [0] = 16, [1] = 113, [2] = 67 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 27, [1] = 124, [2] = 78 }, [5] = { [0] = 12, [1] = 109, [2] = 63 }, [6] = { [0] = 25, [1] = 122, [2] = 76 }, [7] = { [0] = 19, [1] = 116, [2] = 70 } })[R[48]][R[31]], ({ [0] = { [0] = 23, [1] = 27, [2] = 117 }, [1] = { [0] = 19, [1] = 23, [2] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 118 }, [3] = { [0] = 17, [1] = 21, [2] = 111 }, [4] = { [0] = 14, [1] = 18, [2] = 108 }, [5] = { [0] = 29, [1] = 33, [2] = 123 }, [6] = { [0] = 24, [1] = 28, [2] = 118 }, [7] = { [0] = 21, [1] = 25, [2] = 115 } })[R[48]][R[31]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 9, [1] = 106, [2] = 60 }, [1] = { [0] = 15, [1] = 112, [2] = 66 }, [2] = { [0] = 11, [1] = 108, [2] = 62 }, [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[48]][R[31]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 17, [1] = 21, [2] = 111 }, [5] = { [0] = 18, [1] = 22, [2] = 112 }, [6] = { [0] = 16, [1] = 20, [2] = 110 }, [7] = { [0] = 18, [1] = 22, [2] = 112 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 10, [1] = 107, [2] = 61 }, [1] = { [0] = 16, [1] = 113, [2] = 67 }, [2] = { [0] = 12, [1] = 109, [2] = 63 }, [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[48]][R[31]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 27, [1] = 31, [2] = 121 }, [4] = { [0] = 18, [1] = 22, [2] = 112 }, [5] = { [0] = 19, [1] = 23, [2] = 113 }, [6] = { [0] = 17, [1] = 21, [2] = 111 }, [7] = { [0] = 19, [1] = 23, [2] = 113 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 11, [1] = 108, [2] = 62 }, [1] = { [0] = 17, [1] = 114, [2] = 68 }, [2] = { [0] = 13, [1] = 110, [2] = 64 }, [3] = { [0] = 11, [1] = 108, [2] = 62 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[48]][R[31]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 28, [1] = 32, [2] = 122 }, [4] = { [0] = 19, [1] = 23, [2] = 113 }, [5] = { [0] = 20, [1] = 24, [2] = 114 }, [6] = { [0] = 18, [1] = 22, [2] = 112 }, [7] = { [0] = 20, [1] = 24, [2] = 114 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 12, [1] = 109, [2] = 63 }, [1] = { [0] = 18, [1] = 115, [2] = 69 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 12, [1] = 109, [2] = 63 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[48]][R[31]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 19, [1] = 23, [2] = 113 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 20, [1] = 24, [2] = 114 }, [5] = { [0] = 24, [1] = 28, [2] = 118 }, [6] = { [0] = 19, [1] = 23, [2] = 113 }, [7] = { [0] = 21, [1] = 25, [2] = 115 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 13, [1] = 110, [2] = 64 }, [1] = { [0] = 19, [1] = 116, [2] = 70 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 11, [1] = 108, [2] = 62 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[48]][R[31]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 20, [1] = 24, [2] = 114 }, [3] = { [0] = 22, [1] = 26, [2] = 116 }, [4] = { [0] = 21, [1] = 25, [2] = 115 }, [5] = { [0] = 25, [1] = 29, [2] = 119 }, [6] = { [0] = 20, [1] = 24, [2] = 114 }, [7] = { [0] = 22, [1] = 26, [2] = 116 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 14, [1] = 111, [2] = 65 }, [1] = { [0] = 20, [1] = 117, [2] = 71 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 16, [1] = 113, [2] = 67 }, [6] = { [0] = 14, [1] = 111, [2] = 65 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[48]][R[31]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 21, [1] = 25, [2] = 115 }, [3] = { [0] = 23, [1] = 27, [2] = 117 }, [4] = { [0] = 25, [1] = 29, [2] = 119 }, [5] = { [0] = 26, [1] = 30, [2] = 120 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 23, [1] = 27, [2] = 117 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 15, [1] = 112, [2] = 66 }, [1] = { [0] = 21, [1] = 118, [2] = 72 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 19, [1] = 116, [2] = 70 }, [6] = { [0] = 15, [1] = 112, [2] = 66 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[48]][R[31]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 24, [1] = 28, [2] = 118 }, [4] = { [0] = 26, [1] = 30, [2] = 120 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 24, [1] = 28, [2] = 118 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 19, [1] = 116, [2] = 70 }, [6] = { [0] = 15, [1] = 112, [2] = 66 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[48]][R[31]], ({ [0] = { [0] = 14, [1] = 18, [2] = 108 }, [1] = { [0] = 9, [1] = 13, [2] = 103 }, [2] = { [0] = 23, [1] = 27, [2] = 117 }, [3] = { [0] = 25, [1] = 29, [2] = 119 }, [4] = { [0] = 27, [1] = 31, [2] = 121 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 25, [1] = 29, [2] = 119 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 13, [1] = 110, [2] = 64 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 8, [1] = 105, [2] = 59 } })[R[48]][R[31]], ({ [0] = { [0] = 15, [1] = 19, [2] = 109 }, [1] = { [0] = 10, [1] = 14, [2] = 104 }, [2] = { [0] = 24, [1] = 28, [2] = 118 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 28, [1] = 32, [2] = 122 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 26, [1] = 30, [2] = 120 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 14, [1] = 111, [2] = 65 }, [4] = { [0] = 14, [1] = 111, [2] = 65 }, [5] = { [0] = 20, [1] = 117, [2] = 71 }, [6] = { [0] = 16, [1] = 113, [2] = 67 }, [7] = { [0] = 11, [1] = 108, [2] = 62 } })[R[48]][R[31]], ({ [0] = { [0] = 16, [1] = 20, [2] = 110 }, [1] = { [0] = 11, [1] = 15, [2] = 105 }, [2] = { [0] = 25, [1] = 29, [2] = 119 }, [3] = { [0] = 22, [1] = 26, [2] = 116 }, [4] = { [0] = 29, [1] = 33, [2] = 123 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 14, [1] = 111, [2] = 65 }, [4] = { [0] = 17, [1] = 114, [2] = 68 }, [5] = { [0] = 21, [1] = 118, [2] = 72 }, [6] = { [0] = 17, [1] = 114, [2] = 68 }, [7] = { [0] = 11, [1] = 108, [2] = 62 } })[R[48]][R[31]], ({ [0] = { [0] = 17, [1] = 21, [2] = 111 }, [1] = { [0] = 12, [1] = 16, [2] = 106 }, [2] = { [0] = 26, [1] = 30, [2] = 120 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 15, [1] = 19, [2] = 109 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 22, [1] = 119, [2] = 73 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 15, [1] = 112, [2] = 66 }, [4] = { [0] = 17, [1] = 114, [2] = 68 }, [5] = { [0] = 21, [1] = 118, [2] = 72 }, [6] = { [0] = 17, [1] = 114, [2] = 68 }, [7] = { [0] = 12, [1] = 109, [2] = 63 } })[R[48]][R[31]], ({ [0] = { [0] = 21, [1] = 25, [2] = 115 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 27, [1] = 31, [2] = 121 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 14, [1] = 111, [2] = 65 }, [3] = { [0] = 16, [1] = 113, [2] = 67 }, [4] = { [0] = 17, [1] = 114, [2] = 68 }, [5] = { [0] = 22, [1] = 119, [2] = 73 }, [6] = { [0] = 18, [1] = 115, [2] = 69 }, [7] = { [0] = 12, [1] = 109, [2] = 63 } })[R[48]][R[31]], ({ [0] = { [0] = 22, [1] = 26, [2] = 116 }, [1] = { [0] = 17, [1] = 21, [2] = 111 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 14, [1] = 18, [2] = 108 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 15, [1] = 112, [2] = 66 }, [3] = { [0] = 17, [1] = 114, [2] = 68 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 22, [1] = 119, [2] = 73 }, [6] = { [0] = 18, [1] = 115, [2] = 69 }, [7] = { [0] = 13, [1] = 110, [2] = 64 } })[R[48]][R[31]], ({ [0] = { [0] = 23, [1] = 27, [2] = 117 }, [1] = { [0] = 18, [1] = 22, [2] = 112 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 15, [1] = 19, [2] = 109 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 114, [2] = 68 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 15, [1] = 112, [2] = 66 }, [3] = { [0] = 17, [1] = 114, [2] = 68 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 23, [1] = 120, [2] = 74 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 13, [1] = 110, [2] = 64 } })[R[48]][R[31]], ({ [0] = { [0] = 24, [1] = 28, [2] = 118 }, [1] = { [0] = 19, [1] = 23, [2] = 113 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 26, [1] = 30, [2] = 120 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 16, [1] = 20, [2] = 110 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 117, [2] = 71 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 16, [1] = 113, [2] = 67 }, [3] = { [0] = 18, [1] = 115, [2] = 69 }, [4] = { [0] = 18, [1] = 115, [2] = 69 }, [5] = { [0] = 23, [1] = 120, [2] = 74 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 14, [1] = 111, [2] = 65 } })[R[48]][R[31]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 20, [1] = 24, [2] = 114 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 28, [1] = 32, [2] = 122 }, [6] = { [0] = 17, [1] = 21, [2] = 111 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 118, [2] = 72 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 16, [1] = 113, [2] = 67 }, [3] = { [0] = 19, [1] = 116, [2] = 70 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 24, [1] = 121, [2] = 75 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 14, [1] = 111, [2] = 65 } })[R[48]][R[31]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 21, [1] = 25, [2] = 115 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 15, [1] = 19, [2] = 109 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 18, [1] = 22, [2] = 112 }, [7] = { [0] = 28, [1] = 32, [2] = 122 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 17, [1] = 114, [2] = 68 }, [3] = { [0] = 20, [1] = 117, [2] = 71 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 25, [1] = 122, [2] = 76 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[48]][R[31]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 22, [1] = 26, [2] = 116 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 16, [1] = 20, [2] = 110 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 19, [1] = 23, [2] = 113 }, [7] = { [0] = 15, [1] = 19, [2] = 109 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 120, [2] = 74 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 17, [1] = 114, [2] = 68 }, [3] = { [0] = 21, [1] = 118, [2] = 72 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 20, [1] = 117, [2] = 71 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[48]][R[31]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 27, [1] = 31, [2] = 121 }, [2] = { [0] = 28, [1] = 32, [2] = 122 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 23, [1] = 27, [2] = 117 }, [5] = { [0] = 22, [1] = 26, [2] = 116 }, [6] = { [0] = 20, [1] = 24, [2] = 114 }, [7] = { [0] = 16, [1] = 20, [2] = 110 } })[R[48]][R[31]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 121, [2] = 75 }, [1] = { [0] = 23, [1] = 120, [2] = 74 }, [2] = { [0] = 18, [1] = 115, [2] = 69 }, [3] = { [0] = 22, [1] = 119, [2] = 73 }, [4] = { [0] = 19, [1] = 116, [2] = 70 }, [5] = { [0] = 26, [1] = 123, [2] = 77 }, [6] = { [0] = 24, [1] = 121, [2] = 75 }, [7] = { [0] = 15, [1] = 112, [2] = 66 } })[R[48]][R[31]], ({ [0] = { [0] = 19, [1] = 23, [2] = 113 }, [1] = { [0] = 28, [1] = 32, [2] = 122 }, [2] = { [0] = 22, [1] = 26, [2] = 116 }, [3] = { [0] = 19, [1] = 23, [2] = 113 }, [4] = { [0] = 31, [1] = 35, [2] = 125 }, [5] = { [0] = 23, [1] = 27, [2] = 117 }, [6] = { [0] = 22, [1] = 26, [2] = 116 }, [7] = { [0] = 17, [1] = 21, [2] = 111 } })[R[48]][R[31]] })
    if R[48] == 0 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[31]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[31]] })
        for i = 1, game.initial_units() do
          R[49] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 23, [1] = 120, [2] = 74 }, [1] = { [0] = 25, [1] = 122, [2] = 76 }, [2] = { [0] = 12, [1] = 109, [2] = 63 } })[R[49]][R[31]], ({ [0] = { [0] = 13, [1] = 17, [2] = 107 }, [1] = { [0] = 13, [1] = 17, [2] = 107 }, [2] = { [0] = 24, [1] = 28, [2] = 118 } })[R[49]][R[31]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[31]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[31]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[48] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[31]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 29, [1] = 33, [2] = 123 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[31]] })
        for i = 1, game.initial_units() do
          R[50] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 14, [1] = 111, [2] = 65 }, [1] = { [0] = 16, [1] = 113, [2] = 67 }, [2] = { [0] = 18, [1] = 115, [2] = 69 } })[R[50]][R[31]], ({ [0] = { [0] = 24, [1] = 28, [2] = 118 }, [1] = { [0] = 33, [1] = 37, [2] = 127 }, [2] = { [0] = 18, [1] = 22, [2] = 112 } })[R[50]][R[31]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[48] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[51] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 9, [1] = 106, [2] = 60 }, [1] = { [0] = 19, [1] = 116, [2] = 70 }, [2] = { [0] = 14, [1] = 111, [2] = 65 } })[R[51]][R[31]], ({ [0] = { [0] = 16, [1] = 20, [2] = 110 }, [1] = { [0] = 16, [1] = 20, [2] = 110 }, [2] = { [0] = 32, [1] = 36, [2] = 126 } })[R[51]][R[31]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[48] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[31]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[31]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[31]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[31]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[31]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[31]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[31]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[31]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[31]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[31]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[31]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[31]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[31]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[31]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[31]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[31]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[31]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[31]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[31]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[31]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[31]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[31]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[31]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[31]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[31]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[31]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[31]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[31]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[31]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[31]] })
        for i = 1, game.initial_units() do
          R[52] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 19, [1] = 116, [2] = 70 }, [1] = { [0] = 21, [1] = 118, [2] = 72 }, [2] = { [0] = 8, [1] = 105, [2] = 59 } })[R[52]][R[31]], ({ [0] = { [0] = 22, [1] = 26, [2] = 116 }, [1] = { [0] = 29, [1] = 33, [2] = 123 }, [2] = { [0] = 26, [1] = 30, [2] = 120 } })[R[52]][R[31]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[48] == 4 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[31]], ({ [0] = 16, [1] = 20, [2] = 110 })[R[31]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[31]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[31]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[31]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[31]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[31]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[31]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[31]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[31]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[31]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[31]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[31]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[31]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[31]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[31]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[31]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[31]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[31]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[31]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[31]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[31]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[31]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[31]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[31]] })
        for i = 1, game.initial_units() do
          R[53] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 18, [1] = 115, [2] = 69 }, [1] = { [0] = 11, [1] = 108, [2] = 62 }, [2] = { [0] = 7, [1] = 104, [2] = 58 } })[R[53]][R[31]], ({ [0] = { [0] = 14, [1] = 18, [2] = 108 }, [1] = { [0] = 14, [1] = 18, [2] = 108 }, [2] = { [0] = 23, [1] = 27, [2] = 117 } })[R[53]][R[31]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[31]], ({ [0] = 16, [1] = 20, [2] = 110 })[R[31]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[31]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[31]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[31]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[31]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[31]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[31]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[31]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[31]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[31]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[31]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[31]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[31]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[31]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[31]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[31]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[31]] })
        game.create_tube({ ({ [0] = 22, [1] = 119, [2] = 73 })[R[31]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 31, [1] = 35, [2] = 125 })[R[31]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        game.create_tube({ ({ [0] = 24, [1] = 121, [2] = 75 })[R[31]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[31]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[31]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[31]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 30, [1] = 34, [2] = 124 })[R[31]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[48] == 5 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[31]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[31]] })
        for i = 1, game.initial_units() do
          R[54] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 22, [1] = 119, [2] = 73 }, [1] = { [0] = 27, [1] = 124, [2] = 78 }, [2] = { [0] = 5, [1] = 102, [2] = 56 } })[R[54]][R[31]], ({ [0] = { [0] = 31, [1] = 35, [2] = 125 }, [1] = { [0] = 31, [1] = 35, [2] = 125 }, [2] = { [0] = 18, [1] = 22, [2] = 112 } })[R[54]][R[31]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[31]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[31]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[48] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 122, [2] = 76 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        game.create_tube({ ({ [0] = 26, [1] = 123, [2] = 77 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        game.create_tube({ ({ [0] = 27, [1] = 124, [2] = 78 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 6, [1] = 103, [2] = 57 }, [1] = { [0] = 11, [1] = 108, [2] = 62 }, [2] = { [0] = 34, [1] = 131, [2] = 85 } })[R[55]][R[31]], ({ [0] = { [0] = 12, [1] = 16, [2] = 106 }, [1] = { [0] = 10, [1] = 14, [2] = 104 }, [2] = { [0] = 23, [1] = 27, [2] = 117 } })[R[55]][R[31]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[48] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[31]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[31]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[31]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[31]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[31]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[31]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[31]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[31]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[31]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[31]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[31]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[31]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[31]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[31]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[31]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[31]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[31]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[31]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[31]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[31]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[31]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[31]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[31]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[31]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[31]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[31]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[31]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[31]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[31]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[31]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[31]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[31]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[31]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[31]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[31]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[31]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[31]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[31]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[31]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[31]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[31]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[31]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[31]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[31]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[31]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[31]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[31]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[31]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[31]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[31]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[31]], ({ [0] = 26, [1] = 30, [2] = 120 })[R[31]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[31]], ({ [0] = 27, [1] = 31, [2] = 121 })[R[31]] })
        game.create_tube({ ({ [0] = 15, [1] = 112, [2] = 66 })[R[31]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[31]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[31]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[31]] })
        game.create_tube({ ({ [0] = 16, [1] = 113, [2] = 67 })[R[31]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[31]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[31]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[31]] })
        game.create_tube({ ({ [0] = 17, [1] = 114, [2] = 68 })[R[31]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[31]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[31]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[31]] })
        game.create_tube({ ({ [0] = 18, [1] = 115, [2] = 69 })[R[31]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[31]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[31]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[31]] })
        game.create_tube({ ({ [0] = 19, [1] = 116, [2] = 70 })[R[31]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[31]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[31]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[31]] })
        game.create_tube({ ({ [0] = 20, [1] = 117, [2] = 71 })[R[31]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[31]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[31]], ({ [0] = 15, [1] = 19, [2] = 109 })[R[31]] })
        game.create_tube({ ({ [0] = 21, [1] = 118, [2] = 72 })[R[31]], ({ [0] = 28, [1] = 32, [2] = 122 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 17, [1] = 21, [2] = 111 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 18, [1] = 22, [2] = 112 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 19, [1] = 23, [2] = 113 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 20, [1] = 24, [2] = 114 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 21, [1] = 25, [2] = 115 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 22, [1] = 26, [2] = 116 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 23, [1] = 27, [2] = 117 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 24, [1] = 28, [2] = 118 })[R[31]] })
        game.create_tube({ ({ [0] = 23, [1] = 120, [2] = 74 })[R[31]], ({ [0] = 25, [1] = 29, [2] = 119 })[R[31]] })
        for i = 1, game.initial_units() do
          R[56] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 13, [1] = 110, [2] = 64 }, [1] = { [0] = 19, [1] = 116, [2] = 70 }, [2] = { [0] = 9, [1] = 106, [2] = 60 } })[R[56]][R[31]], ({ [0] = { [0] = 11, [1] = 15, [2] = 105 }, [1] = { [0] = 11, [1] = 15, [2] = 105 }, [2] = { [0] = 32, [1] = 36, [2] = 126 } })[R[56]][R[31]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[48]", R[48])
    end
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { ({ [0] = 15, [1] = 106, [2] = 51 })[R[31]], ({ [0] = 5, [1] = 5, [2] = 101 })[R[31]] } }
    U[#U + 1] = game.create_unit{ type = "CommonOreMine", player = players[3], at = { ({ [0] = 15, [1] = 106, [2] = 51 })[R[31]], ({ [0] = 5, [1] = 5, [2] = 101 })[R[31]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:mark_research(3303)
    players[1].workers = 28 - 3 * LEVEL_OF[players[1].difficulty]
    players[1].scientists = 20 - 3 * LEVEL_OF[players[1].difficulty]
    players[1].kids = 18 - 2 * LEVEL_OF[players[1].difficulty]
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
    players[2].workers = 28 - 3 * LEVEL_OF[players[2].difficulty]
    players[2].scientists = 20 - 3 * LEVEL_OF[players[2].difficulty]
    players[2].kids = 18 - 2 * LEVEL_OF[players[2].difficulty]
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
    players[3].workers = 28 - 3 * LEVEL_OF[players[3].difficulty]
    players[3].scientists = 20 - 3 * LEVEL_OF[players[3].difficulty]
    players[3].kids = 18 - 2 * LEVEL_OF[players[3].difficulty]
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
  end

  -- The win.
  local t3 = trigger.count{type = "IonDriveModule", compare = ">=", count = 1}
  mission.victory(t3, "Launch the Ion Drive Module.")
  local t5 = trigger.count{type = "FusionDriveModule", compare = ">=", count = 1}
  mission.victory(t5, "Launch the Fusion Drive Module.")
  local t7 = trigger.count{type = "CommandModule", compare = ">=", count = 1}
  mission.victory(t7, "Launch the Command Module.")
  local t9 = trigger.count{type = "FuelingSystems", compare = ">=", count = 1}
  mission.victory(t9, "Launch the Fueling Systems.")
  local t11 = trigger.count{type = "HabitatRing", compare = ">=", count = 1}
  mission.victory(t11, "Launch the Habitat Ring.")
  local t13 = trigger.count{type = "SensorPackage", compare = ">=", count = 1}
  mission.victory(t13, "Launch the Sensor Package.")
  local t15 = trigger.count{type = "Skydock", compare = ">=", count = 1}
  mission.victory(t15, "Launch the Skydock.")
  local t17 = trigger.count{type = "StasisSystems", compare = ">=", count = 1}
  mission.victory(t17, "Launch the Stasis Systems.")
  local t19 = trigger.count{type = "OrbitalPackage", compare = ">=", count = 1}
  mission.victory(t19, "Launch the Orbital Package.")
  local t21 = trigger.count{type = "PhoenixModule", compare = ">=", count = 1}
  mission.victory(t21, "Launch the Phoenix Module.")
  if game.disasters_enabled() then
    trigger.time{time = 18000, on = BigQuake}  -- after 180 marks
    trigger.time{min = 6000, max = 18000, one_shot = false, on = Quake}  -- after 60 to 180 marks
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Storm}  -- after 60 to 120 marks
    trigger.time{time = 6000, one_shot = false, on = LavaCheck}  -- after 60 marks
  end
  return true
end
