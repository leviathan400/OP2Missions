-- t03Lua.placement.lua  -  Tutorial  3 - Reports and Information (Lua)
-- Converted by op2dll from t03.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in t03Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Tutorial  3 - Reports and Information (Lua)", map = "tutorial.map", tech = "TUTORTEK.TXT",
  type = "Tutorial", max_tech = 12, players_count = 2,

  players = {
    [1] = { colony = "Eden", human = true, color = "Blue" },
    [2] = { colony = "Plymouth", human = false, color = "Red" },
  },

  units = {
    -- Player 1
    { type = "CommandCenter", player = 1, at = { 40, 23 } },
    { type = "StructureFactory", player = 1, at = { 40, 27 } },
    { type = "CommonOreSmelter", player = 1, at = { 40, 32 } },
    { type = "BasicLab", player = 1, at = { 36, 23 } },
    { type = "Agridome", player = 1, at = { 45, 23 } },
    { type = "Residence", player = 1, at = { 46, 19 } },
    { type = "Tokamak", player = 1, at = { 54, 10 } },
    { type = "CommonOreMine", player = 1, at = { 58, 36 } },
  },

  walls = {
    { type = "Tube", at = { 38, 23 } },
    { type = "Tube", at = { 40, 25 } },
    { type = "Tube", at = { 40, 30 } },
    { type = "Tube", at = { 43, 23 } },
    { type = "Tube", at = { 46, 21 } },
  },

  beacons = {
    { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 58, 36 }, after = 7 },
  },
}
