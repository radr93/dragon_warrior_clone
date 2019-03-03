/// @description Set up camera

// Initialize variables and create camera
viewWidth = 512;				// Default width of the camera
viewHeight = 288;				// Default height of the camera
viewX = 0;						// Left side of the camera
viewY = 0;						// Top of the camera
followTarget = obj_Player;		// Camera's target to follow (centered)
camera = camera_create_view(x, y, viewWidth, viewHeight, 0, -1, 2, 2, 0, 0);	// Create the camera
view_camera[0] = camera;		// Apply Camera to View