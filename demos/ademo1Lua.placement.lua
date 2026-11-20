-- ademo1Lua.placement.lua  -  AutoDemo Mission #1 (Lua)
-- Converted by op2dll from ademo1.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in ademo1Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "AutoDemo Mission #1 (Lua)", map = "eden04.map", tech = "PLY_TEK.TXT",
  type = "AutoDemo", max_tech = 8, players_count = 2,

  players = {
    [1] = { colony = "Plymouth", human = true, color = "Blue" },
    [2] = { colony = "Eden", human = false, color = "Magenta" },
  },

  units = {
    -- Player 2
    { type = "CommandCenter", player = 2, at = { 18, 46 } },
    { type = "Tokamak", player = 2, at = { 6, 47 } },
    { type = "Agridome", player = 2, at = { 18, 50 } },
    { type = "ConVec", direction = "East", lights = false, player = 2, at = { 13, 50 } },
    { type = "CommonOreSmelter", player = 2, at = { 13, 46 } },
    { type = "CommonOreMine", player = 2, at = { 7, 34 } },
    { name = "truck1", type = "CargoTruck", direction = "East", player = 2, at = { 10, 43 } },
    { name = "truck2", type = "CargoTruck", direction = "East", player = 2, at = { 15, 47 } },
  },

  walls = {
    { type = "Tube", at = { 16, 46 } },
    { type = "Tube", at = { 18, 48 } },
  },

  beacons = {
    { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 6, 34 } },
  },
}
