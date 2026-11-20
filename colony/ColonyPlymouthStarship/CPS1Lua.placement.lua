-- CPS1Lua.placement.lua  -  Colony Builder - Plymouth, Starship (Lua)
-- Converted by op2dll from CPS1.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in CPS1Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Colony Builder - Plymouth, Starship (Lua)", map = "cm01.map", tech = "MULTITEK.TXT",
  type = "Colony", max_tech = 12, players_count = 2,

  players = {
    [1] = { colony = "Plymouth", human = true, color = "Red" },
    [2] = { colony = "Eden", human = false, color = "Blue" },
  },

  units = {
  },

  walls = {
  },

  beacons = {
  },
}
