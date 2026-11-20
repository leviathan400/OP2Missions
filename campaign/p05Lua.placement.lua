-- p05Lua.placement.lua  -  Plymouth Mission #5 (Lua)
-- Converted by op2dll from p05.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in p05Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Plymouth Mission #5 (Lua)", map = "ply05.map", tech = "PLY_TEK.TXT",
  type = "5", max_tech = 5, players_count = 2,

  players = {
    [1] = { colony = "Plymouth", human = true, color = "Red" },
    [2] = { colony = "Eden", human = false, color = "Blue" },
  },

  units = {
  },

  walls = {
    { type = "Tube", at = { 53, 30 } },
    { type = "Tube", at = { 54, 30 } },
    { type = "Tube", at = { 56, 28 } },
    { type = "Tube", at = { 56, 29 } },
    { type = "Tube", at = { 59, 25 } },
    { type = "Tube", at = { 60, 25 } },
    { type = "Tube", at = { 60, 31 } },
    { type = "Tube", at = { 61, 25 } },
    { type = "Tube", at = { 61, 31 } },
    { type = "Tube", at = { 62, 25 } },
    { type = "Tube", at = { 62, 31 } },
    { type = "Tube", at = { 63, 25 } },
    { type = "Tube", at = { 63, 26 } },
    { type = "Tube", at = { 63, 30 } },
    { type = "Tube", at = { 63, 31 } },
    { type = "Tube", at = { 63, 32 } },
    { type = "Tube", at = { 66, 28 } },
    { type = "Tube", at = { 67, 28 } },
    { type = "Tube", at = { 68, 28 } },
    { type = "Tube", at = { 68, 33 } },
    { type = "Tube", at = { 69, 27 } },
    { type = "Tube", at = { 69, 28 } },
    { type = "Tube", at = { 69, 29 } },
    { type = "Tube", at = { 69, 33 } },
    { type = "Tube", at = { 70, 33 } },
    { type = "Tube", at = { 72, 31 } },
    { type = "Tube", at = { 76, 29 } },
    { type = "Tube", at = { 76, 30 } },
    { type = "Tube", at = { 76, 31 } },
  },

  beacons = {
  },
}
