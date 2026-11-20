-- e06Lua.placement.lua  -  Eden Mission #6 (Lua)
-- Converted by op2dll from e06.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in e06Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Eden Mission #6 (Lua)", map = "eden06.map", tech = "EDENTEK.TXT",
  type = "6", max_tech = 6, players_count = 2,

  players = {
    [1] = { colony = "Eden", human = true, color = "Blue" },
    [2] = { colony = "Plymouth", human = false, color = "Red" },
  },

  units = {
  },

  walls = {
  },

  beacons = {
  },
}
