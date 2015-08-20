/////////////////////////////////////////////
//
//     ~~ [ Tori ] ~~
//        version 1 out of 4
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.6;

camera{
 right x*image_width/image_height
 location <2,5,-11>
 look_at <0,-1.7,0>
}

light_source{
 <0,10,-10>
 color rgb <1,0,0>
}

light_source{
 <0,-10,-10>
 color rgb <0,1,0>
}

light_source{
 <-10,0,-10>
 color rgb <0,0,1>
}

torus{
  4.5,1
 pigment{ color rgbf <1,1,1,0.9> }
 finish{
  reflection 0.2
  refraction 1.0
  ior 1.5
  phong 1.0
 }
 translate <0,-3,0>
}

torus{
  3,1
 pigment{ color rgbf <1,1,1,0.9> }
 finish{
  reflection 0.2
  refraction 1.0
  ior 1.5
  phong 1.0
 }
 translate <0,-1,0>
}

torus{
  1.5,1
 pigment{ color rgbf <1,1,1,0.9> }
 finish{
  reflection 0.2
  refraction 1.0
  ior 1.5
  phong 1.0
 }
 translate <0,1,0>
}

sphere{
 <0,3,0> 1
 pigment{ color rgbf <1,1,1,0.9> }
  finish{
  reflection 0.2
  refraction 1.0
  ior 1.5
  phong 1.0
 }
}