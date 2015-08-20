/////////////////////////////////////////////
//
//     ~~ [ Debris ] ~~
//        version 4 out of 4
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

#declare s = seed(44);
#declare ss = seed(42);
global_settings {
	assumed_gamma 1
}

camera {
	right x*image_width/image_height
	location <0,0,-5.02>
	look_at <0, 0, 0>
}

light_source {
	<1,1,-5>
	rgb 1
}

background {
	rgb 0
}
#declare debris_sub_pigment = pigment {
	crackle
	metric 1
	offset 0.5
	color_map {
		[0.00 rgbt <0,0,0,1>]
		[0.10 rgb <1.1,0.9,0.8>]
	}
	scale 0.1
}

#declare debris_texture = texture {
	pigment {
		crackle
		metric 1
		offset 0.5
		pigment_map {
			[0.07 rgbt <0,0,0,1>]
			[0.10 debris_sub_pigment]
		}
		scale 0.3
	}
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
			precision 70
			
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
		superellipsoid {
			.4
			
			scale .4
			
			rotate 360*rand(s)
			translate (150+750*rand(s))*z
			rotate <1-2*rand(s),1-2*rand(s),0>*<40,60,0>
		}
		#declare i = i + 1;
	#end
	
	//background texture
	texture {
		pigment {
				rgb <.1, .1, .2>
		}
		finish {
			specular .2
		}
	}
	
	//foreground mask texture
	texture {
		debris_texture
	}
	
	no_shadow
}


//main piece

julia_fractal {
		<-0.083, 0.0, -0.83, -0.025>
		hypercomplex
		sqr
		max_iteration 7
		precision 300
	
	//background texture
	texture {
		pigment {
				rgb <.05, .05, .10>
		}
		finish {
			specular .5
		}
	}
	
	//foreground mask texture
	texture {
		debris_texture
		translate 10
	}
	
	scale 0.7
	rotate 20*y
	rotate z*-30
	translate <-2.2,0.9,0>
	no_shadow
	no_reflection
}

//stars
#declare i = 0;
#while(i<2000)
	sphere {
		0
		10
		hollow
		no_reflection
		no_shadow
		pigment {
			rgbt <0,0,0,1>
		}
		interior {
			media {
				emission 1
				density {
					spherical
					color_map {
						[0.0 rgb <0,0,0>]
						[0.5 rgb <1,0,0>]
						[0.7 rgb <0,2,0>]
						[1.0 rgb <0,0,40>]
					}
				}
			}
		}
		translate 900*z
		rotate <1-2*rand(s),1-2*rand(s),0>*<40,60,0>
	}
	#declare i = i + 1;
#end

//reflectors for illusion of fullness
union {
	plane { z (-5.03) }
	plane { z 905 }
	pigment { rgb 0 }
	finish { reflection 1 }
	hollow
}