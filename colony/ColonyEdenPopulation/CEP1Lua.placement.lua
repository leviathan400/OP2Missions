-- CEP1Lua.placement.lua  -  Colony Builder - Eden, Population (Lua)
-- Converted by op2dll from CEP1.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in CEP1Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Colony Builder - Eden, Population (Lua)", map = "cm02.map", tech = "MULTITEK.TXT",
  type = "Colony", max_tech = 12, players_count = 2,

  players = {
    [1] = { colony = "Eden", human = true, color = "Blue" },
    [2] = { colony = "Plymouth", human = false, color = "Red" },
  },

  units = {
  },

  walls = {
    { type = "Tube", at = { 30, 53 } },
    { type = "Tube", at = { 31, 53 } },
    { type = "Tube", at = { 32, 53 } },
    { type = "Tube", at = { 33, 53 } },
    { type = "Tube", at = { 34, 53 } },
    { type = "Tube", at = { 35, 53 } },
    { type = "Tube", at = { 36, 53 } },
    { type = "Tube", at = { 38, 48 } },
    { type = "Tube", at = { 38, 49 } },
    { type = "Tube", at = { 38, 50 } },
    { type = "Tube", at = { 38, 51 } },
    { type = "Tube", at = { 41, 53 } },
    { type = "Tube", at = { 42, 53 } },
    { type = "Tube", at = { 43, 53 } },
    { type = "Tube", at = { 44, 53 } },
    { type = "Tube", at = { 45, 53 } },
    { type = "Tube", at = { 46, 53 } },
  },

  beacons = {
  },
}
