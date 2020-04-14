/// @description Create event is triggered when the game starts, when the object gets made in the room for the first time

tilemap = layer_tilemap_get_id("layer_Collision");
tile_width = tilemap_get_tile_width(tilemap);
tile_height = tilemap_get_tile_height(tilemap);

grav = 0.4
sp = 4 // Ground speed
jmp = -8; // Jumping speed
fall = 8; // Max integer speed for falling
acc = 1; // Acceleration
dec = 0.5; // Deceleration
slp = 0.125; // Slope

// changing variables
slope = 0; // The current slope factor being used.
ang = 0; // player's angle on the ground.
hsp = 0; // Integer horizontal speed
vsp = 0; // Integer vertical speed
hsp_fract = 0; // Fractional speed
vsp_fract = 0; // Fractional speed
mv_down = true;
mv_right = true;

