/////////////////////////////////////////////
//
//     ~~ [ Energy Pulse ] ~~
//        version 1 out of 3
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

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
			[0.00 color <0.0, 0.0, 0.0, 0.8, 0.9>]
			[0.33 color <0.0, 0.2, 0.0, 0.7, 0.8>]
			[0.66 color <0.0, 0.0, 0.0, 1.0, 1.0>]
			[1.00 color <0.1, 0.1, 0.1, 0.6, 0.8>]
		}
		rotate 45*z
	}
}

union {
	//main particle
	sphere {
		<0,0,0>
		1
		hollow
		pigment {
			rgbf 1
		}
		interior {
			media {
				emission 1
				absorption 2
				density{
					marble
					turbulence 20
					lambda 2
					octaves 30
					frequency 0.1
					density_map {
						[0.00 color <0,0,0>]
						[0.50 color <0,0,0.15>]
						[0.55 color <1,1,1>]
						[0.60 color <0,0,0>]
						[1.00 color <0,0,0>]
					}
					rotate 45*z
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
	
	//main particle hull
	sphere {
		<0,0,0>
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
					density_map {
						[0.00 rgb 0]
						[0.07 rgb <0,0,0.02>]
						[0.10 rgb 0.3]
						[0.13 rgb 0]
						[1.00 rgb 0]
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
		scale 1.3
	}
	
	//wall
	sphere {
		<0,0,0>
		1
		hollow
		pigment {
			rgbf 1
		}
		interior {
			media {
				emission 3
				density {
					spherical
					density_map {
						[0.00 rgb 0]
						[0.70 rgb <0,0,0.03> ]
						[1.00 rgb 1]
					}
				}
			}
		}
		scale <0.01,5,0.4>
		translate -1.7*x
	}
	
	//small front sphere
	sphere {
		<0,0,0>
		1
		hollow
		pigment {
			rgbf 1
		}
		interior {
			media {
				emission 3
				density {
					bozo
					density_map {
						[0.00 rgb <0,0,1>]
						[1.00 rgb 1]
					}
					scale 0.1
				}
				density {
					spherical
					density_map {
						[0.00 rgb 0]
						[3.00 rgb 0.1]
						[6.00 rgb 0.3]
						[1.00 rgb 1]
					}
				}
			}
		}
		scale <0.1,0.6,0.3>
		translate -2.2*x
	}
	
	scale <5,3,3>
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
			[0.50 rgb <0.02,0,0.15>]
			[0.60 rgb 0]
			[1.00 rgb 0]
		}
		//translate 5
		scale <20,0.5,1>
		rotate 30*z
	}
}