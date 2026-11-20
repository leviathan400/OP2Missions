-- t12Lua.placement.lua  -  Tutorial 12 - Spaceport (Lua)
-- Converted by op2dll from t12.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in t12Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Tutorial 12 - Spaceport (Lua)", map = "tutorial.map", tech = "TUTORTEK.TXT",
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
    { type = "Spaceport", player = 1, at = { 51, 23 } },
    { type = "CommonStorage", player = 1, at = { 56, 24 } },
    { type = "RareStorage", player = 1, at = { 59, 24 } },
    { type = "Tokamak", player = 1, at = { 52, 11 } },
    { type = "CargoTruck", direction = "East", cargo = "Spacecraft", amount = 91, player = 1, at = { 45, 27 } },
  },

  walls = {
    { type = "Tube", at = { 43, 23 } },
    { type = "Tube", at = { 46, 21 } },
    { type = "Tube", at = { 48, 23 } },
    { type = "Tube", at = { 55, 23 } },
    { type = "Tube", at = { 56, 25 } },
    { type = "Tube", at = { 57, 24 } },
    { type = "Tube", at = { 58, 24 } },
    { type = "Tube", at = { 59, 25 } },
    { type = "Tube", at = { 60, 24 } },
  },

  beacons = {
  },
}
