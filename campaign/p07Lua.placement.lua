-- p07Lua.placement.lua  -  Plymouth Mission #7 (Lua)
-- Converted by op2dll from p07.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in p07Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Plymouth Mission #7 (Lua)", map = "PLY07.map", tech = "PLY_TEK.TXT",
  type = "7", max_tech = 7, players_count = 2,

  players = {
    [1] = { colony = "Plymouth", human = true, color = "Red" },
    [2] = { colony = "Eden", human = false, color = "Blue" },
  },

  units = {
  },

  walls = {
    { type = "Tube", at = { 93, 6 } },
    { type = "Tube", at = { 93, 7 } },
    { type = "Tube", at = { 93, 8 } },
    { type = "Tube", at = { 93, 9 } },
    { type = "Tube", at = { 95, 14 } },
    { type = "Tube", at = { 95, 15 } },
    { type = "Tube", at = { 95, 16 } },
    { type = "Tube", at = { 95, 17 } },
    { type = "Tube", at = { 97, 19 } },
    { type = "Tube", at = { 98, 11 } },
    { type = "Tube", at = { 98, 19 } },
    { type = "Tube", at = { 99, 11 } },
    { type = "Tube", at = { 99, 19 } },
    { type = "Tube", at = { 100, 11 } },
    { type = "Tube", at = { 101, 11 } },
    { type = "Tube", at = { 101, 21 } },
    { type = "Tube", at = { 101, 22 } },
    { type = "Tube", at = { 101, 23 } },
    { type = "Tube", at = { 101, 24 } },
    { type = "Tube", at = { 102, 11 } },
    { type = "Tube", at = { 102, 26 } },
    { type = "Tube", at = { 103, 11 } },
    { type = "Tube", at = { 103, 26 } },
    { type = "Tube", at = { 104, 10 } },
    { type = "Tube", at = { 104, 11 } },
    { type = "Tube", at = { 104, 12 } },
    { type = "Tube", at = { 104, 19 } },
    { type = "Tube", at = { 104, 26 } },
    { type = "Tube", at = { 105, 19 } },
    { type = "Tube", at = { 105, 26 } },
    { type = "Tube", at = { 106, 19 } },
    { type = "Tube", at = { 106, 26 } },
    { type = "Tube", at = { 107, 19 } },
    { type = "Tube", at = { 107, 26 } },
    { type = "Tube", at = { 108, 26 } },
    { type = "Tube", at = { 109, 21 } },
    { type = "Tube", at = { 109, 22 } },
    { type = "Tube", at = { 109, 23 } },
    { type = "Tube", at = { 109, 24 } },
  },

  beacons = {
  },
}
