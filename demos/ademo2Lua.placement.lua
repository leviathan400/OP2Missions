-- ademo2Lua.placement.lua  -  AutoDemo Mission #2 (Lua)
-- Converted by op2dll from ademo2.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in ademo2Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "AutoDemo Mission #2 (Lua)", map = "eden04.map", tech = "PLY_TEK.TXT",
  type = "AutoDemo", max_tech = 8, players_count = 3,

  players = {
    [1] = { colony = "Plymouth", human = true, color = "Blue" },
    [2] = { colony = "Eden", human = false, color = "Red" },
    [3] = { colony = "Plymouth", human = false, color = "Green" },
  },

  units = {
  },

  walls = {
  },

  beacons = {
  },
}
