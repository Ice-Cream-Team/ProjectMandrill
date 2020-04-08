// 1.) Declaring player keyboard input check
rightKey = keyboard_check(vk_right);
leftKey = keyboard_check(vk_left);
upKey = keyboard_check(vk_up);
downKey = keyboard_check(vk_down);
spaceKey = keyboard_check_pressed(vk_space); //jumping motion


// 2.) Movement Calculator

//when we are moving right it will be 1, when left it will be -1
var move = rightKey - leftKey;
horizontalSpeed = move * playerSpeed;
verticalSpeed = min(verticalSpeed + grav, max_drop);


if ((place_meeting(x, y + 1, obj_Collision)) && (spaceKey))
{
	verticalSpeed = jumpHeight;
}

// 3.) Horizontal Collision
/*Set the parent of collidable objects (such as rocks, etc) parent to 
obj_Collision, now we sense it's meeting with our obj_Protag and create a collision
*/
if (place_meeting(x + horizontalSpeed,y,obj_Collision))
{
	//sign returns 1 or -1 depending if we give it a positive or a negative.
	while (!place_meeting(x + sign(horizontalSpeed), y, obj_Collision))
	{
		x = x + sign(horizontalSpeed);
	}
	horizontalSpeed = 0;
}

// 4.) Vertical Collision
if (place_meeting(x, y + verticalSpeed, obj_Collision))
{
		//sign returns 1 or -1 depending if we give it a positive or a negative.
	while (!place_meeting(x,y + sign(verticalSpeed), obj_Collision))
	{
		y = y + sign(verticalSpeed);
	}
	verticalSpeed = 0;
}

// Tile-based horizontal collision.
{
	var bbox_side;
	var moving_right;
	var collision;
	var buffered_speed	

	if (horizontalSpeed > 0)
	{
		moving_right = true;
		bbox_side = bbox_right;
	}
	else
	{
		moving_right = false;
		bbox_side = bbox_left;
	}

	buffered_speed = round(horizontalSpeed+sign(horizontalSpeed)*2);
	collision = (tilemap_get_at_pixel(tilemap, bbox_side+buffered_speed, bbox_top) != 0) || 
	            (tilemap_get_at_pixel(tilemap, bbox_side+buffered_speed, bbox_bottom) != 0);					   

	if (collision)
	{
		x = round(x);
		if (moving_right) 
		{							
			var correction = ((bbox_right + buffered_speed + 1) mod tile_width);			
			x = x + buffered_speed - correction;
		}
		else
		{
			var correction = tile_width - ((bbox_left + buffered_speed) mod tile_width) + 1;		
			x = x + buffered_speed + correction;
		}			
		horizontalSpeed = 0;		
	}
}

// Tile-based vertical collision.
{
	var bbox_side;
	var moving_down;
	var collision;
	var buffered_speed

	if (verticalSpeed > 0)
	{
		moving_down = true;
		bbox_side = bbox_bottom;	
	}
	else
	{
		moving_down = false;
		bbox_side = bbox_top;		
	}	
	
	buffered_speed = round(verticalSpeed+sign(verticalSpeed)*2);
	collision = (tilemap_get_at_pixel(tilemap, bbox_left, bbox_side+buffered_speed) != 0) || 
	            (tilemap_get_at_pixel(tilemap, bbox_right, bbox_side+buffered_speed) != 0);			

	if (collision)
	{
		y = round(y);
		if (moving_down) 
		{							
			var correction = ((bbox_bottom + buffered_speed + 1) mod tile_height);			
			y = y + buffered_speed - correction;
		}
		else
		{
			var correction = tile_height - ((bbox_top + buffered_speed) mod tile_height) + 1;		
			y = y + buffered_speed + correction;
		}			
		if (moving_down and spaceKey)
			verticalSpeed = jumpHeight;
		else
			verticalSpeed = 0;
			
	}
}

// Update positions.
x += horizontalSpeed;
y += verticalSpeed;

