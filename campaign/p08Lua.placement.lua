-- p08Lua.placement.lua  -  Plymouth Mission #8 (Lua)
-- Converted by op2dll from p08.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in p08Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Plymouth Mission #8 (Lua)", map = "ply08.map", tech = "PLY_TEK.TXT",
  type = "8", max_tech = 8, players_count = 2,

  players = {
    [1] = { colony = "Plymouth", human = true, color = "Red" },
    [2] = { colony = "Eden", human = false, color = "Blue" },
  },

  units = {
  },

  walls = {
    { type = "Tube", at = { 98, 27 } },
    { type = "Tube", at = { 98, 28 } },
    { type = "Tube", at = { 98, 29 } },
    { type = "Tube", at = { 98, 30 } },
    { type = "Tube", at = { 98, 31 } },
    { type = "Tube", at = { 99, 31 } },
    { type = "Tube", at = { 100, 31 } },
    { type = "Tube", at = { 100, 41 } },
    { type = "Tube", at = { 101, 31 } },
    { type = "Tube", at = { 101, 41 } },
    { type = "Tube", at = { 102, 31 } },
    { type = "Tube", at = { 102, 41 } },
    { type = "Tube", at = { 103, 41 } },
    { type = "Tube", at = { 104, 34 } },
    { type = "Tube", at = { 104, 35 } },
    { type = "Tube", at = { 104, 36 } },
    { type = "Tube", at = { 104, 37 } },
    { type = "Tube", at = { 104, 38 } },
    { type = "Tube", at = { 104, 39 } },
    { type = "Tube", at = { 104, 40 } },
    { type = "Tube", at = { 104, 41 } },
    { type = "Tube", at = { 105, 41 } },
    { type = "Tube", at = { 106, 41 } },
    { type = "Tube", at = { 107, 32 } },
    { type = "Tube", at = { 107, 41 } },
    { type = "Tube", at = { 108, 32 } },
    { type = "Tube", at = { 108, 41 } },
    { type = "Tube", at = { 109, 32 } },
    { type = "Tube", at = { 109, 41 } },
    { type = "Tube", at = { 110, 32 } },
    { type = "Tube", at = { 110, 41 } },
    { type = "Tube", at = { 111, 32 } },
    { type = "Tube", at = { 111, 41 } },
    { type = "Tube", at = { 112, 23 } },
    { type = "Tube", at = { 112, 24 } },
    { type = "Tube", at = { 112, 25 } },
    { type = "Tube", at = { 112, 26 } },
    { type = "Tube", at = { 112, 27 } },
    { type = "Tube", at = { 112, 28 } },
    { type = "Tube", at = { 112, 29 } },
    { type = "Tube", at = { 112, 30 } },
    { type = "Tube", at = { 112, 31 } },
    { type = "Tube", at = { 112, 32 } },
    { type = "Tube", at = { 112, 33 } },
    { type = "Tube", at = { 112, 34 } },
    { type = "Tube", at = { 112, 35 } },
    { type = "Tube", at = { 112, 36 } },
    { type = "Tube", at = { 112, 41 } },
    { type = "Tube", at = { 113, 31 } },
    { type = "Tube", at = { 113, 41 } },
  },

  beacons = {
  },
}
