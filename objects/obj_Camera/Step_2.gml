/// @description Run Camera

// Look for follow target and update camera's position

if (instance_exists(followTarget)){				// If the follow target exists
	var targetX, targetY, offsetX, offsetY;		// Initialize local variables
	targetX = followTarget.x;					// Set the camera's target (center point) to the follow target's position
	targetY = followTarget.y;					// Set the camera's target (center point) to the follow target's position
	viewX = targetX - (viewWidth/2);			// Find the top left of the view
	viewY = targetY - (viewHeight/2);			// Find the top left of the view
	camera_set_view_pos(camera, viewX, viewY);	// Update position of the camera
}