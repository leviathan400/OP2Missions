-- t04Lua.placement.lua  -  Tutorial  4 - Combat Vehicles and Structures (Lua)
-- Converted by op2dll from t04.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in t04Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Tutorial  4 - Combat Vehicles and Structures (Lua)", map = "tutorial.map", tech = "TUTORTEK.TXT",
  type = "Tutorial", max_tech = 12, players_count = 2,

  players = {
    [1] = { colony = "Eden", human = true, color = "Blue" },
    [2] = { colony = "Plymouth", human = false, color = "Red" },
  },

  units = {
    -- Player 1
    { type = "CommandCenter", player = 1, at = { 40, 23 } },
    { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 44, 28 } },
    { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 47, 28 } },
    { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 49, 26 } },
    { type = "GuardPost", weapon = "Laser", player = 1, at = { 41, 27 } },
    { type = "GuardPost", weapon = "Laser", player = 1, at = { 45, 23 } },
    -- Player 2
    { type = "CargoTruck", direction = "East", player = 2, at = { 51, 36 } },
    { type = "CargoTruck", direction = "East", player = 2, at = { 55, 36 } },
  },

  walls = {
  },

  beacons = {
  },
}
