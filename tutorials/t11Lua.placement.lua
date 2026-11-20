-- t11Lua.placement.lua  -  Tutorial 11 - Colony Control (Lua)
-- Converted by op2dll from t11.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in t11Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Tutorial 11 - Colony Control (Lua)", map = "tutorial.map", tech = "TUTORTEK.TXT",
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
    { type = "VehicleFactory", player = 1, at = { 46, 32 } },
    { type = "Agridome", player = 1, at = { 45, 23 } },
    { type = "Agridome", player = 1, at = { 50, 23 } },
    { type = "Residence", player = 1, at = { 46, 19 } },
    { type = "Residence", player = 1, at = { 46, 16 } },
    { type = "Residence", player = 1, at = { 51, 19 } },
    { type = "MedicalCenter", player = 1, at = { 36, 19 } },
    { type = "Nursery", player = 1, at = { 36, 15 } },
    { type = "University", player = 1, at = { 40, 15 } },
    { type = "StandardLab", player = 1, at = { 40, 19 } },
    { type = "CommandCenter", player = 1, at = { 12, 50 } },
    { type = "CommonOreSmelter", player = 1, at = { 18, 49 } },
    { type = "Tokamak", player = 1, at = { 53, 11 } },
    { type = "ConVec", direction = "East", player = 1, at = { 45, 28 } },
    { type = "ConVec", direction = "East", player = 1, at = { 47, 27 } },
  },

  walls = {
    { type = "Tube", at = { 15, 50 } },
    { type = "Tube", at = { 36, 17 } },
    { type = "Tube", at = { 36, 21 } },
    { type = "Tube", at = { 36, 22 } },
    { type = "Tube", at = { 37, 22 } },
    { type = "Tube", at = { 38, 15 } },
    { type = "Tube", at = { 38, 19 } },
    { type = "Tube", at = { 38, 22 } },
    { type = "Tube", at = { 40, 17 } },
    { type = "Tube", at = { 40, 21 } },
    { type = "Tube", at = { 40, 25 } },
    { type = "Tube", at = { 40, 30 } },
    { type = "Tube", at = { 43, 19 } },
    { type = "Tube", at = { 43, 23 } },
    { type = "Tube", at = { 43, 32 } },
    { type = "Tube", at = { 44, 19 } },
    { type = "Tube", at = { 46, 21 } },
    { type = "Tube", at = { 48, 19 } },
    { type = "Tube", at = { 49, 19 } },
  },

  beacons = {
  },
}
