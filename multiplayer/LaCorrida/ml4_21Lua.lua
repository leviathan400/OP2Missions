-- ml4_21Lua.lua  -  4 Player, LastOne, 'La Corrida' map. (Lua)
--
-- Converted by op2dll from ml4_21.dll ("4 Player, LastOne, 'La Corrida' map."): its setup replayed. `on_init` makes the original's
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
    { type = "GuardPost", at = { 63, 56 }, weapon = "Laser" },
    { type = "GuardPost", at = { 56, 65 }, weapon = "Laser" },
    { type = "GuardPost", at = { 67, 74 }, weapon = "Laser" },
    { type = "GuardPost", at = { 74, 63 }, weapon = "Laser" },
    { type = "CommandCenter", at = { 67, 65 } },
    { type = "StructureFactory", at = { 63, 64 } },
    { type = "AdvancedLab", at = { 62, 75 } },
    { type = "CommonOreSmelter", at = { 63, 60 } },
    { type = "StandardLab", at = { 62, 68 } },
    { type = "Tokamak", at = { 58, 69 } },
    { type = "Tokamak", at = { 58, 60 } },
    { type = "Agridome", at = { 67, 72 } },
    { type = "Residence", at = { 62, 71 } },
    { type = "CommonOreMine", at = { 58, 63 } },
  },
  [2] = {
    { type = "GuardPost", at = { 56, 56 }, weapon = "EMP" },
    { type = "GuardPost", at = { 56, 73 }, weapon = "EMP" },
    { type = "GuardPost", at = { 75, 72 }, weapon = "EMP" },
    { type = "GuardPost", at = { 74, 54 }, weapon = "EMP" },
  },
}
local ai_blocks = {}
local function ai_block(i)
  ai_blocks[i] = ai_blocks[i] or ai.unit_block(AI_UNITS[i])
  return ai_blocks[i]
end
local ai_player, ai_base1, ai_fight1, ai_mining1
local TimeUpgrade_step = 0

local function setup_ai(p)
  ai_player = p
  p.ore = 10000
  p:go_eden()
  p:set_tech_level(6)
  ai_base1 = ai.building_group(p)
  ai_base1:set_rect({ 59, 58, 73, 71 })
  ai_base1:add_units(ai_block(1))
  ai_base1:record_unit_block(ai_block(1), ai_base1)
  ai_base1:record_building({ 67, 68 }, "VehicleFactory", nil, ai_base1)
  ai_base1:record_building({ 71, 73 }, "Tokamak")
  ai_base1:record_building({ 67, 62 }, "Nursery")
  ai_base1:record_building({ 67, 59 }, "Residence")
  ai_base1:record_building({ 70, 62 }, "University")
  ai_base1:record_building({ 70, 59 }, "RobotCommand")
  ai_base1:record_building({ 72, 66 }, "RareOreSmelter")
  ai_base1:record_building({ 68, 56 }, "Tokamak")
  ai_base1:record_building({ 72, 70 }, "Agridome")
  ai_base1:record_building({ 73, 59 }, "DIRT")
  ai_base1:record_veh_reinforce_group(ai_base1, 1000)
  ai_base1:set_targ_count("ConVec", nil, 2)
  ai_base1:set_targ_count("Earthworker", nil, 1)
  ai_base1:record_tubes_touching({ 67, 65 })
  local u65 = game.create_unit{ type = "ConVec", player = p, at = { 67, 65 }, exact = true, lights = false }[1]
  ai_base1:take_unit(u65)
  local sf = ai_base1:first_of_type("StructureFactory")
  if sf then
    sf:set_factory_cargo(1, "VehicleFactory")
    sf:set_factory_cargo(2, "RobotCommand")
    sf:set_factory_cargo(3, "Tokamak")
    sf:set_factory_cargo(4, "University")
    sf:set_factory_cargo(5, "Nursery", "Microwave")
  end
  ai_fight1 = ai.fight_group(p)
  ai_fight1:do_guard_rect()
  ai_fight1:set_rect({ 54, 54, 76, 76 })
  ai_fight1:clear_guarded_rects()
  ai_fight1:add_guarded_rect({ 49, 46, 83, 82 })
  ai_fight1:set_targ_count("Lynx", "Laser", 4)
  ai_base1:record_veh_reinforce_group(ai_fight1, 1)
  ai_fight1:take_unit(game.create_unit{ type = "Lynx", player = p, at = { 67, 65 }, weapon = "Laser", exact = true, lights = false }[1])
  ai_fight1:take_unit(game.create_unit{ type = "Lynx", player = p, at = { 67, 65 }, weapon = "Laser", exact = true, lights = false }[1])
  ai_fight1:take_unit(game.create_unit{ type = "Lynx", player = p, at = { 67, 65 }, weapon = "Laser", exact = true, lights = false }[1])
  ai_fight1:take_unit(game.create_unit{ type = "Lynx", player = p, at = { 67, 65 }, weapon = "Laser", exact = true, lights = false }[1])
  ai_mining1 = ai.mining_group(p)
  ai_mining1:setup({ 58, 63 }, { 63, 60 }, { 56, 61, 65, 66 })
  ai_mining1:set_targ_count("CargoTruck", nil, 3)
  ai_base1:record_veh_reinforce_group(ai_mining1, 100)
  ai_mining1:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 58, 63 }, exact = true, lights = false }[1])
  ai_mining1:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 58, 63 }, exact = true, lights = false }[1])
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
local DoDisaster, Expand2, StartAdvMine, TimeUpgrade

