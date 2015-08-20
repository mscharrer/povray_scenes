/////////////////////////////////////////////
//
//     ~~ [ Sphere Flake ] ~~
//        version 2 out of 2
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

#declare s = seed(51);
#declare depth = 5;
#declare factor = 0.3;
#declare small_count = 18;

global_settings {
	assumed_gamma 1
	max_trace_level 20
}


camera {
	right x*image_width/image_height
	location <1,4,-3>
	look_at <-1.5, .2, 0>
}

light_source {
	<4,4,-8>
	1
}

#macro flakify(subflake)
	union {
		sphere {
			0
			1
		}
		//top
		object {
			subflake
			scale factor
			translate y
			//rotate -90*x
		}
		
		//upper ring
		#declare j = 0;
		#while (j < 4)
			object {
				subflake
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
				subflake
				scale factor
				translate y
				rotate 70*x
				rotate 360*j/7*y
			}
			#declare j = j + 1;
		#end
	}
#end

#declare flake_small = sphere {
	0
	1
}

#declare i = 0;
#while (i < (depth - 1))
	#declare flake_small = flakify(flake_small);
	#declare i = i + 1;
#end

#declare flake_big = flakify(flake_small);

//flakes
union {
	//main flake
	object {
		flake_big
	}
	
	//small flakes
	#declare i = 0;
	#while (i < small_count)
		object {
			flake_small
			translate -0.15*y
			scale 0.3
			translate (2.5 + 12 * rand(s)) * x
			rotate rand(s) * 360 * y
		}
		#declare i = i + 1;
	#end
	
	pigment {
		rgb .2
	}
	finish {
		reflection <.7,.7,.8>
	}
	
	no_shadow
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
	-.2
	100
	hollow
	no_image
	no_shadow
	
	pigment {
		rgb 0
	}
	finish {
		reflection <0.5, 0.3, 0.2>
	}
	normal {
		bumps 0.00002
		scale 0.000001
	}
}
