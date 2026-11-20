-- p01Lua.lua  -  Plymouth Mission #1 (Lua)
-- Converted by op2dll from p01.dll. With p01Lua.placement.lua (what every difficulty makes alike),
-- this makes the colony's start: what changes with the difficulty, and the beacons the setup rolls.
-- Games run: Easy 151, Normal 151, Hard 151.
-- Coordinates are the in-game status-bar ones (map file tile + 1); a kit's are relative to its start.

-- Beacons rolled each game, alike at every difficulty: `count` of the `spots` (no two alike) with the
-- `kinds` by pick, anywhere in an `area` (x1, y1, x2, y2), or a tile's kind picked from `ways`.
local BEACONS = {
  rolled = {
  },
}

-- By difficulty (players[1].difficulty), for each player: colonists, stores, research, Structure Factory
-- kits by bay, the camera, units on fixed tiles, units each on a tile rolled in its `area`, and a kit of
-- units on a start rolled from `starts` or anywhere in `start_area`; then the tubes, walls and beacons
-- only this difficulty makes.
local DIFFICULTIES = {
  Easy = {
    players = {
      [1] = {
        workers = 27, scientists = 11, kids = 0, food = 5000, ore = 8000,
        research = {  },
        view = { 54, 49 },
        units = {
        },
      },
    },
    walls = {
    },
    made = {
      { type = "Tokamak", player = 1, at = { 53, 39 } },
      { type = "Garage", player = 1, at = { 48, 52 } },
      { type = "CommonStorage", player = 1, at = { 36, 51 } },
      { type = "CommonStorage", player = 1, at = { 39, 51 } },
      { type = "CommonStorage", player = 1, at = { 51, 58 } },
      { type = "CommandCenter", player = 1, at = { 54, 49 } },
      { type = "CommonOreSmelter", player = 1, at = { 54, 53 } },
      { type = "Agridome", player = 1, at = { 43, 52 } },
      { type = "Agridome", player = 1, at = { 58, 60 } },
      { type = "Residence", player = 1, at = { 43, 56 } },
      { type = "Residence", player = 1, at = { 59, 52 } },
      { type = "CommonStorage", player = 1, at = { 54, 58 } },
      { type = "StructureFactory", player = 1, at = { 49, 47 } },
      { type = "Tokamak", player = 1, at = { 35, 55 } },
      { type = "RoboMiner", direction = "NorthWest", player = 1, at = { 28, 44 } },
      { type = "RoboMiner", direction = "West", player = 1, at = { 31, 47 } },
      { type = "RoboSurveyor", direction = "North", player = 1, at = { 4, 16 } },
      { type = "RoboSurveyor", direction = "West", player = 1, at = { 28, 46 } },
      { type = "Earthworker", direction = "NorthWest", player = 1, at = { 32, 49 } },
      { type = "CargoTruck", direction = "North", cargo = "Food", amount = 1000, player = 1, at = { 3, 12 } },
      { type = "CargoTruck", direction = "North", cargo = "Food", amount = 1000, player = 1, at = { 5, 12 } },
      { type = "CargoTruck", direction = "NorthEast", cargo = "Food", amount = 1000, player = 1, at = { 41, 52 } },
      { type = "CargoTruck", direction = "North", cargo = "Food", amount = 1000, player = 1, at = { 56, 60 } },
      { type = "CargoTruck", direction = "North", cargo = "CommonMetal", amount = 1000, player = 1, at = { 3, 14 } },
      { type = "CargoTruck", direction = "North", cargo = "CommonMetal", amount = 1000, player = 1, at = { 5, 14 } },
      { type = "CargoTruck", direction = "NorthWest", cargo = "CommonMetal", amount = 1000, player = 1, at = { 35, 51 } },
      { type = "CargoTruck", direction = "NorthWest", cargo = "CommonMetal", amount = 1000, player = 1, at = { 38, 52 } },
      { type = "ConVec", weapon = "Agridome", direction = "North", player = 1, at = { 8, 34 } },
      { type = "ConVec", weapon = "CommandCenter", direction = "North", player = 1, at = { 8, 32 } },
      { type = "ConVec", weapon = "CommonOreSmelter", direction = "South", player = 1, at = { 52, 47 } },
      { type = "ConVec", weapon = "StructureFactory", direction = "West", player = 1, at = { 46, 50 } },
      { type = "ConVec", weapon = "Tokamak", direction = "SouthWest", player = 1, at = { 46, 45 } },
      { type = "ConVec", weapon = "BasicLab", direction = "North", player = 1, at = { 50, 49 } },
      { type = "EvacuationTransport", direction = "West", player = 1, at = { 36, 42 } },
      { type = "EvacuationTransport", direction = "West", player = 1, at = { 38, 40 } },
      { type = "EvacuationTransport", direction = "West", player = 1, at = { 38, 42 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 5, 19 }, beacon = true },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 27, scientists = 11, kids = 0, food = 3000, ore = 4500,
        research = {  },
        kits = { [1] = { "CommandCenter" }, [2] = { "CommonOreSmelter" }, [3] = { "BasicLab" } },
        view = { 54, 49 },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 41, 60 } }, { "Tube", { 43, 58 } }, { "Tube", { 45, 56 } }, { "Tube", { 45, 60 } },
      { "Tube", { 47, 58 } }, { "Tube", { 48, 54 } }, { "Tube", { 49, 60 } }, { "Tube", { 50, 56 } },
      { "Tube", { 50, 60 } }, { "Tube", { 51, 56 } }, { "Tube", { 51, 60 } }, { "Tube", { 52, 62 } },
      { "Tube", { 53, 62 } }, { "Tube", { 54, 60 } }, { "Tube", { 54, 63 } }, { "Tube", { 55, 47 } },
      { "Tube", { 55, 62 } }, { "Tube", { 56, 62 } }, { "Tube", { 57, 45 } }, { "Tube", { 57, 53 } },
      { "Tube", { 57, 62 } }, { "Tube", { 58, 62 } }, { "Tube", { 59, 44 } }, { "Tube", { 59, 48 } },
      { "Tube", { 59, 54 } }, { "Tube", { 59, 58 } }, { "Tube", { 61, 42 } }, { "Tube", { 61, 46 } },
      { "Tube", { 63, 45 } }, { "Tube", { 63, 49 } },
    },
    made = {
      { type = "Tokamak", player = 1, at = { 53, 39 } },
      { type = "Garage", player = 1, at = { 48, 52 } },
      { type = "CommonStorage", player = 1, at = { 36, 51 } },
      { type = "CommonStorage", player = 1, at = { 39, 51 } },
      { type = "CommonStorage", player = 1, at = { 51, 58 } },
      { type = "CommandCenter", player = 1, at = { 54, 49 } },
      { type = "CommonOreSmelter", player = 1, at = { 54, 53 } },
      { type = "Agridome", player = 1, at = { 43, 52 } },
      { type = "Agridome", player = 1, at = { 58, 60 } },
      { type = "Residence", player = 1, at = { 43, 56 } },
      { type = "Residence", player = 1, at = { 59, 52 } },
      { type = "CommonStorage", player = 1, at = { 54, 58 } },
      { type = "Tokamak", player = 1, at = { 29, 60 } },
      { type = "LightTower", player = 1, at = { 58, 36 } },
      { type = "LightTower", player = 1, at = { 33, 60 } },
      { type = "LightTower", player = 1, at = { 36, 46 } },
      { type = "Garage", player = 1, at = { 47, 56 } },
      { type = "CommonStorage", player = 1, at = { 51, 62 } },
      { type = "CommonStorage", player = 1, at = { 54, 62 } },
      { type = "MedicalCenter", player = 1, at = { 55, 45 } },
      { type = "Agridome", player = 1, at = { 62, 60 } },
      { type = "BasicLab", player = 1, at = { 47, 60 } },
      { type = "RecreationFacility", player = 1, at = { 63, 47 } },
      { type = "University", player = 1, at = { 63, 43 } },
      { type = "Residence", player = 1, at = { 43, 60 } },
      { type = "Residence", player = 1, at = { 59, 42 } },
      { type = "Residence", player = 1, at = { 59, 56 } },
      { type = "Residence", player = 1, at = { 59, 46 } },
      { type = "BasicLab", player = 1, at = { 39, 60 } },
      { type = "DIRT", player = 1, at = { 62, 51 } },
      { type = "StructureFactory", player = 1, at = { 49, 47 } },
      { type = "RoboMiner", direction = "SouthWest", player = 1, at = { 31, 48 } },
      { type = "RoboMiner", direction = "West", player = 1, at = { 30, 52 } },
      { type = "RoboSurveyor", direction = "NorthEast", player = 1, at = { 33, 55 } },
      { type = "RoboSurveyor", direction = "West", player = 1, at = { 45, 56 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 49, 58 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 47, 53 } },
      { type = "CargoTruck", direction = "SouthWest", player = 1, at = { 46, 53 } },
      { type = "CargoTruck", direction = "South", cargo = "Food", amount = 1000, player = 1, at = { 41, 53 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 50, 63 } },
      { type = "CargoTruck", direction = "North", cargo = "CommonMetal", amount = 1000, player = 1, at = { 35, 51 } },
      { type = "CargoTruck", direction = "NorthWest", cargo = "CommonMetal", amount = 1000, player = 1, at = { 53, 59 } },
      { type = "CargoTruck", direction = "NorthWest", cargo = "Food", amount = 1000, player = 1, at = { 60, 61 } },
      { type = "ConVec", weapon = "StructureFactory", direction = "West", player = 1, at = { 46, 48 } },
      { type = "ConVec", direction = "East", player = 1, at = { 48, 57 } },
      { type = "ConVec", direction = "South", player = 1, at = { 48, 58 } },
      { type = "ConVec", direction = "West", player = 1, at = { 51, 44 } },
      { type = "ConVec", weapon = "Tokamak", direction = "SouthWest", player = 1, at = { 44, 49 } },
      { type = "ConVec", weapon = "Agridome", direction = "North", player = 1, at = { 45, 43 } },
      { type = "Earthworker", direction = "NorthEast", player = 1, at = { 27, 49 } },
      { type = "EvacuationTransport", direction = "NorthWest", player = 1, at = { 57, 48 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 58, 49 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 52, 50 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 5, 19 }, beacon = true },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 27, scientists = 11, kids = 0, food = 5000, ore = 2000,
        research = {  },
        kits = { [1] = { "CommandCenter" }, [2] = { "Agridome" }, [3] = { "CommonOreSmelter" }, [4] = { "Tokamak" }, [5] = { "StructureFactory" }, [6] = { "BasicLab" } },
        view = { 54, 49 },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 41, 60 } }, { "Tube", { 43, 58 } }, { "Tube", { 45, 56 } }, { "Tube", { 45, 60 } },
      { "Tube", { 47, 58 } }, { "Tube", { 48, 54 } }, { "Tube", { 49, 60 } }, { "Tube", { 50, 56 } },
      { "Tube", { 50, 60 } }, { "Tube", { 51, 56 } }, { "Tube", { 51, 60 } }, { "Tube", { 52, 62 } },
      { "Tube", { 53, 62 } }, { "Tube", { 54, 60 } }, { "Tube", { 54, 63 } }, { "Tube", { 55, 47 } },
      { "Tube", { 55, 62 } }, { "Tube", { 56, 62 } }, { "Tube", { 57, 45 } }, { "Tube", { 57, 53 } },
      { "Tube", { 57, 62 } }, { "Tube", { 58, 62 } }, { "Tube", { 59, 44 } }, { "Tube", { 59, 48 } },
      { "Tube", { 59, 54 } }, { "Tube", { 59, 58 } }, { "Tube", { 61, 42 } }, { "Tube", { 61, 46 } },
      { "Tube", { 63, 45 } }, { "Tube", { 63, 49 } },
    },
    made = {
      { type = "Tokamak", player = 1, at = { 53, 39 } },
      { type = "Garage", player = 1, at = { 48, 52 } },
      { type = "CommonStorage", player = 1, at = { 36, 51 } },
      { type = "CommonStorage", player = 1, at = { 39, 51 } },
      { type = "CommonStorage", player = 1, at = { 51, 58 } },
      { type = "CommandCenter", player = 1, at = { 54, 49 } },
      { type = "CommonOreSmelter", player = 1, at = { 54, 53 } },
      { type = "Agridome", player = 1, at = { 43, 52 } },
      { type = "Agridome", player = 1, at = { 58, 60 } },
      { type = "Residence", player = 1, at = { 43, 56 } },
      { type = "Residence", player = 1, at = { 59, 52 } },
      { type = "CommonStorage", player = 1, at = { 54, 58 } },
      { type = "LightTower", player = 1, at = { 58, 36 } },
      { type = "LightTower", player = 1, at = { 33, 60 } },
      { type = "LightTower", player = 1, at = { 36, 46 } },
      { type = "Garage", player = 1, at = { 47, 56 } },
      { type = "CommonStorage", player = 1, at = { 51, 62 } },
      { type = "CommonStorage", player = 1, at = { 54, 62 } },
      { type = "MedicalCenter", player = 1, at = { 55, 45 } },
      { type = "Agridome", player = 1, at = { 62, 60 } },
      { type = "BasicLab", player = 1, at = { 47, 60 } },
      { type = "RecreationFacility", player = 1, at = { 63, 47 } },
      { type = "University", player = 1, at = { 63, 43 } },
      { type = "Residence", player = 1, at = { 43, 60 } },
      { type = "Residence", player = 1, at = { 59, 42 } },
      { type = "Residence", player = 1, at = { 59, 56 } },
      { type = "Residence", player = 1, at = { 59, 46 } },
      { type = "BasicLab", player = 1, at = { 39, 60 } },
      { type = "DIRT", player = 1, at = { 62, 51 } },
      { type = "StructureFactory", player = 1, at = { 49, 47 } },
      { type = "RoboMiner", direction = "SouthWest", player = 1, at = { 49, 53 } },
      { type = "RoboMiner", direction = "West", player = 1, at = { 49, 54 } },
      { type = "RoboSurveyor", direction = "NorthEast", player = 1, at = { 50, 54 } },
      { type = "RoboSurveyor", direction = "West", garage = { bay = 1, at = { 48, 52 } }, player = 1, at = { 47, 52 } },
      { type = "CargoTruck", direction = "West", garage = { bay = 1, at = { 47, 56 } }, player = 1, at = { 46, 56 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 47, 53 } },
      { type = "CargoTruck", direction = "SouthWest", player = 1, at = { 46, 53 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 37, 61 } },
      { type = "CargoTruck", direction = "NorthEast", cargo = "CommonOre", amount = 1000, player = 1, at = { 50, 63 } },
      { type = "CargoTruck", direction = "North", cargo = "CommonOre", amount = 1000, player = 1, at = { 60, 40 } },
      { type = "CargoTruck", direction = "NorthWest", cargo = "CommonOre", amount = 1000, player = 1, at = { 51, 43 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 60, 61 } },
      { type = "ConVec", direction = "West", garage = { bay = 2, at = { 48, 52 } }, player = 1, at = { 47, 52 } },
      { type = "ConVec", direction = "East", player = 1, at = { 48, 57 } },
      { type = "ConVec", direction = "South", player = 1, at = { 48, 58 } },
      { type = "ConVec", direction = "West", player = 1, at = { 37, 52 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 63, 61 } },
      { type = "ConVec", direction = "North", player = 1, at = { 63, 52 } },
      { type = "Earthworker", direction = "NorthEast", player = 1, at = { 45, 57 } },
      { type = "EvacuationTransport", direction = "NorthWest", player = 1, at = { 57, 48 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 58, 48 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 44, 61 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 5, 19 }, beacon = true },
    },
    beacons = {
    },
  },
}

