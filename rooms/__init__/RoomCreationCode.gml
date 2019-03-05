// Initialize the game

// Randomize the game
randomize();

// Launch Controller Objects
instance_create_layer(0,0,"Controllers",input);
instance_create_layer(0,0,"Controllers",obj_Global);
instance_create_layer(0,0,"Controllers",obj_BattleController);

// Launch Databases
instance_create_layer(0,0,"Controllers",obj_EnemyDatabase);
instance_create_layer(0,0,"Controllers",obj_LevelDatabase)
instance_create_layer(0,0,"Controllers",obj_ItemDatabase);
instance_create_layer(0,0,"Controllers",obj_SpellDatabase);

// Start the game
room_goto_next();