/////////////////////////////////////////////
//
//     ~~ [ Quarks ] ~~
//        version 2 out of 2
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.6;

global_settings { max_trace_level 16}

camera{
	right 1.5 * x * image_width/image_height
	up 1.5 * y
	location <0,0,-5>
	look_at <0,0,0>
}

//filter
box{
	<-10,-10,-4.5>
	<10,10,-4>
	no_reflection
	no_shadow
	pigment {
		marble
		turbulence 20
		lambda 4
		octaves 30
		frequency 0.1
		color_map {
			[0.00 color <0.0, 0.0, 0.0, 0.8, 0.8>]
			[0.33 color <0.0, 0.2, 0.0, 0.7, 0.7>]
			[0.66 color <0.0, 0.0, 0.0, 1.0, 1.0>]
			[1.00 color <0.1, 0.1, 0.1, 0.6, 0.6>]
		}
		rotate 45*z
	}
	normal{
			bumps 0.02
			scale 0.02
		}
	interior{
		ior 1.5
	}
}

#macro quark_texture (quark_color)
		pigment{
			color
			rgb 0.1 + 0.3 * quark_color
		}
		finish{
			reflection 0.7
			ambient 1
		}
		normal{
			bumps 0.01
			scale 0.001
		}
#end

union{
	//quarks
	sphere{
		<0,sqrt(3),0>
		1
		quark_texture(<1,0,0>)
	}
	sphere{
		<-1,0,0>
		1
		quark_texture(<0,1,0>)
	}
	sphere{
		<1,0,0>
		1
		quark_texture(<0,0,1>)
	}
	
	//bonds
	sphere{
		<0,sqrt(3)/3,0>
		0.05
		quark_texture(<4,5,4>)
		no_image
	}
	sphere{
		<0,sqrt(3)/3,-1>
		0.08
		quark_texture(<2,3,2>)
		no_image
	}
	
	//height adjustment
	translate <0,-sqrt(3)/2,0>
}

//hull
cylinder{
	<0,0,10>
	<0,0,-15>
	10
	finish{
		reflection 0.8
		ambient 1
	}
	normal{
		bumps 0.05
		scale 0.001
	}
	hollow
}