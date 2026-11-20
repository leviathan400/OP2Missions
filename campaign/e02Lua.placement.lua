-- e02Lua.placement.lua  -  Eden Mission #2 (Lua)
-- Converted by op2dll from e02.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in e02Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Eden Mission #2 (Lua)", map = "eden02.map", tech = "EDENTEK.TXT",
  type = "2", max_tech = 2, players_count = 1,

  players = {
    [1] = { colony = "Eden", human = true, color = "Blue" },
  },

  units = {
    -- Player 1
    { type = "CommandCenter", player = 1, at = { 56, 28 } },
    { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 55, 28 } },
    { type = "EvacuationTransport", direction = "NorthEast", player = 1, at = { 55, 30 } },
    { type = "EvacuationTransport", direction = "NorthWest", player = 1, at = { 57, 29 } },
    { type = "ConVec", direction = "West", player = 1, at = { 62, 25 } },
  },

  walls = {
  },

  beacons = {
  },
}
