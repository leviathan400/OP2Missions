-- mm4_04Lua.lua  -  4 Player, Midas, 'Barren Land' map. (Lua)
--
-- Converted by op2dll from mm4_04.dll ("4 Player, Midas, 'Barren Land' map."): its setup replayed. `on_init` makes the original's
-- draws of the game's random numbers in its order and, from them and the lobby, the same units,
-- beacons, walls and settings in the same order, as the original's setup did in every game
-- sampled (every player count, the lobby's colonies, resource levels, vehicles, day and night,
-- morale and disasters). Anything not converted is listed at the end. Coordinates are the in-game
-- status-bar ones (map file tile + 1).

-- Where lava may flow from an eruption, as areas { x1, y1, x2, y2 }.
local LAVA_POSSIBLE = {
  { 146, 125, 148, 125 }, { 143, 126, 148, 126 }, { 141, 127, 146, 127 }, { 140, 128, 141, 129 }, { 139, 130, 140, 130 }, { 139, 131, 142, 131 },
  { 149, 131, 151, 131 }, { 137, 132, 144, 132 }, { 149, 132, 150, 132 }, { 135, 133, 149, 133 }, { 135, 134, 143, 134 }, { 133, 135, 138, 135 },
  { 132, 136, 135, 136 }, { 130, 137, 136, 137 }, { 122, 138, 131, 138 }, { 134, 138, 137, 138 }, { 120, 139, 130, 139 }, { 136, 139, 138, 139 },
  { 120, 140, 124, 140 }, { 136, 140, 139, 140 }, { 119, 141, 122, 142 }, { 138, 141, 140, 141 }, { 139, 142, 141, 142 }, { 118, 143, 119, 143 },
  { 121, 143, 122, 145 }, { 140, 143, 142, 143 }, { 112, 144, 112, 144 }, { 117, 144, 119, 144 }, { 141, 144, 144, 144 }, { 112, 145, 113, 145 },
  { 117, 145, 117, 145 }, { 143, 145, 145, 145 }, { 113, 146, 117, 146 }, { 119, 146, 121, 146 }, { 144, 146, 147, 146 }, { 115, 147, 119, 147 },
  { 145, 147, 148, 147 }, { 152, 147, 155, 147 }, { 118, 148, 119, 152 }, { 146, 148, 155, 148 }, { 147, 149, 155, 149 }, { 153, 150, 156, 150 },
  { 155, 151, 156, 151 }, { 156, 152, 156, 152 }, { 118, 153, 118, 153 }, { 118, 154, 119, 154 }, { 118, 155, 121, 155 }, { 117, 156, 121, 156 },
  { 117, 157, 120, 157 }, { 116, 158, 119, 158 }, { 113, 159, 117, 159 }, { 111, 160, 116, 160 }, { 110, 161, 114, 161 }, { 108, 162, 114, 162 },
  { 104, 163, 113, 163 }, { 104, 164, 112, 164 }, { 105, 165, 112, 166 }, { 105, 167, 113, 167 }, { 105, 168, 114, 168 }, { 107, 169, 115, 169 },
  { 107, 170, 116, 170 }, { 107, 171, 117, 171 }, { 107, 172, 118, 174 }, { 108, 175, 119, 176 }, { 109, 177, 120, 177 }, { 110, 178, 122, 180 },
  { 110, 181, 123, 181 }, { 109, 182, 122, 182 }, { 109, 183, 123, 184 }, { 109, 185, 124, 187 }, { 108, 188, 124, 188 }, { 107, 189, 127, 189 },
  { 106, 190, 127, 190 }, { 106, 191, 128, 191 }, { 105, 192, 128, 192 }, { 102, 193, 128, 193 }, { 99, 194, 128, 194 }, { 98, 195, 130, 195 },
  { 97, 196, 131, 196 }, { 97, 197, 132, 197 }, { 96, 198, 132, 201 }, { 95, 202, 131, 202 }, { 94, 203, 130, 203 }, { 93, 204, 130, 204 },
  { 93, 205, 131, 207 }, { 93, 208, 132, 208 }, { 86, 209, 89, 209 }, { 92, 209, 133, 210 }, { 85, 210, 90, 210 }, { 84, 211, 133, 213 },
  { 85, 214, 132, 214 }, { 86, 215, 131, 215 }, { 87, 216, 130, 216 }, { 86, 217, 129, 217 }, { 85, 218, 129, 218 }, { 84, 219, 129, 219 },
  { 84, 220, 106, 220 }, { 110, 220, 129, 223 }, { 84, 221, 104, 221 }, { 84, 222, 103, 223 }, { 83, 224, 102, 225 }, { 110, 224, 130, 224 },
  { 111, 225, 130, 225 }, { 135, 225, 137, 225 }, { 83, 226, 103, 226 }, { 105, 226, 105, 226 }, { 111, 226, 138, 226 }, { 83, 227, 105, 227 },
  { 111, 227, 139, 227 }, { 84, 228, 105, 228 }, { 110, 228, 139, 228 }, { 83, 229, 105, 229 }, { 108, 229, 139, 229 }, { 82, 230, 139, 230 },
  { 81, 231, 139, 231 }, { 80, 232, 138, 232 }, { 79, 233, 138, 233 }, { 77, 234, 138, 234 }, { 76, 235, 138, 235 }, { 75, 236, 137, 236 },
  { 75, 237, 114, 237 }, { 116, 237, 123, 237 }, { 129, 237, 130, 237 }, { 133, 237, 136, 237 }, { 74, 238, 113, 238 }, { 117, 238, 122, 238 },
  { 73, 239, 112, 239 }, { 118, 239, 118, 239 }, { 121, 239, 121, 239 }, { 72, 240, 111, 240 }, { 72, 241, 108, 241 }, { 72, 242, 107, 242 },
  { 71, 243, 105, 243 }, { 70, 244, 104, 244 }, { 70, 245, 97, 245 }, { 65, 246, 65, 246 }, { 70, 246, 96, 246 }, { 63, 247, 65, 247 },
  { 71, 247, 95, 247 }, { 62, 248, 66, 248 }, { 68, 248, 93, 248 }, { 61, 249, 92, 249 }, { 61, 250, 91, 250 }, { 59, 251, 90, 251 },
  { 61, 252, 89, 252 }, { 62, 253, 89, 253 }, { 63, 254, 65, 254 }, { 68, 254, 88, 254 }, { 84, 255, 87, 255 },
}

-- The setup's draws (R) and the units it made (U), in order.
local R, U = {}, {}
local LEVEL_OF = { Easy = 0, Normal = 1, Hard = 2 }
local DIRS = { "East", "SouthEast", "South", "SouthWest", "West", "NorthWest", "North", "NorthEast" }
-- A branch of the setup no sampled game took: logged, so a game that differs from the original says where.
         local function unseen(what, value)
  print("replay: " .. what .. " = " .. tostring(value) .. ": a way no sampled game took")
end
-- k different values of 0 to range - 1, each redrawn while it's one already drawn, into R[at[1]] on.
local function pick(range, k, at)
  local seen = {}
  for i = 1, k do
    local v
    repeat v = game.rand(range) until not seen[v]
    seen[v] = true
    R[at[i]] = v
  end
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Lava, Meteors, Tornados

function Lava(t)
  game.create_eruption({ 105, 227 }, 200)
end

function Meteors(t)
  local r1 = game.rand(255)
  local r2 = game.rand(256)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
end

function Tornados(t)
  local r1 = game.rand(255)
  local r2 = game.rand(256)
  local r3 = game.rand(10)
  local r4 = game.rand(255)
  local r5 = game.rand(256)
  game.create_tornado({ r5 + 1, r4 + 2 }, { r2 + 1, r1 + 2 }, r3 + 10)
end

