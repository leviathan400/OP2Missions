-- ml2_21Lua.lua  -  2 Player, LastOne, 'Peacekeeper' map. (Lua)
--
-- Converted by op2dll from ml2_21.dll ("2 Player, LastOne, 'Peacekeeper' map."): its setup replayed. `on_init` makes the original's
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

-- The computer player: the game's own AI groups, as the mission sets them up (the game runs them).
-- Its unit tables, as the mission's UnitRecord arrays list them (ai.unit_block).
local AI_UNITS = {
  [1] = {
    { type = "CommonOreSmelter", at = { 69, 35 } },
    { type = "CommonOreMine", at = { 73, 35 } },
    { type = "CommandCenter", at = { 69, 32 } },
    { type = "StructureFactory", at = { 70, 28 } },
    { type = "Agridome", at = { 70, 25 } },
    { type = "Residence", at = { 66, 29 } },
    { type = "StandardLab", at = { 65, 32 } },
    { type = "Tokamak", at = { 59, 29 } },
    { type = "AdvancedLab", at = { 69, 20 } },
  },
  [2] = {
    { type = "VehicleFactory", at = { 68, 39 } },
    { type = "RobotCommand", at = { 66, 26 } },
    { type = "Tokamak", at = { 59, 33 } },
    { type = "Nursery", at = { 72, 39 } },
    { type = "University", at = { 75, 39 } },
  },
  [3] = {
    { type = "GuardPost", at = { 77, 46 }, weapon = "RPG" },
    { type = "GuardPost", at = { 75, 41 }, weapon = "ESG" },
    { type = "GuardPost", at = { 54, 17 }, weapon = "RPG" },
    { type = "GuardPost", at = { 57, 22 }, weapon = "ESG" },
    { type = "GuardPost", at = { 59, 38 }, weapon = "ESG" },
    { type = "GuardPost", at = { 74, 19 }, weapon = "ESG" },
    { type = "DIRT", at = { 62, 43 } },
    { type = "Tokamak", at = { 73, 47 } },
  },
  [4] = {
    { type = "GuardPost", at = { 80, 47 }, weapon = "EMP" },
    { type = "GuardPost", at = { 80, 39 }, weapon = "EMP" },
    { type = "GuardPost", at = { 80, 30 }, weapon = "EMP" },
    { type = "GuardPost", at = { 80, 23 }, weapon = "EMP" },
    { type = "GuardPost", at = { 76, 15 }, weapon = "EMP" },
    { type = "GuardPost", at = { 51, 17 }, weapon = "EMP" },
    { type = "GuardPost", at = { 51, 26 }, weapon = "EMP" },
    { type = "GuardPost", at = { 51, 34 }, weapon = "EMP" },
    { type = "GuardPost", at = { 51, 42 }, weapon = "EMP" },
    { type = "GuardPost", at = { 51, 49 }, weapon = "EMP" },
    { type = "GuardPost", at = { 60, 49 }, weapon = "EMP" },
    { type = "GuardPost", at = { 72, 31 }, weapon = "EMP" },
    { type = "Tokamak", at = { 57, 14 } },
  },
  [5] = {
    { type = "Agridome", at = { 63, 22 } },
    { type = "ArachnidFactory", at = { 60, 22 } },
    { type = "Tokamak", at = { 68, 45 } },
  },
  [6] = {
    { type = "GuardPost", at = { 63, 28 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 65, 34 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 73, 25 }, weapon = "Microwave" },
    { type = "RareOreSmelter", at = { 63, 39 } },
    { type = "RareOreMine", at = { 58, 40 } },
    { type = "DIRT", at = { 72, 42 } },
  },
}
local ai_blocks = {}
local function ai_block(i)
  ai_blocks[i] = ai_blocks[i] or ai.unit_block(AI_UNITS[i])
  return ai_blocks[i]
end
local ai_player, ai_base1, ai_fight1, ai_fight2, ai_mining1
local TimeUpgrade_step = 0

local function setup_ai(p)
  ai_player = p
  p.ore = 10000
  p:set_tech_level(5)
  ai_base1 = ai.building_group(p)
  ai_base1:set_rect({ 64, 23, 74, 33 })
  ai_base1:add_units(ai_block(1))
  ai_base1:record_unit_block(ai_block(1), ai_base1)
  ai_base1:record_unit_block(ai_block(1), ai_base1)
  ai_base1:record_building({ 68, 39 }, "VehicleFactory", nil, ai_base1)
  ai_base1:record_building({ 59, 33 }, "Tokamak")
  ai_base1:record_unit_block(ai_block(2), ai_base1)
  ai_base1:record_veh_reinforce_group(ai_base1, 1000)
  ai_base1:set_targ_count("ConVec", nil, 3)
  ai_base1:set_targ_count("Spider", nil, 2)
  ai_base1:set_targ_count("Earthworker", nil, 1)
  ai_base1:record_tubes_touching({ 69, 32 })
  local u34 = game.create_unit{ type = "ConVec", player = p, at = { 69, 32 }, exact = true, lights = false }[1]
  ai_base1:take_unit(u34)
  local u35 = game.create_unit{ type = "ConVec", player = p, at = { 69, 32 }, exact = true, lights = false }[1]
  ai_base1:take_unit(u35)
  local sf = ai_base1:first_of_type("StructureFactory")
  if sf then
    sf:set_factory_cargo(1, "VehicleFactory")
    sf:set_factory_cargo(2, "RobotCommand")
    sf:set_factory_cargo(3, "Tokamak")
    sf:set_factory_cargo(4, "University")
    sf:set_factory_cargo(5, "Nursery", "Microwave")
    sf:set_factory_cargo(6, "GuardPost", "Microwave")
  end
  ai_fight1 = ai.fight_group(p)
  ai_fight1:do_guard_rect()
  ai_fight1:set_rect({ 51, 17, 80, 47 })
  ai_fight1:clear_guarded_rects()
  ai_fight1:add_guarded_rect({ 44, 12, 87, 53 })
  ai_fight1:set_targ_count("Lynx", "Microwave", 4)
  ai_base1:record_veh_reinforce_group(ai_fight1, 1)
  ai_fight1:take_unit(game.create_unit{ type = "Lynx", player = p, at = { 69, 32 }, weapon = "Microwave", exact = true, lights = false }[1])
  ai_fight1:take_unit(game.create_unit{ type = "Lynx", player = p, at = { 69, 32 }, weapon = "Microwave", exact = true, lights = false }[1])
  ai_fight1:take_unit(game.create_unit{ type = "Lynx", player = p, at = { 69, 32 }, weapon = "Microwave", exact = true, lights = false }[1])
  ai_fight1:take_unit(game.create_unit{ type = "Lynx", player = p, at = { 69, 32 }, weapon = "Microwave", exact = true, lights = false }[1])
  ai_fight2 = ai.fight_group(p)
  ai_fight2:do_guard_rect()
  ai_fight2:set_rect({ 51, 17, 80, 47 })
  ai_fight2:clear_guarded_rects()
  ai_fight2:add_guarded_rect({ 44, 12, 87, 53 })
  p:set_default_group(ai_fight2)
  ai_mining1 = ai.mining_group(p)
  ai_mining1:setup({ 73, 35 }, { 69, 35 }, { 66, 33, 74, 36 })
  ai_mining1:set_targ_count("CargoTruck", nil, 3)
  ai_base1:record_veh_reinforce_group(ai_mining1, 100)
  ai_mining1:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 73, 35 }, exact = true, lights = false }[1])
  ai_mining1:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 73, 35 }, exact = true, lights = false }[1])
  p:mark_research(3303)
  p.workers = 27
  p.scientists = 18
  p.kids = 22
  p.food = 3000
  p.ore = 6000
  p:mark_research(3304)
  p:mark_research(3305)
  p:mark_research(3401)
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local function inside(x, y, r) return x >= r[1] and x <= r[3] and y >= r[2] and y <= r[4] end
local DoDisaster, Expand2, Expand3, Expand4, Expand5, Expand6, TimeUpgrade