-- Where lava may flow (x1, y1, x2, y2).
local LAVA_POSSIBLE = {
  { 26, 1, 64, 3 },
  { 27, 4, 64, 4 },
  { 27, 5, 54, 5 },
  { 59, 5, 64, 5 },
  { 27, 6, 53, 6 },
  { 61, 6, 64, 10 },
  { 27, 7, 52, 7 },
  { 28, 8, 52, 9 },
  { 28, 10, 53, 11 },
  { 62, 11, 64, 12 },
  { 27, 12, 53, 12 },
  { 25, 13, 25, 14 },
  { 27, 13, 27, 13 },
  { 31, 13, 53, 13 },
  { 61, 13, 64, 13 },
  { 32, 14, 53, 14 },
  { 55, 14, 55, 14 },
  { 57, 14, 57, 14 },
  { 60, 14, 64, 14 },
  { 32, 15, 64, 15 },
  { 31, 16, 64, 16 },
  { 32, 17, 64, 18 },
  { 28, 18, 28, 18 },
  { 27, 19, 64, 22 },
  { 25, 23, 64, 25 },
  { 23, 26, 64, 28 },
  { 5, 27, 5, 27 },
  { 4, 28, 6, 28 },
  { 4, 29, 7, 29 },
  { 21, 29, 64, 29 },
  { 3, 30, 9, 30 },
  { 20, 30, 64, 30 },
  { 2, 31, 9, 32 },
  { 19, 31, 64, 32 },
  { 3, 33, 10, 33 },
  { 18, 33, 64, 33 },
  { 3, 34, 64, 35 },
  { 4, 36, 64, 37 },
  { 6, 38, 64, 38 },
  { 9, 39, 64, 39 },
  { 10, 40, 64, 41 },
  { 11, 42, 64, 42 },
  { 14, 43, 64, 45 },
  { 15, 46, 64, 46 },
  { 16, 47, 64, 50 },
  { 1, 51, 5, 51 },
  { 16, 51, 17, 51 },
  { 21, 51, 64, 51 },
  { 1, 52, 8, 52 },
  { 22, 52, 64, 52 },
  { 1, 53, 9, 59 },
  { 23, 53, 64, 54 },
  { 22, 55, 64, 56 },
  { 17, 56, 17, 56 },
  { 17, 57, 64, 57 },
  { 15, 58, 64, 58 },
  { 14, 59, 64, 59 },
  { 1, 60, 10, 60 },
  { 13, 60, 64, 60 },
  { 1, 61, 64, 64 },
}

