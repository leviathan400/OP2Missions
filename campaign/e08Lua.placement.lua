-- e08Lua.placement.lua  -  Eden Mission #8 (Lua)
-- Converted by op2dll from e08.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in e08Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Eden Mission #8 (Lua)", map = "eden08.map", tech = "EDENTEK.TXT",
  type = "8", max_tech = 8, players_count = 2,

  players = {
    [1] = { colony = "Eden", human = true, color = "Blue" },
    [2] = { colony = "Plymouth", human = false, color = "Red" },
  },

  units = {
  },

  walls = {
    { type = "Tube", at = { 20, 69 } },
    { type = "Tube", at = { 23, 66 } },
    { type = "Tube", at = { 24, 66 } },
    { type = "Tube", at = { 25, 66 } },
    { type = "Tube", at = { 27, 62 } },
    { type = "Tube", at = { 27, 63 } },
    { type = "Tube", at = { 27, 64 } },
    { type = "Tube", at = { 30, 60 } },
    { type = "Tube", at = { 31, 60 } },
    { type = "Tube", at = { 31, 66 } },
  },

  beacons = {
  },
}
