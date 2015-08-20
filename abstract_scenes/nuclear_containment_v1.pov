/////////////////////////////////////////////
//
//     ~~ [ Nuclear Containment ] ~~
//        version 1 out of 4
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

#include "functions.inc"

#declare fastrender = false;

#declare big_r = 0.65;
#declare small_r = 0.26;
#declare tiny_r = 0.025;
#declare ext_r = small_r + tiny_r;

//good values
#declare rock_octaves = 9;
#declare rock_max_gradient = 20.913;
#declare holder_max_gradient = 2;
#declare isisurface_accuracy = 0.001;

//fast values
#if(fastrender)
	#declare rock_octaves = 7;
	#declare rock_max_gradient = 6;
	#declare holder_max_gradient = 1.4;
	#declare isisurface_accuracy = 0.005;
#end

global_settings {
	assumed_gamma 1
}

camera{
	right x*image_width/image_height
	location <0.5,1.5,-1.5>
	look_at <-0.2,0,-0.1>
}

light_source {
	<5,4,-5>
	1
}

//invisible radiation
sphere {
	0
	1
	pigment {
		rgbt 1
	}
	interior {
		media {
			emission 1.4
			density {
				spherical
			}
			density {
				rgb <0,1,0>
			}
		}
	}
	hollow
	scale 0.3
	no_image
	no_shadow
}

//visible radiation
sphere {
	0
	1
	pigment {
		rgbt 1
	}
	interior {
		media {
			emission 4
			intervals 30
			samples 1,2
			density {
				spherical
				color_map {
					[0.0 rgb 0]
					[0.5 rgb 0.3]
					[1.0 rgb 1]
				}
			}
			density {
				granite
				color_map {
				 [0.0 rgb 0]
				 [0.3 rgb 0]
				 [0.8 rgb <-0.1,0.2,-0.1>]
				 [1.0 rgb <-0.5,2,-0.5>]
				}
			}
		}
	}
	hollow
	scale 0.5
	no_reflection
	no_shadow
}

//rock
isosurface {
	function {
		f_torus(x,y,z, 0.65, 0.33) + 0.09*sqrt(f_ridged_mf(3*x, 3*y, 3*z, 0.5, 2.0, 9, -0.7, 0.8, 0.1))
	}
	contained_by {
		box {
			<-1,-0.35,-1>
			<1,0.35,1>
		}
	}
	threshold 0
	accuracy isisurface_accuracy
	max_gradient rock_max_gradient
	pigment {
		granite
		color_map {
			[0.00 rgb 0.10]
			[0.40 rgb 0.10]
			[0.50 rgb 0.15]
			[0.60 rgb 0.10]
			[0.80 rgb 0.10]
			[0.88 rgb <0.2,0.5,0.2>]
			[1.00 rgb 0.10]
		}
	}
	finish {
		diffuse 0.2
		ambient 0.2
		reflection 0.5 metallic
	}
}

//holder
isosurface {
	function {
			f_torus(x, abs(y) - ext_r, z, big_r, tiny_r) * 
			f_torus(x, abs(y) - ext_r / 2, z, big_r + ext_r * sqrt(3) / 2, tiny_r) * 
			f_torus(x, abs(y) - ext_r / 2, z, big_r - ext_r * sqrt(3) / 2, tiny_r) *
			
			f_torus(abs(x) - big_r, z, y, ext_r, tiny_r) *
			f_torus(abs(z) - big_r, x, y, ext_r, tiny_r)
			
			-0.000005
			
			
	}
	contained_by {
		box {
			0-<1,ext_r + 2*tiny_r,1>
			<1,ext_r + 2*tiny_r,1>
		}
	}
	threshold 0
	accuracy isisurface_accuracy
	max_gradient holder_max_gradient
	pigment {
		rgbf <0.90,0.90,1.0,0.99>
	}
	interior {
		ior 1.4
	}
}

sphere {
	0
	1000
	hollow
	pigment {
		granite
		color_map {
			[0 rgb 0.1]
			[0.2 rgb 0.1]
			[1.0 rgb 0.2]
		}
		scale 1000
	}
	finish {
		ambient 1
		diffuse 0
	}
	no_reflection
	no_shadow
}
