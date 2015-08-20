/////////////////////////////////////////////
//
//     ~~ [ Star ] ~~
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
	location <0,0,0>
	look_at <0,0,-9>
}


//background
blob{
	sphere{ <0,0,-9> 1 2 }
	sphere{ <0,0,-7> 2 2 }
	sphere{ <0,0,-4> 3 2 }
	sphere{ <0,0, 0> 4 2 }
	sphere{ <0,0, 4> 3 2 }
	sphere{ <0,0, 7> 2 2 }
	sphere{ <0,0, 9> 1 2 }
	
	hollow
	
	pigment{
		granite
		color_map {
			[0 rgb 0]
			[1 rgb 0.001]
		}
	}
	finish {
		reflection <0.95,0.90,0.80>
	}
	normal {
		bumps 0.05
		scale 0.03
	}
	scale 5
}

//star light source
light_source {
	<0,0,-3>
	<1,1.2,1.4>
}

//star object
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
					[0.6 rgb <0.3,0.3,0.6>]
					[0.7 rgb <0.9,0.9,1>]
					[1.0 rgb <2,2,4>]
				}
			}
			density{
				bozo
				turbulence 2
				lambda 2
				density_map{
					[0.00 rgb 0.3]
					[0.33 rgb 1.0]
					[0.66 rgb 1.7]
					[1.00 rgbt 0]
				}
			}
			density{
				bozo
				scale 3
				turbulence 2
				lambda 2
				density_map{
					[0.00 rgb 1.0]
					[0.33 rgb 0.0]
					[0.66 rgb 1.0]
					[1.00 rgbt 10.0]
				}
			}
			density{
				bozo
				scale 1/5
				turbulence 2
				lambda 2
				density_map{
					[0.00 rgb 1.0]
					[0.33 rgb 0.0]
					[0.66 rgb 1.0]
					[1.00 rgbt 10.0]
				}
			}
		}
	}
	
	scale 0.55
	translate -3*z
}

//planets
#declare s = seed(44);
#declare n = 1;
#while (n <= 10)
	#declare rad = 0.2 + rand(s) * 3;
	#declare ang = rand(s) * 2 * pi;
	#declare dia = 0.015 + 0.01 * rand(s);
	
	sphere {
		<rad * cos(ang), rad * sin(ang), -3>
		dia
		no_reflection
		no_shadow
		pigment{
			granite
			scale 0.02
			color_map {
				[0 rgb 0]
				[.5 rgb <.8,.5,.4>]
				[1 rgb 1]
			}
		}
		finish {
			ambient 0
		}
	}
	#declare n = n + 1;
#end

//"earth"
sphere {
	<1.7, 1, -3>
	0.05
	no_reflection
	no_shadow
	pigment{
		rgb <.2,.3,.8>
	}
	finish {
		ambient 0
		specular 0.5
	}
	normal {
		bumps 0.5
		scale 0.001
	}
}

// planet clouds
sphere{
	<1.7, 1, -3>
	0.0505
	no_reflection
	no_shadow
	pigment {
		granite
		color_map{
			[0.00 rgbt <1,1,1,1>]
			[0.35 rgbt 1]
			[0.40 rgbt <1,1,1,0.8>]
			[0.50 rgb 0.8]
			[1.00 rgb 1.2]
		}
		scale 0.05
		turbulence 0.3
		lambda 2
		omega 0.2
		translate 0.1
	}
	finish{
		ambient 0
	}
}