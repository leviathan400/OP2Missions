-- CPP1Lua.placement.lua  -  Colony Builder - Plymouth, Population (Lua)
-- Converted by op2dll from CPP1.dll: what its setup makes at every difficulty. What changes with the
-- difficulty (more units on Easy, colonists, stores, research) and the beacons it rolls are in CPP1Lua.lua.
-- Coordinates are the in-game status-bar ones (map file tile + 1).
return {
  name = "Colony Builder - Plymouth, Population (Lua)", map = "cm04.map", tech = "MULTITEK.TXT",
  type = "Colony", max_tech = 12, players_count = 2,

  players = {
    [1] = { colony = "Plymouth", human = true, color = "Red" },
    [2] = { colony = "Eden", human = false, color = "Blue" },
  },

  units = {
    -- Player 1
    { type = "Tokamak", player = 1, at = { 240, 85 } },
    { type = "CommonOreSmelter", player = 1, at = { 220, 74 } },
    { type = "Agridome", player = 1, at = { 227, 81 } },
    { type = "CommandCenter", player = 1, at = { 228, 68 } },
    { type = "CargoTruck", direction = "East", player = 1, at = { 232, 74 } },
    { type = "CargoTruck", direction = "East", player = 1, at = { 233, 74 } },
    { type = "CargoTruck", direction = "East", player = 1, at = { 234, 74 } },
    { type = "RoboSurveyor", direction = "East", player = 1, at = { 232, 76 } },
    { type = "RoboDozer", direction = "East", player = 1, at = { 234, 72 } },
    { type = "RoboMiner", direction = "East", player = 1, at = { 234, 76 } },
    { type = "Earthworker", direction = "East", player = 1, at = { 233, 76 } },
    { type = "ConVec", direction = "East", player = 1, at = { 232, 72 } },
    { type = "ConVec", direction = "East", player = 1, at = { 233, 72 } },
    { type = "StructureFactory", player = 1, at = { 228, 74 } },
  },

  walls = {
    { type = "Tube", at = { 223, 74 } },
    { type = "Tube", at = { 224, 74 } },
    { type = "Tube", at = { 225, 74 } },
    { type = "Tube", at = { 228, 70 } },
    { type = "Tube", at = { 228, 71 } },
    { type = "Tube", at = { 228, 72 } },
    { type = "Tube", at = { 228, 77 } },
    { type = "Tube", at = { 228, 78 } },
    { type = "Tube", at = { 228, 79 } },
  },

  beacons = {
  },
}
