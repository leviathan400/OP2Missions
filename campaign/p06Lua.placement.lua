-- p06Lua.placement.lua  -  Plymouth Mission #6 (Lua)
-- Converted by op2dll from p06.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in p06Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Plymouth Mission #6 (Lua)", map = "PLY06.map", tech = "PLY_TEK.TXT",
  type = "6", max_tech = 6, players_count = 2,

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