function DoDisaster(t)
  local r1 = game.rand(4)
  local r2, r3
  repeat
    r2 = game.rand(128)
    r3 = game.rand(128)
  until not inside(r2 + 1, r3 + 33, { 49, 46, 83, 82 })
  if r1 < 1 then
    game.create_earthquake({ r2 + 1, r3 + 33 }, 1)
  elseif r1 < 2 then
    local r4, r5
    repeat
      r4 = game.rand(128)
      r5 = game.rand(128)
    until not inside(r4 + 1, r5 + 33, { 49, 46, 83, 82 })
    game.create_lightning({ r2 + 1, r3 + 33 }, { r4 + 1, r5 + 33 }, 10)
  elseif r1 < 3 then
    local r4, r5
    repeat
      r4 = game.rand(128)
      r5 = game.rand(128)
    until not inside(r4 + 1, r5 + 33, { 49, 46, 83, 82 })
    game.create_tornado({ r2 + 1, r3 + 33 }, { r4 + 1, r5 + 33 }, 10)
  else
    game.create_meteor({ r2 + 1, r3 + 33 }, 1)
  end
  t:destroy()
  trigger.time{min = 8000, max = 16000, one_shot = false, on = DoDisaster}  -- after 80 to 160 marks
end

function Expand2(t)
  ai_base1:record_unit_block(ai_block(2))
  ai_base1:record_wall({ 54, 67 })
  ai_base1:record_wall({ 54, 68 })
  ai_base1:record_wall({ 54, 69 })
  ai_base1:record_wall({ 54, 71 })
  ai_base1:record_wall({ 54, 72 })
  ai_base1:record_wall({ 54, 73 })
  ai_base1:record_wall({ 54, 74 })
  ai_base1:record_wall({ 54, 75 })
  ai_base1:record_wall({ 55, 71 })
  ai_base1:record_wall({ 55, 75 })
  ai_base1:record_wall({ 56, 75 })
  ai_base1:record_wall({ 57, 71 })
  ai_base1:record_wall({ 57, 75 })
  ai_base1:record_wall({ 57, 77 })
  ai_base1:record_wall({ 57, 78 })
  ai_base1:record_wall({ 58, 71 })
  ai_base1:record_wall({ 58, 72 })
  ai_base1:record_wall({ 58, 73 })
  ai_base1:record_wall({ 58, 74 })
  ai_base1:record_wall({ 58, 75 })
  ai_base1:record_wall({ 73, 72 })
  ai_base1:record_wall({ 73, 73 })
  ai_base1:record_wall({ 73, 74 })
  ai_base1:record_wall({ 73, 76 })
  ai_base1:record_wall({ 73, 77 })
  ai_base1:record_wall({ 74, 74 })
  ai_base1:record_wall({ 75, 70 })
  ai_base1:record_wall({ 75, 74 })
  ai_base1:record_wall({ 76, 70 })
  ai_base1:record_wall({ 76, 74 })
  ai_base1:record_wall({ 77, 70 })
  ai_base1:record_wall({ 77, 71 })
  ai_base1:record_wall({ 77, 72 })
  ai_base1:record_wall({ 77, 73 })
  ai_base1:record_wall({ 77, 74 })
  ai_base1:record_wall({ 54, 54 })
  ai_base1:record_wall({ 54, 55 })
  ai_base1:record_wall({ 54, 56 })
  ai_base1:record_wall({ 54, 57 })
  ai_base1:record_wall({ 54, 58 })
  ai_base1:record_wall({ 54, 60 })
  ai_base1:record_wall({ 54, 61 })
  ai_base1:record_wall({ 55, 54 })
  ai_base1:record_wall({ 55, 58 })
  ai_base1:record_wall({ 56, 54 })
  ai_base1:record_wall({ 57, 54 })
  ai_base1:record_wall({ 58, 54 })
  ai_base1:record_wall({ 58, 55 })
  ai_base1:record_wall({ 60, 53 })
  ai_base1:record_wall({ 61, 53 })
  ai_base1:record_wall({ 66, 52 })
  ai_base1:record_wall({ 67, 52 })
  ai_base1:record_wall({ 68, 52 })
  ai_base1:record_wall({ 69, 52 })
  ai_base1:record_wall({ 70, 52 })
  ai_base1:record_wall({ 72, 52 })
  ai_base1:record_wall({ 72, 53 })
  ai_base1:record_wall({ 72, 54 })
  ai_base1:record_wall({ 72, 55 })
  ai_base1:record_wall({ 72, 56 })
  ai_base1:record_wall({ 73, 52 })
  ai_base1:record_wall({ 73, 56 })
  ai_base1:record_wall({ 74, 52 })
  ai_base1:record_wall({ 75, 52 })
  ai_base1:record_wall({ 75, 56 })
  ai_base1:record_wall({ 76, 52 })
  ai_base1:record_wall({ 76, 53 })
  ai_base1:record_wall({ 76, 54 })
  ai_base1:record_wall({ 76, 55 })
  ai_base1:record_wall({ 76, 56 })
  ai_base1:record_wall({ 76, 58 })
  ai_base1:record_wall({ 76, 59 })
  ai_base1:record_wall({ 76, 60 })
  ai_base1:record_tube({ 57, 57 })
  ai_base1:record_tube({ 58, 57 })
  ai_base1:record_tube({ 59, 57 })
  ai_base1:record_tube({ 60, 57 })
  ai_base1:record_tube({ 61, 57 })
  ai_base1:record_tube({ 62, 57 })
  ai_base1:record_tube({ 74, 56 })
  ai_base1:record_tube({ 74, 57 })
  ai_base1:record_tube({ 56, 67 })
  ai_base1:record_tube({ 56, 68 })
  ai_base1:record_tube({ 56, 69 })
  ai_base1:record_tube({ 56, 70 })
  ai_base1:record_tube({ 56, 71 })
  ai_base1:record_tube({ 56, 72 })
  ai_base1:record_tube({ 74, 71 })
  ai_base1:record_tube({ 74, 72 })
end

