//if click, unselect everything

//if unclick, cancel move and resize

//check if something is being moved

//check if something is being resized

//if nothing is being moved or resized
	//loop all ui layers (sttart from furthest)
	 //loop all ui objects of that layer
 
	  //if scale > 0.95 && visible
	  //check if hoovered,
		  //if hoovered detected, break layer loop (can only hoover one element at once)
  
		  //check if move
  
		  //check if resize
  
		  //check if click detected
		  //if clicked start action move or resize or select
			//check if move
			//else check if resize
			//else check if select
  
  
//TODO:
//when ui object created, add it to list of ui_layer_objects (layer of parent + 1, default 0 if no parent)
//when ui object is destroyed remove from later list