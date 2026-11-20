-- mu6_41Lua.placement.lua  -  6 Player, LandRush, 'Fractures' map. (Lua)
-- Converted by op2dll from mu6_41.dll. It makes nothing: the beacons and each player's kit are made by on_init
-- (mu6_41Lua.lua), in the original's order. No
-- `players` table: in a multiplayer game the lobby sets each player's colony and colour.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "6 Player, LandRush, 'Fractures' map. (Lua)", map = "on6_04.map", tech = "MULTITEK.TXT",
  type = "MultiLandRush", max_tech = 12, players_count = 6,

  walls = {
  },

  beacons = {
  },
}
