/////////////////////////////////////////////
//
//     ~~ [ Liquid Fire ] ~~
//        version 1 out of 2
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

camera{
	right 0.65 * x * image_width / image_height
	up 0.65 * y
	location <0,0,-2.2>
	look_at 0
}

plane {
	z 0
	hollow
	pigment {
		spherical
		color_map {
			[0.0 rgb <0,0,0.002>]
			[0.5 rgb <0.1,0,0>]
			[1.0 rgb <0.3,0,0>]
		}
		scale <1.6,1,1>
	}
	translate 0.1 * z
}

//simple julia fractal
plane{
	z 0
	hollow
	pigment{
		julia <0.353, 0.288>, 2048
		interior 1, 1
		color_map { 
			[0.0 rgbt <0,0,0,1>]
			[0.1 rgbt <0,0,0,1>]
			[0.2 rgb <1,0,0>]
			[0.4 rgb <1,1,0>]
			[1.0 rgb 1]
			//[1 rgb 0]
		}
	}
	finish {
		ambient 1
	}
	rotate <0,0,90>
}

//bright flash in the middle
sphere{
	<0,0,0>
	1.2
	
	hollow
	no_shadow
	no_reflection
	
	pigment{ rgbf 1}
	interior{
		media{
			emission 10
			absorption 0.5
			density{
				spherical
				density_map{
					[0.0 rgb 0]
					[0.3 rgb <0.001,0.001,0.002>]
					[0.6 rgb <0.3,0.3,0.7>]
					[0.7 rgb <0.9,0.9,1.1>]
					[1.0 rgb <2,2,4>]
				}
			}
		}
	}
	scale <0.25, 0.25, 0.2> 
	translate -0.5*z
}


//fractal distortion
plane{
	z (-1)
	hollow
	interior {
		ior 1.7
	}
	pigment {
		rgbt 1
	}
	normal {
		granite 0.07
		scale 0.5
	}
}