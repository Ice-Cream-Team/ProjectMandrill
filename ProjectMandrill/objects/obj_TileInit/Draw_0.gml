/// @description Insert description here
// You can write your code in this editor

// Draw the tilemap.
draw_tilemap(tilemap_id, 0, 0);

// Determine width and heights of each tile.
var tile_width = tilemap_get_tile_width(tilemap_id);
var tile_height = tilemap_get_tile_height(tilemap_id);

// Acquire 2D array of heights and angles.
for (var row = 0; row < COLLIDE_TILE_CELLS_PER_COL; row++)
{
	for (var col = 0; col < COLLIDE_TILE_CELLS_PER_ROW; col++)
	{
		var tile_heights;
		var tile_angle;
		var tile_floor;
		
		// Determine height array and whether or the tile is ground or floor.
		{		
			var floor_cntr, ceil_cntr;
			
			floor_cntr = 0;
			ceil_cntr = 0;
			for (var tile_col = 0; tile_col < tile_width; tile_col++)
			{
				var height;
			
				height = 0;
				for (var tile_row = 0; tile_row < tile_height; tile_row++)
				{
					var surf_color = surface_getpixel(application_surface, 
									                  tile_col + (col * tile_width),
									                  tile_height - tile_row - 1 + (row * tile_height));
				    if (surf_color != c_black) 
					{
						height++;
						if (tile_row <= floor(tile_height/2))
							floor_cntr++;
						else
							ceil_cntr++;
					}
				}
				tile_heights[tile_col] = height;
			}
			tile_floor = floor_cntr >= ceil_cntr; 
		}
		
		// Determine angle from height array.
		{
			var max_height, min_height;
			var max_index, min_index;
			var xdiff, ydiff;
				
			max_height = tile_heights[0];
			min_height = tile_heights[0];
				
			// Determine minimum and maximum values.
			for (var tile_col = 0; tile_col < tile_width; tile_col++)
			{
				max_height = max(tile_heights[tile_col], max_height);
				min_height = min(tile_heights[tile_col], min_height);
			}
				
			// Determine the indices such that their difference is minimized 
			// but one still maps to the maximum and the other maps to the minimum.
			min_index = 0;
			max_index = tile_width - 1;
			for (var left_col = 0; left_col < tile_width; left_col++)
			{
				for (var right_col = left_col; right_col < tile_width; right_col++)
				{
					if ((abs(left_col-right_col) <= abs(min_index - max_index)))
					{
						if (tile_heights[left_col] == max_height && tile_heights[right_col] == min_height)
						{
							max_index = left_col;
							min_index = right_col;
						}  
						else if (tile_heights[left_col] == min_height && tile_heights[right_col] == max_height)
						{
							max_index = right_col;
							min_index = left_col;
						}
							
					}
				}
			}
			
			// Determine angle.
			xdiff = max_index - min_index;
			ydiff = max_height - min_height;
			tile_angle = darctan2(ydiff, xdiff);
			if (tile_floor)
			{
				tile_angle += (tile_angle > 90) ? 180 : 0; 
			} else {
				tile_angle += (tile_angle < 90) ? 180 : 0;
			}
			
			// ("xdiff: " + string(xdiff) + ", ydiff: " + string(ydiff) + ", tile_floor: " + string(tile_floor));
			// show_debug_message("max_height: " + string(max_height) + ", max_index: " + string(max_index));
			// show_debug_message("min_height: " + string(min_height) + ", min_index: " + string(min_index));
		}
		
		// Store the data in the global array.
		{
			var array_index;
			
			array_index = col + (row * COLLIDE_TILE_CELLS_PER_ROW);
		
			global.glb_tile_data[array_index, COLLIDE_TILE_HEIGHTS] = tile_heights;
			global.glb_tile_data[array_index, COLLIDE_TILE_ANGLE] = tile_angle;
			//show_debug_message("col: " + string(col) + ", row: " + string(row));
			//show_debug_message(global.glb_tile_data[array_index, COLLIDE_TILE_HEIGHTS]);
			//show_debug_message(global.glb_tile_data[array_index, COLLIDE_TILE_ANGLE]);
		}
	}
}

//show_debug_message("finished");
room_goto_next();