function DoDisaster(t)
  local r1 = game.rand(4)
  local r2, r3
  repeat
    r2 = game.rand(128)
    r3 = game.rand(64)
  until not inside(r2 + 1, r3 + 33, { 44, 12, 87, 53 })
  if r1 < 1 then
    game.create_earthquake({ r2 + 1, r3 + 33 }, 1)
  elseif r1 < 2 then
    local r4, r5
    repeat
      r4 = game.rand(128)
      r5 = game.rand(64)
    until not inside(r4 + 1, r5 + 33, { 44, 12, 87, 53 })
    game.create_lightning({ r2 + 1, r3 + 33 }, { r4 + 1, r5 + 33 }, 10)
  elseif r1 < 3 then
    local r4, r5
    repeat
      r4 = game.rand(128)
      r5 = game.rand(64)
    until not inside(r4 + 1, r5 + 33, { 44, 12, 87, 53 })
    game.create_tornado({ r2 + 1, r3 + 33 }, { r4 + 1, r5 + 33 }, 10)
  else
    game.create_meteor({ r2 + 1, r3 + 33 }, 1)
  end
  t:destroy()
  trigger.time{min = 10000, max = 20000, one_shot = false, on = DoDisaster}  -- after 100 to 200 marks
end

function Expand2(t)
  ai_base1:record_unit_block(ai_block(6))
end

function Expand3(t)
  ai_base1:record_building({ 63, 25 }, "Residence")
  ai_base1:record_unit_block(ai_block(5), ai_base1)
  local mining1 = ai.mining_group(ai_player)
  mining1:setup({ 57, 40 }, { 61, 40 }, "RareOreMine", "RareOreSmelter", { 57, 37, 65, 41 })
  mining1:set_targ_count("CargoTruck", nil, 2)
  ai_base1:record_veh_reinforce_group(mining1, 100)
end

function Expand4(t)
  ai_base1:record_unit_block(ai_block(4))
end

