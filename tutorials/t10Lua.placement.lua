-- t10Lua.placement.lua  -  Tutorial 10 - Morale (Lua)
-- Converted by op2dll from t10.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in t10Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Tutorial 10 - Morale (Lua)", map = "tutorial.map", tech = "TUTORTEK.TXT",
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
    { type = "StandardLab", player = 1, at = { 40, 19 } },
    { type = "CommonStorage", player = 1, at = { 35, 32 } },
    { type = "CommonStorage", player = 1, at = { 32, 32 } },
    { type = "Tokamak", player = 1, at = { 53, 11 } },
    { type = "ConVec", direction = "East", player = 1, at = { 44, 28 } },
    { type = "ConVec", direction = "East", player = 1, at = { 45, 26 } },
    { type = "Earthworker", direction = "East", player = 1, at = { 47, 27 } },
  },

  walls = {
    { type = "Tube", at = { 32, 33 } },
    { type = "Tube", at = { 33, 32 } },
    { type = "Tube", at = { 34, 32 } },
    { type = "Tube", at = { 35, 33 } },
    { type = "Tube", at = { 36, 32 } },
    { type = "Tube", at = { 37, 32 } },
    { type = "Tube", at = { 38, 32 } },
    { type = "Tube", at = { 39, 32 } },
    { type = "Tube", at = { 40, 25 } },
    { type = "Tube", at = { 40, 30 } },
    { type = "Tube", at = { 40, 31 } },
    { type = "Tube", at = { 40, 32 } },
    { type = "Tube", at = { 43, 23 } },
  },

  beacons = {
  },
}