function on_init()
  local n = game.num_players()
  if n == 2 then
    for _, area in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(area) end
    game.initial_set_tile({ 105, 225 }, 1095)
    game.initial_set_tile({ 105, 226 }, 1118)
    game.initial_set_tile({ 106, 225 }, 1107)
    game.initial_set_tile({ 106, 226 }, 1129)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 8, 246 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 250, 248 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 240, 5 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 157, 30 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 216, 81 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 155, 102 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 174, 133 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 207, 112 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 172, 73 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 131, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 171, 227 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 194, 214 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 134, 169 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 157, 163 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 207, 152 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 233, 164 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 193, 183 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 109, 128 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 68, 146 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 63, 160 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 92, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 60, 178 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 23, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 52, 202 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 110, 33 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 112, 67 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 75, 66 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 36, 55 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 34, 92 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 72, 125 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 98, 94 } }
    pick(4, 2, { 0, 1 })
    R[2] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 19, [1] = 32, [2] = 231, [3] = 203 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 17, [1] = 228, [2] = 215, [3] = 4 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 0 or R[2] == 1 or R[2] == 2 or R[2] == 5 or R[2] == 6 or R[2] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 33, [1] = 48, [2] = 243, [3] = 227 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 24, [1] = 235, [2] = 222, [3] = 11 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 29, [1] = 246, [2] = 234, [3] = 19 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 0 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 31, [2] = 227, [3] = 207 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 31, [2] = 227, [3] = 207 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 31, [2] = 227, [3] = 207 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 1 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 34, [1] = 245, [2] = 232, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 34, [1] = 245, [2] = 232, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 34, [1] = 245, [2] = 232, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 41, [1] = 56, [2] = 251, [3] = 235 }, [7] = { [0] = 29, [1] = 44, [2] = 244, [3] = 223 } })[R[2]][R[0]], ({ [0] = { [0] = 34, [1] = 248, [2] = 242, [3] = 25 }, [1] = { [0] = 42, [1] = 253, [2] = 240, [3] = 29 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 2 or R[2] == 5 or R[2] == 6 or R[2] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 24, [1] = 39, [2] = 234, [3] = 218 }, [7] = { [0] = 30, [1] = 45, [2] = 245, [3] = 224 } })[R[2]][R[0]], ({ [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 31, [1] = 248, [2] = 236, [3] = 25 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 0 or R[2] == 1 then
      else
        unseen("R[2]", R[2])
      end
    elseif R[2] == 3 or R[2] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 } })[R[2]][R[0]], ({ [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 3 then
      else
        unseen("R[2]", R[2])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 35, [1] = 50, [2] = 252, [3] = 229 } })[R[2]][R[0]], ({ [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 3 then
        if LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[2]", R[2])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 31, [2] = 227, [3] = 207 }, [1] = { [0] = 18, [1] = 31, [2] = 229, [3] = 207 }, [2] = { [0] = 39, [1] = 52, [2] = 251, [3] = 223 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 16, [1] = 31, [2] = 233, [3] = 210 }, [5] = { [0] = 10, [1] = 25, [2] = 225, [3] = 203 }, [6] = { [0] = 16, [1] = 31, [2] = 226, [3] = 210 }, [7] = { [0] = 22, [1] = 37, [2] = 237, [3] = 216 } })[R[2]][R[0]], ({ [0] = { [0] = 36, [1] = 250, [2] = 244, [3] = 27 }, [1] = { [0] = 39, [1] = 250, [2] = 237, [3] = 26 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 15, [1] = 231, [2] = 216, [3] = 8 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 35, [1] = 252, [2] = 240, [3] = 29 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 34, [1] = 49, [2] = 251, [3] = 228 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 15, [1] = 232, [2] = 220, [3] = 5 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 23, [1] = 234, [2] = 221, [3] = 10 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[2]][R[0]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[2]][R[0]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[2]][R[0]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 37, [1] = 52, [2] = 254, [3] = 231 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 } })[R[2]][R[0]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 19, [1] = 235, [2] = 220, [3] = 12 }, [4] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [5] = { [0] = 31, [1] = 248, [2] = 236, [3] = 21 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 34, [2] = 230, [3] = 210 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 }, [5] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 22, [1] = 239, [2] = 227, [3] = 16 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 235, [3] = 207 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 29, [1] = 245, [2] = 230, [3] = 22 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 21, [1] = 238, [2] = 226, [3] = 11 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 22, [1] = 35, [2] = 233, [3] = 211 }, [2] = { [0] = 24, [1] = 37, [2] = 236, [3] = 208 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 30, [1] = 246, [2] = 231, [3] = 23 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 24, [1] = 241, [2] = 229, [3] = 18 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 37, [2] = 233, [3] = 213 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 22, [1] = 233, [2] = 220, [3] = 10 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 21, [1] = 238, [2] = 225, [3] = 14 }, [5] = { [0] = 26, [1] = 243, [2] = 231, [3] = 16 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 24, [1] = 37, [2] = 235, [3] = 213 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 23, [1] = 234, [2] = 221, [3] = 11 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 22, [1] = 239, [2] = 226, [3] = 15 }, [5] = { [0] = 27, [1] = 244, [2] = 232, [3] = 17 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 39, [2] = 235, [3] = 215 }, [1] = { [0] = 25, [1] = 38, [2] = 236, [3] = 214 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 26, [1] = 41, [2] = 236, [3] = 220 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 24, [1] = 235, [2] = 222, [3] = 12 }, [3] = { [0] = 25, [1] = 241, [2] = 226, [3] = 18 }, [4] = { [0] = 26, [1] = 243, [2] = 230, [3] = 19 }, [5] = { [0] = 28, [1] = 245, [2] = 233, [3] = 18 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 27, [1] = 244, [2] = 232, [3] = 21 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 40, [2] = 236, [3] = 216 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 26, [1] = 242, [2] = 227, [3] = 19 }, [4] = { [0] = 27, [1] = 244, [2] = 231, [3] = 20 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 22, [1] = 236, [2] = 230, [3] = 13 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 26, [1] = 237, [2] = 224, [3] = 14 }, [3] = { [0] = 27, [1] = 243, [2] = 228, [3] = 20 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 29, [1] = 246, [2] = 234, [3] = 23 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 20, [1] = 231, [2] = 218, [3] = 7 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 29, [1] = 246, [2] = 233, [3] = 22 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 30, [1] = 247, [2] = 235, [3] = 24 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[2]][R[0]], ({ [0] = { [0] = 24, [1] = 238, [2] = 232, [3] = 15 }, [1] = { [0] = 21, [1] = 232, [2] = 219, [3] = 8 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 30, [1] = 247, [2] = 234, [3] = 23 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[2]][R[0]], ({ [0] = { [0] = 25, [1] = 239, [2] = 233, [3] = 16 }, [1] = { [0] = 22, [1] = 233, [2] = 220, [3] = 9 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 22, [1] = 40, [2] = 239, [3] = 213 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[2]][R[0]], ({ [0] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [1] = { [0] = 27, [1] = 238, [2] = 225, [3] = 14 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[2]][R[0]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[2]][R[0]], ({ [0] = { [0] = 32, [1] = 246, [2] = 240, [3] = 23 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 45, [2] = 241, [3] = 221 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 24, [1] = 42, [2] = 241, [3] = 215 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 46, [2] = 242, [3] = 222 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 31, [1] = 242, [2] = 229, [3] = 18 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 29, [1] = 44, [2] = 244, [3] = 222 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 32, [1] = 243, [2] = 230, [3] = 19 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 17, [1] = 234, [2] = 221, [3] = 10 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 37, [1] = 248, [2] = 235, [3] = 24 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 49, [2] = 245, [3] = 225 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 29, [1] = 42, [2] = 241, [3] = 213 }, [3] = { [0] = 28, [1] = 46, [2] = 245, [3] = 219 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 38, [1] = 249, [2] = 236, [3] = 25 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 21, [1] = 238, [2] = 226, [3] = 15 } })[R[2]][R[0]] })
    if R[2] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] })
        for i = 1, game.initial_units() do
          R[3] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [2] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 } })[R[3]][R[0]], ({ [0] = { [0] = 21, [1] = 235, [2] = 229, [3] = 12 }, [1] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [2] = { [0] = 33, [1] = 247, [2] = 241, [3] = 24 } })[R[3]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[0]] })
        for i = 1, game.initial_units() do
          R[4] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 32, [2] = 230, [3] = 208 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 } })[R[4]][R[0]], ({ [0] = { [0] = 34, [1] = 245, [2] = 232, [3] = 21 }, [1] = { [0] = 36, [1] = 247, [2] = 234, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 } })[R[4]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[5] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 33, [2] = 232, [3] = 204 }, [1] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [2] = { [0] = 38, [1] = 51, [2] = 250, [3] = 222 } })[R[5]][R[0]], ({ [0] = { [0] = 19, [1] = 230, [2] = 217, [3] = 7 }, [1] = { [0] = 35, [1] = 246, [2] = 233, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 } })[R[5]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[0]] })
        for i = 1, game.initial_units() do
          R[6] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [1] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [2] = { [0] = 14, [1] = 32, [2] = 231, [3] = 205 } })[R[6]][R[0]], ({ [0] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [1] = { [0] = 31, [1] = 247, [2] = 232, [3] = 24 }, [2] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 } })[R[6]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[0]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
        for i = 1, game.initial_units() do
          R[7] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [1] = { [0] = 19, [1] = 34, [2] = 236, [3] = 213 }, [2] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 } })[R[7]][R[0]], ({ [0] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [1] = { [0] = 23, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 } })[R[7]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[0]] })
        for i = 1, game.initial_units() do
          R[8] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [1] = { [0] = 9, [1] = 24, [2] = 224, [3] = 202 }, [2] = { [0] = 31, [1] = 46, [2] = 246, [3] = 224 } })[R[8]][R[0]], ({ [0] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 }, [1] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [2] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 } })[R[8]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
        for i = 1, game.initial_units() do
          R[9] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 33, [2] = 228, [3] = 212 }, [1] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [2] = { [0] = 44, [1] = 59, [2] = 254, [3] = 238 } })[R[9]][R[0]], ({ [0] = { [0] = 9, [1] = 227, [2] = 219, [3] = 2 }, [1] = { [0] = 7, [1] = 225, [2] = 217, [3] = 0 }, [2] = { [0] = 22, [1] = 240, [2] = 232, [3] = 15 } })[R[9]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[0]] })
        for i = 1, game.initial_units() do
          R[10] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 }, [1] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 }, [2] = { [0] = 13, [1] = 28, [2] = 228, [3] = 207 } })[R[10]][R[0]], ({ [0] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [1] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [2] = { [0] = 36, [1] = 253, [2] = 241, [3] = 30 } })[R[10]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[2]", R[2])
    end
    R[11] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 19, [1] = 32, [2] = 231, [3] = 203 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 17, [1] = 228, [2] = 215, [3] = 4 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 0 or R[11] == 1 or R[11] == 2 or R[11] == 5 or R[11] == 6 or R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 33, [1] = 48, [2] = 243, [3] = 227 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 24, [1] = 235, [2] = 222, [3] = 11 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 29, [1] = 246, [2] = 234, [3] = 19 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 0 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[11] == 1 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[11] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[1]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[1]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[1]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 56, [2] = 251, [3] = 235 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 56, [2] = 251, [3] = 235 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 56, [2] = 251, [3] = 235 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 31, [2] = 227, [3] = 207 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 24, [1] = 39, [2] = 234, [3] = 218 }, [7] = { [0] = 30, [1] = 45, [2] = 245, [3] = 224 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 34, [1] = 245, [2] = 232, [3] = 21 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 31, [1] = 248, [2] = 236, [3] = 25 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 2 or R[11] == 5 or R[11] == 6 or R[11] == 7 then
      elseif R[11] == 0 or R[11] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 } })[R[11]][R[1]], ({ [0] = { [0] = 34, [1] = 248, [2] = 242, [3] = 25 }, [1] = { [0] = 42, [1] = 253, [2] = 240, [3] = 29 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[11]", R[11])
      end
    elseif R[11] == 3 or R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 } })[R[11]][R[1]], ({ [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 28, [1] = 245, [2] = 232, [3] = 21 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 20, [1] = 38, [2] = 237, [3] = 211 })[R[1]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[11]", R[11])
      end
    else
      unseen("R[11]", R[11])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 31, [2] = 227, [3] = 207 }, [1] = { [0] = 18, [1] = 31, [2] = 229, [3] = 207 }, [2] = { [0] = 39, [1] = 52, [2] = 251, [3] = 223 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 16, [1] = 31, [2] = 233, [3] = 210 }, [5] = { [0] = 10, [1] = 25, [2] = 225, [3] = 203 }, [6] = { [0] = 16, [1] = 31, [2] = 226, [3] = 210 }, [7] = { [0] = 22, [1] = 37, [2] = 237, [3] = 216 } })[R[11]][R[1]], ({ [0] = { [0] = 36, [1] = 250, [2] = 244, [3] = 27 }, [1] = { [0] = 39, [1] = 250, [2] = 237, [3] = 26 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 15, [1] = 231, [2] = 216, [3] = 8 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 35, [1] = 252, [2] = 240, [3] = 29 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 34, [1] = 49, [2] = 251, [3] = 228 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 15, [1] = 232, [2] = 220, [3] = 5 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 23, [1] = 234, [2] = 221, [3] = 10 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[11]][R[1]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[11]][R[1]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[11]][R[1]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 37, [1] = 52, [2] = 254, [3] = 231 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 } })[R[11]][R[1]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 19, [1] = 235, [2] = 220, [3] = 12 }, [4] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [5] = { [0] = 31, [1] = 248, [2] = 236, [3] = 21 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 34, [2] = 230, [3] = 210 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 }, [5] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 22, [1] = 239, [2] = 227, [3] = 16 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 235, [3] = 207 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 29, [1] = 245, [2] = 230, [3] = 22 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 21, [1] = 238, [2] = 226, [3] = 11 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 22, [1] = 35, [2] = 233, [3] = 211 }, [2] = { [0] = 24, [1] = 37, [2] = 236, [3] = 208 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 30, [1] = 246, [2] = 231, [3] = 23 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 24, [1] = 241, [2] = 229, [3] = 18 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 37, [2] = 233, [3] = 213 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 22, [1] = 233, [2] = 220, [3] = 10 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 21, [1] = 238, [2] = 225, [3] = 14 }, [5] = { [0] = 26, [1] = 243, [2] = 231, [3] = 16 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 24, [1] = 37, [2] = 235, [3] = 213 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 23, [1] = 234, [2] = 221, [3] = 11 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 22, [1] = 239, [2] = 226, [3] = 15 }, [5] = { [0] = 27, [1] = 244, [2] = 232, [3] = 17 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 39, [2] = 235, [3] = 215 }, [1] = { [0] = 25, [1] = 38, [2] = 236, [3] = 214 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 26, [1] = 41, [2] = 236, [3] = 220 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 24, [1] = 235, [2] = 222, [3] = 12 }, [3] = { [0] = 25, [1] = 241, [2] = 226, [3] = 18 }, [4] = { [0] = 26, [1] = 243, [2] = 230, [3] = 19 }, [5] = { [0] = 28, [1] = 245, [2] = 233, [3] = 18 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 27, [1] = 244, [2] = 232, [3] = 21 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 40, [2] = 236, [3] = 216 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 26, [1] = 242, [2] = 227, [3] = 19 }, [4] = { [0] = 27, [1] = 244, [2] = 231, [3] = 20 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 22, [1] = 236, [2] = 230, [3] = 13 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 26, [1] = 237, [2] = 224, [3] = 14 }, [3] = { [0] = 27, [1] = 243, [2] = 228, [3] = 20 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 29, [1] = 246, [2] = 234, [3] = 23 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 20, [1] = 231, [2] = 218, [3] = 7 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 29, [1] = 246, [2] = 233, [3] = 22 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 30, [1] = 247, [2] = 235, [3] = 24 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[11]][R[1]], ({ [0] = { [0] = 24, [1] = 238, [2] = 232, [3] = 15 }, [1] = { [0] = 21, [1] = 232, [2] = 219, [3] = 8 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 30, [1] = 247, [2] = 234, [3] = 23 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[11]][R[1]], ({ [0] = { [0] = 25, [1] = 239, [2] = 233, [3] = 16 }, [1] = { [0] = 22, [1] = 233, [2] = 220, [3] = 9 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 22, [1] = 40, [2] = 239, [3] = 213 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[11]][R[1]], ({ [0] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [1] = { [0] = 27, [1] = 238, [2] = 225, [3] = 14 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[11]][R[1]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[11]][R[1]], ({ [0] = { [0] = 32, [1] = 246, [2] = 240, [3] = 23 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 45, [2] = 241, [3] = 221 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 24, [1] = 42, [2] = 241, [3] = 215 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 46, [2] = 242, [3] = 222 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 31, [1] = 242, [2] = 229, [3] = 18 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 29, [1] = 44, [2] = 244, [3] = 222 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 32, [1] = 243, [2] = 230, [3] = 19 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 17, [1] = 234, [2] = 221, [3] = 10 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 37, [1] = 248, [2] = 235, [3] = 24 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 49, [2] = 245, [3] = 225 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 29, [1] = 42, [2] = 241, [3] = 213 }, [3] = { [0] = 28, [1] = 46, [2] = 245, [3] = 219 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 38, [1] = 249, [2] = 236, [3] = 25 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 21, [1] = 238, [2] = 226, [3] = 15 } })[R[11]][R[1]] })
    if R[11] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[1]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[1]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[1]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[1]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[1]] })
        for i = 1, game.initial_units() do
          R[12] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [2] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 } })[R[12]][R[1]], ({ [0] = { [0] = 21, [1] = 235, [2] = 229, [3] = 12 }, [1] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [2] = { [0] = 33, [1] = 247, [2] = 241, [3] = 24 } })[R[12]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[1]] })
        for i = 1, game.initial_units() do
          R[13] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 32, [2] = 230, [3] = 208 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 } })[R[13]][R[1]], ({ [0] = { [0] = 34, [1] = 245, [2] = 232, [3] = 21 }, [1] = { [0] = 36, [1] = 247, [2] = 234, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 } })[R[13]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[14] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 33, [2] = 232, [3] = 204 }, [1] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [2] = { [0] = 38, [1] = 51, [2] = 250, [3] = 222 } })[R[14]][R[1]], ({ [0] = { [0] = 19, [1] = 230, [2] = 217, [3] = 7 }, [1] = { [0] = 35, [1] = 246, [2] = 233, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 } })[R[14]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[1]] })
        for i = 1, game.initial_units() do
          R[15] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [1] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [2] = { [0] = 14, [1] = 32, [2] = 231, [3] = 205 } })[R[15]][R[1]], ({ [0] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [1] = { [0] = 31, [1] = 247, [2] = 232, [3] = 24 }, [2] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 } })[R[15]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
        for i = 1, game.initial_units() do
          R[16] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [1] = { [0] = 19, [1] = 34, [2] = 236, [3] = 213 }, [2] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 } })[R[16]][R[1]], ({ [0] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [1] = { [0] = 23, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 } })[R[16]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[1]] })
        for i = 1, game.initial_units() do
          R[17] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [1] = { [0] = 9, [1] = 24, [2] = 224, [3] = 202 }, [2] = { [0] = 31, [1] = 46, [2] = 246, [3] = 224 } })[R[17]][R[1]], ({ [0] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 }, [1] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [2] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 } })[R[17]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
        for i = 1, game.initial_units() do
          R[18] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 33, [2] = 228, [3] = 212 }, [1] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [2] = { [0] = 44, [1] = 59, [2] = 254, [3] = 238 } })[R[18]][R[1]], ({ [0] = { [0] = 9, [1] = 227, [2] = 219, [3] = 2 }, [1] = { [0] = 7, [1] = 225, [2] = 217, [3] = 0 }, [2] = { [0] = 22, [1] = 240, [2] = 232, [3] = 15 } })[R[18]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[1]] })
        for i = 1, game.initial_units() do
          R[19] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 }, [1] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 }, [2] = { [0] = 13, [1] = 28, [2] = 228, [3] = 207 } })[R[19]][R[1]], ({ [0] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [1] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [2] = { [0] = 36, [1] = 253, [2] = 241, [3] = 30 } })[R[19]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[11]", R[11])
    end
    players[1]:mark_research(3303)
    players[1].workers = ({ [0] = 30, [1] = 26, [2] = 24 })[LEVEL_OF[players[1].difficulty]]
    players[1].scientists = 16 - 3 * LEVEL_OF[players[1].difficulty]
    players[1].kids = 22 - 2 * LEVEL_OF[players[1].difficulty]
    players[1].food = 3000 - 1000 * LEVEL_OF[players[1].difficulty]
    players[1].ore = 6000 - 2000 * LEVEL_OF[players[1].difficulty]
    players[({ [0] = 0, [1] = 0, [2] = 1 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3304, [1] = 3304, [2] = 3303 })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      players[1]:mark_research(3305)
      players[({ [0] = 0, [1] = 1 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3401, [1] = 3303 })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[2].difficulty] == 0 then
        players[2]:mark_research(3303)
      elseif LEVEL_OF[players[2].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    players[2].workers = ({ [0] = 30, [1] = 26, [2] = 24 })[LEVEL_OF[players[2].difficulty]]
    players[2].scientists = 16 - 3 * LEVEL_OF[players[2].difficulty]
    players[2].kids = 22 - 2 * LEVEL_OF[players[2].difficulty]
    players[2].food = 3000 - 1000 * LEVEL_OF[players[2].difficulty]
    players[2].ore = 6000 - 2000 * LEVEL_OF[players[2].difficulty]
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      players[2]:mark_research(3304)
      players[2]:mark_research(3305)
      if LEVEL_OF[players[2].difficulty] == 0 then
        players[2]:mark_research(3401)
      elseif LEVEL_OF[players[2].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif LEVEL_OF[players[2].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    game.set_daylight_everywhere(({ [0] = 1, [1] = 0 })[(game.uses_day_night() and 1 or 0)] ~= 0)
    if (game.uses_morale() and 1 or 0) == 0 then
      game.morale_steady("Good")
    elseif (game.uses_morale() and 1 or 0) == 1 then
      game.free_morale()
    else
      unseen("(game.uses_morale() and 1 or 0)", (game.uses_morale() and 1 or 0))
    end
  elseif n == 3 then
    for _, area in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(area) end
    game.initial_set_tile({ 105, 225 }, 1095)
    game.initial_set_tile({ 105, 226 }, 1118)
    game.initial_set_tile({ 106, 225 }, 1107)
    game.initial_set_tile({ 106, 226 }, 1129)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 8, 246 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 250, 248 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 240, 5 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 157, 30 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 216, 81 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 155, 102 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 174, 133 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 207, 112 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 172, 73 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 131, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 171, 227 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 194, 214 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 134, 169 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 157, 163 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 207, 152 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 233, 164 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 193, 183 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 109, 128 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 68, 146 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 63, 160 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 92, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 60, 178 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 23, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 52, 202 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 110, 33 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 112, 67 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 75, 66 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 36, 55 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 34, 92 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 72, 125 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 98, 94 } }
    pick(4, 3, { 0, 1, 20 })
    R[2] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 19, [1] = 32, [2] = 231, [3] = 203 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 17, [1] = 228, [2] = 215, [3] = 4 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 0 or R[2] == 1 or R[2] == 2 or R[2] == 5 or R[2] == 6 or R[2] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 33, [1] = 48, [2] = 243, [3] = 227 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 24, [1] = 235, [2] = 222, [3] = 11 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 29, [1] = 246, [2] = 234, [3] = 19 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 0 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 31, [2] = 227, [3] = 207 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 31, [2] = 227, [3] = 207 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 31, [2] = 227, [3] = 207 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 1 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 34, [1] = 245, [2] = 232, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 34, [1] = 245, [2] = 232, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 34, [1] = 245, [2] = 232, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 41, [1] = 56, [2] = 251, [3] = 235 }, [7] = { [0] = 29, [1] = 44, [2] = 244, [3] = 223 } })[R[2]][R[0]], ({ [0] = { [0] = 34, [1] = 248, [2] = 242, [3] = 25 }, [1] = { [0] = 42, [1] = 253, [2] = 240, [3] = 29 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 0 or R[2] == 1 then
      elseif R[2] == 2 or R[2] == 5 or R[2] == 6 or R[2] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 24, [1] = 39, [2] = 234, [3] = 218 }, [7] = { [0] = 30, [1] = 45, [2] = 245, [3] = 224 } })[R[2]][R[0]], ({ [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 31, [1] = 248, [2] = 236, [3] = 25 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[2]", R[2])
      end
    elseif R[2] == 3 or R[2] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 } })[R[2]][R[0]], ({ [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 20, [1] = 38, [2] = 237, [3] = 211 })[R[0]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 232, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[2]", R[2])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 31, [2] = 227, [3] = 207 }, [1] = { [0] = 18, [1] = 31, [2] = 229, [3] = 207 }, [2] = { [0] = 39, [1] = 52, [2] = 251, [3] = 223 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 16, [1] = 31, [2] = 233, [3] = 210 }, [5] = { [0] = 10, [1] = 25, [2] = 225, [3] = 203 }, [6] = { [0] = 16, [1] = 31, [2] = 226, [3] = 210 }, [7] = { [0] = 22, [1] = 37, [2] = 237, [3] = 216 } })[R[2]][R[0]], ({ [0] = { [0] = 36, [1] = 250, [2] = 244, [3] = 27 }, [1] = { [0] = 39, [1] = 250, [2] = 237, [3] = 26 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 15, [1] = 231, [2] = 216, [3] = 8 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 35, [1] = 252, [2] = 240, [3] = 29 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 34, [1] = 49, [2] = 251, [3] = 228 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 15, [1] = 232, [2] = 220, [3] = 5 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 23, [1] = 234, [2] = 221, [3] = 10 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[2] == 0 or R[2] == 1 or R[2] == 2 or R[2] == 4 or R[2] == 5 or R[2] == 6 or R[2] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 3 then
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 35, [1] = 53, [2] = 252, [3] = 226 })[R[0]], ({ [0] = 22, [1] = 238, [2] = 223, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 18, [1] = 234, [2] = 219, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    if R[2] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 36, [2] = 232, [3] = 212 })[R[0]], ({ [0] = 23, [1] = 237, [2] = 231, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 36, [2] = 232, [3] = 212 })[R[0]], ({ [0] = 23, [1] = 237, [2] = 231, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 37, [1] = 47, [2] = 243, [3] = 223 })[R[0]], ({ [0] = 29, [1] = 243, [2] = 237, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 23, [1] = 33, [2] = 229, [3] = 209 })[R[0]], ({ [0] = 23, [1] = 237, [2] = 231, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 23, [1] = 33, [2] = 229, [3] = 209 })[R[0]], ({ [0] = 20, [1] = 234, [2] = 228, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 36, [2] = 232, [3] = 212 })[R[0]], ({ [0] = 23, [1] = 237, [2] = 231, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 37, [1] = 47, [2] = 243, [3] = 223 })[R[0]], ({ [0] = 29, [1] = 243, [2] = 237, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 23, [1] = 33, [2] = 229, [3] = 209 })[R[0]], ({ [0] = 23, [1] = 237, [2] = 231, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 23, [1] = 33, [2] = 229, [3] = 209 })[R[0]], ({ [0] = 20, [1] = 234, [2] = 228, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 23, [1] = 33, [2] = 229, [3] = 209 })[R[0]], ({ [0] = 23, [1] = 237, [2] = 231, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 23, [1] = 33, [2] = 229, [3] = 209 })[R[0]], ({ [0] = 20, [1] = 234, [2] = 228, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 30, [2] = 228, [3] = 206 })[R[0]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 33, [2] = 231, [3] = 209 })[R[0]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 30, [2] = 228, [3] = 206 })[R[0]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 20, [1] = 33, [2] = 231, [3] = 209 })[R[0]], ({ [0] = 19, [1] = 230, [2] = 217, [3] = 6 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 23, [1] = 36, [2] = 234, [3] = 212 })[R[0]], ({ [0] = 16, [1] = 227, [2] = 214, [3] = 3 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 30, [2] = 228, [3] = 206 })[R[0]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 33, [2] = 231, [3] = 209 })[R[0]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 20, [1] = 33, [2] = 231, [3] = 209 })[R[0]], ({ [0] = 19, [1] = 230, [2] = 217, [3] = 6 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 23, [1] = 36, [2] = 234, [3] = 212 })[R[0]], ({ [0] = 16, [1] = 227, [2] = 214, [3] = 3 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 20, [1] = 33, [2] = 231, [3] = 209 })[R[0]], ({ [0] = 19, [1] = 230, [2] = 217, [3] = 6 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 23, [1] = 36, [2] = 234, [3] = 212 })[R[0]], ({ [0] = 16, [1] = 227, [2] = 214, [3] = 3 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 35, [1] = 48, [2] = 247, [3] = 219 })[R[0]], ({ [0] = 27, [1] = 238, [2] = 225, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 35, [1] = 48, [2] = 247, [3] = 219 })[R[0]], ({ [0] = 27, [1] = 238, [2] = 225, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 30, [2] = 229, [3] = 201 })[R[0]], ({ [0] = 30, [1] = 241, [2] = 228, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 35, [1] = 48, [2] = 247, [3] = 219 })[R[0]], ({ [0] = 33, [1] = 244, [2] = 231, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[0]], ({ [0] = 34, [1] = 245, [2] = 232, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 35, [1] = 48, [2] = 247, [3] = 219 })[R[0]], ({ [0] = 27, [1] = 238, [2] = 225, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 30, [2] = 229, [3] = 201 })[R[0]], ({ [0] = 30, [1] = 241, [2] = 228, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 35, [1] = 48, [2] = 247, [3] = 219 })[R[0]], ({ [0] = 33, [1] = 244, [2] = 231, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[0]], ({ [0] = 34, [1] = 245, [2] = 232, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 35, [1] = 48, [2] = 247, [3] = 219 })[R[0]], ({ [0] = 33, [1] = 244, [2] = 231, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[0]], ({ [0] = 34, [1] = 245, [2] = 232, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 39, [2] = 238, [3] = 212 })[R[0]], ({ [0] = 33, [1] = 249, [2] = 234, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 39, [2] = 238, [3] = 212 })[R[0]], ({ [0] = 33, [1] = 249, [2] = 234, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 33, [2] = 232, [3] = 206 })[R[0]], ({ [0] = 22, [1] = 238, [2] = 223, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 33, [2] = 232, [3] = 206 })[R[0]], ({ [0] = 22, [1] = 238, [2] = 223, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 39, [2] = 238, [3] = 212 })[R[0]], ({ [0] = 33, [1] = 249, [2] = 234, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 18, [1] = 234, [2] = 219, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 39, [2] = 238, [3] = 212 })[R[0]], ({ [0] = 33, [1] = 249, [2] = 234, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 39, [2] = 238, [3] = 212 })[R[0]], ({ [0] = 33, [1] = 249, [2] = 234, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 39, [2] = 238, [3] = 212 })[R[0]], ({ [0] = 33, [1] = 249, [2] = 234, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 39, [2] = 238, [3] = 212 })[R[0]], ({ [0] = 33, [1] = 249, [2] = 234, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 33, [2] = 232, [3] = 206 })[R[0]], ({ [0] = 22, [1] = 238, [2] = 223, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 21, [1] = 39, [2] = 238, [3] = 212 })[R[0]], ({ [0] = 33, [1] = 249, [2] = 234, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 36, [1] = 51, [2] = 253, [3] = 230 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 36, [1] = 51, [2] = 253, [3] = 230 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 28, [1] = 43, [2] = 245, [3] = 222 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 29, [1] = 44, [2] = 246, [3] = 223 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 232, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 223, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 36, [1] = 51, [2] = 253, [3] = 230 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 28, [1] = 43, [2] = 245, [3] = 222 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 29, [1] = 44, [2] = 246, [3] = 223 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 232, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 223, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 29, [1] = 44, [2] = 246, [3] = 223 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 232, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 223, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 5 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 28, [1] = 43, [2] = 243, [3] = 221 })[R[0]], ({ [0] = 17, [1] = 234, [2] = 222, [3] = 7 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 28, [1] = 43, [2] = 243, [3] = 221 })[R[0]], ({ [0] = 17, [1] = 234, [2] = 222, [3] = 7 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 31, [2] = 231, [3] = 209 })[R[0]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 30, [2] = 230, [3] = 208 })[R[0]], ({ [0] = 14, [1] = 231, [2] = 219, [3] = 4 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 24, [1] = 39, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 28, [1] = 43, [2] = 243, [3] = 221 })[R[0]], ({ [0] = 17, [1] = 234, [2] = 222, [3] = 7 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 31, [2] = 231, [3] = 209 })[R[0]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 30, [2] = 230, [3] = 208 })[R[0]], ({ [0] = 14, [1] = 231, [2] = 219, [3] = 4 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 24, [1] = 39, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 30, [2] = 230, [3] = 208 })[R[0]], ({ [0] = 14, [1] = 231, [2] = 219, [3] = 4 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 24, [1] = 39, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 36, [2] = 231, [3] = 215 })[R[0]], ({ [0] = 24, [1] = 242, [2] = 234, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 36, [2] = 231, [3] = 215 })[R[0]], ({ [0] = 24, [1] = 242, [2] = 234, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 36, [1] = 51, [2] = 246, [3] = 230 })[R[0]], ({ [0] = 11, [1] = 229, [2] = 221, [3] = 4 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 28, [1] = 43, [2] = 238, [3] = 222 })[R[0]], ({ [0] = 21, [1] = 239, [2] = 231, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[0]], ({ [0] = 18, [1] = 236, [2] = 228, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 36, [2] = 231, [3] = 215 })[R[0]], ({ [0] = 24, [1] = 242, [2] = 234, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 36, [1] = 51, [2] = 246, [3] = 230 })[R[0]], ({ [0] = 11, [1] = 229, [2] = 221, [3] = 4 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 28, [1] = 43, [2] = 238, [3] = 222 })[R[0]], ({ [0] = 21, [1] = 239, [2] = 231, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[0]], ({ [0] = 18, [1] = 236, [2] = 228, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 28, [1] = 43, [2] = 238, [3] = 222 })[R[0]], ({ [0] = 21, [1] = 239, [2] = 231, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[0]], ({ [0] = 18, [1] = 236, [2] = 228, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 7 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 32, [1] = 47, [2] = 247, [3] = 226 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 32, [1] = 47, [2] = 247, [3] = 226 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 46, [2] = 246, [3] = 225 })[R[0]], ({ [0] = 20, [1] = 237, [2] = 225, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 31, [2] = 231, [3] = 210 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 11, [1] = 26, [2] = 226, [3] = 205 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 32, [1] = 47, [2] = 247, [3] = 226 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 46, [2] = 246, [3] = 225 })[R[0]], ({ [0] = 20, [1] = 237, [2] = 225, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 31, [2] = 231, [3] = 210 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 11, [1] = 26, [2] = 226, [3] = 205 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 31, [2] = 231, [3] = 210 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 11, [1] = 26, [2] = 226, [3] = 205 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 37, [1] = 52, [2] = 254, [3] = 231 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 } })[R[2]][R[0]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 19, [1] = 235, [2] = 220, [3] = 12 }, [4] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [5] = { [0] = 31, [1] = 248, [2] = 236, [3] = 21 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 34, [2] = 230, [3] = 210 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 }, [5] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 22, [1] = 239, [2] = 227, [3] = 16 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 235, [3] = 207 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 29, [1] = 245, [2] = 230, [3] = 22 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 21, [1] = 238, [2] = 226, [3] = 11 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 22, [1] = 35, [2] = 233, [3] = 211 }, [2] = { [0] = 24, [1] = 37, [2] = 236, [3] = 208 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 30, [1] = 246, [2] = 231, [3] = 23 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 24, [1] = 241, [2] = 229, [3] = 18 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 37, [2] = 233, [3] = 213 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 22, [1] = 233, [2] = 220, [3] = 10 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 21, [1] = 238, [2] = 225, [3] = 14 }, [5] = { [0] = 26, [1] = 243, [2] = 231, [3] = 16 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 24, [1] = 37, [2] = 235, [3] = 213 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 23, [1] = 234, [2] = 221, [3] = 11 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 22, [1] = 239, [2] = 226, [3] = 15 }, [5] = { [0] = 27, [1] = 244, [2] = 232, [3] = 17 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 39, [2] = 235, [3] = 215 }, [1] = { [0] = 25, [1] = 38, [2] = 236, [3] = 214 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 26, [1] = 41, [2] = 236, [3] = 220 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 24, [1] = 235, [2] = 222, [3] = 12 }, [3] = { [0] = 25, [1] = 241, [2] = 226, [3] = 18 }, [4] = { [0] = 26, [1] = 243, [2] = 230, [3] = 19 }, [5] = { [0] = 28, [1] = 245, [2] = 233, [3] = 18 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 27, [1] = 244, [2] = 232, [3] = 21 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 40, [2] = 236, [3] = 216 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 26, [1] = 242, [2] = 227, [3] = 19 }, [4] = { [0] = 27, [1] = 244, [2] = 231, [3] = 20 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 22, [1] = 236, [2] = 230, [3] = 13 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 26, [1] = 237, [2] = 224, [3] = 14 }, [3] = { [0] = 27, [1] = 243, [2] = 228, [3] = 20 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 29, [1] = 246, [2] = 234, [3] = 23 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 20, [1] = 231, [2] = 218, [3] = 7 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 29, [1] = 246, [2] = 233, [3] = 22 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 30, [1] = 247, [2] = 235, [3] = 24 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[2]][R[0]], ({ [0] = { [0] = 24, [1] = 238, [2] = 232, [3] = 15 }, [1] = { [0] = 21, [1] = 232, [2] = 219, [3] = 8 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 30, [1] = 247, [2] = 234, [3] = 23 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[2]][R[0]], ({ [0] = { [0] = 25, [1] = 239, [2] = 233, [3] = 16 }, [1] = { [0] = 22, [1] = 233, [2] = 220, [3] = 9 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 22, [1] = 40, [2] = 239, [3] = 213 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[2]][R[0]], ({ [0] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [1] = { [0] = 27, [1] = 238, [2] = 225, [3] = 14 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[2]][R[0]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[2]][R[0]], ({ [0] = { [0] = 32, [1] = 246, [2] = 240, [3] = 23 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 45, [2] = 241, [3] = 221 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 24, [1] = 42, [2] = 241, [3] = 215 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 46, [2] = 242, [3] = 222 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 31, [1] = 242, [2] = 229, [3] = 18 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 29, [1] = 44, [2] = 244, [3] = 222 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 32, [1] = 243, [2] = 230, [3] = 19 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 17, [1] = 234, [2] = 221, [3] = 10 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 37, [1] = 248, [2] = 235, [3] = 24 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 49, [2] = 245, [3] = 225 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 29, [1] = 42, [2] = 241, [3] = 213 }, [3] = { [0] = 28, [1] = 46, [2] = 245, [3] = 219 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 38, [1] = 249, [2] = 236, [3] = 25 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 21, [1] = 238, [2] = 226, [3] = 15 } })[R[2]][R[0]] })
    if R[2] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] })
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [2] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 } })[R[21]][R[0]], ({ [0] = { [0] = 21, [1] = 235, [2] = 229, [3] = 12 }, [1] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [2] = { [0] = 33, [1] = 247, [2] = 241, [3] = 24 } })[R[21]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[0]] })
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 32, [2] = 230, [3] = 208 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 } })[R[22]][R[0]], ({ [0] = { [0] = 34, [1] = 245, [2] = 232, [3] = 21 }, [1] = { [0] = 36, [1] = 247, [2] = 234, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 } })[R[22]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[23] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 33, [2] = 232, [3] = 204 }, [1] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [2] = { [0] = 38, [1] = 51, [2] = 250, [3] = 222 } })[R[23]][R[0]], ({ [0] = { [0] = 19, [1] = 230, [2] = 217, [3] = 7 }, [1] = { [0] = 35, [1] = 246, [2] = 233, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 } })[R[23]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[0]] })
        for i = 1, game.initial_units() do
          R[24] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [1] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [2] = { [0] = 14, [1] = 32, [2] = 231, [3] = 205 } })[R[24]][R[0]], ({ [0] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [1] = { [0] = 31, [1] = 247, [2] = 232, [3] = 24 }, [2] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 } })[R[24]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
        for i = 1, game.initial_units() do
          R[25] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [1] = { [0] = 19, [1] = 34, [2] = 236, [3] = 213 }, [2] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 } })[R[25]][R[0]], ({ [0] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [1] = { [0] = 23, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 } })[R[25]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[0]] })
        for i = 1, game.initial_units() do
          R[26] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [1] = { [0] = 9, [1] = 24, [2] = 224, [3] = 202 }, [2] = { [0] = 31, [1] = 46, [2] = 246, [3] = 224 } })[R[26]][R[0]], ({ [0] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 }, [1] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [2] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 } })[R[26]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
        for i = 1, game.initial_units() do
          R[27] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 33, [2] = 228, [3] = 212 }, [1] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [2] = { [0] = 44, [1] = 59, [2] = 254, [3] = 238 } })[R[27]][R[0]], ({ [0] = { [0] = 9, [1] = 227, [2] = 219, [3] = 2 }, [1] = { [0] = 7, [1] = 225, [2] = 217, [3] = 0 }, [2] = { [0] = 22, [1] = 240, [2] = 232, [3] = 15 } })[R[27]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 7 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[0]] })
        for i = 1, game.initial_units() do
          R[28] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 }, [1] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 }, [2] = { [0] = 13, [1] = 28, [2] = 228, [3] = 207 } })[R[28]][R[0]], ({ [0] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [1] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [2] = { [0] = 36, [1] = 253, [2] = 241, [3] = 30 } })[R[28]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[0]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[2]", R[2])
    end
    R[11] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 19, [1] = 32, [2] = 231, [3] = 203 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 17, [1] = 228, [2] = 215, [3] = 4 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 0 or R[11] == 1 or R[11] == 2 or R[11] == 5 or R[11] == 6 or R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 33, [1] = 48, [2] = 243, [3] = 227 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 24, [1] = 235, [2] = 222, [3] = 11 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 29, [1] = 246, [2] = 234, [3] = 19 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 0 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[11] == 1 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[11] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[1]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[1]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[1]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 56, [2] = 251, [3] = 235 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 56, [2] = 251, [3] = 235 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 56, [2] = 251, [3] = 235 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 31, [2] = 227, [3] = 207 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 24, [1] = 39, [2] = 234, [3] = 218 }, [7] = { [0] = 30, [1] = 45, [2] = 245, [3] = 224 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 34, [1] = 245, [2] = 232, [3] = 21 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 31, [1] = 248, [2] = 236, [3] = 25 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 2 or R[11] == 5 or R[11] == 6 or R[11] == 7 then
      elseif R[11] == 0 or R[11] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 } })[R[11]][R[1]], ({ [0] = { [0] = 34, [1] = 248, [2] = 242, [3] = 25 }, [1] = { [0] = 42, [1] = 253, [2] = 240, [3] = 29 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[11]", R[11])
      end
    elseif R[11] == 3 or R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 } })[R[11]][R[1]], ({ [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 3 then
      else
        unseen("R[11]", R[11])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 35, [1] = 50, [2] = 252, [3] = 229 } })[R[11]][R[1]], ({ [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 3 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
    else
      unseen("R[11]", R[11])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 31, [2] = 227, [3] = 207 }, [1] = { [0] = 18, [1] = 31, [2] = 229, [3] = 207 }, [2] = { [0] = 39, [1] = 52, [2] = 251, [3] = 223 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 16, [1] = 31, [2] = 233, [3] = 210 }, [5] = { [0] = 10, [1] = 25, [2] = 225, [3] = 203 }, [6] = { [0] = 16, [1] = 31, [2] = 226, [3] = 210 }, [7] = { [0] = 22, [1] = 37, [2] = 237, [3] = 216 } })[R[11]][R[1]], ({ [0] = { [0] = 36, [1] = 250, [2] = 244, [3] = 27 }, [1] = { [0] = 39, [1] = 250, [2] = 237, [3] = 26 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 15, [1] = 231, [2] = 216, [3] = 8 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 35, [1] = 252, [2] = 240, [3] = 29 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 34, [1] = 49, [2] = 251, [3] = 228 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 15, [1] = 232, [2] = 220, [3] = 5 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 23, [1] = 234, [2] = 221, [3] = 10 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[11]][R[1]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[11]][R[1]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[11]][R[1]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 37, [1] = 52, [2] = 254, [3] = 231 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 } })[R[11]][R[1]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 19, [1] = 235, [2] = 220, [3] = 12 }, [4] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [5] = { [0] = 31, [1] = 248, [2] = 236, [3] = 21 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 34, [2] = 230, [3] = 210 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 }, [5] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 22, [1] = 239, [2] = 227, [3] = 16 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 235, [3] = 207 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 29, [1] = 245, [2] = 230, [3] = 22 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 21, [1] = 238, [2] = 226, [3] = 11 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 22, [1] = 35, [2] = 233, [3] = 211 }, [2] = { [0] = 24, [1] = 37, [2] = 236, [3] = 208 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 30, [1] = 246, [2] = 231, [3] = 23 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 24, [1] = 241, [2] = 229, [3] = 18 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 37, [2] = 233, [3] = 213 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 22, [1] = 233, [2] = 220, [3] = 10 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 21, [1] = 238, [2] = 225, [3] = 14 }, [5] = { [0] = 26, [1] = 243, [2] = 231, [3] = 16 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 24, [1] = 37, [2] = 235, [3] = 213 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 23, [1] = 234, [2] = 221, [3] = 11 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 22, [1] = 239, [2] = 226, [3] = 15 }, [5] = { [0] = 27, [1] = 244, [2] = 232, [3] = 17 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 39, [2] = 235, [3] = 215 }, [1] = { [0] = 25, [1] = 38, [2] = 236, [3] = 214 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 26, [1] = 41, [2] = 236, [3] = 220 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 24, [1] = 235, [2] = 222, [3] = 12 }, [3] = { [0] = 25, [1] = 241, [2] = 226, [3] = 18 }, [4] = { [0] = 26, [1] = 243, [2] = 230, [3] = 19 }, [5] = { [0] = 28, [1] = 245, [2] = 233, [3] = 18 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 27, [1] = 244, [2] = 232, [3] = 21 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 40, [2] = 236, [3] = 216 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 26, [1] = 242, [2] = 227, [3] = 19 }, [4] = { [0] = 27, [1] = 244, [2] = 231, [3] = 20 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 22, [1] = 236, [2] = 230, [3] = 13 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 26, [1] = 237, [2] = 224, [3] = 14 }, [3] = { [0] = 27, [1] = 243, [2] = 228, [3] = 20 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 29, [1] = 246, [2] = 234, [3] = 23 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 20, [1] = 231, [2] = 218, [3] = 7 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 29, [1] = 246, [2] = 233, [3] = 22 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 30, [1] = 247, [2] = 235, [3] = 24 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[11]][R[1]], ({ [0] = { [0] = 24, [1] = 238, [2] = 232, [3] = 15 }, [1] = { [0] = 21, [1] = 232, [2] = 219, [3] = 8 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 30, [1] = 247, [2] = 234, [3] = 23 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[11]][R[1]], ({ [0] = { [0] = 25, [1] = 239, [2] = 233, [3] = 16 }, [1] = { [0] = 22, [1] = 233, [2] = 220, [3] = 9 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 22, [1] = 40, [2] = 239, [3] = 213 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[11]][R[1]], ({ [0] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [1] = { [0] = 27, [1] = 238, [2] = 225, [3] = 14 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[11]][R[1]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[11]][R[1]], ({ [0] = { [0] = 32, [1] = 246, [2] = 240, [3] = 23 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 45, [2] = 241, [3] = 221 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 24, [1] = 42, [2] = 241, [3] = 215 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 46, [2] = 242, [3] = 222 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 31, [1] = 242, [2] = 229, [3] = 18 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 29, [1] = 44, [2] = 244, [3] = 222 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 32, [1] = 243, [2] = 230, [3] = 19 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 17, [1] = 234, [2] = 221, [3] = 10 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 37, [1] = 248, [2] = 235, [3] = 24 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 49, [2] = 245, [3] = 225 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 29, [1] = 42, [2] = 241, [3] = 213 }, [3] = { [0] = 28, [1] = 46, [2] = 245, [3] = 219 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 38, [1] = 249, [2] = 236, [3] = 25 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 21, [1] = 238, [2] = 226, [3] = 15 } })[R[11]][R[1]] })
    if R[11] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[1]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[1]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[1]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[1]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[1]] })
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [2] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 } })[R[29]][R[1]], ({ [0] = { [0] = 21, [1] = 235, [2] = 229, [3] = 12 }, [1] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [2] = { [0] = 33, [1] = 247, [2] = 241, [3] = 24 } })[R[29]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 1 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[1]] })
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 32, [2] = 230, [3] = 208 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 } })[R[30]][R[1]], ({ [0] = { [0] = 34, [1] = 245, [2] = 232, [3] = 21 }, [1] = { [0] = 36, [1] = 247, [2] = 234, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 } })[R[30]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[1]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 33, [2] = 232, [3] = 204 }, [1] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [2] = { [0] = 38, [1] = 51, [2] = 250, [3] = 222 } })[R[31]][R[1]], ({ [0] = { [0] = 19, [1] = 230, [2] = 217, [3] = 7 }, [1] = { [0] = 35, [1] = 246, [2] = 233, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 } })[R[31]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[1]] })
        for i = 1, game.initial_units() do
          R[32] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [1] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [2] = { [0] = 14, [1] = 32, [2] = 231, [3] = 205 } })[R[32]][R[1]], ({ [0] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [1] = { [0] = 31, [1] = 247, [2] = 232, [3] = 24 }, [2] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 } })[R[32]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
        for i = 1, game.initial_units() do
          R[33] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [1] = { [0] = 19, [1] = 34, [2] = 236, [3] = 213 }, [2] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 } })[R[33]][R[1]], ({ [0] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [1] = { [0] = 23, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 } })[R[33]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[1]] })
        for i = 1, game.initial_units() do
          R[34] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [1] = { [0] = 9, [1] = 24, [2] = 224, [3] = 202 }, [2] = { [0] = 31, [1] = 46, [2] = 246, [3] = 224 } })[R[34]][R[1]], ({ [0] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 }, [1] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [2] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 } })[R[34]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 6 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
        for i = 1, game.initial_units() do
          R[35] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 33, [2] = 228, [3] = 212 }, [1] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [2] = { [0] = 44, [1] = 59, [2] = 254, [3] = 238 } })[R[35]][R[1]], ({ [0] = { [0] = 9, [1] = 227, [2] = 219, [3] = 2 }, [1] = { [0] = 7, [1] = 225, [2] = 217, [3] = 0 }, [2] = { [0] = 22, [1] = 240, [2] = 232, [3] = 15 } })[R[35]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[1]] })
        for i = 1, game.initial_units() do
          R[36] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 }, [1] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 }, [2] = { [0] = 13, [1] = 28, [2] = 228, [3] = 207 } })[R[36]][R[1]], ({ [0] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [1] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [2] = { [0] = 36, [1] = 253, [2] = 241, [3] = 30 } })[R[36]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[11]", R[11])
    end
    R[37] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[37]][R[20]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 19, [1] = 32, [2] = 231, [3] = 203 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 17, [1] = 228, [2] = 215, [3] = 4 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    if R[37] == 0 or R[37] == 1 or R[37] == 2 or R[37] == 5 or R[37] == 6 or R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 33, [1] = 48, [2] = 243, [3] = 227 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 24, [1] = 235, [2] = 222, [3] = 11 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 29, [1] = 246, [2] = 234, [3] = 19 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 0 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[37] == 1 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[37] == 2 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[20]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[20]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[20]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[20]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[20]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[20]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 41, [1] = 56, [2] = 251, [3] = 235 })[R[20]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 41, [1] = 56, [2] = 251, [3] = 235 })[R[20]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 41, [1] = 56, [2] = 251, [3] = 235 })[R[20]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = { [0] = 21, [1] = 31, [2] = 227, [3] = 207 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 24, [1] = 39, [2] = 234, [3] = 218 }, [7] = { [0] = 30, [1] = 45, [2] = 245, [3] = 224 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 34, [1] = 245, [2] = 232, [3] = 21 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 31, [1] = 248, [2] = 236, [3] = 25 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 2 or R[37] == 5 or R[37] == 6 or R[37] == 7 then
      elseif R[37] == 0 or R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 } })[R[37]][R[20]], ({ [0] = { [0] = 34, [1] = 248, [2] = 242, [3] = 25 }, [1] = { [0] = 42, [1] = 253, [2] = 240, [3] = 29 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[37]", R[37])
      end
    elseif R[37] == 3 or R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 } })[R[37]][R[20]], ({ [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 3 then
      elseif R[37] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[37]", R[37])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 35, [1] = 50, [2] = 252, [3] = 229 } })[R[37]][R[20]], ({ [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 3 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[20]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[20]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[20]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
    else
      unseen("R[37]", R[37])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = { [0] = 21, [1] = 31, [2] = 227, [3] = 207 }, [1] = { [0] = 18, [1] = 31, [2] = 229, [3] = 207 }, [2] = { [0] = 39, [1] = 52, [2] = 251, [3] = 223 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 16, [1] = 31, [2] = 233, [3] = 210 }, [5] = { [0] = 10, [1] = 25, [2] = 225, [3] = 203 }, [6] = { [0] = 16, [1] = 31, [2] = 226, [3] = 210 }, [7] = { [0] = 22, [1] = 37, [2] = 237, [3] = 216 } })[R[37]][R[20]], ({ [0] = { [0] = 36, [1] = 250, [2] = 244, [3] = 27 }, [1] = { [0] = 39, [1] = 250, [2] = 237, [3] = 26 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 15, [1] = 231, [2] = 216, [3] = 8 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 35, [1] = 252, [2] = 240, [3] = 29 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 34, [1] = 49, [2] = 251, [3] = 228 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 15, [1] = 232, [2] = 220, [3] = 5 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 23, [1] = 234, [2] = 221, [3] = 10 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[3].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[37]][R[20]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[37]][R[20]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[37]][R[20]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 37, [1] = 52, [2] = 254, [3] = 231 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 } })[R[37]][R[20]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 19, [1] = 235, [2] = 220, [3] = 12 }, [4] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [5] = { [0] = 31, [1] = 248, [2] = 236, [3] = 21 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 34, [2] = 230, [3] = 210 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 }, [5] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 22, [1] = 239, [2] = 227, [3] = 16 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 235, [3] = 207 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 29, [1] = 245, [2] = 230, [3] = 22 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 21, [1] = 238, [2] = 226, [3] = 11 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 22, [1] = 35, [2] = 233, [3] = 211 }, [2] = { [0] = 24, [1] = 37, [2] = 236, [3] = 208 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 30, [1] = 246, [2] = 231, [3] = 23 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 24, [1] = 241, [2] = 229, [3] = 18 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 37, [2] = 233, [3] = 213 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 22, [1] = 233, [2] = 220, [3] = 10 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 21, [1] = 238, [2] = 225, [3] = 14 }, [5] = { [0] = 26, [1] = 243, [2] = 231, [3] = 16 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 24, [1] = 37, [2] = 235, [3] = 213 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 23, [1] = 234, [2] = 221, [3] = 11 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 22, [1] = 239, [2] = 226, [3] = 15 }, [5] = { [0] = 27, [1] = 244, [2] = 232, [3] = 17 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 39, [2] = 235, [3] = 215 }, [1] = { [0] = 25, [1] = 38, [2] = 236, [3] = 214 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 26, [1] = 41, [2] = 236, [3] = 220 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 24, [1] = 235, [2] = 222, [3] = 12 }, [3] = { [0] = 25, [1] = 241, [2] = 226, [3] = 18 }, [4] = { [0] = 26, [1] = 243, [2] = 230, [3] = 19 }, [5] = { [0] = 28, [1] = 245, [2] = 233, [3] = 18 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 27, [1] = 244, [2] = 232, [3] = 21 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 40, [2] = 236, [3] = 216 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 26, [1] = 242, [2] = 227, [3] = 19 }, [4] = { [0] = 27, [1] = 244, [2] = 231, [3] = 20 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 22, [1] = 236, [2] = 230, [3] = 13 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 26, [1] = 237, [2] = 224, [3] = 14 }, [3] = { [0] = 27, [1] = 243, [2] = 228, [3] = 20 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 29, [1] = 246, [2] = 234, [3] = 23 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 20, [1] = 231, [2] = 218, [3] = 7 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 29, [1] = 246, [2] = 233, [3] = 22 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 30, [1] = 247, [2] = 235, [3] = 24 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[37]][R[20]], ({ [0] = { [0] = 24, [1] = 238, [2] = 232, [3] = 15 }, [1] = { [0] = 21, [1] = 232, [2] = 219, [3] = 8 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 30, [1] = 247, [2] = 234, [3] = 23 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[37]][R[20]], ({ [0] = { [0] = 25, [1] = 239, [2] = 233, [3] = 16 }, [1] = { [0] = 22, [1] = 233, [2] = 220, [3] = 9 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 22, [1] = 40, [2] = 239, [3] = 213 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[37]][R[20]], ({ [0] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [1] = { [0] = 27, [1] = 238, [2] = 225, [3] = 14 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[37]][R[20]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[37]][R[20]], ({ [0] = { [0] = 32, [1] = 246, [2] = 240, [3] = 23 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 45, [2] = 241, [3] = 221 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 24, [1] = 42, [2] = 241, [3] = 215 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 46, [2] = 242, [3] = 222 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 31, [1] = 242, [2] = 229, [3] = 18 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 29, [1] = 44, [2] = 244, [3] = 222 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 32, [1] = 243, [2] = 230, [3] = 19 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 17, [1] = 234, [2] = 221, [3] = 10 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 37, [1] = 248, [2] = 235, [3] = 24 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 49, [2] = 245, [3] = 225 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 29, [1] = 42, [2] = 241, [3] = 213 }, [3] = { [0] = 28, [1] = 46, [2] = 245, [3] = 219 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 38, [1] = 249, [2] = 236, [3] = 25 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 21, [1] = 238, [2] = 226, [3] = 15 } })[R[37]][R[20]] })
    if R[37] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[20]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[20]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[20]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[20]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[20]] })
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [2] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 } })[R[38]][R[20]], ({ [0] = { [0] = 21, [1] = 235, [2] = 229, [3] = 12 }, [1] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [2] = { [0] = 33, [1] = 247, [2] = 241, [3] = 24 } })[R[38]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[20]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[20]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[20]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[20]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[20]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[20]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[20]] })
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 19, [1] = 32, [2] = 230, [3] = 208 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 } })[R[39]][R[20]], ({ [0] = { [0] = 34, [1] = 245, [2] = 232, [3] = 21 }, [1] = { [0] = 36, [1] = 247, [2] = 234, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 } })[R[39]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 33, [2] = 232, [3] = 204 }, [1] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [2] = { [0] = 38, [1] = 51, [2] = 250, [3] = 222 } })[R[40]][R[20]], ({ [0] = { [0] = 19, [1] = 230, [2] = 217, [3] = 7 }, [1] = { [0] = 35, [1] = 246, [2] = 233, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 } })[R[40]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[20]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[20]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[20]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[20]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[20]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[20]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[20]] })
        for i = 1, game.initial_units() do
          R[41] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [1] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [2] = { [0] = 14, [1] = 32, [2] = 231, [3] = 205 } })[R[41]][R[20]], ({ [0] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [1] = { [0] = 31, [1] = 247, [2] = 232, [3] = 24 }, [2] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 } })[R[41]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[20]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[20]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[20]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[20]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[20]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[20]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[20]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[20]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[20]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[20]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[20]] })
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [1] = { [0] = 19, [1] = 34, [2] = 236, [3] = 213 }, [2] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 } })[R[42]][R[20]], ({ [0] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [1] = { [0] = 23, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 } })[R[42]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[20]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[20]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[20]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[20]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[20]] })
        for i = 1, game.initial_units() do
          R[43] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [1] = { [0] = 9, [1] = 24, [2] = 224, [3] = 202 }, [2] = { [0] = 31, [1] = 46, [2] = 246, [3] = 224 } })[R[43]][R[20]], ({ [0] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 }, [1] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [2] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 } })[R[43]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[20]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[20]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[20]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[20]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[20]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[20]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[20]] })
        for i = 1, game.initial_units() do
          R[44] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 18, [1] = 33, [2] = 228, [3] = 212 }, [1] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [2] = { [0] = 44, [1] = 59, [2] = 254, [3] = 238 } })[R[44]][R[20]], ({ [0] = { [0] = 9, [1] = 227, [2] = 219, [3] = 2 }, [1] = { [0] = 7, [1] = 225, [2] = 217, [3] = 0 }, [2] = { [0] = 22, [1] = 240, [2] = 232, [3] = 15 } })[R[44]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[20]] })
        for i = 1, game.initial_units() do
          R[45] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 }, [1] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 }, [2] = { [0] = 13, [1] = 28, [2] = 228, [3] = 207 } })[R[45]][R[20]], ({ [0] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [1] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [2] = { [0] = 36, [1] = 253, [2] = 241, [3] = 30 } })[R[45]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[37]", R[37])
    end
    players[1]:mark_research(3303)
    players[1].workers = ({ [0] = 30, [1] = 26, [2] = 24 })[LEVEL_OF[players[1].difficulty]]
    players[1].scientists = 16 - 3 * LEVEL_OF[players[1].difficulty]
    players[1].kids = 22 - 2 * LEVEL_OF[players[1].difficulty]
    players[1].food = 3000 - 1000 * LEVEL_OF[players[1].difficulty]
    players[1].ore = 6000 - 2000 * LEVEL_OF[players[1].difficulty]
    players[({ [0] = 0, [1] = 0, [2] = 1 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3304, [1] = 3304, [2] = 3303 })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      players[1]:mark_research(3305)
      players[({ [0] = 0, [1] = 1 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3401, [1] = 3303 })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[2].difficulty] == 0 then
        players[2]:mark_research(3303)
      elseif LEVEL_OF[players[2].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    players[2].workers = ({ [0] = 30, [1] = 26, [2] = 24 })[LEVEL_OF[players[2].difficulty]]
    players[2].scientists = 16 - 3 * LEVEL_OF[players[2].difficulty]
    players[2].kids = 22 - 2 * LEVEL_OF[players[2].difficulty]
    players[2].food = 3000 - 1000 * LEVEL_OF[players[2].difficulty]
    players[2].ore = 6000 - 2000 * LEVEL_OF[players[2].difficulty]
    players[({ [0] = 1, [1] = 1, [2] = 2 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3304, [1] = 3304, [2] = 3303 })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      players[2]:mark_research(3305)
      players[({ [0] = 1, [1] = 2 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3401, [1] = 3303 })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[3].difficulty] == 0 then
        players[3]:mark_research(3303)
      elseif LEVEL_OF[players[3].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    players[3].workers = ({ [0] = 30, [1] = 26, [2] = 24 })[LEVEL_OF[players[3].difficulty]]
    players[3].scientists = 16 - 3 * LEVEL_OF[players[3].difficulty]
    players[3].kids = 22 - 2 * LEVEL_OF[players[3].difficulty]
    players[3].food = 3000 - 1000 * LEVEL_OF[players[3].difficulty]
    players[3].ore = 6000 - 2000 * LEVEL_OF[players[3].difficulty]
    if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
      players[3]:mark_research(3304)
      players[3]:mark_research(3305)
      if LEVEL_OF[players[3].difficulty] == 0 then
        players[3]:mark_research(3401)
      elseif LEVEL_OF[players[3].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif LEVEL_OF[players[3].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
    end
    game.set_daylight_everywhere(({ [0] = 1, [1] = 0 })[(game.uses_day_night() and 1 or 0)] ~= 0)
    if (game.uses_morale() and 1 or 0) == 0 then
      game.morale_steady("Good")
    elseif (game.uses_morale() and 1 or 0) == 1 then
      game.free_morale()
    else
      unseen("(game.uses_morale() and 1 or 0)", (game.uses_morale() and 1 or 0))
    end
  elseif n == 4 then
    for _, area in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(area) end
    game.initial_set_tile({ 105, 225 }, 1095)
    game.initial_set_tile({ 105, 226 }, 1118)
    game.initial_set_tile({ 106, 225 }, 1107)
    game.initial_set_tile({ 106, 226 }, 1129)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 8, 246 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 250, 248 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 240, 5 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 157, 30 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 216, 81 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 155, 102 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 174, 133 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 207, 112 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 172, 73 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 131, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 171, 227 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 194, 214 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 134, 169 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 157, 163 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 207, 152 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 233, 164 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 193, 183 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 109, 128 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 68, 146 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 63, 160 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 92, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 60, 178 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 23, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 52, 202 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 110, 33 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 112, 67 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 75, 66 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 36, 55 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 34, 92 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 72, 125 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 98, 94 } }
    pick(4, 4, { 0, 1, 20, 46 })
    R[2] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 19, [1] = 32, [2] = 231, [3] = 203 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 17, [1] = 228, [2] = 215, [3] = 4 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 0 or R[2] == 1 or R[2] == 2 or R[2] == 5 or R[2] == 6 or R[2] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 33, [1] = 48, [2] = 243, [3] = 227 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 24, [1] = 235, [2] = 222, [3] = 11 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 29, [1] = 246, [2] = 234, [3] = 19 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 0 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 1 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[0]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[0]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[0]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 41, [1] = 56, [2] = 251, [3] = 235 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 41, [1] = 56, [2] = 251, [3] = 235 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 41, [1] = 56, [2] = 251, [3] = 235 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 31, [2] = 227, [3] = 207 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 24, [1] = 39, [2] = 234, [3] = 218 }, [7] = { [0] = 30, [1] = 45, [2] = 245, [3] = 224 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 34, [1] = 245, [2] = 232, [3] = 21 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 31, [1] = 248, [2] = 236, [3] = 25 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 2 or R[2] == 5 or R[2] == 6 or R[2] == 7 then
      elseif R[2] == 0 or R[2] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 } })[R[2]][R[0]], ({ [0] = { [0] = 34, [1] = 248, [2] = 242, [3] = 25 }, [1] = { [0] = 42, [1] = 253, [2] = 240, [3] = 29 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[2]", R[2])
      end
    elseif R[2] == 3 or R[2] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 } })[R[2]][R[0]], ({ [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 20, [1] = 38, [2] = 237, [3] = 211 })[R[0]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 232, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 1 then
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[2]", R[2])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 31, [2] = 227, [3] = 207 }, [1] = { [0] = 18, [1] = 31, [2] = 229, [3] = 207 }, [2] = { [0] = 39, [1] = 52, [2] = 251, [3] = 223 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 16, [1] = 31, [2] = 233, [3] = 210 }, [5] = { [0] = 10, [1] = 25, [2] = 225, [3] = 203 }, [6] = { [0] = 16, [1] = 31, [2] = 226, [3] = 210 }, [7] = { [0] = 22, [1] = 37, [2] = 237, [3] = 216 } })[R[2]][R[0]], ({ [0] = { [0] = 36, [1] = 250, [2] = 244, [3] = 27 }, [1] = { [0] = 39, [1] = 250, [2] = 237, [3] = 26 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 15, [1] = 231, [2] = 216, [3] = 8 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 35, [1] = 252, [2] = 240, [3] = 29 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 34, [1] = 49, [2] = 251, [3] = 228 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 15, [1] = 232, [2] = 220, [3] = 5 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 23, [1] = 234, [2] = 221, [3] = 10 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[2]][R[0]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[2]][R[0]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[2]][R[0]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 37, [1] = 52, [2] = 254, [3] = 231 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 } })[R[2]][R[0]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 19, [1] = 235, [2] = 220, [3] = 12 }, [4] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [5] = { [0] = 31, [1] = 248, [2] = 236, [3] = 21 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[2]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 34, [2] = 230, [3] = 210 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 }, [5] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 22, [1] = 239, [2] = 227, [3] = 16 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 235, [3] = 207 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 29, [1] = 245, [2] = 230, [3] = 22 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 21, [1] = 238, [2] = 226, [3] = 11 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 22, [1] = 35, [2] = 233, [3] = 211 }, [2] = { [0] = 24, [1] = 37, [2] = 236, [3] = 208 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 30, [1] = 246, [2] = 231, [3] = 23 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 24, [1] = 241, [2] = 229, [3] = 18 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 37, [2] = 233, [3] = 213 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 22, [1] = 233, [2] = 220, [3] = 10 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 21, [1] = 238, [2] = 225, [3] = 14 }, [5] = { [0] = 26, [1] = 243, [2] = 231, [3] = 16 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 24, [1] = 37, [2] = 235, [3] = 213 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 23, [1] = 234, [2] = 221, [3] = 11 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 22, [1] = 239, [2] = 226, [3] = 15 }, [5] = { [0] = 27, [1] = 244, [2] = 232, [3] = 17 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 39, [2] = 235, [3] = 215 }, [1] = { [0] = 25, [1] = 38, [2] = 236, [3] = 214 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 26, [1] = 41, [2] = 236, [3] = 220 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 24, [1] = 235, [2] = 222, [3] = 12 }, [3] = { [0] = 25, [1] = 241, [2] = 226, [3] = 18 }, [4] = { [0] = 26, [1] = 243, [2] = 230, [3] = 19 }, [5] = { [0] = 28, [1] = 245, [2] = 233, [3] = 18 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 27, [1] = 244, [2] = 232, [3] = 21 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 40, [2] = 236, [3] = 216 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 26, [1] = 242, [2] = 227, [3] = 19 }, [4] = { [0] = 27, [1] = 244, [2] = 231, [3] = 20 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 22, [1] = 236, [2] = 230, [3] = 13 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 26, [1] = 237, [2] = 224, [3] = 14 }, [3] = { [0] = 27, [1] = 243, [2] = 228, [3] = 20 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 29, [1] = 246, [2] = 234, [3] = 23 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[2]][R[0]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 20, [1] = 231, [2] = 218, [3] = 7 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 29, [1] = 246, [2] = 233, [3] = 22 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 30, [1] = 247, [2] = 235, [3] = 24 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[2]][R[0]], ({ [0] = { [0] = 24, [1] = 238, [2] = 232, [3] = 15 }, [1] = { [0] = 21, [1] = 232, [2] = 219, [3] = 8 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 30, [1] = 247, [2] = 234, [3] = 23 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[2]][R[0]], ({ [0] = { [0] = 25, [1] = 239, [2] = 233, [3] = 16 }, [1] = { [0] = 22, [1] = 233, [2] = 220, [3] = 9 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[2]][R[0]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 22, [1] = 40, [2] = 239, [3] = 213 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[2]][R[0]], ({ [0] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [1] = { [0] = 27, [1] = 238, [2] = 225, [3] = 14 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[2]][R[0]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[2]][R[0]], ({ [0] = { [0] = 32, [1] = 246, [2] = 240, [3] = 23 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 45, [2] = 241, [3] = 221 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 24, [1] = 42, [2] = 241, [3] = 215 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 46, [2] = 242, [3] = 222 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 31, [1] = 242, [2] = 229, [3] = 18 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 29, [1] = 44, [2] = 244, [3] = 222 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 32, [1] = 243, [2] = 230, [3] = 19 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 17, [1] = 234, [2] = 221, [3] = 10 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 37, [1] = 248, [2] = 235, [3] = 24 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[2]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 49, [2] = 245, [3] = 225 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 29, [1] = 42, [2] = 241, [3] = 213 }, [3] = { [0] = 28, [1] = 46, [2] = 245, [3] = 219 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[2]][R[0]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 38, [1] = 249, [2] = 236, [3] = 25 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 21, [1] = 238, [2] = 226, [3] = 15 } })[R[2]][R[0]] })
    if R[2] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[0]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[0]] })
        for i = 1, game.initial_units() do
          R[47] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [2] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 } })[R[47]][R[0]], ({ [0] = { [0] = 21, [1] = 235, [2] = 229, [3] = 12 }, [1] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [2] = { [0] = 33, [1] = 247, [2] = 241, [3] = 24 } })[R[47]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 1 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[0]] })
        for i = 1, game.initial_units() do
          R[48] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 32, [2] = 230, [3] = 208 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 } })[R[48]][R[0]], ({ [0] = { [0] = 34, [1] = 245, [2] = 232, [3] = 21 }, [1] = { [0] = 36, [1] = 247, [2] = 234, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 } })[R[48]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[0]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[0]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[49] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 33, [2] = 232, [3] = 204 }, [1] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [2] = { [0] = 38, [1] = 51, [2] = 250, [3] = 222 } })[R[49]][R[0]], ({ [0] = { [0] = 19, [1] = 230, [2] = 217, [3] = 7 }, [1] = { [0] = 35, [1] = 246, [2] = 233, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 } })[R[49]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[0]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[0]] })
        for i = 1, game.initial_units() do
          R[50] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [1] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [2] = { [0] = 14, [1] = 32, [2] = 231, [3] = 205 } })[R[50]][R[0]], ({ [0] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [1] = { [0] = 31, [1] = 247, [2] = 232, [3] = 24 }, [2] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 } })[R[50]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 4 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
        for i = 1, game.initial_units() do
          R[51] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [1] = { [0] = 19, [1] = 34, [2] = 236, [3] = 213 }, [2] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 } })[R[51]][R[0]], ({ [0] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [1] = { [0] = 23, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 } })[R[51]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[0]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[0]] })
        for i = 1, game.initial_units() do
          R[52] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [1] = { [0] = 9, [1] = 24, [2] = 224, [3] = 202 }, [2] = { [0] = 31, [1] = 46, [2] = 246, [3] = 224 } })[R[52]][R[0]], ({ [0] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 }, [1] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [2] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 } })[R[52]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 6 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
        for i = 1, game.initial_units() do
          R[53] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 33, [2] = 228, [3] = 212 }, [1] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [2] = { [0] = 44, [1] = 59, [2] = 254, [3] = 238 } })[R[53]][R[0]], ({ [0] = { [0] = 9, [1] = 227, [2] = 219, [3] = 2 }, [1] = { [0] = 7, [1] = 225, [2] = 217, [3] = 0 }, [2] = { [0] = 22, [1] = 240, [2] = 232, [3] = 15 } })[R[53]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[0]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[0]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[0]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[0]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[0]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[0]] })
        for i = 1, game.initial_units() do
          R[54] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 }, [1] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 }, [2] = { [0] = 13, [1] = 28, [2] = 228, [3] = 207 } })[R[54]][R[0]], ({ [0] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [1] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [2] = { [0] = 36, [1] = 253, [2] = 241, [3] = 30 } })[R[54]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[2]", R[2])
    end
    R[11] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 19, [1] = 32, [2] = 231, [3] = 203 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 17, [1] = 228, [2] = 215, [3] = 4 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 0 or R[11] == 1 or R[11] == 2 or R[11] == 5 or R[11] == 6 or R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 33, [1] = 48, [2] = 243, [3] = 227 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 24, [1] = 235, [2] = 222, [3] = 11 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 29, [1] = 246, [2] = 234, [3] = 19 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 0 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[11] == 1 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[11] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[1]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[1]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 44, [2] = 243, [3] = 215 })[R[1]], ({ [0] = 25, [1] = 236, [2] = 223, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 56, [2] = 251, [3] = 235 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 56, [2] = 251, [3] = 235 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 56, [2] = 251, [3] = 235 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 31, [2] = 227, [3] = 207 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 24, [1] = 39, [2] = 234, [3] = 218 }, [7] = { [0] = 30, [1] = 45, [2] = 245, [3] = 224 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 34, [1] = 245, [2] = 232, [3] = 21 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 31, [1] = 248, [2] = 236, [3] = 25 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 2 or R[11] == 5 or R[11] == 6 or R[11] == 7 then
      elseif R[11] == 0 or R[11] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 } })[R[11]][R[1]], ({ [0] = { [0] = 34, [1] = 248, [2] = 242, [3] = 25 }, [1] = { [0] = 42, [1] = 253, [2] = 240, [3] = 29 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[11]", R[11])
      end
    elseif R[11] == 3 or R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 } })[R[11]][R[1]], ({ [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 3 then
      elseif R[11] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[11]", R[11])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 35, [1] = 50, [2] = 252, [3] = 229 } })[R[11]][R[1]], ({ [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 3 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
    else
      unseen("R[11]", R[11])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 31, [2] = 227, [3] = 207 }, [1] = { [0] = 18, [1] = 31, [2] = 229, [3] = 207 }, [2] = { [0] = 39, [1] = 52, [2] = 251, [3] = 223 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 16, [1] = 31, [2] = 233, [3] = 210 }, [5] = { [0] = 10, [1] = 25, [2] = 225, [3] = 203 }, [6] = { [0] = 16, [1] = 31, [2] = 226, [3] = 210 }, [7] = { [0] = 22, [1] = 37, [2] = 237, [3] = 216 } })[R[11]][R[1]], ({ [0] = { [0] = 36, [1] = 250, [2] = 244, [3] = 27 }, [1] = { [0] = 39, [1] = 250, [2] = 237, [3] = 26 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 15, [1] = 231, [2] = 216, [3] = 8 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 35, [1] = 252, [2] = 240, [3] = 29 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 34, [1] = 49, [2] = 251, [3] = 228 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 15, [1] = 232, [2] = 220, [3] = 5 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 23, [1] = 234, [2] = 221, [3] = 10 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[11]][R[1]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[11]][R[1]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[11]][R[1]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 37, [1] = 52, [2] = 254, [3] = 231 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 } })[R[11]][R[1]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 19, [1] = 235, [2] = 220, [3] = 12 }, [4] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [5] = { [0] = 31, [1] = 248, [2] = 236, [3] = 21 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 34, [2] = 230, [3] = 210 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 }, [5] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 22, [1] = 239, [2] = 227, [3] = 16 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 235, [3] = 207 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 29, [1] = 245, [2] = 230, [3] = 22 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 21, [1] = 238, [2] = 226, [3] = 11 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 22, [1] = 35, [2] = 233, [3] = 211 }, [2] = { [0] = 24, [1] = 37, [2] = 236, [3] = 208 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 30, [1] = 246, [2] = 231, [3] = 23 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 24, [1] = 241, [2] = 229, [3] = 18 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 37, [2] = 233, [3] = 213 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 22, [1] = 233, [2] = 220, [3] = 10 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 21, [1] = 238, [2] = 225, [3] = 14 }, [5] = { [0] = 26, [1] = 243, [2] = 231, [3] = 16 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 24, [1] = 37, [2] = 235, [3] = 213 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 23, [1] = 234, [2] = 221, [3] = 11 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 22, [1] = 239, [2] = 226, [3] = 15 }, [5] = { [0] = 27, [1] = 244, [2] = 232, [3] = 17 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 39, [2] = 235, [3] = 215 }, [1] = { [0] = 25, [1] = 38, [2] = 236, [3] = 214 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 26, [1] = 41, [2] = 236, [3] = 220 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 24, [1] = 235, [2] = 222, [3] = 12 }, [3] = { [0] = 25, [1] = 241, [2] = 226, [3] = 18 }, [4] = { [0] = 26, [1] = 243, [2] = 230, [3] = 19 }, [5] = { [0] = 28, [1] = 245, [2] = 233, [3] = 18 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 27, [1] = 244, [2] = 232, [3] = 21 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 40, [2] = 236, [3] = 216 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 26, [1] = 242, [2] = 227, [3] = 19 }, [4] = { [0] = 27, [1] = 244, [2] = 231, [3] = 20 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 22, [1] = 236, [2] = 230, [3] = 13 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 26, [1] = 237, [2] = 224, [3] = 14 }, [3] = { [0] = 27, [1] = 243, [2] = 228, [3] = 20 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 29, [1] = 246, [2] = 234, [3] = 23 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[11]][R[1]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 20, [1] = 231, [2] = 218, [3] = 7 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 29, [1] = 246, [2] = 233, [3] = 22 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 30, [1] = 247, [2] = 235, [3] = 24 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[11]][R[1]], ({ [0] = { [0] = 24, [1] = 238, [2] = 232, [3] = 15 }, [1] = { [0] = 21, [1] = 232, [2] = 219, [3] = 8 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 30, [1] = 247, [2] = 234, [3] = 23 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[11]][R[1]], ({ [0] = { [0] = 25, [1] = 239, [2] = 233, [3] = 16 }, [1] = { [0] = 22, [1] = 233, [2] = 220, [3] = 9 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[11]][R[1]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 22, [1] = 40, [2] = 239, [3] = 213 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[11]][R[1]], ({ [0] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [1] = { [0] = 27, [1] = 238, [2] = 225, [3] = 14 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[11]][R[1]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[11]][R[1]], ({ [0] = { [0] = 32, [1] = 246, [2] = 240, [3] = 23 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 45, [2] = 241, [3] = 221 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 24, [1] = 42, [2] = 241, [3] = 215 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 46, [2] = 242, [3] = 222 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 31, [1] = 242, [2] = 229, [3] = 18 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 29, [1] = 44, [2] = 244, [3] = 222 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 32, [1] = 243, [2] = 230, [3] = 19 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 17, [1] = 234, [2] = 221, [3] = 10 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 37, [1] = 248, [2] = 235, [3] = 24 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[11]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 49, [2] = 245, [3] = 225 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 29, [1] = 42, [2] = 241, [3] = 213 }, [3] = { [0] = 28, [1] = 46, [2] = 245, [3] = 219 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[11]][R[1]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 38, [1] = 249, [2] = 236, [3] = 25 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 21, [1] = 238, [2] = 226, [3] = 15 } })[R[11]][R[1]] })
    if R[11] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[1]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[1]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[1]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[1]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[1]] })
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [2] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 } })[R[55]][R[1]], ({ [0] = { [0] = 21, [1] = 235, [2] = 229, [3] = 12 }, [1] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [2] = { [0] = 33, [1] = 247, [2] = 241, [3] = 24 } })[R[55]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[1]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[1]] })
        for i = 1, game.initial_units() do
          R[56] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 32, [2] = 230, [3] = 208 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 } })[R[56]][R[1]], ({ [0] = { [0] = 34, [1] = 245, [2] = 232, [3] = 21 }, [1] = { [0] = 36, [1] = 247, [2] = 234, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 } })[R[56]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[57] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 33, [2] = 232, [3] = 204 }, [1] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [2] = { [0] = 38, [1] = 51, [2] = 250, [3] = 222 } })[R[57]][R[1]], ({ [0] = { [0] = 19, [1] = 230, [2] = 217, [3] = 7 }, [1] = { [0] = 35, [1] = 246, [2] = 233, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 } })[R[57]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[1]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[1]] })
        for i = 1, game.initial_units() do
          R[58] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [1] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [2] = { [0] = 14, [1] = 32, [2] = 231, [3] = 205 } })[R[58]][R[1]], ({ [0] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [1] = { [0] = 31, [1] = 247, [2] = 232, [3] = 24 }, [2] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 } })[R[58]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[1]] })
        for i = 1, game.initial_units() do
          R[59] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [1] = { [0] = 19, [1] = 34, [2] = 236, [3] = 213 }, [2] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 } })[R[59]][R[1]], ({ [0] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [1] = { [0] = 23, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 } })[R[59]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[1]] })
        for i = 1, game.initial_units() do
          R[60] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [1] = { [0] = 9, [1] = 24, [2] = 224, [3] = 202 }, [2] = { [0] = 31, [1] = 46, [2] = 246, [3] = 224 } })[R[60]][R[1]], ({ [0] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 }, [1] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [2] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 } })[R[60]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[1]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[1]] })
        for i = 1, game.initial_units() do
          R[61] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 33, [2] = 228, [3] = 212 }, [1] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [2] = { [0] = 44, [1] = 59, [2] = 254, [3] = 238 } })[R[61]][R[1]], ({ [0] = { [0] = 9, [1] = 227, [2] = 219, [3] = 2 }, [1] = { [0] = 7, [1] = 225, [2] = 217, [3] = 0 }, [2] = { [0] = 22, [1] = 240, [2] = 232, [3] = 15 } })[R[61]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[1]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[1]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[1]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[1]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[1]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[1]] })
        for i = 1, game.initial_units() do
          R[62] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 }, [1] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 }, [2] = { [0] = 13, [1] = 28, [2] = 228, [3] = 207 } })[R[62]][R[1]], ({ [0] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [1] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [2] = { [0] = 36, [1] = 253, [2] = 241, [3] = 30 } })[R[62]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[11]", R[11])
    end
    R[37] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[37]][R[20]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 19, [1] = 32, [2] = 231, [3] = 203 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 17, [1] = 228, [2] = 215, [3] = 4 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    if R[37] == 0 or R[37] == 1 or R[37] == 2 or R[37] == 5 or R[37] == 6 or R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 33, [1] = 48, [2] = 243, [3] = 227 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 24, [1] = 235, [2] = 222, [3] = 11 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 29, [1] = 246, [2] = 234, [3] = 19 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 0 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 21, [1] = 31, [2] = 227, [3] = 207 })[R[20]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 21, [1] = 31, [2] = 227, [3] = 207 })[R[20]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 21, [1] = 31, [2] = 227, [3] = 207 })[R[20]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 1 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[20]], ({ [0] = 34, [1] = 245, [2] = 232, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[20]], ({ [0] = 34, [1] = 245, [2] = 232, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[20]], ({ [0] = 34, [1] = 245, [2] = 232, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[37] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[37] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[37] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 41, [1] = 56, [2] = 251, [3] = 235 }, [7] = { [0] = 29, [1] = 44, [2] = 244, [3] = 223 } })[R[37]][R[20]], ({ [0] = { [0] = 34, [1] = 248, [2] = 242, [3] = 25 }, [1] = { [0] = 42, [1] = 253, [2] = 240, [3] = 29 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 2 or R[37] == 5 or R[37] == 6 or R[37] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 24, [1] = 39, [2] = 234, [3] = 218 }, [7] = { [0] = 30, [1] = 45, [2] = 245, [3] = 224 } })[R[37]][R[20]], ({ [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 31, [1] = 248, [2] = 236, [3] = 25 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 0 or R[37] == 1 then
      else
        unseen("R[37]", R[37])
      end
    elseif R[37] == 3 or R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 } })[R[37]][R[20]], ({ [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 28, [1] = 245, [2] = 232, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 20, [1] = 38, [2] = 237, [3] = 211 })[R[20]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[20]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[37]", R[37])
      end
    else
      unseen("R[37]", R[37])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = { [0] = 21, [1] = 31, [2] = 227, [3] = 207 }, [1] = { [0] = 18, [1] = 31, [2] = 229, [3] = 207 }, [2] = { [0] = 39, [1] = 52, [2] = 251, [3] = 223 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 16, [1] = 31, [2] = 233, [3] = 210 }, [5] = { [0] = 10, [1] = 25, [2] = 225, [3] = 203 }, [6] = { [0] = 16, [1] = 31, [2] = 226, [3] = 210 }, [7] = { [0] = 22, [1] = 37, [2] = 237, [3] = 216 } })[R[37]][R[20]], ({ [0] = { [0] = 36, [1] = 250, [2] = 244, [3] = 27 }, [1] = { [0] = 39, [1] = 250, [2] = 237, [3] = 26 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 15, [1] = 231, [2] = 216, [3] = 8 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 35, [1] = 252, [2] = 240, [3] = 29 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 34, [1] = 49, [2] = 251, [3] = 228 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 15, [1] = 232, [2] = 220, [3] = 5 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 23, [1] = 234, [2] = 221, [3] = 10 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[3].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[37]][R[20]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[37]][R[20]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[37]][R[20]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 37, [1] = 52, [2] = 254, [3] = 231 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 } })[R[37]][R[20]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 19, [1] = 235, [2] = 220, [3] = 12 }, [4] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [5] = { [0] = 31, [1] = 248, [2] = 236, [3] = 21 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 34, [2] = 230, [3] = 210 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 }, [5] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 22, [1] = 239, [2] = 227, [3] = 16 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 235, [3] = 207 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 29, [1] = 245, [2] = 230, [3] = 22 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 21, [1] = 238, [2] = 226, [3] = 11 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 22, [1] = 35, [2] = 233, [3] = 211 }, [2] = { [0] = 24, [1] = 37, [2] = 236, [3] = 208 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 30, [1] = 246, [2] = 231, [3] = 23 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 24, [1] = 241, [2] = 229, [3] = 18 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 37, [2] = 233, [3] = 213 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 22, [1] = 233, [2] = 220, [3] = 10 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 21, [1] = 238, [2] = 225, [3] = 14 }, [5] = { [0] = 26, [1] = 243, [2] = 231, [3] = 16 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 24, [1] = 37, [2] = 235, [3] = 213 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 23, [1] = 234, [2] = 221, [3] = 11 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 22, [1] = 239, [2] = 226, [3] = 15 }, [5] = { [0] = 27, [1] = 244, [2] = 232, [3] = 17 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 39, [2] = 235, [3] = 215 }, [1] = { [0] = 25, [1] = 38, [2] = 236, [3] = 214 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 26, [1] = 41, [2] = 236, [3] = 220 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 24, [1] = 235, [2] = 222, [3] = 12 }, [3] = { [0] = 25, [1] = 241, [2] = 226, [3] = 18 }, [4] = { [0] = 26, [1] = 243, [2] = 230, [3] = 19 }, [5] = { [0] = 28, [1] = 245, [2] = 233, [3] = 18 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 27, [1] = 244, [2] = 232, [3] = 21 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 40, [2] = 236, [3] = 216 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 26, [1] = 242, [2] = 227, [3] = 19 }, [4] = { [0] = 27, [1] = 244, [2] = 231, [3] = 20 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 22, [1] = 236, [2] = 230, [3] = 13 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 26, [1] = 237, [2] = 224, [3] = 14 }, [3] = { [0] = 27, [1] = 243, [2] = 228, [3] = 20 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 29, [1] = 246, [2] = 234, [3] = 23 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 20, [1] = 231, [2] = 218, [3] = 7 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 29, [1] = 246, [2] = 233, [3] = 22 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 30, [1] = 247, [2] = 235, [3] = 24 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[37]][R[20]], ({ [0] = { [0] = 24, [1] = 238, [2] = 232, [3] = 15 }, [1] = { [0] = 21, [1] = 232, [2] = 219, [3] = 8 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 30, [1] = 247, [2] = 234, [3] = 23 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[37]][R[20]], ({ [0] = { [0] = 25, [1] = 239, [2] = 233, [3] = 16 }, [1] = { [0] = 22, [1] = 233, [2] = 220, [3] = 9 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[37]][R[20]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 22, [1] = 40, [2] = 239, [3] = 213 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[37]][R[20]], ({ [0] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [1] = { [0] = 27, [1] = 238, [2] = 225, [3] = 14 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[37]][R[20]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[37]][R[20]], ({ [0] = { [0] = 32, [1] = 246, [2] = 240, [3] = 23 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 45, [2] = 241, [3] = 221 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 24, [1] = 42, [2] = 241, [3] = 215 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 46, [2] = 242, [3] = 222 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 31, [1] = 242, [2] = 229, [3] = 18 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 29, [1] = 44, [2] = 244, [3] = 222 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 32, [1] = 243, [2] = 230, [3] = 19 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 17, [1] = 234, [2] = 221, [3] = 10 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 37, [1] = 248, [2] = 235, [3] = 24 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 49, [2] = 245, [3] = 225 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 29, [1] = 42, [2] = 241, [3] = 213 }, [3] = { [0] = 28, [1] = 46, [2] = 245, [3] = 219 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[37]][R[20]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 38, [1] = 249, [2] = 236, [3] = 25 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 21, [1] = 238, [2] = 226, [3] = 15 } })[R[37]][R[20]] })
    if R[37] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[20]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[20]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[20]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[20]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[20]] })
        for i = 1, game.initial_units() do
          R[63] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [2] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 } })[R[63]][R[20]], ({ [0] = { [0] = 21, [1] = 235, [2] = 229, [3] = 12 }, [1] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [2] = { [0] = 33, [1] = 247, [2] = 241, [3] = 24 } })[R[63]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[20]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[20]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[20]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[20]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[20]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[20]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[20]] })
        for i = 1, game.initial_units() do
          R[64] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 19, [1] = 32, [2] = 230, [3] = 208 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 } })[R[64]][R[20]], ({ [0] = { [0] = 34, [1] = 245, [2] = 232, [3] = 21 }, [1] = { [0] = 36, [1] = 247, [2] = 234, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 } })[R[64]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[65] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 33, [2] = 232, [3] = 204 }, [1] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [2] = { [0] = 38, [1] = 51, [2] = 250, [3] = 222 } })[R[65]][R[20]], ({ [0] = { [0] = 19, [1] = 230, [2] = 217, [3] = 7 }, [1] = { [0] = 35, [1] = 246, [2] = 233, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 } })[R[65]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[20]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[20]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[20]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[20]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[20]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[20]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[20]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[20]] })
        for i = 1, game.initial_units() do
          R[66] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [1] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [2] = { [0] = 14, [1] = 32, [2] = 231, [3] = 205 } })[R[66]][R[20]], ({ [0] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [1] = { [0] = 31, [1] = 247, [2] = 232, [3] = 24 }, [2] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 } })[R[66]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[20]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[20]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[20]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[20]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[20]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[20]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[20]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[20]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[20]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[20]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[20]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[20]] })
        for i = 1, game.initial_units() do
          R[67] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [1] = { [0] = 19, [1] = 34, [2] = 236, [3] = 213 }, [2] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 } })[R[67]][R[20]], ({ [0] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [1] = { [0] = 23, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 } })[R[67]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[20]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[20]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[20]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[20]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[20]] })
        for i = 1, game.initial_units() do
          R[68] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [1] = { [0] = 9, [1] = 24, [2] = 224, [3] = 202 }, [2] = { [0] = 31, [1] = 46, [2] = 246, [3] = 224 } })[R[68]][R[20]], ({ [0] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 }, [1] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [2] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 } })[R[68]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[20]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[20]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[20]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[20]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[20]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[20]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[20]] })
        for i = 1, game.initial_units() do
          R[69] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 18, [1] = 33, [2] = 228, [3] = 212 }, [1] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [2] = { [0] = 44, [1] = 59, [2] = 254, [3] = 238 } })[R[69]][R[20]], ({ [0] = { [0] = 9, [1] = 227, [2] = 219, [3] = 2 }, [1] = { [0] = 7, [1] = 225, [2] = 217, [3] = 0 }, [2] = { [0] = 22, [1] = 240, [2] = 232, [3] = 15 } })[R[69]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 7 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[20]] })
        for i = 1, game.initial_units() do
          R[70] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 }, [1] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 }, [2] = { [0] = 13, [1] = 28, [2] = 228, [3] = 207 } })[R[70]][R[20]], ({ [0] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [1] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [2] = { [0] = 36, [1] = 253, [2] = 241, [3] = 30 } })[R[70]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[20]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[20]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[20]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[20]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[37]", R[37])
    end
    R[71] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[71]][R[46]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    players[4]:center_view({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[71]][R[46]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 20, [1] = 231, [2] = 218, [3] = 8 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[71]][R[46]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 19, [1] = 32, [2] = 231, [3] = 203 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[71]][R[46]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 17, [1] = 228, [2] = 215, [3] = 4 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    if R[71] == 0 or R[71] == 1 or R[71] == 2 or R[71] == 5 or R[71] == 6 or R[71] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 33, [1] = 48, [2] = 243, [3] = 227 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[71]][R[46]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 24, [1] = 235, [2] = 222, [3] = 11 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 29, [1] = 246, [2] = 234, [3] = 19 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 0 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 21, [1] = 31, [2] = 227, [3] = 207 })[R[46]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 21, [1] = 31, [2] = 227, [3] = 207 })[R[46]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 21, [1] = 31, [2] = 227, [3] = 207 })[R[46]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 1 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[46]], ({ [0] = 34, [1] = 245, [2] = 232, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[46]], ({ [0] = 34, [1] = 245, [2] = 232, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[46]], ({ [0] = 34, [1] = 245, [2] = 232, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[71] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[71] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[71] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[71]", R[71])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 41, [1] = 56, [2] = 251, [3] = 235 }, [7] = { [0] = 29, [1] = 44, [2] = 244, [3] = 223 } })[R[71]][R[46]], ({ [0] = { [0] = 34, [1] = 248, [2] = 242, [3] = 25 }, [1] = { [0] = 42, [1] = 253, [2] = 240, [3] = 29 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 2 or R[71] == 5 or R[71] == 6 or R[71] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 24, [1] = 39, [2] = 234, [3] = 218 }, [7] = { [0] = 30, [1] = 45, [2] = 245, [3] = 224 } })[R[71]][R[46]], ({ [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 31, [1] = 248, [2] = 236, [3] = 25 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 0 or R[71] == 1 then
      else
        unseen("R[71]", R[71])
      end
    elseif R[71] == 3 or R[71] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 } })[R[71]][R[46]], ({ [3] = { [0] = 32, [1] = 248, [2] = 233, [3] = 25 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[46]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 3 then
      else
        unseen("R[71]", R[71])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 35, [1] = 50, [2] = 252, [3] = 229 } })[R[71]][R[46]], ({ [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 3 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[46]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[46]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[46]], ({ [0] = 21, [1] = 237, [2] = 222, [3] = 14 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[71]", R[71])
      end
    else
      unseen("R[71]", R[71])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = { [0] = 21, [1] = 31, [2] = 227, [3] = 207 }, [1] = { [0] = 18, [1] = 31, [2] = 229, [3] = 207 }, [2] = { [0] = 39, [1] = 52, [2] = 251, [3] = 223 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 16, [1] = 31, [2] = 233, [3] = 210 }, [5] = { [0] = 10, [1] = 25, [2] = 225, [3] = 203 }, [6] = { [0] = 16, [1] = 31, [2] = 226, [3] = 210 }, [7] = { [0] = 22, [1] = 37, [2] = 237, [3] = 216 } })[R[71]][R[46]], ({ [0] = { [0] = 36, [1] = 250, [2] = 244, [3] = 27 }, [1] = { [0] = 39, [1] = 250, [2] = 237, [3] = 26 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 15, [1] = 231, [2] = 216, [3] = 8 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 35, [1] = 252, [2] = 240, [3] = 29 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 34, [1] = 49, [2] = 251, [3] = 228 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[71]][R[46]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 15, [1] = 232, [2] = 220, [3] = 5 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[71]][R[46]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 23, [1] = 234, [2] = 221, [3] = 10 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[4].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[71]][R[46]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[71]][R[46]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[71]][R[46]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[71]][R[46]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[71]][R[46]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[71]][R[46]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[71]][R[46]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[4].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[71]][R[46]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[71]][R[46]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 17, [1] = 30, [2] = 228, [3] = 206 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 36, [1] = 51, [2] = 253, [3] = 230 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 21, [1] = 36, [2] = 231, [3] = 215 }, [7] = { [0] = 32, [1] = 47, [2] = 247, [3] = 226 } })[R[71]][R[46]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 17, [1] = 234, [2] = 222, [3] = 7 }, [6] = { [0] = 24, [1] = 242, [2] = 234, [3] = 17 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[71]][R[46]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 15, [1] = 33, [2] = 232, [3] = 206 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[71]][R[46]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[71]][R[46]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[4].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 35, [1] = 53, [2] = 252, [3] = 226 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[71]][R[46]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 22, [1] = 238, [2] = 223, [3] = 15 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 17, [1] = 30, [2] = 229, [3] = 201 }, [3] = { [0] = 33, [1] = 51, [2] = 250, [3] = 224 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 31, [1] = 46, [2] = 246, [3] = 225 } })[R[71]][R[46]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 25, [1] = 236, [2] = 223, [3] = 12 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 18, [1] = 234, [2] = 219, [3] = 11 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 35, [1] = 48, [2] = 247, [3] = 219 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 15, [1] = 30, [2] = 230, [3] = 208 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 16, [1] = 31, [2] = 231, [3] = 210 } })[R[71]][R[46]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 33, [1] = 244, [2] = 231, [3] = 21 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 14, [1] = 231, [2] = 219, [3] = 4 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 23, [1] = 33, [2] = 229, [3] = 209 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 31, [1] = 44, [2] = 243, [3] = 215 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 31, [1] = 46, [2] = 248, [3] = 225 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 11, [1] = 26, [2] = 226, [3] = 205 } })[R[71]][R[46]], ({ [0] = { [0] = 20, [1] = 234, [2] = 228, [3] = 11 }, [1] = { [0] = 16, [1] = 227, [2] = 214, [3] = 3 }, [2] = { [0] = 34, [1] = 245, [2] = 232, [3] = 22 }, [3] = { [0] = 33, [1] = 249, [2] = 234, [3] = 26 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 18, [1] = 236, [2] = 228, [3] = 11 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = { [0] = 44, [1] = 54, [2] = 250, [3] = 230 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 37, [1] = 52, [2] = 254, [3] = 231 }, [5] = { [0] = 16, [1] = 31, [2] = 231, [3] = 209 }, [6] = { [0] = 37, [1] = 52, [2] = 247, [3] = 231 }, [7] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 } })[R[71]][R[46]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 19, [1] = 235, [2] = 220, [3] = 12 }, [4] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [5] = { [0] = 31, [1] = 248, [2] = 236, [3] = 21 }, [6] = { [0] = 21, [1] = 239, [2] = 231, [3] = 14 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 34, [2] = 230, [3] = 210 }, [1] = { [0] = 20, [1] = 33, [2] = 231, [3] = 209 }, [2] = { [0] = 22, [1] = 35, [2] = 234, [3] = 206 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[71]][R[46]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 }, [5] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 22, [1] = 239, [2] = 227, [3] = 16 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 235, [3] = 207 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[71]][R[46]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 29, [1] = 245, [2] = 230, [3] = 22 }, [4] = { [0] = 19, [1] = 236, [2] = 223, [3] = 12 }, [5] = { [0] = 21, [1] = 238, [2] = 226, [3] = 11 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 23, [1] = 240, [2] = 228, [3] = 17 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 36, [2] = 232, [3] = 212 }, [1] = { [0] = 22, [1] = 35, [2] = 233, [3] = 211 }, [2] = { [0] = 24, [1] = 37, [2] = 236, [3] = 208 }, [3] = { [0] = 17, [1] = 35, [2] = 234, [3] = 208 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[71]][R[46]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 30, [1] = 246, [2] = 231, [3] = 23 }, [4] = { [0] = 20, [1] = 237, [2] = 224, [3] = 13 }, [5] = { [0] = 22, [1] = 239, [2] = 227, [3] = 12 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 24, [1] = 241, [2] = 229, [3] = 18 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 37, [2] = 233, [3] = 213 }, [1] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 18, [1] = 36, [2] = 235, [3] = 209 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[71]][R[46]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 22, [1] = 233, [2] = 220, [3] = 10 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 21, [1] = 238, [2] = 225, [3] = 14 }, [5] = { [0] = 26, [1] = 243, [2] = 231, [3] = 16 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 25, [1] = 242, [2] = 230, [3] = 19 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 38, [2] = 234, [3] = 214 }, [1] = { [0] = 24, [1] = 37, [2] = 235, [3] = 213 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[71]][R[46]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 23, [1] = 234, [2] = 221, [3] = 11 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 22, [1] = 239, [2] = 226, [3] = 15 }, [5] = { [0] = 27, [1] = 244, [2] = 232, [3] = 17 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 26, [1] = 243, [2] = 231, [3] = 20 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 39, [2] = 235, [3] = 215 }, [1] = { [0] = 25, [1] = 38, [2] = 236, [3] = 214 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 20, [1] = 35, [2] = 235, [3] = 213 }, [6] = { [0] = 26, [1] = 41, [2] = 236, [3] = 220 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[71]][R[46]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 24, [1] = 235, [2] = 222, [3] = 12 }, [3] = { [0] = 25, [1] = 241, [2] = 226, [3] = 18 }, [4] = { [0] = 26, [1] = 243, [2] = 230, [3] = 19 }, [5] = { [0] = 28, [1] = 245, [2] = 233, [3] = 18 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 27, [1] = 244, [2] = 232, [3] = 21 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 40, [2] = 236, [3] = 216 }, [1] = { [0] = 26, [1] = 39, [2] = 237, [3] = 215 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[71]][R[46]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 26, [1] = 242, [2] = 227, [3] = 19 }, [4] = { [0] = 27, [1] = 244, [2] = 231, [3] = 20 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 28, [1] = 245, [2] = 233, [3] = 22 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 23, [1] = 38, [2] = 238, [3] = 216 }, [6] = { [0] = 27, [1] = 42, [2] = 237, [3] = 221 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[71]][R[46]], ({ [0] = { [0] = 22, [1] = 236, [2] = 230, [3] = 13 }, [1] = { [0] = 19, [1] = 230, [2] = 217, [3] = 6 }, [2] = { [0] = 26, [1] = 237, [2] = 224, [3] = 14 }, [3] = { [0] = 27, [1] = 243, [2] = 228, [3] = 20 }, [4] = { [0] = 28, [1] = 245, [2] = 232, [3] = 21 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 29, [1] = 246, [2] = 234, [3] = 23 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 19, [1] = 37, [2] = 236, [3] = 210 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 14, [1] = 29, [2] = 229, [3] = 208 } })[R[71]][R[46]], ({ [0] = { [0] = 23, [1] = 237, [2] = 231, [3] = 14 }, [1] = { [0] = 20, [1] = 231, [2] = 218, [3] = 7 }, [2] = { [0] = 27, [1] = 238, [2] = 225, [3] = 15 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 29, [1] = 246, [2] = 233, [3] = 22 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 30, [1] = 247, [2] = 235, [3] = 24 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 24, [1] = 39, [2] = 241, [3] = 218 }, [5] = { [0] = 24, [1] = 39, [2] = 239, [3] = 217 }, [6] = { [0] = 28, [1] = 43, [2] = 238, [3] = 222 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[71]][R[46]], ({ [0] = { [0] = 24, [1] = 238, [2] = 232, [3] = 15 }, [1] = { [0] = 21, [1] = 232, [2] = 219, [3] = 8 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 }, [3] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [4] = { [0] = 30, [1] = 247, [2] = 234, [3] = 23 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 20, [1] = 38, [2] = 237, [3] = 211 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 17, [1] = 32, [2] = 232, [3] = 211 } })[R[71]][R[46]], ({ [0] = { [0] = 25, [1] = 239, [2] = 233, [3] = 16 }, [1] = { [0] = 22, [1] = 233, [2] = 220, [3] = 9 }, [2] = { [0] = 29, [1] = 240, [2] = 227, [3] = 17 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 27, [1] = 40, [2] = 238, [3] = 216 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 21, [1] = 39, [2] = 238, [3] = 212 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 25, [1] = 40, [2] = 240, [3] = 218 }, [6] = { [0] = 29, [1] = 44, [2] = 239, [3] = 223 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[71]][R[46]], ({ [0] = { [0] = 29, [1] = 243, [2] = 237, [3] = 20 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 30, [1] = 241, [2] = 228, [3] = 18 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [3] = { [0] = 22, [1] = 40, [2] = 239, [3] = 213 }, [4] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 18, [1] = 33, [2] = 233, [3] = 212 } })[R[71]][R[46]], ({ [0] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [1] = { [0] = 27, [1] = 238, [2] = 225, [3] = 14 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 11, [1] = 229, [2] = 221, [3] = 4 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [6] = { [0] = 30, [1] = 45, [2] = 240, [3] = 224 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[71]][R[46]], ({ [0] = { [0] = 31, [1] = 245, [2] = 239, [3] = 22 }, [1] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 32, [1] = 42, [2] = 238, [3] = 218 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 26, [1] = 39, [2] = 238, [3] = 210 }, [3] = { [0] = 23, [1] = 41, [2] = 240, [3] = 214 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 } })[R[71]][R[46]], ({ [0] = { [0] = 32, [1] = 246, [2] = 240, [3] = 23 }, [1] = { [0] = 29, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 13, [1] = 231, [2] = 223, [3] = 6 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 45, [2] = 241, [3] = 221 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 24, [1] = 42, [2] = 241, [3] = 215 }, [4] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [5] = { [0] = 27, [1] = 42, [2] = 242, [3] = 220 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[71]][R[46]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 30, [1] = 241, [2] = 228, [3] = 17 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 30, [1] = 247, [2] = 235, [3] = 20 }, [6] = { [0] = 14, [1] = 232, [2] = 224, [3] = 7 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 46, [2] = 242, [3] = 222 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 27, [1] = 40, [2] = 239, [3] = 211 }, [3] = { [0] = 25, [1] = 43, [2] = 242, [3] = 216 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 28, [1] = 43, [2] = 243, [3] = 221 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 20, [1] = 35, [2] = 235, [3] = 214 } })[R[71]][R[46]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 31, [1] = 242, [2] = 229, [3] = 18 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 16, [1] = 233, [2] = 220, [3] = 9 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 15, [1] = 233, [2] = 225, [3] = 8 }, [7] = { [0] = 32, [1] = 249, [2] = 237, [3] = 26 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 29, [1] = 44, [2] = 244, [3] = 222 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[71]][R[46]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 32, [1] = 243, [2] = 230, [3] = 19 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 17, [1] = 234, [2] = 221, [3] = 10 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 16, [1] = 234, [2] = 226, [3] = 9 }, [7] = { [0] = 19, [1] = 236, [2] = 224, [3] = 13 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 28, [1] = 41, [2] = 240, [3] = 212 }, [3] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 32, [1] = 47, [2] = 242, [3] = 226 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[71]][R[46]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 37, [1] = 248, [2] = 235, [3] = 24 }, [2] = { [0] = 31, [1] = 242, [2] = 229, [3] = 19 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 24, [1] = 241, [2] = 228, [3] = 17 }, [5] = { [0] = 24, [1] = 241, [2] = 229, [3] = 14 }, [6] = { [0] = 17, [1] = 235, [2] = 227, [3] = 10 }, [7] = { [0] = 20, [1] = 237, [2] = 225, [3] = 14 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 49, [2] = 245, [3] = 225 }, [1] = { [0] = 28, [1] = 41, [2] = 239, [3] = 217 }, [2] = { [0] = 29, [1] = 42, [2] = 241, [3] = 213 }, [3] = { [0] = 28, [1] = 46, [2] = 245, [3] = 219 }, [4] = { [0] = 29, [1] = 44, [2] = 246, [3] = 223 }, [5] = { [0] = 30, [1] = 45, [2] = 245, [3] = 223 }, [6] = { [0] = 36, [1] = 51, [2] = 246, [3] = 230 }, [7] = { [0] = 21, [1] = 36, [2] = 236, [3] = 215 } })[R[71]][R[46]], ({ [0] = { [0] = 27, [1] = 241, [2] = 235, [3] = 18 }, [1] = { [0] = 38, [1] = 249, [2] = 236, [3] = 25 }, [2] = { [0] = 25, [1] = 236, [2] = 223, [3] = 13 }, [3] = { [0] = 21, [1] = 237, [2] = 222, [3] = 14 }, [4] = { [0] = 32, [1] = 249, [2] = 236, [3] = 25 }, [5] = { [0] = 25, [1] = 242, [2] = 230, [3] = 15 }, [6] = { [0] = 19, [1] = 237, [2] = 229, [3] = 12 }, [7] = { [0] = 21, [1] = 238, [2] = 226, [3] = 15 } })[R[71]][R[46]] })
    if R[71] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[46]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[46]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 40, [1] = 50, [2] = 246, [3] = 226 })[R[46]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 41, [1] = 51, [2] = 247, [3] = 227 })[R[46]], ({ [0] = 27, [1] = 241, [2] = 235, [3] = 18 })[R[46]] })
        for i = 1, game.initial_units() do
          R[72] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 38, [1] = 48, [2] = 244, [3] = 224 }, [1] = { [0] = 25, [1] = 35, [2] = 231, [3] = 211 }, [2] = { [0] = 37, [1] = 47, [2] = 243, [3] = 223 } })[R[72]][R[46]], ({ [0] = { [0] = 21, [1] = 235, [2] = 229, [3] = 12 }, [1] = { [0] = 30, [1] = 244, [2] = 238, [3] = 21 }, [2] = { [0] = 33, [1] = 247, [2] = 241, [3] = 24 } })[R[72]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[46]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[46]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[46]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[46]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[46]], ({ [0] = 39, [1] = 250, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 28, [1] = 41, [2] = 239, [3] = 217 })[R[46]], ({ [0] = 40, [1] = 251, [2] = 238, [3] = 27 })[R[46]] })
        for i = 1, game.initial_units() do
          R[73] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 19, [1] = 32, [2] = 230, [3] = 208 }, [1] = { [0] = 21, [1] = 34, [2] = 232, [3] = 210 }, [2] = { [0] = 23, [1] = 36, [2] = 234, [3] = 212 } })[R[73]][R[46]], ({ [0] = { [0] = 34, [1] = 245, [2] = 232, [3] = 21 }, [1] = { [0] = 36, [1] = 247, [2] = 234, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 15 } })[R[73]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[74] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 20, [1] = 33, [2] = 232, [3] = 204 }, [1] = { [0] = 25, [1] = 38, [2] = 237, [3] = 209 }, [2] = { [0] = 38, [1] = 51, [2] = 250, [3] = 222 } })[R[74]][R[46]], ({ [0] = { [0] = 19, [1] = 230, [2] = 217, [3] = 7 }, [1] = { [0] = 35, [1] = 246, [2] = 233, [3] = 23 }, [2] = { [0] = 28, [1] = 239, [2] = 226, [3] = 16 } })[R[74]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[46]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[46]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[46]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[46]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[46]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[46]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[46]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[46]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[46]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[46]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[46]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[46]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[46]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 28, [1] = 46, [2] = 245, [3] = 219 })[R[46]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 47, [2] = 246, [3] = 220 })[R[46]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 30, [1] = 48, [2] = 247, [3] = 221 })[R[46]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[46]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 31, [1] = 49, [2] = 248, [3] = 222 })[R[46]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[46]], ({ [0] = 24, [1] = 240, [2] = 225, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[46]], ({ [0] = 25, [1] = 241, [2] = 226, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[46]], ({ [0] = 26, [1] = 242, [2] = 227, [3] = 19 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[46]], ({ [0] = 27, [1] = 243, [2] = 228, [3] = 20 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 50, [2] = 249, [3] = 223 })[R[46]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[46]], ({ [0] = 28, [1] = 244, [2] = 229, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[46]], ({ [0] = 29, [1] = 245, [2] = 230, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 51, [2] = 250, [3] = 224 })[R[46]], ({ [0] = 30, [1] = 246, [2] = 231, [3] = 23 })[R[46]] })
        for i = 1, game.initial_units() do
          R[75] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 26, [1] = 44, [2] = 243, [3] = 217 }, [1] = { [0] = 27, [1] = 45, [2] = 244, [3] = 218 }, [2] = { [0] = 14, [1] = 32, [2] = 231, [3] = 205 } })[R[75]][R[46]], ({ [0] = { [0] = 24, [1] = 240, [2] = 225, [3] = 17 }, [1] = { [0] = 31, [1] = 247, [2] = 232, [3] = 24 }, [2] = { [0] = 28, [1] = 244, [2] = 229, [3] = 21 } })[R[75]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[46]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[46]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[46]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[46]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[46]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[46]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[46]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[46]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[46]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[46]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[46]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[46]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[46]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[46]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[46]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[46]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[46]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[46]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[46]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[46]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[46]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[46]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[46]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[46]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[46]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[46]], ({ [0] = 17, [1] = 234, [2] = 221, [3] = 10 })[R[46]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[46]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[46]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[46]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 247, [3] = 224 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[46]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[46]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[46]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[46]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 31, [1] = 46, [2] = 248, [3] = 225 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[46]], ({ [0] = 18, [1] = 235, [2] = 222, [3] = 11 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[46]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 47, [2] = 249, [3] = 226 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[46]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[46]], ({ [0] = 24, [1] = 241, [2] = 228, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[46]], ({ [0] = 25, [1] = 242, [2] = 229, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[46]], ({ [0] = 26, [1] = 243, [2] = 230, [3] = 19 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[46]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[46]] })
        game.create_tube({ ({ [0] = 33, [1] = 48, [2] = 250, [3] = 227 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 236, [3] = 25 })[R[46]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[46]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 34, [1] = 49, [2] = 251, [3] = 228 })[R[46]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[46]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[46]], ({ [0] = 21, [1] = 238, [2] = 225, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[46]], ({ [0] = 22, [1] = 239, [2] = 226, [3] = 15 })[R[46]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[46]], ({ [0] = 23, [1] = 240, [2] = 227, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 35, [1] = 50, [2] = 252, [3] = 229 })[R[46]], ({ [0] = 31, [1] = 248, [2] = 235, [3] = 24 })[R[46]] })
        for i = 1, game.initial_units() do
          R[76] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 28, [1] = 43, [2] = 245, [3] = 222 }, [1] = { [0] = 19, [1] = 34, [2] = 236, [3] = 213 }, [2] = { [0] = 27, [1] = 42, [2] = 244, [3] = 221 } })[R[76]][R[46]], ({ [0] = { [0] = 15, [1] = 232, [2] = 219, [3] = 8 }, [1] = { [0] = 23, [1] = 240, [2] = 227, [3] = 16 }, [2] = { [0] = 18, [1] = 235, [2] = 222, [3] = 11 } })[R[76]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[46]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[46]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[46]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 30, [1] = 45, [2] = 245, [3] = 223 })[R[46]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 17 })[R[46]] })
        for i = 1, game.initial_units() do
          R[77] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 26, [1] = 41, [2] = 241, [3] = 219 }, [1] = { [0] = 9, [1] = 24, [2] = 224, [3] = 202 }, [2] = { [0] = 31, [1] = 46, [2] = 246, [3] = 224 } })[R[77]][R[46]], ({ [0] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 }, [1] = { [0] = 20, [1] = 237, [2] = 225, [3] = 10 }, [2] = { [0] = 33, [1] = 250, [2] = 238, [3] = 23 } })[R[77]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[46]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[46]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[46]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[46]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[46]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 37, [1] = 52, [2] = 247, [3] = 231 })[R[46]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[46]] })
        game.create_tube({ ({ [0] = 38, [1] = 53, [2] = 248, [3] = 232 })[R[46]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[46]] })
        game.create_tube({ ({ [0] = 39, [1] = 54, [2] = 249, [3] = 233 })[R[46]], ({ [0] = 19, [1] = 237, [2] = 229, [3] = 12 })[R[46]] })
        for i = 1, game.initial_units() do
          R[78] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 18, [1] = 33, [2] = 228, [3] = 212 }, [1] = { [0] = 23, [1] = 38, [2] = 233, [3] = 217 }, [2] = { [0] = 44, [1] = 59, [2] = 254, [3] = 238 } })[R[78]][R[46]], ({ [0] = { [0] = 9, [1] = 227, [2] = 219, [3] = 2 }, [1] = { [0] = 7, [1] = 225, [2] = 217, [3] = 0 }, [2] = { [0] = 22, [1] = 240, [2] = 232, [3] = 15 } })[R[78]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 7 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[46]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[46]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[46]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[46]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[46]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[46]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[46]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[46]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[46]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[46]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[46]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[46]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[46]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[46]] })
        for i = 1, game.initial_units() do
          R[79] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 19, [1] = 34, [2] = 234, [3] = 213 }, [1] = { [0] = 25, [1] = 40, [2] = 240, [3] = 219 }, [2] = { [0] = 13, [1] = 28, [2] = 228, [3] = 207 } })[R[79]][R[46]], ({ [0] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [1] = { [0] = 15, [1] = 232, [2] = 220, [3] = 9 }, [2] = { [0] = 36, [1] = 253, [2] = 241, [3] = 30 } })[R[79]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[46]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[46]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[46]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[46]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[46]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[46]], ({ [0] = 30, [1] = 247, [2] = 235, [3] = 24 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[46]], ({ [0] = 31, [1] = 248, [2] = 236, [3] = 25 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 36, [2] = 236, [3] = 215 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[46]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 37, [2] = 237, [3] = 216 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[46]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 38, [2] = 238, [3] = 217 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[46]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 24, [1] = 39, [2] = 239, [3] = 218 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[46]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 40, [2] = 240, [3] = 219 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[46]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 26, [1] = 41, [2] = 241, [3] = 220 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[46]], ({ [0] = 19, [1] = 236, [2] = 224, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 27, [1] = 42, [2] = 242, [3] = 221 })[R[46]], ({ [0] = 32, [1] = 249, [2] = 237, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 21, [1] = 238, [2] = 226, [3] = 15 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 22, [1] = 239, [2] = 227, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 23, [1] = 240, [2] = 228, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 24, [1] = 241, [2] = 229, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 25, [1] = 242, [2] = 230, [3] = 19 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 26, [1] = 243, [2] = 231, [3] = 20 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 27, [1] = 244, [2] = 232, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 28, [1] = 245, [2] = 233, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 44, [2] = 244, [3] = 223 })[R[46]], ({ [0] = 29, [1] = 246, [2] = 234, [3] = 23 })[R[46]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[71]", R[71])
    end
    players[1]:mark_research(3303)
    players[1].workers = ({ [0] = 30, [1] = 26, [2] = 24 })[LEVEL_OF[players[1].difficulty]]
    players[1].scientists = 16 - 3 * LEVEL_OF[players[1].difficulty]
    players[1].kids = 22 - 2 * LEVEL_OF[players[1].difficulty]
    players[1].food = 3000 - 1000 * LEVEL_OF[players[1].difficulty]
    players[1].ore = 6000 - 2000 * LEVEL_OF[players[1].difficulty]
    players[({ [0] = 0, [1] = 0, [2] = 1 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3304, [1] = 3304, [2] = 3303 })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      players[1]:mark_research(3305)
      players[({ [0] = 0, [1] = 1 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3401, [1] = 3303 })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[2].difficulty] == 0 then
        players[2]:mark_research(3303)
      elseif LEVEL_OF[players[2].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    players[2].workers = ({ [0] = 30, [1] = 26, [2] = 24 })[LEVEL_OF[players[2].difficulty]]
    players[2].scientists = 16 - 3 * LEVEL_OF[players[2].difficulty]
    players[2].kids = 22 - 2 * LEVEL_OF[players[2].difficulty]
    players[2].food = 3000 - 1000 * LEVEL_OF[players[2].difficulty]
    players[2].ore = 6000 - 2000 * LEVEL_OF[players[2].difficulty]
    players[({ [0] = 1, [1] = 1, [2] = 2 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3304, [1] = 3304, [2] = 3303 })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      players[2]:mark_research(3305)
      players[({ [0] = 1, [1] = 2 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3401, [1] = 3303 })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[3].difficulty] == 0 then
        players[3]:mark_research(3303)
      elseif LEVEL_OF[players[3].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    players[3].workers = ({ [0] = 30, [1] = 26, [2] = 24 })[LEVEL_OF[players[3].difficulty]]
    players[3].scientists = 16 - 3 * LEVEL_OF[players[3].difficulty]
    players[3].kids = 22 - 2 * LEVEL_OF[players[3].difficulty]
    players[3].food = 3000 - 1000 * LEVEL_OF[players[3].difficulty]
    players[3].ore = 6000 - 2000 * LEVEL_OF[players[3].difficulty]
    players[({ [0] = 2, [1] = 2, [2] = 3 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3304, [1] = 3304, [2] = 3303 })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      players[3]:mark_research(3305)
      players[({ [0] = 2, [1] = 3 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3401, [1] = 3303 })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[4].difficulty] == 0 then
        players[4]:mark_research(3303)
      elseif LEVEL_OF[players[4].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    players[4].workers = ({ [0] = 30, [1] = 26, [2] = 24 })[LEVEL_OF[players[4].difficulty]]
    players[4].scientists = 16 - 3 * LEVEL_OF[players[4].difficulty]
    players[4].kids = 22 - 2 * LEVEL_OF[players[4].difficulty]
    players[4].food = 3000 - 1000 * LEVEL_OF[players[4].difficulty]
    players[4].ore = 6000 - 2000 * LEVEL_OF[players[4].difficulty]
    if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
      players[4]:mark_research(3304)
      players[4]:mark_research(3305)
      if LEVEL_OF[players[4].difficulty] == 0 then
        players[4]:mark_research(3401)
      elseif LEVEL_OF[players[4].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif LEVEL_OF[players[4].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
    end
    game.set_daylight_everywhere(({ [0] = 1, [1] = 0 })[(game.uses_day_night() and 1 or 0)] ~= 0)
    if (game.uses_morale() and 1 or 0) == 0 then
      game.morale_steady("Good")
    elseif (game.uses_morale() and 1 or 0) == 1 then
      game.free_morale()
    else
      unseen("(game.uses_morale() and 1 or 0)", (game.uses_morale() and 1 or 0))
    end
  end

  -- The win.
  local t2 = trigger.midas{time = 25000}
  mission.victory(t2, "Have the most ore in storage at Mark 250", {one_shot = true})
  if game.disasters_enabled() then
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Tornados}  -- after 60 to 120 marks
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Meteors}  -- after 60 to 120 marks
    trigger.research{tech = 5201, one_shot = true, on = Lava}
  end
  return true
end
