/////////////////////////////////////////////
//
//     ~~ [ Magnification ] ~~
//        version 1 out of 1
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.6;

global_settings { max_trace_level 12}

camera{
	right x*image_width/image_height
	location <2,5,-10>
	look_at <0,0,0>
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

#declare r = seed(1276543);

#declare a=-100;
#while (a<=100)
 #declare b=-100;
 #while (b<=100)
   #declare o = a+rand(r)/4;
   #declare p = b+rand(r)/4;
   sphere{
    <o,p,40> 0.4
    pigment{ color rgbf <1,1,1,0.9> }
    finish{
     reflection 0.3
     phong 1.0
    }
    interior{
			ior 1+rand(r)
		}
   }
  #declare b = b+1;
 #end
 #declare a = a+1;
#end

sphere{
    <0,0,20> 4.0
    pigment{ color rgbf <0.9,0.9,0.8,0.9> }
     finish{
     reflection 0.1
     ior 0.8
     phong 1.0
    }
}

sphere{
    <0,0,10> 4.0
    pigment{ color rgbf <0.9,0.9,0.8,0.9> }
     finish{
     reflection 0.1
     ior 1.2
     phong 1.0
    }
}

sphere{
    <0,0,0> 4.0
    pigment{ color rgbf <0.9,0.9,0.8,0.9> }
     finish{
     reflection 0.1
     ior 1.1
     phong 0.8
    }
}