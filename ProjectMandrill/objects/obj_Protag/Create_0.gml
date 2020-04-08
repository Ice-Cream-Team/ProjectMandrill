// Create event is triggered when the game starts, when the object gets made in the room for the first time

horizontalSpeed = 0; //hspeed is built in
verticalSpeed = 0; //vspeed is built in
grav = 0.7; //"gravity" is a built in var so must use grav
max_drop = 4; // max vertical drop speed.
playerSpeed = 4; //speed is built in
jumpHeight = -16;

tilemap = layer_tilemap_get_id("layer_Collision");
tile_width = tilemap_get_tile_width(tilemap);
tile_height = tilemap_get_tile_height(tilemap);