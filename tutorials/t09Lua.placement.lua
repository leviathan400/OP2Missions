-- t09Lua.placement.lua  -  Tutorial  9 - Construction (Lua)
-- Converted by op2dll from t09.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in t09Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Tutorial  9 - Construction (Lua)", map = "tutorial.map", tech = "TUTORTEK.TXT",
  type = "Tutorial", max_tech = 12, players_count = 2,

  players = {
    [1] = { colony = "Eden", human = true, color = "Blue" },
    [2] = { colony = "Plymouth", human = false, color = "Red" },
  },

  units = {
    -- Player 1
    { type = "CommandCenter", player = 1, at = { 40, 23 } },
    { type = "StructureFactory", player = 1, at = { 40, 27 } },
    { type = "Agridome", player = 1, at = { 45, 23 } },
    { type = "Residence", player = 1, at = { 46, 19 } },
    { type = "BasicLab", player = 1, at = { 34, 23 } },
    { type = "Residence", player = 1, at = { 50, 19 } },
    { type = "Tokamak", player = 1, at = { 53, 11 } },
    { type = "CommonStorage", player = 1, at = { 42, 27 } },
    { type = "ConVec", direction = "East", player = 1, at = { 45, 28 } },
    { type = "ConVec", direction = "East", player = 1, at = { 47, 27 } },
    { type = "GeoCon", direction = "East", player = 1, at = { 46, 25 } },
    { type = "RoboDozer", direction = "East", player = 1, at = { 48, 24 } },
    { type = "Earthworker", direction = "East", player = 1, at = { 49, 26 } },
  },

  walls = {
    { type = "Tube", at = { 40, 25 } },
    { type = "Tube", at = { 43, 23 } },
    { type = "Tube", at = { 46, 21 } },
    { type = "Tube", at = { 48, 19 } },
  },

  beacons = {
    { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 51, 34 }, after = 13 },
  },
}
