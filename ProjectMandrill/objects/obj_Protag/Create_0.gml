/// @description Create event is triggered when the game starts, when the object gets made in the room for the first time

// Constant variables (can't be constants but unchanging)
tilemap = layer_tilemap_get_id("layer_Collision");
tile_width = tilemap_get_tile_width(tilemap);
tile_height = tilemap_get_tile_height(tilemap);

// Changing variables
grav = 0.4
sp = 4
jmp = -8
max_drop = 8
hsp = 0; // Integer horizontal speed
vsp = 0; // Integer vertical speed
hsp_fract = 0; // Fractional speed
vsp_fract = 0; // Fractional speed
mv_down = true;
mv_right = true;

