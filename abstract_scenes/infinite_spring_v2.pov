/////////////////////////////////////////////
//
//     ~~ [ Infinite Spring ] ~~
//        version 2 out of 2
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

global_settings {
	max_trace_level 30
	assumed_gamma 1.0
}

camera{
	right x*image_width/image_height
	location <0,0,-5>
	look_at <0,0,0>
}

light_source {
	<-10,-10,-10>
	<1,1,1>
}

//filter
plane {
	z (-4.9)
	hollow
	no_reflection
	no_shadow
	pigment {
		granite
		color_map {
			[0.00 rgbf <1,.8,.5,1>]
			[1.00 rgbf <1,1,1,1>]
		}
		scale 0.3
	}
	finish{
		diffuse 0
		ambient 1
	}
}

//background
plane{
	z
	1000
	hollow
	pigment{
		rgb <0.003,0.005,0.003>
	}
}

#macro spring_fractal(start_pos, end_pos, detail, level)
	#local n = 0;
	#local middle_pos = 0;
	#local spiral_length = vlength(end_pos - start_pos);
	#local spiral_direction = vnormalize(end_pos - start_pos);
	#local x_dir = 0.4 * spiral_length * <spiral_direction.y, spiral_direction.z, spiral_direction.x>;
	#local y_dir = 0.4 * spiral_length * <spiral_direction.z, spiral_direction.x, spiral_direction.y>;
	#local last_pos = start_pos + (-1 / detail) * (end_pos - start_pos) + x_dir * cos(-1 / detail * 4 * pi) + y_dir * sin(-1 / detail * 4 * pi);
	#local current_pos = 0;
	#while (n<detail)
		#local middle_pos = start_pos + (n / detail) * (end_pos - start_pos);
		#local current_pos = middle_pos + x_dir * cos(n / detail * 4 * pi) + y_dir * sin(n / detail * 4 * pi);
		#if(level=0)
			cylinder {
				current_pos
				last_pos
				spiral_length * 0.1
				1.7
			}
		#else
			spring_fractal(last_pos, current_pos, detail, level - 1)
		#end
		#local last_pos = current_pos;
		#local n = n + 1;
	#end
#end

union {
	blob {
		spring_fractal(<-2, 0, 0>, <-1, 0, 0>, 20, 3)
	}
	blob {
		spring_fractal(<-1, 0, 0>, < 0, 0, 0>, 20, 3)
	}
	blob {
		spring_fractal(< 0, 0, 0>, < 1, 0, 0>, 20, 3)
	}
	blob {
		spring_fractal(< 1, 0, 0>, < 2, 0, 0>, 20, 3)
	}
	pigment {
		rgb <.4,.3,.2>
	}
	normal {
		bumps 0.01
		scale 0.1
	}
	finish {
		reflection .8
	}
	scale 2.0
}

#declare ghost_spring = sphere_sweep {
	cubic_spline
	9,
	<1, 0, -1>, 0.1
	<0,  1, -.75>, 0.2
	<-1, 0, -.5>, 0.3
	<0,  -1, -.25>, 0.3
	<1, 0, 0>, 0.3
	<0,  1, .25>, 0.3
	<-1, 0, .5>, 0.3
	<0,  -1, .75>, 0.2
	<1, 0, 1>, 0.1
	
	tolerance 0.001
	
	hollow
	no_shadow
	no_reflection
	
	pigment {
		granite
		color_map {
			[0.0 rgbt <0,0,0,1>]
			[0.2 rgbt <0,0,0,1>]
			[1.0 rgbt <0.2,0.2,0.2, 0.9>]
		}
	}
	finish {
		diffuse 0
		ambient 1
	}
	
	scale <0.3,0.3,0.8>
}

#declare s = seed(52);

#declare iter = 0;
#while (iter<500)
	object {
		ghost_spring
		rotate <rand(s), rand(s), rand(s)> * 360
		translate <2*rand(s) - 1, 2*rand(s) - 1, 2*rand(s) - 1> * <30, 20, 20> + 30*z
		scale rand(s) + 0.1
	}
	#declare iter = iter + 1;
#end

//invisible cylinder for reflection effects
cylinder {
	<0,-10,0>
	<0,10,0>
	2
	hollow
	no_image
	no_shadow
	pigment {
		radial
		color_map {
			[0.0 rgb <.3, 0, 0>]
			[0.1 rgb <0, .3, 0>]
			[0.2 rgb <0, 0, .3>]
			[0.3 rgb <.3, 0, 0>]
			[0.4 rgb <0, .3, 0>]
			[0.5 rgb <0, 0, .3>]
			[0.6 rgb <.3, 0, 0>]
			[0.7 rgb <0, .3, 0>]
			[0.8 rgb <0, 0, .3>]
			[0.9 rgb <.3, 0, 0>]
		}
	}
	rotate 90*z
	scale 20
}
