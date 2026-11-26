# OP2Missions

Outpost 2 missions as readable source, mostly the game's stock missions re-created. The original mission DLLs shipped
without source; these are written from what each mission does when it runs, so they can be read, changed and learned
from.

In [OP2Lua](https://github.com/leviathan400/OP2Lua) so far:

- **`multiplayer/`:** the 59 stock multiplayer missions: 25 Last One Standing, 8 Space Race, 7 Resource Race, 6 Midas
  and 13 Land Rush.
- **`campaign/`:** the 24 campaign missions, Eden and Plymouth 1 to 12 (`e01` to `e12`, `p01` to `p12`).
- **`colony/`:** the 5 colony games (`CEP1`, `CES1`, `CPP1`, `CPS1`, `CPS2`).
- **`tutorials/`:** the 14 tutorials (`t01` to `t14`).
- **`demos/`:** the 3 auto demos (`ademo1` to `ademo3`), the games the menu plays by itself.

## How they were made

Each mission DLL was run in [OP2MissionReader](https://github.com/leviathan400/OP2MissionReader), which runs a
mission's setup in [op2-rs](https://gitlab.com/bufke/op2-rs)'s mission host (an x86 emulator with the game's API)
over every player count, colony, resource level, vehicle setting, day and night, morale and disaster choice, and many
random seeds. `op2dll lua` then wrote the mission again from what it did:

- `on_init` makes the original's draws of the game's random numbers in the same order, and from them and the lobby
  the same units, beacons, walls and settings in the same order. So a game started with these is the original's game.
- The win, the disasters and other timed events, lava, and the two stock computer players (Peacekeeper and La Corrida)
  are converted. Fractures' setup is written by hand from the original's rules.
- Each `.lua` ends with a list of anything that wasn't converted.

**Checked against the originals:** each mission was run side by side with its original DLL in
[OP2TestHarness](https://github.com/leviathan400/OP2TestHarness) (the real game, OPU 1.4.1, seed 1, nobody playing)
for 10,000 ticks. Every unit's owner, type, weapon, position and hit points and the game's random numbers matched on
every tick, for all 59. They haven't been played through by people yet: what players set off is converted but not
tested this way. Reports are welcome as issues.

**Campaign missions:** each converted at Easy, Normal and Hard, with the start, the objectives, the timers and
disasters, scripted events and reinforcements, and the computer player's base, AI groups and waves. All 24 matched their
originals in OP2TestHarness at all three difficulties (seed 1, nobody playing, up to 40,000 ticks): 72 runs, every
unit's owner, type, weapon, position and hit points and the game's random numbers on every tick. That tests what a
mission does on its own. The objectives the player's research and buildings add (Eden 3 and 5, Plymouth 1, 3, 5 and 8)
and Eden 12's and Plymouth 12's evacuation of the children, the RLV attacks and the RLV's capture were run the same way
with the research, units and launches given by script, objectives and messages compared too. Eden 12's RLV attacks and
Plymouth 12's RLV capture need OP2LuaCore 0.8.14 or later. Still empty or unconverted, listed at the end of each `.lua`:
Eden 4's and Plymouth 4's lab visits and Eden 7's RestorePeople. A mission's carry-over from the one before isn't
converted.

**Colony games:** each setup was run at Easy, Normal and Hard over many seeds. What every difficulty makes alike is in
the placement file; the rest (extra units, colonists, stores, research, kits, morale) and the beacons the setup rolls
are in the `.lua` by difficulty, and so are the triggers and the computer player's setup. The win (450, 600 or 750
colonists by difficulty, or the starship's cargo), the failure checks, the disasters and lava, and the computer players'
bases, AI groups and attack waves are converted, some of the computer players' functions written by hand from the
original's rules. All five matched their originals in OP2TestHarness at all three difficulties (seed 1, nobody playing,
40,000 ticks or until the colony fails): every unit's id, owner, type, weapon, position and hit points and the game's
random numbers on every tick, the computer players' units included. What comes only with a player's help, or late in a
game, was checked with scripted input that keeps the colony going (Command Centers, people and food topped up,
tanks), every object and the object allocator compared too:
- Plymouth Starship II's attack waves and Easy leaving, once player 1 has a Command Center: they match at all three
  difficulties until the mission ends.
- Eden Population's waves and raids, set off by player 1's research (weapons, medical, the big topic and five weapon
  topics the raids answer): Easy (which has none) until the colony is won, Normal for 80,000 ticks, Hard until the
  colony fails.
- Eden Starship's computer bases taking their rare ore mines and base 1's third expansion (around ticks 78,000 to
  107,000): Easy for 150,000 ticks, Normal and Hard until the colony fails.

No function of the colony games is left empty.

**Tutorials:** their setups are the same at every difficulty and roll nothing, and the DLLs make only the start and
the objectives (the guidance comes from the game itself), so each is converted whole. All 14 matched their originals
in OP2TestHarness on every tick and in every screenshot.

**Auto demos:** converted like the colony games, their start and their end, with their computer players' AI groups
and trigger functions finished by hand. All three matched their originals in OP2TestHarness on every tick and in every
screenshot.

## Installing

You need Outpost 2 with [OPU](https://www.outpost2.net/) 1.4.1 and the OP2Lua runtime:

1. Copy `OP2LuaCore.dll` from [OP2LuaSDK](https://github.com/leviathan400/OP2LuaSDK)'s `bin` into your Outpost 2
   `OPU` folder (the SDK's `INSTALL.md` has the exact path).
2. Copy a map's folder from `multiplayer/` into `OPU\maps\` (for example `OPU\maps\AlliedSiege\`). Each mission is
   three files: `<dll>Lua.dll` (OP2Lua's stub, which the game loads), `<dll>Lua.lua` (the mission) and
   `<dll>Lua.placement.lua`.
3. The mission lists in the game's multiplayer lobby with "(Lua)" after the original's name. Every player in a network
   game needs the same files.

For the campaign missions, colony games, tutorials and auto demos, copy a folder from `colony/`, or the files from
`campaign/`, `tutorials/` or `demos/`, into a folder under `OPU\maps\` the same way. Each is named as the original with
"(Lua)" after it. The colony games list under Colony Games, as their DLL names start with `c`. Whether the game's
campaign menu plays the Lua campaign missions, its Tutorial menu lists the tutorials, or its menu plays the Lua demos,
isn't checked yet: they were tested by starting each one directly.

The maps themselves (`.map`), tilesets and art come from your own install; nothing of the game is in this repository.

## Multiplayer missions

| DLL | Map | Players | Type | Folder |
|---|---|---|---|---|
| `mu2_02` | Great Divide | 2 | Land Rush | [`GreatDivide`](multiplayer/GreatDivide/) |
| `mu2_10` | Beach Party | 2 | Land Rush | [`BeachParty`](multiplayer/BeachParty/) |
| `mu3_08` | Three's a Crowd | 3 | Land Rush | [`ThreesACrowd`](multiplayer/ThreesACrowd/) |
| `mu4_03` | Rock Garden | 4 | Land Rush | [`RockGarden`](multiplayer/RockGarden/) |
| `mu4_04` | Barren Land | 4 | Land Rush | [`BarrenLand`](multiplayer/BarrenLand/) |
| `mu4_07` | Four Mesas | 4 | Land Rush | [`FourMesas`](multiplayer/FourMesas/) |
| `mu4_08` | The Rift | 4 | Land Rush | [`TheRift`](multiplayer/TheRift/) |
| `mu4_13` | Unsettled Earth | 4 | Land Rush | [`UnsettledEarth`](multiplayer/UnsettledEarth/) |
| `mu4_31` | Flood Plain | 4 | Land Rush | [`FloodPlain`](multiplayer/FloodPlain/) |
| `mu6_01` | Axen's Home | 6 | Land Rush | [`AxensHome`](multiplayer/AxensHome/) |
| `mu6_02` | Around the World | 6 | Land Rush | [`AroundTheWorld`](multiplayer/AroundTheWorld/) |
| `mu6_12` | Root Canal | 6 | Land Rush | [`RootCanal`](multiplayer/RootCanal/) |
| `mu6_41` | Fractures | 6 | Land Rush | [`Fractures`](multiplayer/Fractures/) |
| `ml2_01` | Close Encounter | 2 | Last One Standing | [`CloseEncounter`](multiplayer/CloseEncounter/) |
| `ml2_02` | Great Divide | 2 | Last One Standing | [`GreatDivide`](multiplayer/GreatDivide/) |
| `ml2_03` | River of Fire | 2 | Last One Standing | [`RiverOfFire`](multiplayer/RiverOfFire/) |
| `ml2_05` | Wishbone | 2 | Last One Standing | [`Wishbone`](multiplayer/Wishbone/) |
| `ml2_08` | Ambush Alley | 2 | Last One Standing | [`AmbushAlley`](multiplayer/AmbushAlley/) |
| `ml2_10` | Beach Party | 2 | Last One Standing | [`BeachParty`](multiplayer/BeachParty/) |
| `ml2_11` | Labyrinth | 2 | Last One Standing | [`Labyrinth`](multiplayer/Labyrinth/) |
| `ml2_21` | Peacekeeper | 2 | Last One Standing | [`Peacekeeper`](multiplayer/Peacekeeper/) |
| `ml2_31` | Tug-O-War | 2 | Last One Standing | [`TugOWar`](multiplayer/TugOWar/) |
| `ml3_08` | Three's a Crowd | 3 | Last One Standing | [`ThreesACrowd`](multiplayer/ThreesACrowd/) |
| `ml4_01` | Coliseum | 4 | Last One Standing | [`Coliseum`](multiplayer/Coliseum/) |
| `ml4_05` | Crash Zone | 4 | Last One Standing | [`CrashZone`](multiplayer/CrashZone/) |
| `ml4_07` | Four Mesas | 4 | Last One Standing | [`FourMesas`](multiplayer/FourMesas/) |
| `ml4_08` | The Rift | 4 | Last One Standing | [`TheRift`](multiplayer/TheRift/) |
| `ml4_10` | Double Cross | 4 | Last One Standing | [`DoubleCross`](multiplayer/DoubleCross/) |
| `ml4_12` | Olympus Mons | 4 | Last One Standing | [`OlympusMons`](multiplayer/OlympusMons/) |
| `ml4_13` | Unsettled Earth | 4 | Last One Standing | [`UnsettledEarth`](multiplayer/UnsettledEarth/) |
| `ml4_21` | La Corrida | 4 | Last One Standing | [`LaCorrida`](multiplayer/LaCorrida/) |
| `ml4_41` | Handprint | 4 | Last One Standing | [`Handprint`](multiplayer/Handprint/) |
| `ml6_01` | Axen's Home | 6 | Last One Standing | [`AxensHome`](multiplayer/AxensHome/) |
| `ml6_02` | Around the World | 6 | Last One Standing | [`AroundTheWorld`](multiplayer/AroundTheWorld/) |
| `ml6_03` | Allied Siege | 6 | Last One Standing | [`AlliedSiege`](multiplayer/AlliedSiege/) |
| `ml6_12` | Root Canal | 6 | Last One Standing | [`RootCanal`](multiplayer/RootCanal/) |
| `ml6_21` | Pie Chart | 6 | Last One Standing | [`PieChart`](multiplayer/PieChart/) |
| `ml6_31` | Earlobe | 6 | Last One Standing | [`Earlobe`](multiplayer/Earlobe/) |
| `mm2_07` | Twin Valleys | 2 | Midas | [`TwinValleys`](multiplayer/TwinValleys/) |
| `mm3_08` | Three's a Crowd | 3 | Midas | [`ThreesACrowd`](multiplayer/ThreesACrowd/) |
| `mm4_01` | Coliseum | 4 | Midas | [`Coliseum`](multiplayer/Coliseum/) |
| `mm4_04` | Barren Land | 4 | Midas | [`BarrenLand`](multiplayer/BarrenLand/) |
| `mm4_08` | The Rift | 4 | Midas | [`TheRift`](multiplayer/TheRift/) |
| `mm4_11` | Hidden Treasure | 4 | Midas | [`HiddenTreasure`](multiplayer/HiddenTreasure/) |
| `mr2_10` | Beach Party | 2 | Resource Race | [`BeachParty`](multiplayer/BeachParty/) |
| `mr3_08` | Three's a Crowd | 3 | Resource Race | [`ThreesACrowd`](multiplayer/ThreesACrowd/) |
| `mr4_03` | Rock Garden | 4 | Resource Race | [`RockGarden`](multiplayer/RockGarden/) |
| `mr4_05` | Crash Zone | 4 | Resource Race | [`CrashZone`](multiplayer/CrashZone/) |
| `mr4_10` | Double Cross | 4 | Resource Race | [`DoubleCross`](multiplayer/DoubleCross/) |
| `mr4_12` | Olympus Mons | 4 | Resource Race | [`OlympusMons`](multiplayer/OlympusMons/) |
| `mr6_01` | Axen's Home | 6 | Resource Race | [`AxensHome`](multiplayer/AxensHome/) |
| `mf2_01` | Close Encounter | 2 | Space Race | [`CloseEncounter`](multiplayer/CloseEncounter/) |
| `mf3_02` | Biohazard | 3 | Space Race | [`Biohazard`](multiplayer/Biohazard/) |
| `mf3_08` | Three's a Crowd | 3 | Space Race | [`ThreesACrowd`](multiplayer/ThreesACrowd/) |
| `mf4_03` | Rock Garden | 4 | Space Race | [`RockGarden`](multiplayer/RockGarden/) |
| `mf4_05` | Crash Zone | 4 | Space Race | [`CrashZone`](multiplayer/CrashZone/) |
| `mf4_08` | The Rift | 4 | Space Race | [`TheRift`](multiplayer/TheRift/) |
| `mf6_02` | Around the World | 6 | Space Race | [`AroundTheWorld`](multiplayer/AroundTheWorld/) |
| `mf6_12` | Root Canal | 6 | Space Race | [`RootCanal`](multiplayer/RootCanal/) |

`Players` is the most the mission takes. Folders follow `OPU/base/maps`; Flood Plain (`mu4_31`) is in `FloodPlain/`.

## Campaign missions

| DLL | Mission |
|---|---|
| `e01` | Eden Mission #1 |
| `e02` | Eden Mission #2 |
| `e03` | Eden Mission #3 |
| `e04` | Eden Mission #4 |
| `e05` | Eden Mission #5 |
| `e06` | Eden Mission #6 |
| `e07` | Eden Mission #7 |
| `e08` | Eden Mission #8 |
| `e09` | Eden Mission #9 |
| `e10` | Eden Mission #10 |
| `e11` | Eden Mission #11 |
| `e12` | Eden Mission #12 |
| `p01` | Plymouth Mission #1 |
| `p02` | Plymouth Mission #2 |
| `p03` | Plymouth Mission #3 |
| `p04` | Plymouth Mission #4 |
| `p05` | Plymouth Mission #5 |
| `p06` | Plymouth Mission #6 |
| `p07` | Plymouth Mission #7 |
| `p08` | Plymouth Mission #8 |
| `p09` | Plymouth Mission #9 |
| `p10` | Plymouth Mission #10 |
| `p11` | Plymouth Mission #11 |
| `p12` | Plymouth Mission #12 |

## Colony games

| DLL | Colony game | Folder |
|---|---|---|
| `CEP1` | Colony Builder - Eden, Population | [`ColonyEdenPopulation`](colony/ColonyEdenPopulation/) |
| `CES1` | Colony Builder - Eden, Starship | [`ColonyEdenStarship`](colony/ColonyEdenStarship/) |
| `CPP1` | Colony Builder - Plymouth, Population | [`ColonyPlymouthPopulation`](colony/ColonyPlymouthPopulation/) |
| `CPS1` | Colony Builder - Plymouth, Starship | [`ColonyPlymouthStarship`](colony/ColonyPlymouthStarship/) |
| `CPS2` | Colony Builder II - Plymouth, Starship | [`ColonyPlymouthStarship2`](colony/ColonyPlymouthStarship2/) |

## Tutorials

| DLL | Tutorial |
|---|---|
| `t01` | 1 - Navigating the Map |
| `t02` | 2 - Basic Vehicle Commands |
| `t03` | 3 - Reports and Information |
| `t04` | 4 - Combat Vehicles and Structures |
| `t05` | 5 - Advanced Vehicle Commands |
| `t06` | 6 - Docking |
| `t07` | 7 - Mining Vehicles and Structures |
| `t08` | 8 - Research and Scientists |
| `t09` | 9 - Construction |
| `t10` | 10 - Morale |
| `t11` | 11 - Colony Control |
| `t12` | 12 - Spaceport |
| `t13` | P - Plymouth Unit Reference |
| `t14` | E - Eden Unit Reference |

## Auto demos

| DLL | Demo |
|---|---|
| `ademo1` | AutoDemo Mission #1 |
| `ademo2` | AutoDemo Mission #2 |
| `ademo3` | AutoDemo Mission #3 |

## Related

- [OP2Lua](https://github.com/leviathan400/OP2Lua) and [OP2LuaSDK](https://github.com/leviathan400/OP2LuaSDK): the
  Lua mission runtime and its SDK.
- [OP2MissionReader](https://github.com/leviathan400/OP2MissionReader): opens mission DLLs and converts them.
- [OP2TestHarness](https://github.com/leviathan400/OP2TestHarness): runs missions in the game and records what they do.
- [op2-rs](https://gitlab.com/bufke/op2-rs): the Outpost 2 reimplementation whose mission host runs the DLLs.
