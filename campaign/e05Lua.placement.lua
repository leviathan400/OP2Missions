-- e05Lua.placement.lua  -  Eden Mission #5 (Lua)
-- Converted by op2dll from e05.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in e05Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Eden Mission #5 (Lua)", map = "eden05.map", tech = "EDENTEK.TXT",
  type = "5", max_tech = 5, players_count = 2,

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
