/// @description Create the camera

if (room != __init__){
	if (!instance_exists(obj_Camera)){
		instance_create_layer(0, 0, "Controllers", obj_Camera);
	}

	if (!instance_exists(obj_PlayerController)){
		instance_create_layer(0, 0, "Controllers", obj_PlayerController);
	}
}