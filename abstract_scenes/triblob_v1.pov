/////////////////////////////////////////////
//
//     ~~ [ Triblob ] ~~
//        version 1 out of 1
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.6;

global_settings { max_trace_level 9}

camera{
	right x*image_width/image_height
	location <0,-5,0>
	look_at <0,0,0>
}

light_source{
	<0,-10,0>
	color <0.75,0.9,1.7>
}

#macro coolBlobSpheres(num)
	#local r=sin(pi/num);
	#if(num=3)
		#local r=0.85;
	#end
	#local i=0;
	#while(i<num)
		#local p=i/num*2*pi;
		sphere{ <cos(p),0,sin(p)> 1.5*r 2 }
		#declare i=i+1;
	#end
#end

#macro coolBlob(num,initial)
union{
	blob{
		coolBlobSpheres(num)
		pigment{
			checker
			rgb 0
			rgb .2
			scale 0.25
		}
		finish{
			reflection <1.08,0.8,0.7>
		}
		no_image
	}
	blob{
		coolBlobSpheres(num)
		pigment{
			color
			rgb initial
		}
		normal{
			bumps 0.0005
			scale 0.01
		}
		finish{
			reflection <1.1,0.9,0.9>
		}
		no_reflection
	}
}
#end

//main blob
object{
  coolBlob(3,0.03)
  scale 1.4
}

#declare s=seed(10);

//dots
#declare i=0;
#while(i<130)
	#local pos = <24*rand(s)-12,6-rand(s),15*rand(s)-7.5>;
	#local rot = 90*pow(rand(s),3)*<rand(s),rand(s),rand(s)>;
	#local num = ceil(rand(s)*5)+1;
	#local sz = 0.3*pow(rand(s),0.4);
	sphere{
		pos
		2*sz
		hollow
		pigment{
			color rgb <0,0,0>
		}
		finish{
			reflection 1
		}
		normal{
			bumps 0.01
		}
		no_image
		no_shadow
	}
	#declare i=i+1;
#end

sphere{
	<0,0,0>
	30
	hollow
	pigment{
		color <1,1,1,1>
	}
	finish{
		reflection <.6,.63,.6>
	}
	normal{
		bumps 0.005
	}
	no_image
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
	hollow
	pigment{
		granite
		color_map{
			[0 rgb 0]
			[1 rgb <4.5,6.5,4>]
		}
		scale 50
		turbulence 0.2
	}
	finish{
		ambient 1
		diffuse 0
	}
}