-- ademo3Lua.placement.lua  -  AutoDemo Mission #3 (Lua)
-- Converted by op2dll from ademo3.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in ademo3Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "AutoDemo Mission #3 (Lua)", map = "eden04.map", tech = "PLY_TEK.TXT",
  type = "AutoDemo", max_tech = 8, players_count = 3,

  players = {
    [1] = { colony = "Plymouth", human = true, color = "Blue" },
    [2] = { colony = "Eden", human = false, color = "Red" },
    [3] = { colony = "Plymouth", human = false, color = "Green" },
  },

  units = {
    -- Player 3
    { type = "CommandCenter", player = 3, at = { 42, 44 } },
    { type = "AdvancedLab", player = 3, at = { 42, 48 } },
    { type = "MHDGenerator", player = 3, at = { 36, 53 } },
    { type = "CommonStorage", player = 3, at = { 45, 44 } },
    { type = "RareStorage", player = 3, at = { 47, 44 } },
    { type = "GuardPost", weapon = "RPG", player = 3, at = { 31, 50 } },
    { type = "GuardPost", weapon = "RPG", player = 3, at = { 31, 46 } },
    { type = "GuardPost", weapon = "EMP", player = 3, at = { 37, 40 } },
    { type = "GuardPost", weapon = "RPG", player = 3, at = { 42, 40 } },
    { type = "GuardPost", weapon = "RPG", player = 3, at = { 39, 53 } },
    { type = "GuardPost", weapon = "RPG", player = 3, at = { 42, 53 } },
    { name = "spaceport", type = "Spaceport", player = 3, at = { 36, 47 } },
  },

  walls = {
    { type = "Tube", at = { 40, 44 } },
    { type = "Tube", at = { 40, 47 } },
    { type = "Tube", at = { 42, 46 } },
  },

  beacons = {
  },
}