function StartAdvMine(t)
  ai_base1:record_building({ 74, 61 }, "RareOreMine")
  local mining1 = ai.mining_group(ai_player)
  mining1:setup({ 73, 61 }, { 73, 67 }, "RareOreMine", "RareOreSmelter", { 69, 60, 75, 67 })
  mining1:set_targ_count("CargoTruck", nil, 2)
  ai_base1:record_veh_reinforce_group(mining1, 100)
  mining1:take_unit(game.create_unit{ type = "CargoTruck", player = ai_player, at = { 67, 68 }, exact = true, lights = false }[1])
end

function TimeUpgrade(t)
  TimeUpgrade_step = TimeUpgrade_step + 1
  if TimeUpgrade_step == 1 then
    ai_fight1:set_targ_count("Lynx", "Starflare", 2)
  elseif TimeUpgrade_step == 2 then
    ai_fight1:set_targ_count("Lynx", "RailGun", 2)
  elseif TimeUpgrade_step == 3 then
    ai_fight1:set_targ_count("Lynx", "EMP", 2)
  elseif TimeUpgrade_step == 4 then
    ai_fight1:set_targ_count("Lynx", "AcidCloud", 1)
    ai_player:set_tech_level(8)
  elseif TimeUpgrade_step == 5 then
    ai_fight1:set_targ_count("Panther", "AcidCloud", 1)
    ai_player:set_tech_level(9)
  elseif TimeUpgrade_step == 6 then
    ai_fight1:set_targ_count("Lynx", "ThorsHammer", 2)
    ai_player:set_tech_level(10)
  elseif TimeUpgrade_step == 7 then
    ai_fight1:set_targ_count("Tiger", "ThorsHammer", 2)
    ai_player:set_tech_level(12)
  else
    t:destroy()
  end
end

