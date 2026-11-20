-- p02Lua.placement.lua  -  Plymouth Mission #2 (Lua)
-- Converted by op2dll from p02.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in p02Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Plymouth Mission #2 (Lua)", map = "PLY02.map", tech = "PLY_TEK.TXT",
  type = "2", max_tech = 2, players_count = 1,

  players = {
    [1] = { colony = "Plymouth", human = true, color = "Red" },
  },

  units = {
  },

  walls = {
  },

  beacons = {
  },
}
