-- t01Lua.placement.lua  -  Tutorial  1 - Navigating the Map (Lua)
-- Converted by op2dll from t01.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in t01Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Tutorial  1 - Navigating the Map (Lua)", map = "tutorial.map", tech = "TUTORTEK.TXT",
  type = "Tutorial", max_tech = 12, players_count = 2,

  players = {
    [1] = { colony = "Eden", human = true, color = "Blue" },
    [2] = { colony = "Plymouth", human = false, color = "Red" },
  },

  units = {
    -- Player 1
    { type = "Tokamak", player = 1, at = { 34, 26 } },
    { type = "CommonOreMine", player = 1, at = { 51, 35 } },
    { type = "LightTower", player = 1, at = { 5, 38 } },
  },

  walls = {
  },

  beacons = {
    { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 51, 35 }, after = 1 },
  },
}
