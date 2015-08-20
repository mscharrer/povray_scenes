/////////////////////////////////////////////
//
//     ~~ [ Tori ] ~~
//        version 4 out of 4
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.6;

global_settings {
	max_trace_level 11
	assumed_gamma 3 //added gamma
}

camera{
	right x*image_width/image_height
	location <2,5,-11>
	look_at <0,-1.7,0>
}


light_source{ <10,10,-3>  color rgb -.3 }//new negative light added
light_source{ <0,10,-10>  color rgb <.8,0,0> }
light_source{ <0,-10,-10> color rgb <0,.65,0> }
light_source{ <-10,0,-10> color rgb <0,0,1> }
light_source{ <10,10,10>  color rgb <.1,.1,.1> }

union{
	torus{ 7.5,1 translate <0,-7,0> no_image}
	torus{ 6,1 translate <0,-5,0> no_image}
	torus{ 4.5,1 translate <0,-3,0> }
	torus{ 3,1   translate <0,-1,0> }
	torus{ 1.5,1 translate <0,1,0>  }
	sphere{ <0,3,0> 1 }
	torus{ 1.5,1 translate <0,5,0>  no_image}
	torus{ 3,1   translate <0,7,0> no_image}
	torus{ 4.5,1 translate <0,9,0> no_image}
	torus{ 6,1 translate <0,11,0> no_image}
	torus{ 7.5,1 translate <0,13,0> no_image}
	
	texture{
		pigment{ color rgbf <1,1,1,0.9> }
		finish{ reflection .3 phong 1.0 }
	}
	interior{ ior 1.5 }
}

//out of view objects removed

//second reflecting sphere removed

sphere{
	<0,0,0> 50
	hollow
	pigment{ color rgbt <0,0,0,.5> }
	finish{ ambient 0 phong 0 reflection 1 }
}