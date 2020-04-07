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
verticalSpeed = verticalSpeed + grav;


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
x = x + horizontalSpeed;


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
y = y + verticalSpeed;

