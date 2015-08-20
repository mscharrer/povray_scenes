/////////////////////////////////////////////
//
//     ~~ [ Nuclear Containment ] ~~
//        version 4 out of 4
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

#include "functions.inc"


/////////////////////////
////  configuration  ////
/////////////////////////

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
#declare trace_depth = 9;

//fast values
#if(fastrender)
	#declare rock_octaves = 6;
	#declare rock_max_gradient = 4;
	#declare holder_max_gradient = 1.3;
	#declare isisurface_accuracy = 0.005;
	#declare trace_depth = 3;
#end

global_settings {
	assumed_gamma 1
	max_trace_level trace_depth
	adc_bailout 0.1
}


////////////////////////////////
////  basic scene elements  ////
////////////////////////////////

background {
	rgb .2
}

camera {
	right x*image_width/image_height
	location <0.5,1.5,-1.5>
	look_at <-0.2,0,-0.1>
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
			[1.0 rgb <0.16,0.10,0.17>]
		}
		scale 1000
	}
	finish {
		ambient 1
		diffuse 0
	}
	no_shadow
}


light_source {
	<5,4,-5>
	1
}



////////////////////////
////  declarations  ////
////////////////////////

#macro glass()
	pigment {
		rgbf <0.87,0.87,1.0,0.96>
	}
	finish {
		reflection <0.1,0.15,0.2>
	}
	interior {
		ior 1.5
		media {
			emission 0.6
			intervals 10
			density {
				granite
				color_map {
					[0.36 rgb <0,0,0>]
					[0.37 rgb <3,0,0>]
					[0.38 rgb <0,0,0>]
					
					[0.56 rgb <0,0,0>]
					[0.57 rgb <0,15,0>]
					[0.58 rgb <0,0,0>]
					
					[0.76 rgb <0,0,0>]
					[0.77 rgb <0,0,5>]
					[0.78 rgb <0,0,0>]
				}
			}
		}
	}
	hollow
#end

#declare apparatus_holder = blob {
	sphere {< 0.0, 0,0>, 0.8, 2.5}
	sphere {< 0.0, 1,0>, 1, -0.3}
	sphere {< 0.0,-1,0>, 1, -0.3}
	cylinder {<0.3,0,-1>, <0.3,0,1>, 0.4, -5 }
	sphere {<-0.7, 0,0>, 0.5, 2.0}
	cylinder {<0,0,0>, <-4,0,0>, 0.2, 2 }
	cylinder {<-4,0,0>, <-4,-5000,0>, 0.2, 2 }
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
				emission 10
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
				emission 9
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
				[0.40 rgb  <0.03, 0.02, 0.04>]
				[0.75 rgb  <0.03, 0.02, 0.05>]
				[0.80 rgb  0.00]
				[0.88 rgb  <0,0.8,0>]
				[1.00 rgb  0.00]
			}
			scale 0.7
			translate 30
		}
		finish {
			diffuse 0.5
			ambient 0.2
			reflection <0.2,0.4,0.2>
		}
	}
	
	//plutonium darkeners
	cylinder {
		<0,.3,0>
		<0,-.3,0>
		1.0
		pigment{
			cylindrical
			color_map {
				[0.0  rgbt <0,0,0,1>]
				[0.2  rgbt <0,0,0,0>]
				[1.0  rgbt <0,0,0,0>]
			}
		}
		no_shadow
		no_image
		scale 0.7 * (x+z) + y
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

#declare transformer = union {
	//main shape
	blob {
		//pipe
		cylinder {<0,-10000,0>, <0,10000,0>, .2, 2 }
		
		//blob
		sphere {<0,-2.0,0>, .5, 0.4}
		sphere {<0,-1.5,0>, .5, 0.5}
		sphere {<0,-1.0,0>, 1 , 0.5}
		sphere {<0,-0.5,0>, 1 , 0.6}
		sphere {<0, 0.0,0>, 2 , 1.5}
		sphere {<0, 0.5,0>, 1 , 0.6}
		sphere {<0, 1.0,0>, 1 , 0.5}
		sphere {<0, 1.5,0>, .5, 0.5}
		sphere {<0, 2.0,0>, .5, 0.4}
		
		glass()
		
		hollow
	}
	
	union {
		torus {0.3, 0.04 translate <0,-1.5,0>}
		torus {0.7, 0.05 translate <0,-1.0,0>}
		torus {0.9, 0.05 translate <0,-0.5,0>}
		torus {1.0, 0.05 translate <0, 0.0,0>}
		torus {0.9, 0.05 translate <0, 0.5,0>}
		torus {0.7, 0.05 translate <0, 1.0,0>}
		torus {0.3, 0.04 translate <0, 1.5,0>}
		glass()
		
	}
	//shiny stuff
	sphere {
		0
		1
		
		pigment {
			rgbt 1
		}
		interior {
			ior 1.5
			media {
				emission 11
				intervals 10
				samples 1,2
				density {
					spherical
					color_map {
						[0.0 rgb 0]
						[1.0 rgb 1]
					}
				}
				density {
					granite
					color_map {
						[0.0 rgb 0]
						[0.3 rgb 0]
						[0.5 rgb <1,1,1>]
						[0.6 rgb <3,0,0>]
						[0.7 rgb <0,2,0>]
						[0.8 rgb <0,0,4>]
						[0.8 rgb <1,1,1>]
						[1.0 rgb 0]
					}
					translate 200
				}
			}
		}
		
		scale <0.5,0.8,0.5>
		
		hollow
	}
	
	scale 0.5
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

#declare fireball = sphere {
	0
	1
	pigment {
		rgbt 1
	}
	interior {
		media {
			emission 4
			intervals 8
			density {
				spherical
			}
			density {
				granite
				color_map {
				[0.00 rgb 0]
				[0.50 rgb <1, 0, 0>]
				[0.60 rgb 0]
				[0.65 rgb <5, 4, 1>]
				[0.70 rgb 0]
				[0.80 rgb 0]
				[0.85 rgb <4, 4, 4>]
				[0.90 rgb 0]
				}
			}
		}
	}
	hollow
	no_shadow
}

