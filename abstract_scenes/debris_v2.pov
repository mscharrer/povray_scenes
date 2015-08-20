/////////////////////////////////////////////
//
//     ~~ [ Debris ] ~~
//        version 2 out of 4
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

#declare s = seed(44);

global_settings {
	assumed_gamma 1
}

camera {
	right x*image_width/image_height
	location <0,0,-5>
	look_at <0, 0, 0>
}

light_source {
	<1,1,-5>
	rgb 1
}

background {
	rgb 0
}

union {
	//julia fractal debris
	#declare i = 0;
	#while(i<400)
		julia_fractal {
			0.5-<rand(s),rand(s),rand(s),1>
			slice <0.1*rand(s),0.1*rand(s),0.1*rand(s),1>, 0.1*rand(s)
			hypercomplex
			sqr
			max_iteration 7
			precision 60
			
			scale 0.5
			rotate 360*rand(s)
			translate (4+100*rand(s))*z
			rotate <1-2*rand(s),1-2*rand(s),0>*<40,60,0>
		}
		#declare i = i + 1;
	#end
	
	//fake debris made of cubes to fill the background
	#declare i = 0;
	#while(i<20000)
		box {
			-0.3
			0.3
			
			rotate 360*rand(s)
			translate (200+1000*rand(s))*z
			rotate <1-2*rand(s),1-2*rand(s),0>*<40,60,0>
		}
		#declare i = i + 1;
	#end
	
	//background reflective texture
	texture {
		pigment {
				rgb <.1, .1, .2>
		}
		finish {
			reflection <.6, .6, .8>
		}
	}
	
	//foreground mask texture
	texture {
		pigment {
			crackle
			metric 1
			offset 0.5
			color_map {
				[0.00 rgbt <0,0,0,1>]
				[0.15 rgb <1,0.9,0.8>]
			}
			scale 0.3
		}
	}
	
	no_shadow
}

//reflectors for illusion of fullness
union {
	plane { z (-6) }
	plane { z 1200 }
	pigment { rgb 0 }
	finish { reflection 1 }
	hollow
} 