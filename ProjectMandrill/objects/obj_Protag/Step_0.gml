#region // 1.) Declaring player keyboard input check

right_key = keyboard_check(vk_right);
left_key = keyboard_check(vk_left);
up_key = keyboard_check(vk_up);
down_key = keyboard_check(vk_down);
space_key = keyboard_check_pressed(vk_space); //jmping motion

#endregion

#region // 2.) Movement Calculator

// Wen we are moving right it will be 1, when left it will be -1
hsp = (right_key - left_key) * sp;
vsp = min(vsp + grav, fall);
mv_right = hsp > 0;
mv_down = vsp > 0;

// Remove fractional component from speeds before collision.
vsp_fract = (abs(vsp) - floor(abs(vsp))) * sign(vsp);
hsp_fract = (abs(hsp) - floor(abs(hsp))) * sign(hsp);
vsp -= vsp_fract;
hsp -= hsp_fract;


#endregion

#region // 3.) Object-based collision

// Horizontal collision
/*Set the parent of collidable objects (such as rocks, etc) parent to 
obj_Collision, now we sense it's meeting with our obj_Protag and create a collision
*/
if (place_meeting(x + hsp, y, obj_Collision))
{
	//sign returns 1 or -1 depending if we give it a positive or a negative.
	while (!place_meeting(x + sign(hsp), y, obj_Collision))
	{
		x = x + sign(hsp);
	}
	hsp = 0;
}

// Vertical Collision
if (place_meeting(x, y + vsp, obj_Collision))
{
		//sign returns 1 or -1 depending if we give it a positive or a negative.
	while (!place_meeting(x,y + sign(vsp), obj_Collision))
	{
		y = y + sign(vsp);
	}
	// 
	if (space_key)
		vsp = jmp;
	else
		vsp = 0;
}

#endregion

#region // 4.) Tile-based Sonic-retro detection. http://info.sonicretro.org/SPG:Solid_Tiles
#macro TILE_DETECTION_SENSOR_TOTAL 4

// A, B, C, D
/*{
	enum dtypes { down, up, left, right };
	var bvsp = max(1, abs(vsp));
	var bhsp = max(1, abs(hsp));
	var speeds  = [vsp,              vsp];
	var directs = [dtypes.down,      dtypes.down];
	var xchecks = [bbox_right,       bbox_left];
	var ychecks = [bbox_bottom+bvsp, bbox_bottom+bvsp];
	
	for (var each_sensor = 0; each_sensor < TILE_DETECTION_SENSOR_TOTAL; each_sensor++)
	{
		var direct_check = (directs[each_sensor] == dtypes.down and mv_down == true) or
		                   (directs[each_sensor] == dtypes.up and mv_down == false) or
						   (directs[each_sensor] == dtypes.right and mv_right == true) or
						   (directs[each_sensor] == dtypes.left and mv_right == false);
		
		if (direct_check == false)
			continue;
			
		var tile_detected = tilemap_get_at_pixel(tilemap, xchecks[each_sensor], ychecks[each_sensor]);
		
		if (tile_detected == 0)
			continue;
			
		if 
	}
}*/

// Tile-based horizontal collision.
{
	var bbox_side;	
	var tile_detected;
	var chsp;

	// Get x values of boundary side in direction of movement.
	bbox_side = mv_right ? bbox_right : bbox_left;
	
	// Bound the horizontal speed such that we always check for a tile.
	chsp = (mv_right ? max(hsp, 1) : min(hsp, -1));
	
	// Determine the tile detection at three points.
	tile_detected = (tilemap_get_at_pixel(tilemap, bbox_side + chsp, y) != 0) ||
	                (tilemap_get_at_pixel(tilemap, bbox_side + chsp, bbox_top) != 0) ||
				    (tilemap_get_at_pixel(tilemap, bbox_side + chsp, bbox_bottom) != 0);
	
	// Perform collision operations.
	if (tile_detected)
	{
		var correction
		
		// Snap y such that object aligns with tile.
		correction = ((bbox_side + chsp) mod tile_width) - (mv_right ? -1 : tile_width);
		x = x + chsp - correction;
						
		hsp = 0;		
	}
}

// Tile-based vertical collision.
{
	var bbox_side;	
	var tile_detected;
	var cvsp;

	// Get y values of boundary side in direction of movement.
	bbox_side = mv_down ? bbox_bottom : bbox_top;
	
	// Bound the vertical speed so such that we always check for tile detection.
	cvsp = (mv_down ? max(vsp, 1) : min(vsp, -1));
	
	// Determine the tile detection at two points.
	tile_detected = (tilemap_get_at_pixel(tilemap, bbox_left, bbox_side + cvsp) != 0) ||
				    (tilemap_get_at_pixel(tilemap, bbox_right, bbox_side + cvsp) != 0);
	
	// Perform the tile detection operations.
	if (tile_detected)
	{
		var correction
		
		// Snap y such that object aligns with tile.
		correction = ((bbox_side + cvsp) mod tile_height) - (mv_down ? -1 : tile_height);
		y = y + cvsp - correction;
				
		// jmp if necessary.
		if (mv_down and space_key)
			vsp = jmp;
		else
			vsp = 0;
			
	}
}

#endregion

#region // 5.) Update position and restore speeds.

// Update positions.
x += hsp;
y += vsp;

// Add the fractional components back into the speeds.
vsp += vsp_fract;
hsp += hsp_fract;

#endregion

