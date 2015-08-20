/////////////////////////////////////////////
//
//     ~~ [ Blueprints ] ~~
//        version 1 out of 2
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

camera{
	right x*image_width/image_height
	location <0,0,0>
	look_at <0,0,1>
}

//distortion filter
plane {
	z
	1
	hollow
		pigment {
		rgbt 1
	}
	normal {
		granite 0.015
	}
	interior {
		ior 1.1
	}
}

sphere{
	0
	1
	hollow
	pigment {
		rgbf 1
	}
	interior {
		media {
			emission 1
			density {
				spherical
				color_map {
					[0.0 rgb 0 ]
					[0.1 rgb 0 ]
					[0.5 rgb <.4,.4,.3> ]
					[0.6 rgb <.6,.6,.7> ]
					[1.0 rgb <.8,.8,1> ]
				}
				turbulence 0.2
				lambda 5
			}
			density{
				crackle
				metric 19.000
				offset 0.571
				color_map {
					[0.19 rgb 0]
					[0.20 rgb 4]
					[0.21 rgb 0]
				}
				scale 0.15
				scale x / 1.4
				rotate 30
			}
		}
	}
	scale 1.4 * x
	translate 2.1 * z
}