local kits_set = false
local function make_unit(player, u, at, kits, exact)
  local made = game.create_unit{ type = u.type, player = player, at = at, direction = u.direction,
                                 weapon = u.weapon, lights = u.lights, exact = exact }
  if u.cargo and made[1] then made[1]:set_cargo(u.cargo, u.amount) end
  -- A ConVec's kit with its weapon (a Guard Post kit's).
  if u.topping and made[1] then made[1]:set_kit(u.weapon, u.topping) end
  -- A vehicle the setup parks in a Garage: its bay, by the Garage's dock.
  if u.garage and made[1] then made[1]:put_in_garage(u.garage.bay, u.garage.at) end
  if u.type == "StructureFactory" and kits and made[1] then
    for bay, kit in pairs(kits) do made[1]:set_factory_cargo(bay, kit[1], kit[2]) end
    kits_set = true
  end
end

-- One player's start at the chosen difficulty.
function make_player(player, p)
  if p.tech_level then player:set_tech_level(p.tech_level) end
  for _, tech in ipairs(p.research) do player:mark_research(tech) end
  -- Only the numbers the setup sets.
  for _, k in ipairs({ "ore", "rare_ore", "food", "workers", "scientists", "kids" }) do
    if p[k] then player[k] = p[k] end
  end
  for _, u in ipairs(p.units) do make_unit(player, u, u.at, p.kits, true) end
  -- As the setup draws them: the game's own MAP_RECT::RandPt.
  for _, u in ipairs(p.rolled or {}) do make_unit(player, u, game.rand_point(u.area), p.kits, true) end
  local start = p.starts and p.starts[game.rand(#p.starts) + 1]
  local s = p.start_area
  -- A start drawn in a row or a column draws only along it (CPS2: one GetRand(91) for x).
  local function along(lo, hi) return hi > lo and lo + game.rand(hi - lo + 1) or lo end
  if s then start = { along(s[1], s[3]), along(s[2], s[4]) } end
  local function place(t) return start and { start[1] + t[1], start[2] + t[2] } or t end
  -- The original asks for every unit of a kit on one tile; the game finds each a place nearby.
  for _, u in ipairs(p.kit or {}) do make_unit(player, u, place(u.at), p.kits, false) end
  -- A Structure Factory alike at every difficulty is the placement's; its bays are the difficulty's (Eden 1).
  if p.kits and not kits_set then
    local f = player:buildings("StructureFactory")[1]
    if f then
      for bay, kit in pairs(p.kits) do f:set_factory_cargo(bay, kit[1], kit[2]) end
    end
  end
  kits_set = false
  if p.view then player:center_view(place(p.view)) end
end

function make_walls(walls)
  for _, w in ipairs(walls) do
    if w[1] == "Tube" then game.create_tube(w[2]) else game.create_wall(w[1], w[2]) end
  end
end

function make_things(d)
  make_walls(d.walls)
  for _, b in ipairs(d.beacons) do game.create_beacon(b) end
end

local function copy(t)
  local c = {}
  for k, v in pairs(t) do c[k] = v end
  return c
end

-- The difficulty's units and beacons in the order the original makes them; `roll = k` rolls the k-th of `rolled`.
function make_in_order(d, rolled)
  for _, t in ipairs(d.made or {}) do
    if t.roll then
      roll_beacons({ rolled[t.roll] })
    elseif t.beacon then
      local b = copy(t)
      b.beacon = nil
      game.create_beacon(b)
    else
      make_unit(players[t.player], t, t.at, d.players[t.player] and d.players[t.player].kits, true)
    end
  end
end

function roll_beacons(rolled)
  for _, r in ipairs(rolled) do
    if r.table then
      -- As the setup draws them: an index into its table, again while it repeats one; all picks, then the beacons.
      local picks, seen = {}, {}
      while #picks < r.count do
        local v = game.rand(#r.table)
        if not seen[v] then seen[v] = true picks[#picks + 1] = v end
      end
      for i, v in ipairs(picks) do
        local b = copy(r.kinds[i])
        b.at = r.table[v + 1]
        game.create_beacon(b)
      end
    elseif r.spots then
      local spots = {}
      for i, s in ipairs(r.spots) do spots[i] = s end
      for i = 1, r.count do
        local b = copy(r.kinds[i])
        b.at = table.remove(spots, game.rand(#spots) + 1)
        game.create_beacon(b)
      end
    elseif r.area then
      local a, b = r.area, copy(r)
      b.area, b.draws, b.x_draw, b.base = nil, nil, nil, nil
      if r.draws then
        -- As the setup draws it: two numbers, one added to the base's x and the other to its y.
        local d = { game.rand(r.draws[1]), game.rand(r.draws[2]) }
        b.at = { r.base[1] + d[r.x_draw], r.base[2] + d[3 - r.x_draw] }
      else
        b.at = { a[1] + game.rand(a[3] - a[1] + 1), a[2] + game.rand(a[4] - a[2] + 1) }
      end
      game.create_beacon(b)
    else
      game.create_beacon(r.ways[game.rand(#r.ways) + 1])
    end
  end
end

-- Not converted (the list at the end says why); their triggers are made as the original makes them.
function CheckKits(t) end
function EnableFails(t) end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local EruptLava, EvacAgriKit, EvacCommandKit, EvacEWC, EvacFactKit, EvacFood, EvacLabKit, EvacMiners, EvacOre, EvacPeople, EvacSmelterKit, EvacSurveyors, EvacTokamakKit

function EruptLava(t)
  if players[1].difficulty == "Easy" then
    game.set_tile({ 53, 9 }, 1104)
    game.set_tile({ 54, 9 }, 1115)
    game.set_tile({ 53, 10 }, 1126)
    game.set_tile({ 54, 10 }, 1137)
    game.create_eruption({ 53, 10 }, 90)
  elseif players[1].difficulty == "Normal" then
    game.set_tile({ 53, 9 }, 1104)
    game.set_tile({ 54, 9 }, 1115)
    game.set_tile({ 53, 10 }, 1126)
    game.set_tile({ 54, 10 }, 1137)
    game.create_eruption({ 53, 10 }, 90)
  else
    game.set_tile({ 53, 9 }, 1104)
    game.set_tile({ 54, 9 }, 1115)
    game.set_tile({ 53, 10 }, 1126)
    game.set_tile({ 54, 10 }, 1137)
    game.create_eruption({ 53, 10 }, 110)
  end
end

local EvacAgriKit_done  -- EvacAgriKit does nothing more once it has acted
function EvacAgriKit(t)
  if EvacAgriKit_done then return end
  game.message_at("Agridome Kit evacuated successfully.", 0, 1, -1, -1)
  EvacAgriKit_done = true
end

local EvacCommandKit_done  -- EvacCommandKit does nothing more once it has acted
function EvacCommandKit(t)
  if EvacCommandKit_done then return end
  game.message_at("Command Center Kit evacuated successfully.", 0, 1, -1, -1)
  EvacCommandKit_done = true
end

local EvacEWC_done  -- EvacEWC does nothing more once it has acted
function EvacEWC(t)
  if EvacEWC_done then return end
  game.message_at("Earthworker evacuated successfully.", 0, 1, -1, -1)
  EvacEWC_done = true
end

local EvacFactKit_done  -- EvacFactKit does nothing more once it has acted
function EvacFactKit(t)
  if EvacFactKit_done then return end
  game.message_at("Structure Factory Kit evacuated successfully.", 0, 1, -1, -1)
  EvacFactKit_done = true
end

local EvacFood_done  -- EvacFood does nothing more once it has acted
function EvacFood(t)
  if EvacFood_done then return end
  game.message_at("Food evacuated successfully.", 0, 1, -1, -1)
  EvacFood_done = true
end

local EvacLabKit_done  -- EvacLabKit does nothing more once it has acted
function EvacLabKit(t)
  if EvacLabKit_done then return end
  game.message_at("Basic Lab Kit evacuated successfully.", 0, 1, -1, -1)
  EvacLabKit_done = true
end

local EvacMiners_done  -- EvacMiners does nothing more once it has acted
function EvacMiners(t)
  if EvacMiners_done then return end
  game.message_at("Robo-Miners evacuated successfully.", 0, 1, -1, -1)
  EvacMiners_done = true
end

local EvacOre_done  -- EvacOre does nothing more once it has acted
function EvacOre(t)
  if EvacOre_done then return end
  game.message_at("Metals evacuated successfully.", 0, 1, -1, -1)
  EvacOre_done = true
end

local EvacPeople_done  -- EvacPeople does nothing more once it has acted
function EvacPeople(t)
  if EvacPeople_done then return end
  game.message_at("Colonists evacuated successfully.", 0, 1, -1, -1)
  EvacPeople_done = true
end

local EvacSmelterKit_done  -- EvacSmelterKit does nothing more once it has acted
function EvacSmelterKit(t)
  if EvacSmelterKit_done then return end
  game.message_at("Smelter Kit evacuated successfully.", 0, 1, -1, -1)
  EvacSmelterKit_done = true
end

local EvacSurveyors_done  -- EvacSurveyors does nothing more once it has acted
function EvacSurveyors(t)
  if EvacSurveyors_done then return end
  game.message_at("Robo-Surveyors evacuated successfully.", 0, 1, -1, -1)
  EvacSurveyors_done = true
end

local EvacTokamakKit_done  -- EvacTokamakKit does nothing more once it has acted
function EvacTokamakKit(t)
  if EvacTokamakKit_done then return end
  game.message_at("Tokamak Kit evacuated successfully.", 0, 1, -1, -1)
  EvacTokamakKit_done = true
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  -- The setup's own map edits, after its units (and the draws it makes for them).
  game.initial_set_tile({ 53, 9 }, 1095)
  game.initial_set_tile({ 54, 9 }, 1107)
  game.initial_set_tile({ 53, 10 }, 1118)
  game.initial_set_tile({ 54, 10 }, 1129)
  game.set_daylight_everywhere(true)
  game.morale_steady("Terrible")
  for _, r in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(r) end

  -- The win.
  local t5 = trigger.escape{at = { x = 32, y = 0, raw = true }, width = 10, height = 25, type = "CargoTruck", count = 4, cargo = 1, amount = 4000, player = 1, on = EvacFood}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t5, "Evacuate 4000 units of food.")
  end
  local t6 = trigger.escape{at = { x = 32, y = 0, raw = true }, width = 10, height = 25, type = "CargoTruck", count = 4, cargo = 4, amount = 4000, player = 1, on = EvacOre}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t6, "Evacuate 4000 units of Common Metals.")
  end
  local t7 = trigger.escape{at = { x = 32, y = 0, raw = true }, width = 10, height = 25, type = "EvacuationTransport", count = 3, player = 1, on = EvacPeople}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t7, "Evacuate the colonists in the 3 Evacuation Transports.")
  end
  local t8 = trigger.escape{at = { x = 32, y = 0, raw = true }, width = 10, height = 25, type = "RoboMiner", count = 2, player = 1, on = EvacMiners}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t8, "Evacuate 2 Robo-Miners.")
  end
  local t9 = trigger.escape{at = { x = 32, y = 0, raw = true }, width = 10, height = 25, type = "RoboSurveyor", count = 2, player = 1, on = EvacSurveyors}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t9, "Evacuate 2 Robo-Surveyors.")
  end
  local t10 = trigger.escape{at = { x = 32, y = 0, raw = true }, width = 10, height = 25, type = "Earthworker", count = 1, player = 1, on = EvacEWC}
  local t18
  if difficulty == "Easy" then
    t18 = trigger.set{t5, t6, t7, t8, t9, t10}
  elseif difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t10, "Evacuate the Earthworker.")
  end
  local t11 = trigger.escape{at = { x = 32, y = 0, raw = true }, width = 10, height = 25, type = "ConVec", count = 1, cargo = 28, amount = 1, player = 1, on = EvacCommandKit}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t11, "Evacuate a Command Center kit.")
  end
  local t12 = trigger.escape{at = { x = 32, y = 0, raw = true }, width = 10, height = 25, type = "ConVec", count = 1, cargo = 54, amount = 1, player = 1, on = EvacSmelterKit}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t12, "Evacuate a Smelter kit.")
  end
  local t13 = trigger.escape{at = { x = 32, y = 0, raw = true }, width = 10, height = 25, type = "ConVec", count = 1, cargo = 39, amount = 1, player = 1, on = EvacAgriKit}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t13, "Evacuate an Agridome kit.")
  end
  local t14 = trigger.escape{at = { x = 32, y = 0, raw = true }, width = 10, height = 25, type = "ConVec", count = 1, cargo = 58, amount = 1, player = 1, on = EvacTokamakKit}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t14, "Evacuate a Tokamak kit.")
  end
  local t15 = trigger.escape{at = { x = 32, y = 0, raw = true }, width = 10, height = 25, type = "ConVec", count = 1, cargo = 47, amount = 1, player = 1, on = EvacFactKit}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t15, "Evacuate a Structure Factory kit.")
  end
  local t16 = trigger.escape{at = { x = 32, y = 0, raw = true }, width = 10, height = 25, type = "ConVec", count = 1, cargo = 33, amount = 1, player = 1, on = EvacLabKit}
  local t19, t20
  if difficulty == "Easy" then
    t19 = trigger.set{t11, t12, t13, t14, t15, t16}
    t20 = trigger.set{t18, t19}
    mission.victory(t20, "Move all units and their cargoes to the mining beacon northwest of our colony.")
  elseif difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t16, "Evacuate a Basic Lab kit.")
  end
  local t30 = trigger.vehicle_count{compare = "<", count = 22, player = 1, one_shot = true}
  mission.failure(t30)
  if difficulty == "Easy" then
    trigger.time{time = 2700, on = EruptLava}  -- after 27 marks
  elseif difficulty == "Normal" then
    trigger.time{time = 1800, on = EruptLava}  -- after 18 marks
  elseif difficulty == "Hard" then
    trigger.time{time = 900, on = EruptLava}  -- after 9 marks
  end
  trigger.time{time = 20, one_shot = false, on = CheckKits}  -- after 0 marks  -- CheckKits isn't converted
  trigger.building_count{compare = "==", count = 0, player = 1, one_shot = true, on = EnableFails}  -- EnableFails isn't converted
end

-- Not converted:
-- - CheckKits isn't converted: it calls Trigger::HasFired
-- - EnableFails isn't converted: a count trigger on a cargo
-- - 8 of the setup's triggers aren't converted yet (they call NoResponseToTrigger, CheckKits, EnableFails)
