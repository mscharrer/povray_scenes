/////////////////////////////////////////////
//
//     ~~ [ Tori ] ~~
//        version 3 out of 4
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.6;

global_settings { max_trace_level 9}

camera{
 right x*image_width/image_height
 location <2,5,-11>
 look_at <0,-1.7,0>
}

//
light_source{ <0,10,-10>  color rgb <.8,0,0> }
light_source{ <0,-10,-10> color rgb <0,.8,0> }
light_source{ <-10,0,-10> color rgb <0,0,.8> }
light_source{ <10,10,10>  color rgb <.1,.1,.1> } //new light added

//old construct
//combined all objects into one
union{
 torus{ 4.5,1 translate <0,-3,0> }
 torus{ 3,1   translate <0,-1,0> }
 torus{ 1.5,1 translate <0,1,0>  }
 sphere{ <0,3,0> 1 }


 //texture
 pigment{ color rgbf <1,1,1,0.9> }
 finish{ reflection .3 phong 1.0 }
 interior{ ior 1.5 }
}

//added more stuff outside the area of view
//gets rid of the reflective emptiness in the lower parts of the picture
union{
 sphere{ <0,15,0> 8 }
 torus{ 13,4 translate <0,15,0> }
 pigment{ color rgbf <.3,.3,.3,0.9> }
 finish{ reflection .2 phong 0.5 }
 interior{ ior 1.8 }
}

sphere{
 <0,0,0> 100
 hollow
 pigment{ color rgb 0 }
 finish{ ambient 0 phong 0 reflection 1 }
}

//another reflecting sphere at half radius (50% reflection, 50% transmittance)
sphere{
 <0,0,0> 50
 hollow
 pigment{ color rgbt <0,0,0,.5> }
 finish{ ambient 0 phong 0 reflection 1 }
}