function Expand5(t)
  ai_base1:record_tube({ 77, 39 })
  ai_base1:record_tube({ 78, 39 })
  ai_base1:record_tube({ 79, 39 })
  ai_base1:record_tube({ 79, 38 })
  ai_base1:record_tube({ 79, 37 })
  ai_base1:record_tube({ 79, 36 })
  ai_base1:record_tube({ 79, 35 })
  ai_base1:record_tube({ 79, 34 })
  ai_base1:record_tube({ 79, 33 })
  ai_base1:record_tube({ 79, 32 })
  ai_base1:record_tube({ 79, 31 })
  ai_base1:record_tube({ 79, 30 })
  ai_base1:record_tube({ 79, 29 })
  ai_base1:record_tube({ 79, 28 })
  ai_base1:record_tube({ 79, 27 })
  ai_base1:record_tube({ 79, 26 })
  ai_base1:record_tube({ 79, 25 })
  ai_base1:record_tube({ 79, 24 })
  ai_base1:record_tube({ 79, 23 })
  ai_base1:record_tube({ 78, 23 })
  ai_base1:record_tube({ 77, 23 })
  ai_base1:record_tube({ 76, 23 })
  ai_base1:record_tube({ 76, 22 })
  ai_base1:record_tube({ 76, 21 })
  ai_base1:record_tube({ 76, 20 })
  ai_base1:record_tube({ 76, 19 })
  ai_base1:record_tube({ 76, 18 })
  ai_base1:record_tube({ 76, 17 })
  ai_base1:record_tube({ 79, 40 })
  ai_base1:record_tube({ 79, 41 })
  ai_base1:record_tube({ 79, 42 })
  ai_base1:record_tube({ 79, 43 })
  ai_base1:record_tube({ 79, 44 })
  ai_base1:record_tube({ 79, 45 })
  ai_base1:record_tube({ 79, 46 })
  ai_base1:record_tube({ 79, 47 })
  ai_base1:record_wall({ 80, 20 })
  ai_base1:record_wall({ 82, 22 })
  ai_base1:record_wall({ 82, 23 })
  ai_base1:record_wall({ 82, 24 })
  ai_base1:record_wall({ 82, 25 })
  ai_base1:record_wall({ 82, 28 })
  ai_base1:record_wall({ 82, 29 })
  ai_base1:record_wall({ 82, 30 })
  ai_base1:record_wall({ 82, 31 })
  ai_base1:record_wall({ 82, 32 })
  ai_base1:record_wall({ 82, 37 })
  ai_base1:record_wall({ 82, 38 })
  ai_base1:record_wall({ 82, 39 })
  ai_base1:record_wall({ 82, 40 })
  ai_base1:record_wall({ 82, 41 })
  ai_base1:record_wall({ 82, 45 })
  ai_base1:record_wall({ 82, 46 })
  ai_base1:record_wall({ 82, 47 })
  ai_base1:record_wall({ 82, 48 })
  ai_base1:record_wall({ 82, 49 })
  ai_base1:record_wall({ 79, 49 })
  ai_base1:record_wall({ 79, 51 })
  ai_base1:record_wall({ 80, 25 })
  ai_base1:record_wall({ 80, 28 })
  ai_base1:record_wall({ 80, 32 })
  ai_base1:record_wall({ 80, 34 })
  ai_base1:record_wall({ 80, 35 })
  ai_base1:record_wall({ 80, 37 })
  ai_base1:record_wall({ 80, 41 })
  ai_base1:record_wall({ 80, 43 })
  ai_base1:record_wall({ 80, 45 })
  ai_base1:record_wall({ 80, 49 })
  ai_base1:record_wall({ 81, 25 })
  ai_base1:record_wall({ 81, 28 })
  ai_base1:record_wall({ 81, 32 })
  ai_base1:record_wall({ 81, 37 })
  ai_base1:record_wall({ 81, 41 })
  ai_base1:record_wall({ 81, 45 })
  ai_base1:record_wall({ 81, 49 })
  ai_base1:record_wall({ 66, 17 })
  ai_base1:record_wall({ 66, 18 })
  ai_base1:record_wall({ 66, 19 })
  ai_base1:record_wall({ 66, 20 })
  ai_base1:record_wall({ 66, 21 })
  ai_base1:record_wall({ 67, 17 })
  ai_base1:record_wall({ 68, 17 })
  ai_base1:record_wall({ 69, 17 })
  ai_base1:record_wall({ 70, 11 })
  ai_base1:record_wall({ 71, 11 })
  ai_base1:record_wall({ 72, 11 })
  ai_base1:record_wall({ 72, 17 })
  ai_base1:record_wall({ 72, 18 })
  ai_base1:record_wall({ 72, 19 })
  ai_base1:record_wall({ 72, 20 })
  ai_base1:record_wall({ 72, 21 })
  ai_base1:record_wall({ 72, 22 })
  ai_base1:record_wall({ 73, 11 })
  ai_base1:record_wall({ 73, 27 })
  ai_base1:record_wall({ 74, 11 })
  ai_base1:record_wall({ 74, 27 })
  ai_base1:record_wall({ 75, 11 })
  ai_base1:record_wall({ 75, 27 })
  ai_base1:record_wall({ 75, 28 })
  ai_base1:record_wall({ 75, 29 })
  ai_base1:record_wall({ 75, 30 })
  ai_base1:record_wall({ 75, 31 })
  ai_base1:record_wall({ 75, 32 })
  ai_base1:record_wall({ 75, 33 })
  ai_base1:record_wall({ 75, 34 })
  ai_base1:record_wall({ 75, 35 })
  ai_base1:record_wall({ 75, 36 })
  ai_base1:record_wall({ 76, 13 })
  ai_base1:record_wall({ 77, 13 })
  ai_base1:record_wall({ 77, 17 })
  ai_base1:record_wall({ 78, 13 })
  ai_base1:record_wall({ 78, 14 })
  ai_base1:record_wall({ 78, 15 })
  ai_base1:record_wall({ 78, 16 })
  ai_base1:record_wall({ 78, 17 })
  ai_base1:record_wall({ 78, 51 })
  local base1 = ai.building_group(ai_player)
  base1:set_rect({ 64, 23, 74, 33 })
  ai_base1:record_veh_reinforce_group(base1, 200)
  base1:set_targ_count("Earthworker", nil, 1)
  base1:record_tube({ 58, 21 })
  base1:record_tube({ 57, 21 })
  base1:record_tube({ 56, 21 })
  base1:record_tube({ 55, 21 })
  base1:record_tube({ 54, 21 })
  base1:record_tube({ 53, 21 })
  base1:record_tube({ 53, 20 })
  base1:record_tube({ 53, 19 })
  base1:record_tube({ 53, 18 })
  base1:record_tube({ 53, 17 })
  base1:record_tube({ 53, 22 })
  base1:record_tube({ 53, 23 })
  base1:record_tube({ 53, 24 })
  base1:record_tube({ 53, 25 })
  base1:record_tube({ 53, 26 })
  base1:record_tube({ 53, 27 })
  base1:record_tube({ 53, 28 })
  base1:record_tube({ 53, 29 })
  base1:record_tube({ 53, 30 })
  base1:record_tube({ 53, 31 })
  base1:record_tube({ 53, 32 })
  base1:record_tube({ 53, 33 })
  base1:record_tube({ 53, 34 })
  base1:record_tube({ 53, 35 })
  base1:record_tube({ 53, 36 })
  base1:record_tube({ 53, 37 })
  base1:record_tube({ 53, 38 })
  base1:record_tube({ 53, 39 })
  base1:record_tube({ 53, 40 })
  base1:record_tube({ 53, 41 })
  base1:record_tube({ 53, 42 })
  base1:record_tube({ 53, 43 })
  base1:record_tube({ 53, 44 })
  base1:record_tube({ 53, 45 })
  base1:record_tube({ 53, 46 })
  base1:record_tube({ 53, 47 })
  base1:record_tube({ 53, 48 })
  base1:record_tube({ 53, 49 })
  base1:record_tube({ 54, 49 })
  base1:record_tube({ 55, 49 })
  base1:record_tube({ 56, 49 })
  base1:record_tube({ 57, 49 })
  base1:record_tube({ 58, 49 })
  base1:record_tube({ 59, 49 })
  base1:record_wall({ 49, 15 })
  base1:record_wall({ 49, 16 })
  base1:record_wall({ 49, 17 })
  base1:record_wall({ 49, 18 })
  base1:record_wall({ 49, 19 })
  base1:record_wall({ 49, 24 })
  base1:record_wall({ 49, 25 })
  base1:record_wall({ 49, 26 })
  base1:record_wall({ 49, 27 })
  base1:record_wall({ 49, 28 })
  base1:record_wall({ 49, 32 })
  base1:record_wall({ 49, 33 })
  base1:record_wall({ 49, 34 })
  base1:record_wall({ 49, 35 })
  base1:record_wall({ 49, 36 })
  base1:record_wall({ 49, 40 })
  base1:record_wall({ 49, 41 })
  base1:record_wall({ 49, 42 })
  base1:record_wall({ 49, 43 })
  base1:record_wall({ 49, 44 })
  base1:record_wall({ 49, 47 })
  base1:record_wall({ 49, 48 })
  base1:record_wall({ 49, 49 })
  base1:record_wall({ 49, 50 })
  base1:record_wall({ 49, 51 })
  base1:record_wall({ 50, 15 })
  base1:record_wall({ 50, 19 })
  base1:record_wall({ 50, 24 })
  base1:record_wall({ 50, 28 })
  base1:record_wall({ 50, 32 })
  base1:record_wall({ 50, 36 })
  base1:record_wall({ 50, 40 })
  base1:record_wall({ 50, 44 })
  base1:record_wall({ 50, 47 })
  base1:record_wall({ 50, 51 })
  base1:record_wall({ 51, 15 })
  base1:record_wall({ 51, 19 })
  base1:record_wall({ 51, 24 })
  base1:record_wall({ 51, 28 })
  base1:record_wall({ 51, 32 })
  base1:record_wall({ 51, 36 })
  base1:record_wall({ 51, 40 })
  base1:record_wall({ 51, 44 })
  base1:record_wall({ 51, 47 })
  base1:record_wall({ 51, 51 })
  base1:record_wall({ 52, 13 })
  base1:record_wall({ 52, 15 })
  base1:record_wall({ 52, 19 })
  base1:record_wall({ 52, 21 })
  base1:record_wall({ 52, 22 })
  base1:record_wall({ 52, 24 })
  base1:record_wall({ 52, 28 })
  base1:record_wall({ 52, 30 })
  base1:record_wall({ 52, 32 })
  base1:record_wall({ 52, 36 })
  base1:record_wall({ 52, 38 })
  base1:record_wall({ 52, 40 })
  base1:record_wall({ 52, 44 })
  base1:record_wall({ 52, 47 })
  base1:record_wall({ 52, 51 })
  base1:record_wall({ 55, 38 })
  base1:record_wall({ 55, 39 })
  base1:record_wall({ 55, 40 })
  base1:record_wall({ 55, 41 })
  base1:record_wall({ 55, 42 })
  base1:record_wall({ 56, 26 })
  base1:record_wall({ 56, 27 })
  base1:record_wall({ 56, 28 })
  base1:record_wall({ 56, 29 })
  base1:record_wall({ 56, 30 })
  base1:record_wall({ 56, 31 })
  base1:record_wall({ 56, 32 })
  base1:record_wall({ 56, 33 })
  base1:record_wall({ 56, 34 })
  base1:record_wall({ 56, 35 })
  base1:record_wall({ 56, 38 })
  base1:record_wall({ 56, 42 })
  base1:record_wall({ 57, 26 })
  base1:record_wall({ 57, 35 })
  base1:record_wall({ 57, 42 })
  base1:record_wall({ 58, 26 })
  base1:record_wall({ 58, 35 })
  base1:record_wall({ 58, 42 })
  base1:record_wall({ 58, 47 })
  base1:record_wall({ 58, 48 })
  base1:record_wall({ 58, 50 })
  base1:record_wall({ 59, 26 })
  base1:record_wall({ 59, 35 })
  base1:record_wall({ 59, 42 })
  base1:record_wall({ 59, 47 })
  base1:record_wall({ 60, 47 })
  base1:record_wall({ 60, 51 })
  base1:record_wall({ 61, 47 })
  base1:record_wall({ 61, 51 })
  base1:record_wall({ 62, 47 })
  base1:record_wall({ 62, 48 })
  base1:record_wall({ 62, 49 })
  base1:record_wall({ 62, 50 })
  base1:record_wall({ 62, 51 })
end

function Expand6(t)
  ai_base1:record_unit_block(ai_block(3))
end

function TimeUpgrade(t)
  TimeUpgrade_step = TimeUpgrade_step + 1
  if TimeUpgrade_step == 1 then
    ai_fight1:set_targ_count("Lynx", "Stickyfoam", 1)
    ai_fight1:set_targ_count("Lynx", "Starflare", 3)
  elseif TimeUpgrade_step == 2 then
    ai_fight1:set_targ_count("Lynx", "EMP", 4)
  elseif TimeUpgrade_step == 3 then
    ai_fight1:set_targ_count("Lynx", "RPG", 4)
    ai_player:set_tech_level(6)
  elseif TimeUpgrade_step == 4 then
    ai_fight1:set_targ_count("Spider", nil, 4)
    ai_player:set_tech_level(8)
  elseif TimeUpgrade_step == 5 then
    ai_fight1:set_targ_count("Lynx", "ESG", 4)
    ai_player:set_tech_level(9)
  elseif TimeUpgrade_step == 6 then
    ai_fight1:set_targ_count("Tiger", "RPG", 4)
    ai_player:set_tech_level(10)
  elseif TimeUpgrade_step == 7 then
    ai_fight1:set_targ_count("Tiger", "EMP", 4)
    ai_player:set_tech_level(12)
  else
    t:destroy()
  end
end

