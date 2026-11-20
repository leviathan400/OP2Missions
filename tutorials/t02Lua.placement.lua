-- t02Lua.placement.lua  -  Tutorial  2 - Basic Vehicle Commands (Lua)
-- Converted by op2dll from t02.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in t02Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Tutorial  2 - Basic Vehicle Commands (Lua)", map = "tutorial.map", tech = "TUTORTEK.TXT",
  type = "Tutorial", max_tech = 12, players_count = 2,

  players = {
    [1] = { colony = "Eden", human = true, color = "Blue" },
    [2] = { colony = "Plymouth", human = false, color = "Red" },
  },

  units = {
    -- Player 1
    { type = "CargoTruck", direction = "East", player = 1, at = { 35, 27 } },
    { type = "CargoTruck", direction = "East", player = 1, at = { 39, 27 } },
    { type = "CargoTruck", direction = "East", player = 1, at = { 43, 27 } },
    { type = "Scout", direction = "East", player = 1, at = { 30, 19 } },
    { type = "RoboDozer", direction = "East", player = 1, at = { 39, 15 } },
  },

  walls = {
  },

  beacons = {
  },
}
