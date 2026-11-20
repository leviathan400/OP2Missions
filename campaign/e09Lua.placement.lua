-- e09Lua.placement.lua  -  Eden Mission #9 (Lua)
-- Converted by op2dll from e09.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in e09Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Eden Mission #9 (Lua)", map = "eden09.map", tech = "EDENTEK.TXT",
  type = "9", max_tech = 9, players_count = 2,

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
