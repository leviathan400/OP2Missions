-- p12Lua.placement.lua  -  Plymouth Mission #12 (Lua)
-- Converted by op2dll from p12.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in p12Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Plymouth Mission #12 (Lua)", map = "PLY12.map", tech = "PLY_TEK.TXT",
  type = "12", max_tech = 12, players_count = 3,

  players = {
    [1] = { colony = "Plymouth", human = true, color = "Red" },
    [2] = { colony = "Eden", human = false, color = "Blue" },
    [3] = { colony = "Eden", human = false, color = "Green" },
  },

  units = {
  },

  walls = {
  },

  beacons = {
  },
}
