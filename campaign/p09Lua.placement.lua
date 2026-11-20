-- p09Lua.placement.lua  -  Plymouth Mission #9 (Lua)
-- Converted by op2dll from p09.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in p09Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Plymouth Mission #9 (Lua)", map = "PLY09.map", tech = "PLY_TEK.TXT",
  type = "9", max_tech = 9, players_count = 2,

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
