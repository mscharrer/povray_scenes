/////////////////////////////////////////////
//
//     ~~ [ Nuclear Containment ] ~~
//        version 2 out of 4
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

#macro glass()
	pigment {
		rgbf <0.80,0.80,1.0,0.95>
	}
	interior {
		ior 1.4
	}
	finish {
		reflection 0.1
	}
#end

global_settings {
	assumed_gamma 1
}

background {
	rgb .2
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

#declare apparatus_holder = blob {
	sphere {< 0.0, 0,0>, 0.8, 2.5}
	sphere {< 0.0, 1,0>, 1, -0.3}
	sphere {< 0.0,-1,0>, 1, -0.3}
	cylinder {<0.3,0,-1>, <0.3,0,1>, 0.4, -5 }
	sphere {<-0.7, 0,0>, 0.5, 2.0}
	cylinder {<0,0,0>, <-4,0,0>, 0.2, 2 }
	cylinder {<-4,0,0>, <-4,-1000,0>, 0.2, 2 }
	glass()
	scale 0.5
}
#declare radioactive_apparatus = union {
	//invisible radiation
	sphere {
		0
		1
		pigment {
			rgbt 1
		}
		interior {
			media {
				emission 5
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
				emission 8
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
					[0.00 rgb 0]
					[0.30 rgb 0]
					[0.80 rgb <-0.1,0.2,-0.1>]
					[0.97 rgb <-0.5,2,-0.5>]
					[1.00 rgb 0]
					}
				}
			}
		}
		hollow
		scale 0.5
		no_reflection
		no_shadow
	}

	//putonium
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
				[0.00 rgb  0.00]
				[0.40 rgb  0.05]
				[0.50 rgb  0.00]
				[0.60 rgb  0.05]
				[0.80 rgb  0.00]
				[0.88 rgb  <0,0.8,0>]
				[1.00 rgb  0.00]
			}
			scale 0.7
			translate 30
		}
		finish {
			diffuse 0.3
			ambient 0.3
			reflection <0.35,0.40,0.35> metallic
		}
	}
	
	//plutonium darkeners
	cylinder {
		<0,.4,0>
		<0,-.4,0>
		2
		pigment{
			cylindrical
			color_map {
				[0  rgbt <0,0,0,1>]
				[.2 rgbt <0,0,0,.2>]
				[1  rgbt <0,0,0,0>]
			}
		}
		no_shadow
		no_image
		scale <3,1,3>
	}
	
	//containment
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
		glass()
	}
	
	//holders
	object {
		apparatus_holder
		translate -x * (big_r + 1.6*small_r)
	}
	object {
		apparatus_holder
		translate -x * (big_r + 1.6*small_r)
		rotate z*180
	}
}

object {
	radioactive_apparatus
}

object {
	radioactive_apparatus
	rotate <0,90,0>
	translate <-10,-9,20>
}

object {
	radioactive_apparatus
	rotate <180,0,0>
	rotate <0,270,0>
	translate <-15,-17,1>
}

object {
	radioactive_apparatus
	rotate <0,193,0>
	translate <7,-16,1>
}

object {
	radioactive_apparatus
	rotate <0,180,0>
	translate <-5,-20,20>
}

object {
	radioactive_apparatus
	rotate <0,90,0>
	translate <-65,-45,40>
}

object {
	radioactive_apparatus
	rotate <0,270,0>
	translate <-20,-90,40>
}

#macro verical_pipe(start_pos, stepsize, n, seedval)
	sphere_sweep {
		linear_spline
		2 * n + 1
		#local i=0;
		#local s = seed(seedval);
		#local current_pos = start_pos;
		#while(i < n)
			current_pos, 0.1,
			#local current_pos = current_pos + (1.5 + rand(s)) * stepsize * x;
			current_pos, 0.1,
			#if(rand(s) > 0.5)
				#local current_pos = current_pos + (0.3 + rand(s)) * stepsize * z;
			#else
				#local current_pos = current_pos + (1.0 + rand(s)) * stepsize * y;
			#end
			#local i = i + 1;
		#end
		current_pos, 0.1
		glass()
	}
#end


verical_pipe(<-20,-15,2>, 5, 5, 0)
verical_pipe(<-30,-6,10>, 5, 5, 3)
verical_pipe(<8,-5,10>, -5, 5, 4)

verical_pipe(<-120,-30,30>, 10, 10, 5)
verical_pipe(<-120,-50,30>, 10, 10, 8)
verical_pipe(<-120,-70,30>, 10, 10, 10)
verical_pipe(<30,-40,30>, -10, 10, 11)

#macro mangled_pipe(start_pos, stepsize, n, seedval)
	sphere_sweep {
		linear_spline
		n + 2
		#local i=0;
		#local s = seed(seedval);
		#local current_pos = start_pos;
		#local diff = 0;
		#local lastdiff = 0;
		current_pos + 1000*y, 0.1,
		#while(i < n)
			
			#if(rand(s) > 0.5)
				#local diff = 1;
			#else
				#local diff = -1;
			#end
			
			#if(rand(s) > 0.4)
				#local diff = diff * x;
			#else
				#if(rand(s) > 0.7)
					#local diff = diff * y;
				#else
					#local diff = diff * z;
				#end
			#end
			
			#if(vlength(diff + lastdiff) > 0.5)
				current_pos, 0.1,
				#local current_pos = current_pos + (0.5 + rand(s)) * diff * stepsize;
				#local i = i + 1;
				#local lastdiff = diff;
			#end
		#end
		current_pos - 1000*y, 0.1
		glass()
	}
#end

mangled_pipe(<-20,-35,30>, 10, 30, 43)
mangled_pipe(<-3,-15,30>, 5, 30, 44)
mangled_pipe(<-30,-20,30>, 10, 30, 45)
mangled_pipe(<-30,-55,40>, 10, 40, 46)


//straight pipes
union {
	#declare xpos = -200;
	#declare zpos = 0;
	#declare s = seed(69);
	#while(xpos < 90)
		#declare xpos = xpos + (3 + rand(s)) * 2;
		#declare zpos = 40 + 40*rand(s);
		cylinder {
			<xpos, 1000, zpos>
			<xpos, -1000, zpos>
			0.1
		}
	#end
	#declare xpos = -1000;
	#declare zpos = 0;
	#declare s = seed(70);
	#while(xpos < -200)
		#declare xpos = xpos + (3 + rand(s)) * 20;
		#declare zpos = 50 + 10*rand(s);
		cylinder {
			<xpos, 10000, zpos>
			<xpos, -10000, zpos>
			0.5
		}
	#end
	glass()
}

//background
sphere {
	0
	1000
	hollow
	pigment {
		granite
		color_map {
			[0 rgb 0.07]
			[0.2 rgb 0.07]
			[1.0 rgb <0.16,0.13,0.16>]
		}
		scale 1000
	}
	finish {
		ambient 1
		diffuse 0
	}
	no_shadow
}
