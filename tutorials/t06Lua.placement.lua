-- t06Lua.placement.lua  -  Tutorial  6 - Docking (Lua)
-- Converted by op2dll from t06.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in t06Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Tutorial  6 - Docking (Lua)", map = "tutorial.map", tech = "TUTORTEK.TXT",
  type = "Tutorial", max_tech = 12, players_count = 2,

  players = {
    [1] = { colony = "Eden", human = true, color = "Blue" },
    [2] = { colony = "Plymouth", human = false, color = "Red" },
  },

  units = {
    -- Player 1
    { type = "CommonOreMine", player = 1, at = { 58, 36 } },
    { type = "CommonOreSmelter", player = 1, at = { 40, 32 } },
    { type = "CommonStorage", player = 1, at = { 35, 33 } },
    { type = "Garage", player = 1, at = { 35, 37 } },
    { type = "StructureFactory", player = 1, at = { 40, 27 } },
    { type = "CommandCenter", player = 1, at = { 40, 23 } },
    { type = "Agridome", player = 1, at = { 45, 23 } },
    { type = "Tokamak", player = 1, at = { 52, 11 } },
    { type = "CargoTruck", direction = "East", player = 1, at = { 45, 28 } },
    { type = "CargoTruck", direction = "East", player = 1, at = { 46, 26 } },
    { type = "CargoTruck", direction = "East", player = 1, at = { 48, 25 } },
    { type = "ConVec", direction = "East", player = 1, at = { 49, 27 } },
    { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 51, 26 } },
    { type = "EvacuationTransport", weapon = "Agridome", direction = "East", player = 1, at = { 48, 29 } },
    { type = "EvacuationTransport", direction = "East", player = 1, at = { 50, 30 } },
  },

  walls = {
    { type = "Tube", at = { 35, 34 } },
    { type = "Tube", at = { 35, 35 } },
    { type = "Tube", at = { 35, 38 } },
    { type = "Tube", at = { 36, 33 } },
    { type = "Tube", at = { 37, 33 } },
    { type = "Tube", at = { 40, 25 } },
    { type = "Tube", at = { 40, 30 } },
    { type = "Tube", at = { 43, 23 } },
  },

  beacons = {
    { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 58, 36 } },
  },
}
