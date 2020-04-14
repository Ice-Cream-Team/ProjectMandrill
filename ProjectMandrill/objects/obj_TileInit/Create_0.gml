/// @description Create the collision tiles and generaet array of tiles.

#macro COLLIDE_TILE_CELLS_PER_ROW 16
#macro COLLIDE_TILE_CELLS_PER_COL 13
#macro COLLIDE_TILE_HEIGHTS 0
#macro COLLIDE_TILE_ANGLE 1

// Create tile layer and tilemap.
var layer_id = layer_create(0, "layer_Collision");
tilemap_id = layer_tilemap_create(layer_id, 0, 0, tiles_Collision2, COLLIDE_TILE_CELLS_PER_ROW, COLLIDE_TILE_CELLS_PER_COL);

// Set the tiles.
for (var row = 0; row < COLLIDE_TILE_CELLS_PER_COL; row++)
{
	for (var col = 0; col < COLLIDE_TILE_CELLS_PER_ROW; col++)
	{
		tilemap_set(tilemap_id, col+row*COLLIDE_TILE_CELLS_PER_ROW, col, row);
	}
}

