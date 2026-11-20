-- e07Lua.placement.lua  -  Eden Mission #7 (Lua)
-- Converted by op2dll from e07.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in e07Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Eden Mission #7 (Lua)", map = "eden07.map", tech = "EDENTEK.TXT",
  type = "7", max_tech = 7, players_count = 2,

  players = {
    [1] = { colony = "Eden", human = true, color = "Blue" },
    [2] = { colony = "Plymouth", human = false, color = "Red" },
  },

  units = {
  },

  walls = {
    { type = "Tube", at = { 56, 36 } },
    { type = "Tube", at = { 62, 36 } },
    { type = "Tube", at = { 63, 36 } },
    { type = "Tube", at = { 64, 36 } },
    { type = "Tube", at = { 66, 38 } },
    { type = "Tube", at = { 66, 39 } },
    { type = "Tube", at = { 66, 40 } },
    { type = "Tube", at = { 67, 33 } },
    { type = "Tube", at = { 67, 34 } },
    { type = "Tube", at = { 70, 30 } },
  },

  beacons = {
  },
}
