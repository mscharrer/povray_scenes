/////////////////////////////////////////////
//
//     ~~ [ Sphere Flake ] ~~
//        version 1 out of 2
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

#declare depth = 5;
#declare factor = 0.3;

global_settings {
	assumed_gamma 1
	max_trace_level 10
}


camera {
	right x*image_width/image_height
	location <1,2.5,-4>
	look_at <-1, .2, 0>
}

light_source {
	<4,4,-8>
	1
}

#declare flake = sphere {
	0
	1
}

#declare i = 0;
#while (i < depth)
	#declare flake = union {
		sphere {
			0
			1
		}
		//top
		object {
			flake
			scale factor
			translate y
			//rotate -90*x
		}
		
		//upper ring
		#declare j = 0;
		#while (j < 4)
			object {
				flake
				scale factor
				translate y
				rotate 35*x
				rotate 360*j/4*y
			}
			#declare j = j + 1;
		#end
		
		//middle ring
		#declare j = 0;
		#while (j < 7)
			object {
				flake
				scale factor
				translate y
				rotate 70*x
				rotate 360*j/7*y
			}
			#declare j = j + 1;
		#end
	}
	#declare i = i + 1;
#end

//flake
object {
	flake
	no_shadow
	
	pigment {
		rgb .2
	}
	finish {
		reflection <.8,.8,.9>
	}
}

plane {
	y
	(-.05)
	hollow
	pigment {
		rgb .2
	}
	finish {
		reflection <.5,.65,.5>
	}
}
//reflector
sphere {
	0
	1000
	hollow
	no_image
	no_shadow
	
	pigment {
		rgb 0
	}
	finish {
		reflection <0.5, 0.3, 0.2>
	}
}
