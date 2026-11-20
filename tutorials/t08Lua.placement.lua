-- t08Lua.placement.lua  -  Tutorial  8 - Research and Scientists (Lua)
-- Converted by op2dll from t08.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in t08Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Tutorial  8 - Research and Scientists (Lua)", map = "tutorial.map", tech = "TUTORTEK.TXT",
  type = "Tutorial", max_tech = 12, players_count = 2,

  players = {
    [1] = { colony = "Eden", human = true, color = "Blue" },
    [2] = { colony = "Plymouth", human = false, color = "Red" },
  },

  units = {
    -- Player 1
    { type = "CommandCenter", player = 1, at = { 40, 22 } },
    { type = "Agridome", player = 1, at = { 45, 22 } },
    { type = "Residence", player = 1, at = { 46, 18 } },
    { type = "StandardLab", player = 1, at = { 40, 18 } },
    { type = "MedicalCenter", player = 1, at = { 36, 18 } },
    { type = "University", player = 1, at = { 41, 14 } },
    { type = "Tokamak", player = 1, at = { 53, 10 } },
  },

  walls = {
    { type = "Tube", at = { 38, 18 } },
    { type = "Tube", at = { 40, 20 } },
    { type = "Tube", at = { 41, 16 } },
    { type = "Tube", at = { 43, 18 } },
    { type = "Tube", at = { 43, 22 } },
    { type = "Tube", at = { 44, 18 } },
    { type = "Tube", at = { 46, 20 } },
  },

  beacons = {
  },
}
