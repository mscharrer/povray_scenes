/////////////////////////////////////////////
//
//     ~~ [ Blueprints ] ~~
//        version 2 out of 2
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

global_settings {
	assumed_gamma 1
}

camera{
	right x*image_width/image_height
	location <0,0,0>
	look_at <0,0,1>
}

//distortion filter
plane {
	z
	0.1
	hollow
		pigment {
		rgbt 1
	}
	normal {
		granite 0.005
		scale 0.003
	}
	interior {
		ior 1.5
	}
}

//cell volume
sphere{
	0
	1
	hollow
	pigment {
		rgbf 1
	}
	interior {
		media {
			emission 1.8
			density {
				spherical
				color_map {
					[0.0 rgb 0 ]
					[0.1 rgb 0 ]
					[0.5 rgb <.4,.4,.3> ]
					[0.6 rgb <.6,.6,.7> ]
					[1.0 rgb <.9,.9,1.4> ]
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
				turbulence 0.01
				lambda 6
				scale 0.15
				scale x / 1.4 + y + z
				rotate 30
			}
		}
	}
	scale 1.4 * x + y + z
	translate 2.1 * z
}

//background
plane {
	z
	10
	hollow
	pigment {
		crackle
		metric 19.000
		offset 0.571
		color_map {
			[0.18 rgb 0]
			[0.20 rgb <.06,.05,.04>]
			[0.22 rgb 0]
		}
		turbulence 0.1
		octaves 6
		lambda 4
		scale 0.6
		scale x / 1.4 + y + z
		rotate 62
		translate 10
	}
}