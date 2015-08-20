/////////////////////////////////////////////
//
//     ~~ [ Fractal Supernova ] ~~
//        version 1 out of 1
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

global_settings {
	max_trace_level 7
	assumed_gamma 1.0
}

camera{
	right x*image_width/image_height
	location <0,0,-9>
	look_at <0,0,0>
}

//supernova
sphere {
	0
	1.7
	hollow
	pigment {
		rgbf 1
	}
	interior {
		media {
			emission 0.4
			density {
				spherical
				density_map {
					[0.0 rgb <1,0,0>]
					[0.4 rgb <0,1,0>]
					[0.8 rgb <0,0,1>]
					[1.0 rgb <1,1,1>]
				}
			}
			density {
				mandel 33
				exponent 6
			}
			density {
				mandel 33
				exponent 6
				rotate 50*x
			}
			density {
				mandel 33
				exponent 6
				rotate 50*y
			}
			density {
				mandel 33
				exponent 6
				rotate <40,40,0>
			}
		}
	}
	rotate 30
	scale 3
}

//background
plane {
	z
	10
	hollow
	pigment {
		granite
		scale 10
	}
	finish {
		ambient <0,0.003,0>
	}
}