function on_init()
  local n = game.num_humans()
  if n == 2 then
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 58, 63 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 74, 61 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 38, 11 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 11, 31 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 36, 121 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 8, 91 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 100, 7 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 122, 38 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 125, 103 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 96, 124 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 34, 20 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 109, 9 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 7, 90 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 96, 113 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 52, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 36, 39 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 32, 19 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 24, 32 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 5, 25 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 20, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 6, 16 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 34, 11 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 92, 38 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 97, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 98, 48 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 118, 4 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 122, 26 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 112, 31 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 109, 17 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 110, 41 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 29, 81 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 30, 88 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 21, 80 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 28, 102 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 19, 102 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 12, 114 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 13, 124 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 31, 111 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 91, 88 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 96, 82 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 105, 93 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 101 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 96 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 114, 100 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 109, 112 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 107, 121 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 71, 57 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 55, 54 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 75 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 73, 70 } }
    players[3].ore = 10000
    players[3]:go_eden()
    players[3]:set_tech_level(6)
    setup_ai(players[n + 1])
    game.create_tube({ 62, 73 })
    game.create_tube({ 64, 71 })
    game.create_tube({ 65, 71 })
    game.create_tube({ 63, 58 })
    game.create_tube({ 70, 65 })
    game.create_tube({ 71, 65 })
    game.create_tube({ 72, 65 })
    game.create_tube({ 73, 65 })
    game.create_tube({ 74, 65 })
    game.create_tube({ 58, 65 })
    game.create_tube({ 59, 65 })
    game.create_tube({ 60, 65 })
    pick(4, 2, { 0, 1 })
    R[2] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[2]][R[0]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[2]][R[0]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[2]][R[0]] })
    if R[2] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 1 or R[2] == 2 or R[2] == 3 or R[2] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [3] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [4] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[2]][R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[0]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 9, [1] = 16, [2] = 113, [3] = 112 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 1 or R[2] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[2]][R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[0]], ({ [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[2]][R[0]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[2]][R[0]], ({ [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 } })[R[2]][R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[2]][R[0]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[2]", R[2])
      end
      U[#U]:set_lights(true)
      if R[2] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 11, [1] = 112, [2] = 16, [3] = 115 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
      U[#U]:set_lights(true)
      if R[2] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 11, [1] = 112, [2] = 16, [3] = 115 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [3] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 } })[R[2]][R[0]], ({ [1] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [3] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [4] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 5 or R[2] == 6 or R[2] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [6] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [7] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[2]][R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[2]][R[0]], ({ [5] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [6] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [7] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 5 or R[2] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [7] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[2]][R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[2] == 5 then
          if LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[2]", R[2])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [7] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[2]][R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[2] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[2] == 5 then
        else
          unseen("R[2]", R[2])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[2]][R[0]], ({ [5] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[2] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[2]", R[2])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [7] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 } })[R[2]][R[0]], ({ [5] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [6] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [7] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    if R[2] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 6 then
      if LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [3] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [5] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [6] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[2]][R[0]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [6] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [1] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [3] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [4] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [7] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 } })[R[2]][R[0]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [3] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [4] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [6] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[2] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[3] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[3]][R[0]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 18, [1] = 25, [2] = 122, [3] = 121 } })[R[3]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        for i = 1, game.initial_units() do
          R[4] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[4]][R[0]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[4]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
        for i = 1, game.initial_units() do
          R[5] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[5]][R[0]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[5]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
        for i = 1, game.initial_units() do
          R[6] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[6]][R[0]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[6]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] })
        for i = 1, game.initial_units() do
          R[7] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[7]][R[0]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[7]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[8] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 } })[R[8]][R[0]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[8]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[9]][R[0]], ({ [0] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 } })[R[9]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[10]][R[0]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[10]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[2]", R[2])
    end
    R[11] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[11]][R[1]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[11]][R[1]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[11]][R[1]] })
    if R[11] == 5 or R[11] == 6 or R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [5] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [6] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [7] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[11]][R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[11]][R[1]], ({ [5] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [6] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [7] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[11] == 5 or R[11] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [7] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[11]][R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        if R[11] == 5 then
          if LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[11] == 7 then
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
          unseen("R[11]", R[11])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [7] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[11]][R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        if R[11] == 5 then
        elseif R[11] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[11]", R[11])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [5] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[11]][R[1]], ({ [5] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[11]", R[11])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [7] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 } })[R[11]][R[1]], ({ [5] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [6] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [7] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
    elseif R[11] == 1 or R[11] == 2 or R[11] == 3 or R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [3] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [4] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[11]][R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 1 or R[11] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[11]][R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[1]], ({ [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[11]][R[1]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[11]][R[1]], ({ [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 } })[R[11]][R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[11]][R[1]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[1]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 9, [1] = 16, [2] = 113, [3] = 112 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 2 then
        elseif LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
      U[#U]:set_lights(true)
      if R[11] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 4 then
        if LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 11, [1] = 112, [2] = 16, [3] = 115 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
      U[#U]:set_lights(true)
      if R[11] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 11, [1] = 112, [2] = 16, [3] = 115 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [3] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 } })[R[11]][R[1]], ({ [1] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [3] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [4] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    if R[11] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [3] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [5] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [6] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[11]][R[1]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [6] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [1] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [3] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [4] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [7] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 } })[R[11]][R[1]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [3] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [4] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [6] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[11] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[12] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[12]][R[1]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 18, [1] = 25, [2] = 122, [3] = 121 } })[R[12]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        for i = 1, game.initial_units() do
          R[13] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[13]][R[1]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[13]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
        for i = 1, game.initial_units() do
          R[14] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[14]][R[1]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[14]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
        for i = 1, game.initial_units() do
          R[15] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[15]][R[1]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[15]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] })
        for i = 1, game.initial_units() do
          R[16] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[16]][R[1]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[16]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 } })[R[17]][R[1]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[17]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[18]][R[1]], ({ [0] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 } })[R[18]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[19]][R[1]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[19]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    game.set_daylight_everywhere(({ [0] = 1, [1] = 0 })[(game.uses_day_night() and 1 or 0)] ~= 0)
    if (game.uses_morale() and 1 or 0) == 0 then
      game.morale_steady("Good")
    elseif (game.uses_morale() and 1 or 0) == 1 then
      game.free_morale()
    else
      unseen("(game.uses_morale() and 1 or 0)", (game.uses_morale() and 1 or 0))
    end
  elseif n == 3 then
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 58, 63 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 74, 61 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 38, 11 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 11, 31 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 36, 121 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 8, 91 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 100, 7 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 122, 38 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 125, 103 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 96, 124 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 34, 20 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 109, 9 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 7, 90 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 96, 113 } }
    if LEVEL_OF[players[1].difficulty] == 0 then
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 52, 29 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 36, 39 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 32, 19 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 24, 32 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 5, 25 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 20, 3 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 6, 16 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 34, 11 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 92, 38 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 97, 29 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 98, 48 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 118, 4 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 122, 26 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 112, 31 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 109, 17 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 110, 41 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 29, 81 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 30, 88 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 21, 80 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 28, 102 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 19, 102 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 12, 114 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 13, 124 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 31, 111 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 91, 88 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 96, 82 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 105, 93 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 101 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 96 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 114, 100 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 109, 112 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 107, 121 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 71, 57 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 55, 54 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 75 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 73, 70 } }
    elseif LEVEL_OF[players[1].difficulty] == 1 or LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    players[4].ore = 10000
    players[4]:go_eden()
    players[4]:set_tech_level(6)
    setup_ai(players[n + 1])
    game.create_tube({ 62, 73 })
    game.create_tube({ 64, 71 })
    game.create_tube({ 65, 71 })
    game.create_tube({ 63, 58 })
    game.create_tube({ 70, 65 })
    game.create_tube({ 71, 65 })
    game.create_tube({ 72, 65 })
    game.create_tube({ 73, 65 })
    game.create_tube({ 74, 65 })
    game.create_tube({ 58, 65 })
    game.create_tube({ 59, 65 })
    game.create_tube({ 60, 65 })
    pick(4, 3, { 0, 1, 20 })
    R[2] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[2]][R[0]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[2]][R[0]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[2]][R[0]] })
    if R[2] == 1 or R[2] == 2 or R[2] == 3 or R[2] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [3] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [4] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[2]][R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[0]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 9, [1] = 16, [2] = 113, [3] = 112 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 1 or R[2] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[2]][R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[0]], ({ [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[2]][R[0]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[2]][R[0]], ({ [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 } })[R[2]][R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[2]", R[2])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [3] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[2]][R[0]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [3] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [4] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[2]], player = players[1], at = { ({ [1] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [3] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [4] = { [0] = 11, [1] = 112, [2] = 16, [3] = 115 } })[R[2]][R[0]], ({ [1] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [2] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [3] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [4] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [3] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 } })[R[2]][R[0]], ({ [1] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [3] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [4] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[2] == 5 or R[2] == 6 or R[2] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [6] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [7] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[2]][R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[2]][R[0]], ({ [5] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [6] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [7] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 5 or R[2] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [7] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[2]][R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[2]", R[2])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [5] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[2]][R[0]], ({ [5] = { [0] = 18, [1] = 25, [2] = 122, [3] = 121 }, [7] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[2] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[2] == 7 then
        else
          unseen("R[2]", R[2])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[2]][R[0]], ({ [5] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[2] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[2]", R[2])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [7] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 } })[R[2]][R[0]], ({ [5] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [6] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [7] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[2] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    if R[2] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 6 then
      if LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [3] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [5] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [6] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[2]][R[0]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [6] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [1] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [3] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [4] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [7] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 } })[R[2]][R[0]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [3] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [4] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [6] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[2] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[21]][R[0]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 18, [1] = 25, [2] = 122, [3] = 121 } })[R[21]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[22]][R[0]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[22]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
        for i = 1, game.initial_units() do
          R[23] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[23]][R[0]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[23]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
        for i = 1, game.initial_units() do
          R[24] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[24]][R[0]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[24]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] })
        for i = 1, game.initial_units() do
          R[25] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[25]][R[0]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[25]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[26] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 } })[R[26]][R[0]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[26]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[27] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[27]][R[0]], ({ [0] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 } })[R[27]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[28] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[28]][R[0]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[28]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[2]", R[2])
    end
    R[11] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[11]][R[1]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[11]][R[1]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[11]][R[1]] })
    if R[11] == 1 or R[11] == 2 or R[11] == 3 or R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [3] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [4] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[11]][R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[1]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 9, [1] = 16, [2] = 113, [3] = 112 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 1 or R[11] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[11]][R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[1]], ({ [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[11]][R[1]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[11]][R[1]], ({ [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 } })[R[11]][R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[11]][R[1]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[11]", R[11])
      end
      U[#U]:set_lights(true)
      if R[11] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 11, [1] = 112, [2] = 16, [3] = 115 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
      U[#U]:set_lights(true)
      if R[11] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 11, [1] = 112, [2] = 16, [3] = 115 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [3] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 } })[R[11]][R[1]], ({ [1] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [3] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [4] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 5 or R[11] == 6 or R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [5] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [6] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [7] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[11]][R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[11]][R[1]], ({ [5] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [6] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [7] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[11] == 5 or R[11] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [7] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[11]][R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        if R[11] == 5 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[11] == 7 then
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
          unseen("R[11]", R[11])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [7] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[11]][R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        if R[11] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[11] == 5 then
        else
          unseen("R[11]", R[11])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [5] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[11]][R[1]], ({ [5] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[11]", R[11])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [7] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 } })[R[11]][R[1]], ({ [5] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [6] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [7] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
    elseif R[11] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    if R[11] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [3] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [5] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [6] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[11]][R[1]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [6] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [1] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [3] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [4] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [7] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 } })[R[11]][R[1]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [3] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [4] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [6] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[11] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[29]][R[1]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 18, [1] = 25, [2] = 122, [3] = 121 } })[R[29]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[30]][R[1]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[30]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[31]][R[1]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[31]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
        for i = 1, game.initial_units() do
          R[32] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[32]][R[1]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[32]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] })
        for i = 1, game.initial_units() do
          R[33] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[33]][R[1]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[33]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[34] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 } })[R[34]][R[1]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[34]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[35] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[35]][R[1]], ({ [0] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 } })[R[35]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[36] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[36]][R[1]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[36]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[11]", R[11])
    end
    R[37] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[37]][R[20]] })
    if R[37] == 1 or R[37] == 2 or R[37] == 3 or R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [3] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [4] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[37]][R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[20]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[20]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[20]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 9, [1] = 16, [2] = 113, [3] = 112 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 1 or R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[37]][R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[20]], ({ [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[37]][R[20]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[37]][R[20]], ({ [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 } })[R[37]][R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[37]][R[20]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      if R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 11, [1] = 112, [2] = 16, [3] = 115 })[R[20]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      if R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[20]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[20]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[20]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 11, [1] = 112, [2] = 16, [3] = 115 })[R[20]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [3] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 } })[R[37]][R[20]], ({ [1] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [3] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [4] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 5 or R[37] == 6 or R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [6] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [7] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[37]][R[20]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[37]][R[20]], ({ [5] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [6] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [7] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 5 or R[37] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [7] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[37]][R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[37] == 5 then
          if LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[37] == 7 then
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
          unseen("R[37]", R[37])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [7] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[37]][R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[37] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[20]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[37] == 5 then
        else
          unseen("R[37]", R[37])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [5] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[37]][R[20]], ({ [5] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[37] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[37]", R[37])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [7] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 } })[R[37]][R[20]], ({ [5] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [6] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [7] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[20]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
    elseif R[37] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[20]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[20]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[20]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[20]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[20]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[20]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[20]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[20]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [3] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [5] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [6] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[37]][R[20]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [6] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [1] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [3] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [4] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [7] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 } })[R[37]][R[20]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [3] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [4] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [6] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[38]][R[20]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 18, [1] = 25, [2] = 122, [3] = 121 } })[R[38]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] })
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[39]][R[20]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[39]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] })
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[40]][R[20]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[40]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[20]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[20]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] })
        for i = 1, game.initial_units() do
          R[41] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[41]][R[20]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[41]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[20]] })
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[42]][R[20]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[42]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[43] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 } })[R[43]][R[20]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[43]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[44] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[44]][R[20]], ({ [0] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 } })[R[44]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[45] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[45]][R[20]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[45]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[37]", R[37])
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
      if LEVEL_OF[players[1].difficulty] == 0 then
        players[4]:mark_research(3303)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    players[4].workers = ({ [0] = 27, [1] = 24, [2] = 20 })[LEVEL_OF[players[1].difficulty]]
    players[4].scientists = 18 - 3 * LEVEL_OF[players[1].difficulty]
    players[4].kids = 22 - 2 * LEVEL_OF[players[1].difficulty]
    players[4].food = 3000 - 1000 * LEVEL_OF[players[1].difficulty]
    players[4].ore = 6000 - 2000 * LEVEL_OF[players[1].difficulty]
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      players[4]:mark_research(3304)
      players[4]:mark_research(3305)
      if LEVEL_OF[players[1].difficulty] == 0 then
        players[4]:mark_research(3401)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 58, 63 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 74, 61 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 38, 11 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 11, 31 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 36, 121 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 8, 91 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 100, 7 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 122, 38 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 125, 103 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 96, 124 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 34, 20 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 109, 9 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 7, 90 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 96, 113 } }
    if LEVEL_OF[players[1].difficulty] == 0 then
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 52, 29 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 36, 39 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 32, 19 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 24, 32 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 5, 25 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 20, 3 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 6, 16 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 34, 11 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 92, 38 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 97, 29 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 98, 48 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 118, 4 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 122, 26 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 112, 31 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 109, 17 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 110, 41 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 29, 81 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 30, 88 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 21, 80 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 28, 102 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 19, 102 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 12, 114 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 13, 124 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 31, 111 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 91, 88 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 96, 82 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 105, 93 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 101 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 96 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 114, 100 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 109, 112 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 107, 121 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 71, 57 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 55, 54 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 75 } }
      game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 73, 70 } }
    elseif LEVEL_OF[players[1].difficulty] == 1 or LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    players[5].ore = 10000
    players[5]:go_eden()
    players[5]:set_tech_level(6)
    setup_ai(players[n + 1])
    game.create_tube({ 62, 73 })
    game.create_tube({ 64, 71 })
    game.create_tube({ 65, 71 })
    game.create_tube({ 63, 58 })
    game.create_tube({ 70, 65 })
    game.create_tube({ 71, 65 })
    game.create_tube({ 72, 65 })
    game.create_tube({ 73, 65 })
    game.create_tube({ 74, 65 })
    game.create_tube({ 58, 65 })
    game.create_tube({ 59, 65 })
    game.create_tube({ 60, 65 })
    pick(4, 4, { 0, 1, 20, 46 })
    R[2] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[2]][R[0]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[2]][R[0]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[2]][R[0]] })
    if R[2] == 5 or R[2] == 6 or R[2] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [6] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [7] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[2]][R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[2]][R[0]], ({ [5] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [6] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [7] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[2] == 5 or R[2] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [7] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[2]][R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[2] == 5 then
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
        elseif R[2] == 7 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[2]", R[2])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [5] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[2]][R[0]], ({ [5] = { [0] = 18, [1] = 25, [2] = 122, [3] = 121 }, [7] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[2] == 7 then
        elseif R[2] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[2]", R[2])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[2]][R[0]], ({ [5] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[2]", R[2])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [7] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 } })[R[2]][R[0]], ({ [5] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [6] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [7] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[2] == 1 or R[2] == 2 or R[2] == 3 or R[2] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [3] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [4] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[2]][R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 1 or R[2] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[2]][R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[0]], ({ [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[2]][R[0]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[2]][R[0]], ({ [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 } })[R[2]][R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[2]][R[0]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[0]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 9, [1] = 16, [2] = 113, [3] = 112 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
      U[#U]:set_lights(true)
      if R[2] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 11, [1] = 112, [2] = 16, [3] = 115 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
      U[#U]:set_lights(true)
      if R[2] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 11, [1] = 112, [2] = 16, [3] = 115 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [3] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 } })[R[2]][R[0]], ({ [1] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [3] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [4] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[0]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    if R[2] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [3] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [5] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [6] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[2]][R[0]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [6] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [1] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [3] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [4] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [7] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 } })[R[2]][R[0]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [3] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [4] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [6] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[2] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[47] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[47]][R[0]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 18, [1] = 25, [2] = 122, [3] = 121 } })[R[47]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        for i = 1, game.initial_units() do
          R[48] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[48]][R[0]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[48]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
        for i = 1, game.initial_units() do
          R[49] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[49]][R[0]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[49]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[0]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[0]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[0]] })
        for i = 1, game.initial_units() do
          R[50] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[50]][R[0]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[50]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[0]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[0]] })
        for i = 1, game.initial_units() do
          R[51] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[51]][R[0]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[51]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[52] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 } })[R[52]][R[0]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[52]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[53] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[53]][R[0]], ({ [0] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 } })[R[53]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[54] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[54]][R[0]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[54]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[2]", R[2])
    end
    R[11] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[11]][R[1]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[11]][R[1]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[11]][R[1]] })
    if R[11] == 5 or R[11] == 6 or R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [5] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [6] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [7] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[11]][R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[11]][R[1]], ({ [5] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [6] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [7] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 5 or R[11] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [7] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[11]][R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        if R[11] == 5 then
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
        elseif R[11] == 7 then
          if LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[11]", R[11])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [5] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[11]][R[1]], ({ [5] = { [0] = 18, [1] = 25, [2] = 122, [3] = 121 }, [7] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        if R[11] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[11] == 7 then
        else
          unseen("R[11]", R[11])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [5] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[11]][R[1]], ({ [5] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[11] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [7] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 } })[R[11]][R[1]], ({ [5] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [6] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [7] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
    elseif R[11] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 1 or R[11] == 2 or R[11] == 3 or R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [3] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [4] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[11]][R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 1 or R[11] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[11]][R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[1]], ({ [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[11]][R[1]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[11]][R[1]], ({ [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 } })[R[11]][R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[11]][R[1]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[1]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 9, [1] = 16, [2] = 113, [3] = 112 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[11]", R[11])
      end
      U[#U]:set_lights(true)
      if R[11] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 11, [1] = 112, [2] = 16, [3] = 115 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
      U[#U]:set_lights(true)
      if R[11] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 11, [1] = 112, [2] = 16, [3] = 115 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [3] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 } })[R[11]][R[1]], ({ [1] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [3] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [4] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    if R[11] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [3] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [5] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [6] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[11]][R[1]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [6] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [1] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [3] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [4] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [7] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 } })[R[11]][R[1]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [3] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [4] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [6] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[11] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[55]][R[1]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 18, [1] = 25, [2] = 122, [3] = 121 } })[R[55]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        for i = 1, game.initial_units() do
          R[56] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[56]][R[1]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[56]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
        for i = 1, game.initial_units() do
          R[57] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[57]][R[1]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[57]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[1]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[1]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[1]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[1]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[1]] })
        for i = 1, game.initial_units() do
          R[58] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[58]][R[1]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[58]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[1]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[1]] })
        for i = 1, game.initial_units() do
          R[59] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[59]][R[1]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[59]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[60] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 } })[R[60]][R[1]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[60]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[61] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[61]][R[1]], ({ [0] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 } })[R[61]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[62] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[62]][R[1]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[62]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[11]", R[11])
    end
    R[37] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[37]][R[20]] })
    if R[37] == 5 or R[37] == 6 or R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [6] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [7] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[37]][R[20]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[37]][R[20]], ({ [5] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [6] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [7] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 5 or R[37] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [7] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[37]][R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[37] == 5 then
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
        elseif R[37] == 7 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[37]", R[37])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [5] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[37]][R[20]], ({ [5] = { [0] = 18, [1] = 25, [2] = 122, [3] = 121 }, [7] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[37] == 7 then
        elseif R[37] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[37]", R[37])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [5] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[37]][R[20]], ({ [5] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[37] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[37]", R[37])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [7] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 } })[R[37]][R[20]], ({ [5] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [6] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [7] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[20]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
    elseif R[37] == 1 or R[37] == 2 or R[37] == 3 or R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [3] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [4] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[37]][R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 1 or R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[37]][R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[20]], ({ [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[37]][R[20]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[37]][R[20]], ({ [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 } })[R[37]][R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[37]][R[20]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[20]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[20]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[20]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 9, [1] = 16, [2] = 113, [3] = 112 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      if R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 11, [1] = 112, [2] = 16, [3] = 115 })[R[20]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      if R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[20]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[20]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[20]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 11, [1] = 112, [2] = 16, [3] = 115 })[R[20]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [3] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 } })[R[37]][R[20]], ({ [1] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [3] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [4] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[20]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[20]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[20]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[20]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[20]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[20]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[20]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[20]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[20]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [3] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [5] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [6] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[37]][R[20]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [6] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [1] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [3] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [4] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [7] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 } })[R[37]][R[20]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [3] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [4] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [6] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[63] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[63]][R[20]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 18, [1] = 25, [2] = 122, [3] = 121 } })[R[63]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] })
        for i = 1, game.initial_units() do
          R[64] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[64]][R[20]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[64]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] })
        for i = 1, game.initial_units() do
          R[65] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[65]][R[20]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[65]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[20]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[20]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[20]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[20]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[20]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[20]] })
        for i = 1, game.initial_units() do
          R[66] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[66]][R[20]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[66]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[20]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[20]] })
        for i = 1, game.initial_units() do
          R[67] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[67]][R[20]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[67]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[68] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 } })[R[68]][R[20]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[68]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[69] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[69]][R[20]], ({ [0] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 } })[R[69]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[70] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[70]][R[20]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[70]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[37]", R[37])
    end
    R[71] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    players[4]:center_view({ ({ [0] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [3] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [5] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [6] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[71]][R[46]] })
    if R[71] == 1 or R[71] == 2 or R[71] == 3 or R[71] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [3] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [4] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[71]][R[46]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[46]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[46]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[46]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[46]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[46]], ({ [0] = 9, [1] = 16, [2] = 113, [3] = 112 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 1 or R[71] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[71]][R[46]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[46]], ({ [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[71]][R[46]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[71]][R[46]], ({ [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 } })[R[71]][R[46]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[46]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[46]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[46]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[46]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[46]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[71]", R[71])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[71]], player = players[4], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [3] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [4] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[71]][R[46]], ({ [1] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [3] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [4] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[71]], player = players[4], at = { ({ [1] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [3] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [4] = { [0] = 11, [1] = 112, [2] = 16, [3] = 115 } })[R[71]][R[46]], ({ [1] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [2] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [3] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [4] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [1] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [2] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [3] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 } })[R[71]][R[46]], ({ [1] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [2] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [3] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [4] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[46]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[46]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[46]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 4 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[46]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[71]", R[71])
      end
    elseif R[71] == 5 or R[71] == 6 or R[71] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [5] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [6] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [7] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 } })[R[71]][R[46]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [6] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [7] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 } })[R[71]][R[46]], ({ [5] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [6] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [7] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 5 or R[71] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [5] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [7] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[71]][R[46]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        if R[71] == 5 then
          if LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[46]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[46]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[46]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif R[71] == 7 then
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
          unseen("R[71]", R[71])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [5] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [7] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[71]][R[46]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        if R[71] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[46]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[71] == 5 then
        else
          unseen("R[71]", R[71])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[46]], ({ [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [7] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[46]], ({ [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [5] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[71]][R[46]], ({ [5] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 }, [7] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[71] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[46]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[46]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[46]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
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
      else
        unseen("R[71]", R[71])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 20, [1] = 121, [2] = 25, [3] = 124 }, [7] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 } })[R[71]][R[46]], ({ [5] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [6] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [7] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 5 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[46]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 6 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[46]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[46]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[46]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[46]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 7 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[46]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[71]", R[71])
      end
    elseif R[71] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[46]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 19, [1] = 120, [2] = 24, [3] = 123 })[R[46]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[46]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[46]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 22, [1] = 123, [2] = 27, [3] = 126 })[R[46]], ({ [0] = 10, [1] = 17, [2] = 114, [3] = 113 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[46]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 21, [1] = 122, [2] = 26, [3] = 125 })[R[46]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[46]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[46]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[46]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[71]", R[71])
    end
    U[#U]:set_lights(true)
    if R[71] == 0 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[46]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[46]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[46]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 1 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[46]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[46]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[46]], ({ [0] = 16, [1] = 23, [2] = 120, [3] = 119 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 2 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[46]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[46]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[46]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 3 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[46]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[46]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[46]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[46]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 12, [1] = 113, [2] = 17, [3] = 116 })[R[46]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[71] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[46]], ({ [0] = 12, [1] = 19, [2] = 116, [3] = 115 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[46]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[71] == 6 then
      if LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[46]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[46]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[46]], ({ [0] = 13, [1] = 20, [2] = 117, [3] = 116 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 15, [1] = 116, [2] = 20, [3] = 119 })[R[46]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[46]], ({ [0] = 20, [1] = 27, [2] = 124, [3] = 123 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[46]], ({ [0] = 21, [1] = 28, [2] = 125, [3] = 124 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[46]], ({ [0] = 14, [1] = 21, [2] = 118, [3] = 117 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[46]], ({ [0] = 11, [1] = 18, [2] = 115, [3] = 114 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 23, [1] = 124, [2] = 28, [3] = 127 })[R[46]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[71]", R[71])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [3] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [4] = { [0] = 15, [1] = 116, [2] = 20, [3] = 119 }, [5] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [6] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [7] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[71]][R[46]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [3] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [4] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 }, [5] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [6] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [1] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [3] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [4] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [5] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 }, [6] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [7] = { [0] = 23, [1] = 124, [2] = 28, [3] = 127 } })[R[71]][R[46]], ({ [0] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [3] = { [0] = 11, [1] = 18, [2] = 115, [3] = 114 }, [4] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [5] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [6] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [7] = { [0] = 21, [1] = 28, [2] = 125, [3] = 124 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[71] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[72] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[72]][R[46]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 12, [1] = 19, [2] = 116, [3] = 115 }, [2] = { [0] = 18, [1] = 25, [2] = 122, [3] = 121 } })[R[72]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[46]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 117, [2] = 21, [3] = 120 })[R[46]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[46]] })
        for i = 1, game.initial_units() do
          R[73] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [1] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [2] = { [0] = 19, [1] = 120, [2] = 24, [3] = 123 } })[R[73]][R[46]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 13, [1] = 20, [2] = 117, [3] = 116 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[73]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[46]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[46]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[46]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[46]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[46]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[46]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[46]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[46]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[46]] })
        for i = 1, game.initial_units() do
          R[74] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 13, [1] = 114, [2] = 18, [3] = 117 }, [2] = { [0] = 17, [1] = 118, [2] = 22, [3] = 121 } })[R[74]][R[46]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[74]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[46]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[46]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[46]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[46]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[46]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[46]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 115, [2] = 19, [3] = 118 })[R[46]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 118, [2] = 22, [3] = 121 })[R[46]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[46]] })
        game.create_tube({ ({ [0] = 18, [1] = 119, [2] = 23, [3] = 122 })[R[46]], ({ [0] = 15, [1] = 22, [2] = 119, [3] = 118 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[46]], ({ [0] = 18, [1] = 25, [2] = 122, [3] = 121 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 121, [2] = 25, [3] = 124 })[R[46]], ({ [0] = 19, [1] = 26, [2] = 123, [3] = 122 })[R[46]] })
        for i = 1, game.initial_units() do
          R[75] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [2] = { [0] = 14, [1] = 115, [2] = 19, [3] = 118 } })[R[75]][R[46]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 14, [1] = 21, [2] = 118, [3] = 117 }, [2] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 } })[R[75]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[46]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 114, [2] = 18, [3] = 117 })[R[46]], ({ [0] = 17, [1] = 24, [2] = 121, [3] = 120 })[R[46]] })
        for i = 1, game.initial_units() do
          R[76] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [1] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[76]][R[46]], ({ [0] = { [0] = 9, [1] = 16, [2] = 113, [3] = 112 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 } })[R[76]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[77] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 } })[R[77]][R[46]], ({ [0] = { [0] = 20, [1] = 27, [2] = 124, [3] = 123 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[77]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[78] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 }, [1] = { [0] = 21, [1] = 122, [2] = 26, [3] = 125 }, [2] = { [0] = 18, [1] = 119, [2] = 23, [3] = 122 } })[R[78]][R[46]], ({ [0] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 }, [1] = { [0] = 16, [1] = 23, [2] = 120, [3] = 119 }, [2] = { [0] = 17, [1] = 24, [2] = 121, [3] = 120 } })[R[78]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[79] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 16, [1] = 117, [2] = 21, [3] = 120 }, [1] = { [0] = 12, [1] = 113, [2] = 17, [3] = 116 }, [2] = { [0] = 22, [1] = 123, [2] = 27, [3] = 126 } })[R[79]][R[46]], ({ [0] = { [0] = 19, [1] = 26, [2] = 123, [3] = 122 }, [1] = { [0] = 15, [1] = 22, [2] = 119, [3] = 118 }, [2] = { [0] = 10, [1] = 17, [2] = 114, [3] = 113 } })[R[79]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[71]", R[71])
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
    players[({ [0] = 3, [1] = 3, [2] = 4 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3304, [1] = 3304, [2] = 3303 })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      players[4]:mark_research(3305)
      players[({ [0] = 3, [1] = 4 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3401, [1] = 3303 })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[1].difficulty] == 0 then
        players[5]:mark_research(3303)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    players[5].workers = ({ [0] = 27, [1] = 24, [2] = 20 })[LEVEL_OF[players[1].difficulty]]
    players[5].scientists = 18 - 3 * LEVEL_OF[players[1].difficulty]
    players[5].kids = 22 - 2 * LEVEL_OF[players[1].difficulty]
    players[5].food = 3000 - 1000 * LEVEL_OF[players[1].difficulty]
    players[5].ore = 6000 - 2000 * LEVEL_OF[players[1].difficulty]
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      players[5]:mark_research(3304)
      players[5]:mark_research(3305)
      if LEVEL_OF[players[1].difficulty] == 0 then
        players[5]:mark_research(3401)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
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
  trigger.time{time = 4000, on = Expand2}  -- after 40 marks
  trigger.count{type = "RareOreSmelter", cargo = "None", compare = "==", count = 1, player = ai_player, one_shot = true, on = StartAdvMine}
  trigger.time{time = 7000, one_shot = false, on = TimeUpgrade}  -- after 70 marks
  if game.disasters_enabled() then
    trigger.time{min = 8000, max = 16000, one_shot = false, on = DoDisaster}  -- after 80 to 160 marks
  end
  return true
end
