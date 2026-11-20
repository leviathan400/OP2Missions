-- CPS2Lua.placement.lua  -  Colony Builder II - Plymouth, Starship (Lua)
-- Converted by op2dll from CPS2.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in CPS2Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Colony Builder II - Plymouth, Starship (Lua)", map = "on1_01.map", tech = "MULTITEK.TXT",
  type = "Colony", max_tech = 12, players_count = 2,

  players = {
    [1] = { colony = "Plymouth", human = true, color = "Red" },
    [2] = { colony = "Eden", human = false, color = "Blue" },
  },

  units = {
  },

  walls = {
    { type = "Tube", at = { 233, 51 } },
    { type = "Tube", at = { 234, 51 } },
    { type = "Tube", at = { 235, 51 } },
    { type = "Tube", at = { 236, 51 } },
  },

  beacons = {
  },
}
