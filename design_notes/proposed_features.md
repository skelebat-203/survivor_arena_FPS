## Basic game stuff
- End state
- Start screen
- 

## Infinate map
Keep things dynamic
- Procedurally generate an infinately shifting map
- Every {nn} seconds a platform will fall and another generated. Oldest 1st?
- Need to make sure the new plataform is positioned a max (x, y, z)away from at least 2 other platforms. And they have a max (x, y, z) from center. 
- The available map area is an oblong cilender

## Moving platforms
Makes things more dynamic and sets up an oportunity for the player to temporarally trap themselves (higer tension)
- Could add moving platforms, that go from platform A to platform B. If A or B disappear the moving platform's path is updated.

## Home base
Creates a rest point
- A perminate platform no mobs spawn within projectile range of platform edge

## Gun
- add an overheat mechanic
	- Need a temp bar (top-right?)
	- Need overheat animation

## Mob 
### Despawm
1. By getting shot {nn} times

### Spawn
- {nn} after a mob despawns
- need to set a max mob {nn}

### Homing
Likely covered in tutorial

- need to set a distance from player where the mob will home in on player
- after (kill - 1) hits mob runs away from player.  (this is to discourage camping)
	- every 5 sec regain 1 HP.
	- At full move to the nearest platform that is not home base
	- never run toward home base
	
### Mob types
- bat: homing, 3 hits to kill, gravity = 0
- weeping angel: homing, involnerable, gravity = 0 if not in view

## Scoring
1. mobs killed
2. time without dying

## Power ups
2 in game at a time. 
**Rough idea for mechanics** - spawn every 60 sec. despawn every 90 sec. last 30 sec

### PP Up list
- Move Speed boost
- Slow mobs
- fire speed boost
- Power shot

### Super PP Up???
**beserk mode**  triggered as a bonus???
- 30 sec
- color shift
- Move Speed boost
- faster mobs
- fire speed boost
- Power shot

## Swarm mode
For {nn} every thime a mob despawns another spawns with no cool down


## Stats
### UI
- player mob HP

### Metrics
Max means across all games
- max speed
- mobs killed (max)
- time played (max)
- time (max)
- jumps (max)
- games played
