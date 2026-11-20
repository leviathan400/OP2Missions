-- e03Lua.placement.lua  -  Eden Mission #3 (Lua)
-- Converted by op2dll from e03.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in e03Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Eden Mission #3 (Lua)", map = "eden03.map", tech = "EDENTEK.TXT",
  type = "3", max_tech = 3, players_count = 1,

  players = {
    [1] = { colony = "Eden", human = true, color = "Blue" },
  },

  units = {
  },

  walls = {
    { type = "Tube", at = { 56, 29 } },
    { type = "Tube", at = { 57, 29 } },
    { type = "Tube", at = { 58, 29 } },
    { type = "Tube", at = { 59, 29 } },
    { type = "Tube", at = { 61, 27 } },
    { type = "Tube", at = { 61, 31 } },
    { type = "Tube", at = { 61, 32 } },
    { type = "Tube", at = { 61, 33 } },
    { type = "Tube", at = { 61, 34 } },
    { type = "Tube", at = { 64, 29 } },
    { type = "Tube", at = { 64, 36 } },
    { type = "Tube", at = { 65, 29 } },
    { type = "Tube", at = { 65, 36 } },
    { type = "Tube", at = { 66, 29 } },
    { type = "Tube", at = { 66, 36 } },
    { type = "Tube", at = { 67, 29 } },
    { type = "Tube", at = { 67, 36 } },
  },

  beacons = {
  },
}
