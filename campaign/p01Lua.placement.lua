-- p01Lua.placement.lua  -  Plymouth Mission #1 (Lua)
-- Converted by op2dll from p01.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in p01Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Plymouth Mission #1 (Lua)", map = "PLY01.map", tech = "PLY_TEK.TXT",
  type = "1", max_tech = 1, players_count = 1,

  players = {
    [1] = { colony = "Plymouth", human = true, color = "Red" },
  },

  units = {
  },

  walls = {
    { type = "Tube", at = { 36, 52 } },
    { type = "Tube", at = { 37, 51 } },
    { type = "Tube", at = { 38, 51 } },
    { type = "Tube", at = { 39, 52 } },
    { type = "Tube", at = { 40, 51 } },
    { type = "Tube", at = { 41, 51 } },
    { type = "Tube", at = { 43, 54 } },
    { type = "Tube", at = { 46, 52 } },
    { type = "Tube", at = { 49, 50 } },
    { type = "Tube", at = { 51, 52 } },
    { type = "Tube", at = { 51, 59 } },
    { type = "Tube", at = { 52, 47 } },
    { type = "Tube", at = { 52, 58 } },
    { type = "Tube", at = { 53, 47 } },
    { type = "Tube", at = { 53, 58 } },
    { type = "Tube", at = { 54, 51 } },
    { type = "Tube", at = { 54, 56 } },
    { type = "Tube", at = { 54, 59 } },
    { type = "Tube", at = { 55, 58 } },
    { type = "Tube", at = { 56, 58 } },
    { type = "Tube", at = { 57, 49 } },
    { type = "Tube", at = { 57, 58 } },
    { type = "Tube", at = { 58, 49 } },
    { type = "Tube", at = { 59, 49 } },
    { type = "Tube", at = { 59, 50 } },
  },

  beacons = {
  },
}
