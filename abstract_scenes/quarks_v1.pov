/////////////////////////////////////////////
//
//     ~~ [ Quarks ] ~~
//        version 1 out of 2
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.6;

global_settings { max_trace_level 14} //should be 12

camera{
	right x*image_width/image_height
	location <0,0,-5>
	look_at <0,0,0>
}

box{
	<-10,-10,-4.5>
	<10,10,-4>
	no_reflection
	no_shadow
	pigment{
		color
		<0,0,0,1,1>
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
			rgb 0.1 +0.3*quark_color
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
	translate <0,-sqrt(3)/2,0>
}

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