function on_init()
  local n = game.num_humans()
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 57, 10 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 69, 17 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 76, 49 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 58, 48 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 73, 35 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 58, 40 } }
  if LEVEL_OF[players[1].difficulty] == 0 then
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 35, 12 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 18, 31 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 9, 39 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 20, 49 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 34, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 36, 42 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 60, 24 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 3, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 27, 2 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 96, 61 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 105, 43 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 115, 30 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 4 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 109, 50 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 96, 37 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 126, 21 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 49, 29 } }
  elseif LEVEL_OF[players[1].difficulty] == 1 or LEVEL_OF[players[1].difficulty] == 2 then
  else
    unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
  end
  players[3].ore = 10000
  players[3]:set_tech_level(5)
  setup_ai(players[n + 1])
  game.create_tube({ 69, 23 })
  pick(2, 2, { 0, 1 })
  R[2] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 118, [1] = 12 }, [1] = { [0] = 122, [1] = 16 }, [2] = { [0] = 122, [1] = 16 }, [3] = { [0] = 114, [1] = 8 }, [4] = { [0] = 118, [1] = 12 }, [5] = { [0] = 117, [1] = 11 }, [6] = { [0] = 114, [1] = 8 }, [7] = { [0] = 120, [1] = 14 } })[R[2]][R[1]], ({ [0] = { [0] = 53, [1] = 11 }, [1] = { [0] = 49, [1] = 7 }, [2] = { [0] = 53, [1] = 11 }, [3] = { [0] = 49, [1] = 7 }, [4] = { [0] = 52, [1] = 10 }, [5] = { [0] = 50, [1] = 8 }, [6] = { [0] = 47, [1] = 5 }, [7] = { [0] = 50, [1] = 8 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  players[1]:center_view({ ({ [0] = { [0] = 118, [1] = 12 }, [1] = { [0] = 122, [1] = 16 }, [2] = { [0] = 122, [1] = 16 }, [3] = { [0] = 114, [1] = 8 }, [4] = { [0] = 118, [1] = 12 }, [5] = { [0] = 117, [1] = 11 }, [6] = { [0] = 114, [1] = 8 }, [7] = { [0] = 120, [1] = 14 } })[R[2]][R[1]], ({ [0] = { [0] = 53, [1] = 11 }, [1] = { [0] = 49, [1] = 7 }, [2] = { [0] = 53, [1] = 11 }, [3] = { [0] = 49, [1] = 7 }, [4] = { [0] = 52, [1] = 10 }, [5] = { [0] = 50, [1] = 8 }, [6] = { [0] = 47, [1] = 5 }, [7] = { [0] = 50, [1] = 8 } })[R[2]][R[1]] })
  if R[2] == 5 or R[2] == 6 or R[2] == 7 then
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 114, [1] = 8 }, [6] = { [0] = 123, [1] = 17 }, [7] = { [0] = 114, [1] = 8 } })[R[2]][R[1]], ({ [0] = 57, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 122, [1] = 16 }, [6] = { [0] = 114, [1] = 8 }, [7] = { [0] = 122, [1] = 16 } })[R[2]][R[1]], ({ [5] = { [0] = 51, [1] = 9 }, [6] = { [0] = 56, [1] = 14 }, [7] = { [0] = 56, [1] = 14 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 5 or R[2] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 122, [1] = 16 }, [7] = { [0] = 115, [1] = 9 } })[R[2]][R[1]], ({ [0] = 47, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 5 then
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
      elseif R[2] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 119, [1] = 13 })[R[1]], ({ [0] = 47, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 119, [1] = 13 })[R[1]], ({ [0] = 47, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 119, [1] = 13 })[R[1]], ({ [0] = 47, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [5] = { [0] = 121, [1] = 15 }, [7] = { [0] = 120, [1] = 14 } })[R[2]][R[1]], ({ [5] = { [0] = 55, [1] = 13 }, [7] = { [0] = 53, [1] = 11 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 7 then
      elseif R[2] == 5 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 117, [1] = 11 })[R[1]], ({ [0] = 47, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[2]", R[2])
      end
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 117, [1] = 11 })[R[1]], ({ [5] = { [0] = 53, [1] = 11 }, [7] = { [0] = 50, [1] = 8 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 118, [1] = 12 })[R[1]], ({ [5] = { [0] = 52, [1] = 10 }, [7] = { [0] = 51, [1] = 9 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 118, [1] = 12 }, [7] = { [0] = 123, [1] = 17 } })[R[2]][R[1]], ({ [5] = { [0] = 54, [1] = 12 }, [7] = { [0] = 51, [1] = 9 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif R[2] == 6 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 114, [1] = 8 })[R[1]], ({ [0] = 53, [1] = 11 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 114, [1] = 8 })[R[1]], ({ [0] = 50, [1] = 8 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 119, [1] = 13 })[R[1]], ({ [0] = 48, [1] = 6 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      unseen("R[2]", R[2])
    end
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 124, [1] = 18 }, [6] = { [0] = 121, [1] = 15 }, [7] = { [0] = 117, [1] = 11 } })[R[2]][R[1]], ({ [5] = { [0] = 49, [1] = 7 }, [6] = { [0] = 50, [1] = 8 }, [7] = { [0] = 48, [1] = 6 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 5 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 124, [1] = 18 })[R[1]], ({ [0] = 49, [1] = 7 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 121, [1] = 15 })[R[1]], ({ [0] = 50, [1] = 8 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 121, [1] = 15 })[R[1]], ({ [0] = 50, [1] = 8 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 116, [1] = 10 })[R[1]], ({ [0] = 58, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 117, [1] = 11 })[R[1]], ({ [0] = 57, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 7 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 117, [1] = 11 })[R[1]], ({ [0] = 48, [1] = 6 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[2]", R[2])
    end
  elseif R[2] == 0 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 115, [1] = 9 })[R[1]], ({ [0] = 56, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 120, [1] = 14 })[R[1]], ({ [0] = 56, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 114, [1] = 8 })[R[1]], ({ [0] = 53, [1] = 11 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 122, [1] = 16 })[R[1]], ({ [0] = 53, [1] = 11 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 123, [1] = 17 })[R[1]], ({ [0] = 47, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 121, [1] = 15 })[R[1]], ({ [0] = 58, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 122, [1] = 16 })[R[1]], ({ [0] = 57, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 124, [1] = 18 })[R[1]], ({ [0] = 56, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 117, [1] = 11 })[R[1]], ({ [0] = 58, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 117, [1] = 11 })[R[1]], ({ [0] = 58, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[2] == 1 or R[2] == 2 or R[2] == 3 or R[2] == 4 then
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 122, [1] = 16 }, [2] = { [0] = 115, [1] = 9 }, [3] = { [0] = 119, [1] = 13 }, [4] = { [0] = 115, [1] = 9 } })[R[2]][R[1]], ({ [0] = 56, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 4 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 115, [1] = 9 })[R[1]], ({ [0] = 48, [1] = 6 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 119, [1] = 13 })[R[1]], ({ [0] = 49, [1] = 7 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 114, [1] = 8 })[R[1]], ({ [0] = 52, [1] = 10 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 123, [1] = 17 })[R[1]], ({ [0] = 57, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 117, [1] = 11 })[R[1]], ({ [0] = 46, [1] = 4 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 118, [1] = 12 })[R[1]], ({ [0] = 47, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 1 or R[2] == 2 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 113, [1] = 7 }, [2] = { [0] = 114, [1] = 8 } })[R[2]][R[1]], ({ [0] = 47, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 122, [1] = 16 })[R[1]], ({ [1] = { [0] = 52, [1] = 10 }, [2] = { [0] = 56, [1] = 14 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 117, [1] = 11 }, [2] = { [0] = 118, [1] = 12 } })[R[2]][R[1]], ({ [1] = { [0] = 57, [1] = 15 }, [2] = { [0] = 53, [1] = 11 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 117, [1] = 11 }, [2] = { [0] = 122, [1] = 16 } })[R[2]][R[1]], ({ [1] = { [0] = 53, [1] = 11 }, [2] = { [0] = 50, [1] = 8 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 123, [1] = 17 }, [2] = { [0] = 121, [1] = 15 } })[R[2]][R[1]], ({ [0] = 58, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 124, [1] = 18 }, [2] = { [0] = 123, [1] = 17 } })[R[2]][R[1]], ({ [1] = { [0] = 57, [1] = 15 }, [2] = { [0] = 58, [1] = 16 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 3 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 114, [1] = 8 })[R[1]], ({ [0] = 57, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 121, [1] = 15 })[R[1]], ({ [0] = 53, [1] = 11 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 115, [1] = 9 })[R[1]], ({ [0] = 52, [1] = 10 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 123, [1] = 17 })[R[1]], ({ [0] = 47, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 120, [1] = 14 })[R[1]], ({ [0] = 58, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 121, [1] = 15 })[R[1]], ({ [0] = 57, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    if R[2] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 121, [1] = 15 })[R[1]], ({ [0] = 58, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 119, [1] = 13 })[R[1]], ({ [0] = 57, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 3 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 122, [1] = 16 })[R[1]], ({ [0] = 58, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 112, [1] = 6 })[R[1]], ({ [0] = 54, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 118, [1] = 12 })[R[1]], ({ [0] = 47, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    if R[2] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 124, [1] = 18 })[R[1]], ({ [0] = 54, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 2 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 116, [1] = 10 })[R[1]], ({ [0] = 58, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 3 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 116, [1] = 10 })[R[1]], ({ [0] = 54, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 116, [1] = 10 })[R[1]], ({ [0] = 50, [1] = 8 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 112, [1] = 6 })[R[1]], ({ [0] = 54, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 124, [1] = 18 }, [2] = { [0] = 116, [1] = 10 }, [3] = { [0] = 116, [1] = 10 }, [4] = { [0] = 116, [1] = 10 } })[R[2]][R[1]], ({ [1] = { [0] = 54, [1] = 12 }, [2] = { [0] = 58, [1] = 16 }, [3] = { [0] = 54, [1] = 12 }, [4] = { [0] = 50, [1] = 8 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[2]", R[2])
  end
  U[#U]:set_lights(true)
  if R[2] == 0 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 117, [1] = 11 })[R[1]], ({ [0] = 58, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 113, [1] = 7 })[R[1]], ({ [0] = 49, [1] = 7 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 113, [1] = 7 })[R[1]], ({ [0] = 49, [1] = 7 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[2] == 1 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 124, [1] = 18 })[R[1]], ({ [0] = 54, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 114, [1] = 8 })[R[1]], ({ [0] = 53, [1] = 11 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 114, [1] = 8 })[R[1]], ({ [0] = 53, [1] = 11 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[2] == 2 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 116, [1] = 10 })[R[1]], ({ [0] = 58, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 118, [1] = 12 })[R[1]], ({ [0] = 49, [1] = 7 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 118, [1] = 12 })[R[1]], ({ [0] = 49, [1] = 7 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[2] == 3 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 116, [1] = 10 })[R[1]], ({ [0] = 54, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 117, [1] = 11 })[R[1]], ({ [0] = 50, [1] = 8 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 117, [1] = 11 })[R[1]], ({ [0] = 50, [1] = 8 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[2] == 4 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 116, [1] = 10 })[R[1]], ({ [0] = 50, [1] = 8 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 113, [1] = 7 })[R[1]], ({ [0] = 58, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[2] == 5 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 124, [1] = 18 })[R[1]], ({ [0] = 49, [1] = 7 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 124, [1] = 18 })[R[1]], ({ [0] = 55, [1] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[2] == 6 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 121, [1] = 15 })[R[1]], ({ [0] = 50, [1] = 8 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 116, [1] = 10 })[R[1]], ({ [0] = 58, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 117, [1] = 11 })[R[1]], ({ [0] = 57, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 119, [1] = 13 })[R[1]], ({ [0] = 58, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 117, [1] = 11 })[R[1]], ({ [0] = 51, [1] = 9 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 119, [1] = 13 })[R[1]], ({ [0] = 58, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 117, [1] = 11 })[R[1]], ({ [0] = 51, [1] = 9 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[2] == 7 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 117, [1] = 11 })[R[1]], ({ [0] = 48, [1] = 6 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 124, [1] = 18 })[R[1]], ({ [0] = 55, [1] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[2]", R[2])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 114, [1] = 8 }, [1] = { [0] = 113, [1] = 7 }, [2] = { [0] = 119, [1] = 13 }, [3] = { [0] = 118, [1] = 12 }, [4] = { [0] = 116, [1] = 10 }, [5] = { [0] = 123, [1] = 17 }, [6] = { [0] = 118, [1] = 12 }, [7] = { [0] = 123, [1] = 17 } })[R[2]][R[1]], ({ [0] = { [0] = 50, [1] = 8 }, [1] = { [0] = 52, [1] = 10 }, [2] = { [0] = 48, [1] = 6 }, [3] = { [0] = 49, [1] = 7 }, [4] = { [0] = 58, [1] = 16 }, [5] = { [0] = 53, [1] = 11 }, [6] = { [0] = 52, [1] = 10 }, [7] = { [0] = 58, [1] = 16 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 115, [1] = 9 }, [1] = { [0] = 115, [1] = 9 }, [2] = { [0] = 118, [1] = 12 }, [3] = { [0] = 117, [1] = 11 }, [4] = { [0] = 117, [1] = 11 }, [5] = { [0] = 124, [1] = 18 }, [6] = { [0] = 119, [1] = 13 }, [7] = { [0] = 124, [1] = 18 } })[R[2]][R[1]], ({ [0] = { [0] = 50, [1] = 8 }, [1] = { [0] = 51, [1] = 9 }, [2] = { [0] = 47, [1] = 5 }, [3] = { [0] = 48, [1] = 6 }, [4] = { [0] = 57, [1] = 15 }, [5] = { [0] = 52, [1] = 10 }, [6] = { [0] = 51, [1] = 9 }, [7] = { [0] = 58, [1] = 16 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if R[2] == 0 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[3] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 113, [1] = 7 }, [1] = { [0] = 118, [1] = 12 }, [2] = { [0] = 123, [1] = 17 } })[R[3]][R[1]], ({ [0] = { [0] = 46, [1] = 4 }, [1] = { [0] = 49, [1] = 7 }, [2] = { [0] = 55, [1] = 13 } })[R[3]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 1 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 117, [1] = 11 })[R[1]], ({ [0] = 55, [1] = 13 })[R[1]] })
      for i = 1, game.initial_units() do
        R[4] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 113, [1] = 7 }, [1] = { [0] = 117, [1] = 11 }, [2] = { [0] = 120, [1] = 14 } })[R[4]][R[1]], ({ [0] = { [0] = 56, [1] = 14 }, [1] = { [0] = 50, [1] = 8 }, [2] = { [0] = 46, [1] = 4 } })[R[4]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 117, [1] = 11 })[R[1]], ({ [0] = 55, [1] = 13 })[R[1]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 2 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 118, [1] = 12 })[R[1]], ({ [0] = 55, [1] = 13 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 12 })[R[1]], ({ [0] = 56, [1] = 14 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 13 })[R[1]], ({ [0] = 56, [1] = 14 })[R[1]] })
      for i = 1, game.initial_units() do
        R[5] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 122, [1] = 16 }, [1] = { [0] = 114, [1] = 8 }, [2] = { [0] = 118, [1] = 12 } })[R[5]][R[1]], ({ [0] = { [0] = 46, [1] = 4 }, [1] = { [0] = 51, [1] = 9 }, [2] = { [0] = 56, [1] = 14 } })[R[5]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 118, [1] = 12 })[R[1]], ({ [0] = 55, [1] = 13 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 12 })[R[1]], ({ [0] = 56, [1] = 14 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 13 })[R[1]], ({ [0] = 56, [1] = 14 })[R[1]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 3 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 115, [1] = 9 })[R[1]], ({ [0] = 55, [1] = 13 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 12 })[R[1]], ({ [0] = 52, [1] = 10 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 13 })[R[1]], ({ [0] = 52, [1] = 10 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 15 })[R[1]], ({ [0] = 55, [1] = 13 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 15 })[R[1]], ({ [0] = 56, [1] = 14 })[R[1]] })
      for i = 1, game.initial_units() do
        R[6] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 123, [1] = 17 }, [1] = { [0] = 119, [1] = 13 }, [2] = { [0] = 115, [1] = 9 } })[R[6]][R[1]], ({ [0] = { [0] = 57, [1] = 15 }, [1] = { [0] = 51, [1] = 9 }, [2] = { [0] = 46, [1] = 4 } })[R[6]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 115, [1] = 9 })[R[1]], ({ [0] = 55, [1] = 13 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 12 })[R[1]], ({ [0] = 52, [1] = 10 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 13 })[R[1]], ({ [0] = 52, [1] = 10 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 15 })[R[1]], ({ [0] = 55, [1] = 13 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 15 })[R[1]], ({ [0] = 56, [1] = 14 })[R[1]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 4 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 114, [1] = 8 })[R[1]], ({ [0] = 54, [1] = 12 })[R[1]] })
      for i = 1, game.initial_units() do
        R[7] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 122, [1] = 16 }, [1] = { [0] = 123, [1] = 17 }, [2] = { [0] = 119, [1] = 13 } })[R[7]][R[1]], ({ [0] = { [0] = 46, [1] = 4 }, [1] = { [0] = 52, [1] = 10 }, [2] = { [0] = 56, [1] = 14 } })[R[7]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 114, [1] = 8 })[R[1]], ({ [0] = 54, [1] = 12 })[R[1]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 5 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[8] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 119, [1] = 13 }, [1] = { [0] = 113, [1] = 7 }, [2] = { [0] = 113, [1] = 7 } })[R[8]][R[1]], ({ [0] = { [0] = 57, [1] = 15 }, [1] = { [0] = 52, [1] = 10 }, [2] = { [0] = 47, [1] = 5 } })[R[8]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 6 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[9] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 123, [1] = 17 }, [1] = { [0] = 122, [1] = 16 }, [2] = { [0] = 119, [1] = 13 } })[R[9]][R[1]], ({ [0] = { [0] = 47, [1] = 5 }, [1] = { [0] = 53, [1] = 11 }, [2] = { [0] = 54, [1] = 12 } })[R[9]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 7 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[10] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 117, [1] = 11 }, [1] = { [0] = 113, [1] = 7 }, [2] = { [0] = 123, [1] = 17 } })[R[10]][R[1]], ({ [0] = { [0] = 56, [1] = 14 }, [1] = { [0] = 52, [1] = 10 }, [2] = { [0] = 47, [1] = 5 } })[R[10]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[2]", R[2])
  end
  R[11] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 118 }, [1] = { [0] = 16, [1] = 122 }, [2] = { [0] = 16, [1] = 122 }, [3] = { [0] = 8, [1] = 114 }, [4] = { [0] = 12, [1] = 118 }, [5] = { [0] = 11, [1] = 117 }, [6] = { [0] = 8, [1] = 114 }, [7] = { [0] = 14, [1] = 120 } })[R[11]][R[1]], ({ [0] = { [0] = 11, [1] = 53 }, [1] = { [0] = 7, [1] = 49 }, [2] = { [0] = 11, [1] = 53 }, [3] = { [0] = 7, [1] = 49 }, [4] = { [0] = 10, [1] = 52 }, [5] = { [0] = 8, [1] = 50 }, [6] = { [0] = 5, [1] = 47 }, [7] = { [0] = 8, [1] = 50 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  players[2]:center_view({ ({ [0] = { [0] = 12, [1] = 118 }, [1] = { [0] = 16, [1] = 122 }, [2] = { [0] = 16, [1] = 122 }, [3] = { [0] = 8, [1] = 114 }, [4] = { [0] = 12, [1] = 118 }, [5] = { [0] = 11, [1] = 117 }, [6] = { [0] = 8, [1] = 114 }, [7] = { [0] = 14, [1] = 120 } })[R[11]][R[1]], ({ [0] = { [0] = 11, [1] = 53 }, [1] = { [0] = 7, [1] = 49 }, [2] = { [0] = 11, [1] = 53 }, [3] = { [0] = 7, [1] = 49 }, [4] = { [0] = 10, [1] = 52 }, [5] = { [0] = 8, [1] = 50 }, [6] = { [0] = 5, [1] = 47 }, [7] = { [0] = 8, [1] = 50 } })[R[11]][R[1]] })
  if R[11] == 0 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 9, [1] = 115 })[R[1]], ({ [0] = 14, [1] = 56 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 14, [1] = 120 })[R[1]], ({ [0] = 14, [1] = 56 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 8, [1] = 114 })[R[1]], ({ [0] = 11, [1] = 53 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 16, [1] = 122 })[R[1]], ({ [0] = 11, [1] = 53 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 17, [1] = 123 })[R[1]], ({ [0] = 5, [1] = 47 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 121 })[R[1]], ({ [0] = 16, [1] = 58 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 122 })[R[1]], ({ [0] = 15, [1] = 57 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 124 })[R[1]], ({ [0] = 14, [1] = 56 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 11, [1] = 117 })[R[1]], ({ [0] = 16, [1] = 58 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 11, [1] = 117 })[R[1]], ({ [0] = 16, [1] = 58 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[11] == 5 or R[11] == 6 or R[11] == 7 then
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [5] = { [0] = 8, [1] = 114 }, [6] = { [0] = 17, [1] = 123 }, [7] = { [0] = 8, [1] = 114 } })[R[11]][R[1]], ({ [0] = 15, [1] = 57 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [5] = { [0] = 16, [1] = 122 }, [6] = { [0] = 8, [1] = 114 }, [7] = { [0] = 16, [1] = 122 } })[R[11]][R[1]], ({ [5] = { [0] = 9, [1] = 51 }, [6] = { [0] = 14, [1] = 56 }, [7] = { [0] = 14, [1] = 56 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 5 or R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [5] = { [0] = 16, [1] = 122 }, [7] = { [0] = 9, [1] = 115 } })[R[11]][R[1]], ({ [0] = 5, [1] = 47 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 5 then
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
      elseif R[11] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 119 })[R[1]], ({ [0] = 5, [1] = 47 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 119 })[R[1]], ({ [0] = 5, [1] = 47 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 119 })[R[1]], ({ [0] = 5, [1] = 47 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [5] = { [0] = 15, [1] = 121 }, [7] = { [0] = 14, [1] = 120 } })[R[11]][R[1]], ({ [5] = { [0] = 13, [1] = 55 }, [7] = { [0] = 11, [1] = 53 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 7 then
      elseif R[11] == 5 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 11, [1] = 117 })[R[1]], ({ [0] = 5, [1] = 47 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[11]", R[11])
      end
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 11, [1] = 117 })[R[1]], ({ [5] = { [0] = 11, [1] = 53 }, [7] = { [0] = 8, [1] = 50 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 12, [1] = 118 })[R[1]], ({ [5] = { [0] = 10, [1] = 52 }, [7] = { [0] = 9, [1] = 51 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [5] = { [0] = 12, [1] = 118 }, [7] = { [0] = 17, [1] = 123 } })[R[11]][R[1]], ({ [5] = { [0] = 12, [1] = 54 }, [7] = { [0] = 9, [1] = 51 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif R[11] == 6 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 8, [1] = 114 })[R[1]], ({ [0] = 11, [1] = 53 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 8, [1] = 114 })[R[1]], ({ [0] = 8, [1] = 50 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 13, [1] = 119 })[R[1]], ({ [0] = 6, [1] = 48 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      unseen("R[11]", R[11])
    end
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [5] = { [0] = 18, [1] = 124 }, [6] = { [0] = 15, [1] = 121 }, [7] = { [0] = 11, [1] = 117 } })[R[11]][R[1]], ({ [5] = { [0] = 7, [1] = 49 }, [6] = { [0] = 8, [1] = 50 }, [7] = { [0] = 6, [1] = 48 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 5 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 124 })[R[1]], ({ [0] = 7, [1] = 49 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 121 })[R[1]], ({ [0] = 8, [1] = 50 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 121 })[R[1]], ({ [0] = 8, [1] = 50 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 10, [1] = 116 })[R[1]], ({ [0] = 16, [1] = 58 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 11, [1] = 117 })[R[1]], ({ [0] = 15, [1] = 57 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 7 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 11, [1] = 117 })[R[1]], ({ [0] = 6, [1] = 48 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[11]", R[11])
    end
  elseif R[11] == 1 or R[11] == 2 or R[11] == 3 or R[11] == 4 then
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = { [0] = 16, [1] = 122 }, [2] = { [0] = 9, [1] = 115 }, [3] = { [0] = 13, [1] = 119 }, [4] = { [0] = 9, [1] = 115 } })[R[11]][R[1]], ({ [0] = 14, [1] = 56 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 3 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 8, [1] = 114 })[R[1]], ({ [0] = 15, [1] = 57 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 15, [1] = 121 })[R[1]], ({ [0] = 11, [1] = 53 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 9, [1] = 115 })[R[1]], ({ [0] = 10, [1] = 52 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 17, [1] = 123 })[R[1]], ({ [0] = 5, [1] = 47 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 14, [1] = 120 })[R[1]], ({ [0] = 16, [1] = 58 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 121 })[R[1]], ({ [0] = 15, [1] = 57 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 1 or R[11] == 2 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [1] = { [0] = 7, [1] = 113 }, [2] = { [0] = 8, [1] = 114 } })[R[11]][R[1]], ({ [0] = 5, [1] = 47 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 16, [1] = 122 })[R[1]], ({ [1] = { [0] = 10, [1] = 52 }, [2] = { [0] = 14, [1] = 56 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [1] = { [0] = 11, [1] = 117 }, [2] = { [0] = 12, [1] = 118 } })[R[11]][R[1]], ({ [1] = { [0] = 15, [1] = 57 }, [2] = { [0] = 11, [1] = 53 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = { [0] = 11, [1] = 117 }, [2] = { [0] = 16, [1] = 122 } })[R[11]][R[1]], ({ [1] = { [0] = 11, [1] = 53 }, [2] = { [0] = 8, [1] = 50 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 17, [1] = 123 }, [2] = { [0] = 15, [1] = 121 } })[R[11]][R[1]], ({ [0] = 16, [1] = 58 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 18, [1] = 124 }, [2] = { [0] = 17, [1] = 123 } })[R[11]][R[1]], ({ [1] = { [0] = 15, [1] = 57 }, [2] = { [0] = 16, [1] = 58 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 9, [1] = 115 })[R[1]], ({ [0] = 6, [1] = 48 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 13, [1] = 119 })[R[1]], ({ [0] = 7, [1] = 49 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 8, [1] = 114 })[R[1]], ({ [0] = 10, [1] = 52 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 17, [1] = 123 })[R[1]], ({ [0] = 15, [1] = 57 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 11, [1] = 117 })[R[1]], ({ [0] = 4, [1] = 46 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 12, [1] = 118 })[R[1]], ({ [0] = 5, [1] = 47 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    if R[11] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 121 })[R[1]], ({ [0] = 16, [1] = 58 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 13, [1] = 119 })[R[1]], ({ [0] = 15, [1] = 57 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 3 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 122 })[R[1]], ({ [0] = 16, [1] = 58 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 4 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 6, [1] = 112 })[R[1]], ({ [0] = 12, [1] = 54 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 12, [1] = 118 })[R[1]], ({ [0] = 5, [1] = 47 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    if R[11] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 124 })[R[1]], ({ [0] = 12, [1] = 54 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 2 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 10, [1] = 116 })[R[1]], ({ [0] = 16, [1] = 58 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 3 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 10, [1] = 116 })[R[1]], ({ [0] = 12, [1] = 54 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 4 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 10, [1] = 116 })[R[1]], ({ [0] = 8, [1] = 50 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 6, [1] = 112 })[R[1]], ({ [0] = 12, [1] = 54 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [1] = { [0] = 18, [1] = 124 }, [2] = { [0] = 10, [1] = 116 }, [3] = { [0] = 10, [1] = 116 }, [4] = { [0] = 10, [1] = 116 } })[R[11]][R[1]], ({ [1] = { [0] = 12, [1] = 54 }, [2] = { [0] = 16, [1] = 58 }, [3] = { [0] = 12, [1] = 54 }, [4] = { [0] = 8, [1] = 50 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[11]", R[11])
  end
  U[#U]:set_lights(true)
  if R[11] == 0 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 11, [1] = 117 })[R[1]], ({ [0] = 16, [1] = 58 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 7, [1] = 113 })[R[1]], ({ [0] = 7, [1] = 49 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 7, [1] = 113 })[R[1]], ({ [0] = 7, [1] = 49 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[11] == 1 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 124 })[R[1]], ({ [0] = 12, [1] = 54 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 8, [1] = 114 })[R[1]], ({ [0] = 11, [1] = 53 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 8, [1] = 114 })[R[1]], ({ [0] = 11, [1] = 53 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[11] == 2 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 10, [1] = 116 })[R[1]], ({ [0] = 16, [1] = 58 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 12, [1] = 118 })[R[1]], ({ [0] = 7, [1] = 49 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 12, [1] = 118 })[R[1]], ({ [0] = 7, [1] = 49 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[11] == 3 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 10, [1] = 116 })[R[1]], ({ [0] = 12, [1] = 54 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 11, [1] = 117 })[R[1]], ({ [0] = 8, [1] = 50 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 11, [1] = 117 })[R[1]], ({ [0] = 8, [1] = 50 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[11] == 4 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 10, [1] = 116 })[R[1]], ({ [0] = 8, [1] = 50 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 7, [1] = 113 })[R[1]], ({ [0] = 16, [1] = 58 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[11] == 5 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 124 })[R[1]], ({ [0] = 7, [1] = 49 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 124 })[R[1]], ({ [0] = 13, [1] = 55 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[11] == 6 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 121 })[R[1]], ({ [0] = 8, [1] = 50 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 10, [1] = 116 })[R[1]], ({ [0] = 16, [1] = 58 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 11, [1] = 117 })[R[1]], ({ [0] = 15, [1] = 57 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 13, [1] = 119 })[R[1]], ({ [0] = 16, [1] = 58 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 11, [1] = 117 })[R[1]], ({ [0] = 9, [1] = 51 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 13, [1] = 119 })[R[1]], ({ [0] = 16, [1] = 58 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 11, [1] = 117 })[R[1]], ({ [0] = 9, [1] = 51 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[11] == 7 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 11, [1] = 117 })[R[1]], ({ [0] = 6, [1] = 48 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 124 })[R[1]], ({ [0] = 13, [1] = 55 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[11]", R[11])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 8, [1] = 114 }, [1] = { [0] = 7, [1] = 113 }, [2] = { [0] = 13, [1] = 119 }, [3] = { [0] = 12, [1] = 118 }, [4] = { [0] = 10, [1] = 116 }, [5] = { [0] = 17, [1] = 123 }, [6] = { [0] = 12, [1] = 118 }, [7] = { [0] = 17, [1] = 123 } })[R[11]][R[1]], ({ [0] = { [0] = 8, [1] = 50 }, [1] = { [0] = 10, [1] = 52 }, [2] = { [0] = 6, [1] = 48 }, [3] = { [0] = 7, [1] = 49 }, [4] = { [0] = 16, [1] = 58 }, [5] = { [0] = 11, [1] = 53 }, [6] = { [0] = 10, [1] = 52 }, [7] = { [0] = 16, [1] = 58 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 9, [1] = 115 }, [1] = { [0] = 9, [1] = 115 }, [2] = { [0] = 12, [1] = 118 }, [3] = { [0] = 11, [1] = 117 }, [4] = { [0] = 11, [1] = 117 }, [5] = { [0] = 18, [1] = 124 }, [6] = { [0] = 13, [1] = 119 }, [7] = { [0] = 18, [1] = 124 } })[R[11]][R[1]], ({ [0] = { [0] = 8, [1] = 50 }, [1] = { [0] = 9, [1] = 51 }, [2] = { [0] = 5, [1] = 47 }, [3] = { [0] = 6, [1] = 48 }, [4] = { [0] = 15, [1] = 57 }, [5] = { [0] = 10, [1] = 52 }, [6] = { [0] = 9, [1] = 51 }, [7] = { [0] = 16, [1] = 58 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if R[11] == 0 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[12] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 7, [1] = 113 }, [1] = { [0] = 12, [1] = 118 }, [2] = { [0] = 17, [1] = 123 } })[R[12]][R[1]], ({ [0] = { [0] = 4, [1] = 46 }, [1] = { [0] = 7, [1] = 49 }, [2] = { [0] = 13, [1] = 55 } })[R[12]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 11, [1] = 117 })[R[1]], ({ [0] = 13, [1] = 55 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 11, [1] = 117 })[R[1]], ({ [0] = 13, [1] = 55 })[R[1]] })
      for i = 1, game.initial_units() do
        R[13] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 7, [1] = 113 }, [1] = { [0] = 11, [1] = 117 }, [2] = { [0] = 14, [1] = 120 } })[R[13]][R[1]], ({ [0] = { [0] = 14, [1] = 56 }, [1] = { [0] = 8, [1] = 50 }, [2] = { [0] = 4, [1] = 46 } })[R[13]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 2 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 12, [1] = 118 })[R[1]], ({ [0] = 13, [1] = 55 })[R[1]] })
      game.create_tube({ ({ [0] = 12, [1] = 118 })[R[1]], ({ [0] = 14, [1] = 56 })[R[1]] })
      game.create_tube({ ({ [0] = 13, [1] = 119 })[R[1]], ({ [0] = 14, [1] = 56 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 12, [1] = 118 })[R[1]], ({ [0] = 13, [1] = 55 })[R[1]] })
      game.create_tube({ ({ [0] = 12, [1] = 118 })[R[1]], ({ [0] = 14, [1] = 56 })[R[1]] })
      game.create_tube({ ({ [0] = 13, [1] = 119 })[R[1]], ({ [0] = 14, [1] = 56 })[R[1]] })
      for i = 1, game.initial_units() do
        R[14] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 122 }, [1] = { [0] = 8, [1] = 114 }, [2] = { [0] = 12, [1] = 118 } })[R[14]][R[1]], ({ [0] = { [0] = 4, [1] = 46 }, [1] = { [0] = 9, [1] = 51 }, [2] = { [0] = 14, [1] = 56 } })[R[14]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 3 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 9, [1] = 115 })[R[1]], ({ [0] = 13, [1] = 55 })[R[1]] })
      game.create_tube({ ({ [0] = 12, [1] = 118 })[R[1]], ({ [0] = 10, [1] = 52 })[R[1]] })
      game.create_tube({ ({ [0] = 13, [1] = 119 })[R[1]], ({ [0] = 10, [1] = 52 })[R[1]] })
      game.create_tube({ ({ [0] = 15, [1] = 121 })[R[1]], ({ [0] = 13, [1] = 55 })[R[1]] })
      game.create_tube({ ({ [0] = 15, [1] = 121 })[R[1]], ({ [0] = 14, [1] = 56 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 9, [1] = 115 })[R[1]], ({ [0] = 13, [1] = 55 })[R[1]] })
      game.create_tube({ ({ [0] = 12, [1] = 118 })[R[1]], ({ [0] = 10, [1] = 52 })[R[1]] })
      game.create_tube({ ({ [0] = 13, [1] = 119 })[R[1]], ({ [0] = 10, [1] = 52 })[R[1]] })
      game.create_tube({ ({ [0] = 15, [1] = 121 })[R[1]], ({ [0] = 13, [1] = 55 })[R[1]] })
      game.create_tube({ ({ [0] = 15, [1] = 121 })[R[1]], ({ [0] = 14, [1] = 56 })[R[1]] })
      for i = 1, game.initial_units() do
        R[15] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 123 }, [1] = { [0] = 13, [1] = 119 }, [2] = { [0] = 9, [1] = 115 } })[R[15]][R[1]], ({ [0] = { [0] = 15, [1] = 57 }, [1] = { [0] = 9, [1] = 51 }, [2] = { [0] = 4, [1] = 46 } })[R[15]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 8, [1] = 114 })[R[1]], ({ [0] = 12, [1] = 54 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 8, [1] = 114 })[R[1]], ({ [0] = 12, [1] = 54 })[R[1]] })
      for i = 1, game.initial_units() do
        R[16] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 122 }, [1] = { [0] = 17, [1] = 123 }, [2] = { [0] = 13, [1] = 119 } })[R[16]][R[1]], ({ [0] = { [0] = 4, [1] = 46 }, [1] = { [0] = 10, [1] = 52 }, [2] = { [0] = 14, [1] = 56 } })[R[16]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 5 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[17] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 13, [1] = 119 }, [1] = { [0] = 7, [1] = 113 }, [2] = { [0] = 7, [1] = 113 } })[R[17]][R[1]], ({ [0] = { [0] = 15, [1] = 57 }, [1] = { [0] = 10, [1] = 52 }, [2] = { [0] = 5, [1] = 47 } })[R[17]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 6 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[18] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 123 }, [1] = { [0] = 16, [1] = 122 }, [2] = { [0] = 13, [1] = 119 } })[R[18]][R[1]], ({ [0] = { [0] = 5, [1] = 47 }, [1] = { [0] = 11, [1] = 53 }, [2] = { [0] = 12, [1] = 54 } })[R[18]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 7 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[19] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 11, [1] = 117 }, [1] = { [0] = 7, [1] = 113 }, [2] = { [0] = 17, [1] = 123 } })[R[19]][R[1]], ({ [0] = { [0] = 14, [1] = 56 }, [1] = { [0] = 10, [1] = 52 }, [2] = { [0] = 5, [1] = 47 } })[R[19]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[11]", R[11])
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
    if LEVEL_OF[players[1].difficulty] == 0 then
      players[3]:mark_research(3303)
    elseif LEVEL_OF[players[1].difficulty] == 1 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif LEVEL_OF[players[1].difficulty] == 2 then
  else
    unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
  end
  players[3].workers = ({ [0] = 27, [1] = 24, [2] = 20 })[LEVEL_OF[players[1].difficulty]]
  players[3].scientists = 18 - 3 * LEVEL_OF[players[1].difficulty]
  players[3].kids = 22 - 2 * LEVEL_OF[players[1].difficulty]
  players[3].food = 3000 - 1000 * LEVEL_OF[players[1].difficulty]
  players[3].ore = 6000 - 2000 * LEVEL_OF[players[1].difficulty]
  if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
    players[3]:mark_research(3304)
    players[3]:mark_research(3305)
    if LEVEL_OF[players[1].difficulty] == 0 then
      players[3]:mark_research(3401)
    elseif LEVEL_OF[players[1].difficulty] == 1 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif LEVEL_OF[players[1].difficulty] == 2 then
  else
    unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
  end
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 44, 62 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 102, 4 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 107, 17 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 19, 41 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 36, 4 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 95, 62 } }
  game.set_daylight_everywhere(({ [0] = 1, [1] = 0 })[(game.uses_day_night() and 1 or 0)] ~= 0)
  if (game.uses_morale() and 1 or 0) == 0 then
    game.morale_steady("Good")
  elseif (game.uses_morale() and 1 or 0) == 1 then
    game.free_morale()
  else
    unseen("(game.uses_morale() and 1 or 0)", (game.uses_morale() and 1 or 0))
  end

  -- The win.
  mission.last_one_standing("Eliminate your opponents.")
  trigger.time{time = 4000, on = Expand2}  -- after 40 marks
  trigger.time{time = 12000, on = Expand3}  -- after 120 marks
  trigger.time{time = 18000, on = Expand4}  -- after 180 marks
  trigger.time{time = 24000, on = Expand5}  -- after 240 marks
  trigger.time{time = 30000, on = Expand6}  -- after 300 marks
  trigger.time{time = 7000, one_shot = false, on = TimeUpgrade}  -- after 70 marks
  if game.disasters_enabled() then
    trigger.time{min = 10000, max = 20000, one_shot = false, on = DoDisaster}  -- after 100 to 200 marks
  end
  return true
end
