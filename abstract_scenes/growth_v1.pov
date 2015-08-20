/////////////////////////////////////////////
//
//     ~~ [ Growth ] ~~
//        version 1 out of 3
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.6;

global_settings {
	max_trace_level 30
	assumed_gamma 1.0
}

#declare s = seed(6);

camera{
	right x*image_width/image_height
	location <0,-27,0>
	look_at <0,0,0>
}

//distortion filter
plane {
	y
	(-24)
	hollow
		pigment {
		rgbt 1
	}
	normal {
		granite 0.035
	}
	interior {
		ior 1.1
	}
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
		cylinder {
			last_pos
			current_pos
			arm_size * 0.2
			2
			pigment {
				rgb current_col
			}
		}
		#if(level > 0)
			tree_fractal(current_pos, vrotate(current_dir, 90 * rvec(s)), 0.9 * arm_size, current_col, detail - 0.65, level - 1)
		#end
		#local current_dir = vrotate(current_dir, 50 * rvec(s));
		#local current_col = <0.95, 1.05, 1.0> * current_col;
		#local n = n + 1;
	#end
#end

blob {
	tree_fractal(<0,-5,0>, <0,1,0>, 0.5, <0.7,0.1,0>, 6, 7)
	sturm on
	rotate <0,90,0>
	translate <0,0,2.5>
}