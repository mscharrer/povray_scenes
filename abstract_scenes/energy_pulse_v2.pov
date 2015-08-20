/////////////////////////////////////////////
//
//     ~~ [ Energy Pulse ] ~~
//        version 2 out of 3
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

#declare level_of_detail = 6;

global_settings {
	max_trace_level 4
	assumed_gamma 1.0
}

camera{
	right 4 * x * image_width/image_height
	up 4 * y
	location <0.1,0,-5>
	look_at <0,0,0>
}

//filter
plane {
	z
	0-4
	hollow
	pigment {
		marble
		turbulence 20
		lambda 4
		octaves 30
		frequency 0.1
		color_map {
			[0.00 rgbft <1.0, 1.0, 1.0, 1,.3>]
			[0.33 rgbft <0.7, 1.0, 0.7, 1,.3>]
			[0.66 rgbft <1.0, 1.0, 1.0, 1,.3>]
			[1.00 rgbft <0.8, 0.8, 0.8, 1,.3>]
		}
		rotate 45*z
		scale 20
	}
}

#declare particle_density = density{
	marble
	turbulence 20
	lambda 2
	octaves 30
	frequency 0.1
	density_map {
		[0.00 color <0,0,0>]
		[0.52 color <0,0,0.15>]
		[0.55 color <1.5,1.8,1.2>]
		[0.57 color <0,0,0>]
		[0.60 color <0,0,0>]
		[0.61 color <.5,.5,0>]
		[0.62 color <0,0,0>]
		[1.00 color <0,0,0>]
	}
	rotate 45*z
}

union {
	//main particle
	sphere {
		0 1
		hollow
		pigment {
			rgbf 1
		}
		interior {
			media {
				intervals 5 * level_of_detail
				samples 1, level_of_detail
				emission 1.5
				absorption 2
				density {
					particle_density
				}
				density {
					spherical
					density_map {
						[0.0 rgb <0.0, 0.0, 0.0>]
						[0.4 rgb <0.3, 0.1, 0.1>]
						[0.7 rgb <0.7, 0.5, 0.3>]
						[1.0 rgb <1.0, 1.0, 1.0>]
					}
				}
			}
		}
	}
	
	//particle first hull
	sphere {
		0 1
		hollow
		pigment {
			rgbf 1
		}
		interior {
			media {
				intervals 5 * level_of_detail
				samples 1, level_of_detail
				emission 0.7
				density {
					spherical
					density_map {
						[0.000 rgb 0]
						[0.070 rgb 0]
						[0.075 rgb <.2,0,0>]
						[0.080 rgb <0,.2,0>]
						[0.085 rgb <0,0,.2>]
						[0.090 rgb 0.3]
						[0.105 rgb 0]
						[1.000 rgb 0]
					}
				}
				density {
					gradient x
					density_map {
						[0.00 rgb 1]
						[0.20 rgb 0.4]
						[0.50 rgb 0]
						[1.00 rgb 0]
					}
					translate <0.5,0,0>
					scale 2
				}
			}
		}
		scale 1.1
	}
	
	intersection {
		sphere {
			0 1
		}
		box {
			<-1,-1,-1>
			<-0.5,1,1>
		}
		hollow
		pigment {
			rgbf 1
		}
		interior {
			media {
				intervals 5 * level_of_detail
				samples 1, level_of_detail
				emission 3
				density {
					particle_density
					scale 0.1
				}
				density {
					spherical
					density_map {
						[0.000 rgb <0.0, 0.0, 0.0>]
						[0.010 rgb <0.8, 1.0, 0.8>]
						[0.015 rgb <0.0, 0.0, 0.05>]
						[0.040 rgb <0.0, 0.0, 0.0>]
						[1.000 rgb <0.0, 0.0, 0.0>]
					}
				}
				density {
					gradient x
					density_map {
						[0.00 rgb 1]
						[0.10 rgb 0.4]
						[0.20 rgb 0]
						[1.00 rgb 0]
					}
					translate <0.5,0,0>
					scale 2
				}
			}
		}
		scale <1.5, 3, 0.3>
		translate <0,0.1,0>
	}
	
	scale <6.9,3.7,3.7>
	rotate <0,0,30>
	translate<1.6,1,0>
}

//background
plane {
	z
	10
	hollow
	pigment {
		granite
		color_map {
			[0.00 rgb 0]
			[0.40 rgb 0]
			[0.50 rgb <0.08,0,0.6>]
			[0.60 rgb 0]
			[1.00 rgb 0]
		}
		//translate 5
		scale <20,0.5,1>
		rotate 30*z
	}
}