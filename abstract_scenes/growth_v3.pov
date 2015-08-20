/////////////////////////////////////////////
//
//     ~~ [ Growth ] ~~
//        version 3 out of 3
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

global_settings {
	max_trace_level 3
	assumed_gamma 1.30
}

#declare s = seed(6);

camera{
	right x*image_width/image_height
	location <0,-27,0>
	look_at <0.01,0,0>
}

//reflector
sphere{
	<0,-9,0>
	1000
	
	finish {
		reflection .4
	}
	normal {
		bumps 0.000019
		scale 0.000001
	}
	
	no_shadow
	no_reflection
}

//distortion filter
plane {
	-y
	(24)
	
	
	pigment {
		rgbt 1
	}
	normal {
		granite 0.030
	}
	interior {
		ior 1.1
	}
	
	no_shadow
	no_reflection
}

light_source {
	<-10,-10,-10>
	<1,1,1>
}

#macro rvec(rand_seed)
	<1 - 2*rand(rand_seed), 1 - 2*rand(rand_seed), 1 - 2*rand(rand_seed)>
#end

#macro tree_fractal(pos, dir, arm_size, col, detail, level)
	#local n = 0;
	#local last_pos = pos;
	#local current_pos = pos;
	#local current_dir = dir;
	#local current_col = col;
	#while (n<detail)
		#local last_pos = current_pos;
		#local current_pos = last_pos + 4.5 * arm_size * current_dir;
		#local arm_size = arm_size * pow(0.92, n);
		#local start_pos = last_pos*<1.2,1,1>;
		#local end_pos = current_pos*<1.2,1,1>;
		cylinder {
			start_pos
			end_pos
			arm_size * 0.2
			2
			pigment {
				granite
				color_map {
					[0 rgb <0.3,0.2,0.1>]
					[1 rgb 2*current_col - <0.3,0.2,0.1>]
				}
				scale 0.15
			}
			finish {
				ambient .08
			}
		}
		
		#if(level > 0)
			tree_fractal(current_pos, vrotate(current_dir, 90 * rvec(s)), 0.9 * arm_size, current_col, detail - 0.65, level - 1)
		#end
		
		#if(level > 4)
			tree_fractal((current_pos + last_pos)/2, vrotate(current_dir, 90 * rvec(s)), 0.4 * arm_size, <.8,1,1.2>*current_col, detail - 3, level - 3)
		#end
		
		#local current_dir = vrotate(current_dir, 50 * rvec(s));
		#local current_col = <0.93, 1.07, 0.97> * current_col;
		#local n = n + 1;
	#end
#end

union {
	blob {
		tree_fractal(<0,-11,0>, <0,1,0>, 0.5, <.8,0.05,0>, 4, 9)
		sturm on
		
		rotate <0,90,0>
		scale 0.5
		
		no_reflection
	}
	blob{
		tree_fractal(<0,-5,0>, <0,1,0>, 0.5, <0.7,0.1,0.02>, 6, 7)
		sturm on
		
		rotate <0,90,0>
		translate <-2,0,0>
	}
	scale 0.95
}