#declare drone = union {
	blob {
		//general structure
		cylinder {<-1,-1,0> <-1,1,0> 0.6 (-4) }
		sphere{<-1,0,0> 1 3 }
		cylinder{<-.5,0,0> <.5,0,0> .5 2 }
		sphere{<1,0,0> 1 3 }
		cylinder {<1,-1,0> <1,1,0> 0.6 (-4) }
		
		//bumps
		cylinder {<-.3,0,0> <-.3,0.6,0> 0.1 3}
		cylinder {<  0,0,0> <  0,1.0,0> 0.1 3}
		cylinder {< .3,0,0> < .3,0.6,0> 0.1 3}
		sturm
		scale <.8,.3,1>
		
		pigment {
			crackle
			scale 0.07
			color_map {
				[0.0 rgb <.9,.4,.0>]
				[0.1 rgb <.5,.3,.1>]
			}
		}
		finish {
			ambient .1
			diffuse 0.1
			reflection <0.5,0.3,0.1> metallic
		}
		normal {
			bumps 0.1
			scale 0.01
		}
	}
	object {
		fireball
		scale 0.5
		translate -.9*x
	}
	object {
		fireball
		scale 0.5
		rotate 130
		translate .9*x
	}
	//light source
	sphere {
		fireball
		scale 0.4
		translate .5 * y
		no_image
	}
}

///////////////////////////////////
////  manual object placement  ////
///////////////////////////////////


//apparatus objects
object { radioactive_apparatus }
object { radioactive_apparatus rotate <  0, 90,  0> translate < -10, -9,20> }
object { radioactive_apparatus rotate <180,  0,  0> rotate <0,270,0> translate <-15,-17,1> }
object { radioactive_apparatus rotate <  0,193,  0> translate <  7,-16,  1> }
object { radioactive_apparatus rotate <  0,180,  0> translate < -5,-20, 20> }
object { radioactive_apparatus rotate <  0, 90,  0> translate <-65,-45, 40> }
object { radioactive_apparatus rotate <  0,270,  0> translate <-20,-90, 40> }



//transformer objects
object { transformer translate < -4, -9, 22> }
object { transformer scale .7 rotate  10*y translate < -1.65, -0.45,  -0.5> }
object { transformer rotate  20*y translate < -85, -35, 40> }
object { transformer rotate  30*y translate < -16, -42, 40> }
object { transformer rotate  40*y translate < -60,-140, 40> }
object { transformer rotate  50*y translate <-150,-240, 40> }
object { transformer rotate  60*y translate <-190,-150, 40> }
object { transformer rotate  70*y translate <- 30, -15, 35> }
object { transformer rotate  80*y translate <  20, -60, 40> }
object { transformer rotate  90*y translate <  10, -20, 60> }
object { transformer rotate 100*y translate <   0,-130, 60> }

//simple pipes
verical_pipe(< -20,-15,  2>,   5,  5,  0)
verical_pipe(< -30, -6, 10>,   5,  5,  3)
verical_pipe(<  8,  -5, 10>,  -5,  5,  4)
verical_pipe(<-120,-30, 30>,  10, 10,  5)
verical_pipe(<-120,-50, 30>,  10, 10,  8)
verical_pipe(<-120,-70, 30>,  10, 10, 10)
verical_pipe(<  30,-40, 30>, -10, 10, 11)


//complex pipes
mangled_pipe(<-20,-35, 30>, 10, 30, 43)
mangled_pipe(< -3,-15, 30>,  5, 30, 44)
mangled_pipe(<-30,-20, 30>, 10, 30, 45)
mangled_pipe(<-30,-55, 40>, 10, 40, 46)



/////////////////////////
////  auto placement ////
/////////////////////////

//random pipes with transformers and plutonium holders
#declare n = 500;
#declare s = seed(44);

#declare i = 0;
#while(i < n)
	#declare ang = rand(s) * 2 * pi;
	#declare rad = 70 + 40 * rand(s);
	#declare height = (0.9 - 2*rand(s)) * 2 * rad;
	#declare pos = <rad * cos(ang), height, rad * sin(ang)>;
	#declare rot = 360 * rand(s);
	
	object {
		//choose type
		#if(rand(s) > 0.5)
			transformer
		#else
			radioactive_apparatus
		#end
		
		//transform
		rotate rot*y
		translate pos
	}
	
	#declare i = i + 1;
#end


//random drones
#declare n = 2000;
#declare s = seed(42);

#declare i = 0;
#while(i < n)
	#declare pos = <1-2*rand(s),1-2*rand(s),1-2*rand(s)> * 100;
	#if(vlength(pos) > 20)
		object {
			drone
			scale 0.4
			rotate 360 * rand(s) * y
			rotate 20 * <rand(s), 0, rand(s)>
			translate pos
		}
	#end
		
	#declare i = i + 1;
#end
