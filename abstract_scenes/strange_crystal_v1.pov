/////////////////////////////////////////////
//
//     ~~ [ Strange Crystal ] ~~
//        version 1 out of 4
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

#declare s = seed(44);
#declare box_count = 30;

global_settings {
	assumed_gamma 1
	max_trace_level 6
	photons {
		count 20000
		autostop 0
		jitter .4
	}
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

merge {
	#declare i = 0;
	#while (i < box_count)
		box {
			-1
			1
			
			rotate 360*<rand(s), rand(s), rand(s)>
		}
		#declare i = i + 1;
	#end
	
	pigment {
		rgbt <0.5, 1.0, 0.5, 0.9>
	}
	finish {
		ambient 0
		diffuse 0
		reflection 0.2
	}
	interior {
		ior 1.5
	}
	photons{
		target
		reflection on
		refraction on
	}
	
	translate <-3.5,1,5.5>
}

plane {
	y
	0
	
	pigment {
		rgb .8
	}
	finish {
		ambient 0
	}
}