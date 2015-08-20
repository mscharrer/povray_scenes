/////////////////////////////////////////////
//
//     ~~ [ Strange Crystal ] ~~
//        version 3 out of 4
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

#declare s = seed(44);
#declare box_count = 40;

global_settings {
	assumed_gamma 1
	max_trace_level 16
	photons {
		count 2000000
		autostop 0
		jitter .4
	}
}

background {
	rgb 0.1
}

camera {
	right x*image_width/image_height
	location <3,4,-3>
	look_at <-3, 0, 1>
}

light_source {
	<-5.7,4.5,11.5>
	<1,.9,.7>
	area_light <1, 0, 0>, <0, 0, 1>, 4, 4
	adaptive 2
	jitter
}

//whole crystal
#declare crystal_base = merge {
	#declare i = 0;
	#while (i < box_count)
		box {
			-1
			1
			
			rotate 360*<rand(s), rand(s), rand(s)>
		}
		#declare i = i + 1;
	#end
}

//the cut through the crystal
#declare crystal_separator = blob {
	sphere { <-2,0,0> 4 2.9 }
	cylinder { <1,-4,0> <1,4,0> 1.5 (-2.2) }
	sphere { <.2,.7,-.8> 0.5 (-1) }
	scale 1.3
}

//the actual crystal
union {
	//left piece
	intersection {
		object { crystal_base }
		object { crystal_separator }
		
		rotate 10*z
		translate -.2*x
	}
	
	//right piece
	difference {
		object { crystal_base }
		object { crystal_separator }
		
		rotate -10*z
		translate .2*x
	}
	
	//small shard
	intersection {
		object { crystal_base }
		sphere { 0 3 translate -4*x }
		
		rotate -90*z
		rotate 90*y
		translate -3.0*y
		scale 0.5
		translate <-1.5, 0, -7.6>
	}
	
	pigment {
		rgbt <0.5, 1.0, 0.5, 0.9>
	}
	finish {
		ambient 0
		diffuse 0
		reflection <0.65, 0.55, 0.48>
	}
	interior {
		ior 1.8
	}
	photons{
		target
		reflection on
		refraction on
		collect off
	}
	
	rotate -30*y
	translate <-3.5,1,5.5>
}

//floor
plane {
	y
	0
	
	pigment {
		crackle
		color_map {
			[0.00 rgb .3]
			[0.02 rgb .8]
		}
		scale 0.05
	}
	finish {
		ambient <0.03,0.03,0.04>
	}
}