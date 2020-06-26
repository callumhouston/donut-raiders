# Donut Raiders

### By Callum Houston

**Donut Raiders is a space invaders replica game coded with lua. The game can be simulated in Corona SDK using keyboard input.**

### Information 
- Start with 3 lives (can gain more)
- Invaders gradually get faster and increase army size
- Alien Boss comes every 1000 points

### Features
- Character can shoot (basic)
- Character can move (basic)
- Invaders can shoot (basic)
- Invaders can move (basic)
- Bullet Collision Detection (basic)
- Muteable Music and Sound Effects (custom)
- Boss Alien (custom)
- "Slow Invaders" Powerup (custom)
- "Super Saiyan" Powerup (custom)
- Invaders Gradually Speed Up (custom)

### How to Play
- Open game in Corona SDK
- Select Play using "up" and "down" arrows on keyboard
- Press "enter" to go to selected scene
- You are now in game - Read "controls" for more information

### Controls
- Press "left" and "right" arrows on keyboard to move left and right
- Press "space bar" to shoot
- Press "s" to activate Slow Invaders Powerup (This powerup can be used once per game)
- Press "e" to active Super Saiyan Powerup (This powerup is only available with golden life)
- Press "m" to mute music
- Press "k" to mute death sound effect
- Press "l" to mute shooting sound effect

### Function Descriptions

#### Boss Alien
The Boss Alien appears every 1000 points and moves from right to left across the screen.
Killing this alien will grant the player 1 extra life.

#### Super Saiyan
The Super Saiyan powerup can only be axctivated when player has a golden life (4th life).
The powerup makes cheif wiggum eat the golden donut, and gain superpowers for a temporary amount of time.
These superpowers include superspeed, and super fast bullets, which last 5 seconds. This powerup is activated 
by pressing the "e" key.

#### Slow Invaders
The Slow Invaders powerup is a one time use powerup per game, and it assists the player by
stopping the movemnet and attack of invaders for 5 seconds. This powerup is activated by
pressing the "s" key.

#### Music and Background Sounds
The Game features custom music and game sounds, these can  both be turned off if the player prefers. I personally
enjoy the game more without the sound of Invaders dieing. Invaders dieing sound effect muted by pressing "k". Wiggum shooting sound effect muted by pressing "l". Music muted by pressing "m".

### Small Bugs and Issues - How to avoid them
There are a few small bugs within my game, which are harmless as long as you avoid them. The first bug displays an error when trying to play the game, this bug occurs when the game attempts to start before it is loaded in. To prevent this error, please be sure that the menu screen has fully loaded in before pressing play. Another error is pressing the escape key when it is not needed. This can cause key input to spaz out as well as break the screen image. Refrain from pressing the escape key except when exiting the help screen and highscores screen. Finally, the only gameplay bug. There is a small bug which occurs quite rarely where the player conitnues to move left/right without holding down the arrow. In the event of this bug, you can rid of it by pressing the arrow down in the way it is moving.

# 

# Thank You