-- t07Lua.placement.lua  -  Tutorial  7 - Mining Vehicles and Structures (Lua)
-- Converted by op2dll from t07.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in t07Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Tutorial  7 - Mining Vehicles and Structures (Lua)", map = "tutorial.map", tech = "TUTORTEK.TXT",
  type = "Tutorial", max_tech = 12, players_count = 2,

  players = {
    [1] = { colony = "Eden", human = true, color = "Blue" },
    [2] = { colony = "Plymouth", human = false, color = "Red" },
  },

  units = {
    -- Player 1
    { type = "CommandCenter", player = 1, at = { 40, 23 } },
    { type = "Agridome", player = 1, at = { 45, 23 } },
    { type = "Residence", player = 1, at = { 46, 19 } },
    { type = "CommonOreSmelter", player = 1, at = { 40, 32 } },
    { type = "Tokamak", player = 1, at = { 52, 11 } },
    { type = "CargoTruck", direction = "East", player = 1, at = { 45, 28 } },
    { type = "CargoTruck", direction = "East", player = 1, at = { 47, 27 } },
    { type = "CargoTruck", direction = "East", player = 1, at = { 49, 28 } },
    { type = "RoboSurveyor", direction = "East", player = 1, at = { 48, 25 } },
    { type = "RoboMiner", direction = "East", player = 1, at = { 50, 26 } },
    { type = "RoboMiner", direction = "East", player = 1, at = { 51, 24 } },
  },

  walls = {
    { type = "Tube", at = { 40, 25 } },
    { type = "Tube", at = { 40, 26 } },
    { type = "Tube", at = { 40, 27 } },
    { type = "Tube", at = { 40, 28 } },
    { type = "Tube", at = { 40, 29 } },
    { type = "Tube", at = { 40, 30 } },
    { type = "Tube", at = { 43, 23 } },
    { type = "Tube", at = { 46, 21 } },
  },

  beacons = {
    { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 54, 32 } },
    { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 43, 41 } },
  },
}
