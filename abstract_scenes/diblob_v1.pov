/////////////////////////////////////////////
//
//     ~~ [ Diblob ] ~~
//        version 1 out of 1
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.6;

global_settings { max_trace_level 12} //should be 12

camera{
	right x*image_width/image_height
	location <0,-5,0>
	look_at <0,0,0>
}

light_source{
	<0,-10,0>
	color 1
}


union{
	blob{
		sphere{
			<-1,0,0> 1.5 2
			pigment{
				checker
				rgb 0
				rgb .2
				scale 0.25
			}
			finish{
				reflection <1,1,1.1>
			}
		}
		sphere{
			<1,0,0> 1.5 2
			pigment{
				checker
				rgb 0
				rgb .2
				scale 0.25
			}
			finish{
				reflection <1.1,1,1>
			}
		}
	}
	scale 1.5
}
/*union{
	blob{
		sphere{ <-1,2,0> 1.5 2 }
		sphere{ < 1,2,0> 1.5 2 }
	}
	sphere{
	pigment{ color <1,1,1> }
	finish{ reflection 1 }
	normal{
		bumps 2
	}
}*/


sphere{
	<0,0,0>
	30
	hollow
	pigment{
		color <1,1,1,1>
	}
	finish{
		reflection <.6,.62,.6>
	}
	normal{
		bumps 0.005
	}
}

sphere{
	<0,0,0>
	100
	hollow
	pigment{
		color <0,0,0,0,0.01>
	}
	finish{
		reflection 1
	}
	normal{
		bumps 0.0001
	}
}

plane{
	y 200
	pigment{
		granite
		color_map{
			[0 rgb 0]
			[1 rgb 4]
		}
		scale 50
		turbulence 0.2
	}
	finish{
		ambient 1
		diffuse 0
	}
}