-- e01Lua.placement.lua  -  Eden Mission #1 (Lua)
-- Converted by op2dll from e01.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in e01Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Eden Mission #1 (Lua)", map = "eden01.map", tech = "EDENTEK.TXT",
  type = "1", max_tech = 1, players_count = 1,

  players = {
    [1] = { colony = "Eden", human = true, color = "Blue" },
  },

  units = {
    -- Player 1
    { type = "AdvancedLab", player = 1, at = { 4, 4 } },
    { type = "CommonOreSmelter", player = 1, at = { 4, 13 } },
    { type = "CommonStorage", player = 1, at = { 8, 14 } },
    { type = "Residence", player = 1, at = { 13, 8 } },
    { type = "CommandCenter", player = 1, at = { 18, 14 } },
    { type = "Garage", player = 1, at = { 9, 18 } },
    { type = "StructureFactory", player = 1, at = { 15, 19 } },
    { type = "Agridome", player = 1, at = { 11, 23 } },
    { type = "Residence", player = 1, at = { 7, 25 } },
    { type = "Tokamak", player = 1, at = { 3, 30 } },
    { type = "Agridome", player = 1, at = { 17, 27 } },
  },

  walls = {
    { type = "Tube", at = { 1, 4 } },
    { type = "Tube", at = { 1, 13 } },
    { type = "Tube", at = { 2, 4 } },
    { type = "Tube", at = { 4, 1 } },
    { type = "Tube", at = { 4, 2 } },
    { type = "Tube", at = { 4, 10 } },
    { type = "Tube", at = { 4, 11 } },
    { type = "Tube", at = { 7, 13 } },
    { type = "Tube", at = { 8, 15 } },
    { type = "Tube", at = { 9, 14 } },
    { type = "Tube", at = { 9, 25 } },
    { type = "Tube", at = { 10, 25 } },
    { type = "Tube", at = { 11, 25 } },
    { type = "Tube", at = { 12, 18 } },
    { type = "Tube", at = { 14, 23 } },
    { type = "Tube", at = { 15, 22 } },
    { type = "Tube", at = { 15, 23 } },
    { type = "Tube", at = { 18, 10 } },
    { type = "Tube", at = { 18, 11 } },
    { type = "Tube", at = { 18, 12 } },
    { type = "Tube", at = { 18, 16 } },
    { type = "Tube", at = { 18, 17 } },
    { type = "Tube", at = { 18, 18 } },
    { type = "Tube", at = { 18, 19 } },
  },

  beacons = {
  },
}
