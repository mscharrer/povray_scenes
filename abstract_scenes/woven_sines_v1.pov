/////////////////////////////////////////////
//
//     ~~ [ Woven Sines ] ~~
//        version 1 out of 2
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.6;

global_settings { max_trace_level 12} 

camera{
	right x*image_width/image_height
	location <0,0,-25>
	look_at <0,0,0>
}

light_source{
	2*<0,0,-11>
	color rgb 1
}


blob{
	#declare i=0;
	#while(i<2*2*pi)
		sphere{
			3.5*<3*sin(11*i),2*sin(10*i),sin(9*i)>
			0.7
			1
		}
		#declare i = i+0.004;
	#end
	translate <0,0,-4>
	no_shadow
	finish{
		reflection 1
	}
}

#declare pigm = function{
	pattern {
		granite
		turbulence 1
	}
}
union{
	plane{z 0}
	plane{-z 30}
	pigment{
		function{
			pigm(3*x+4*pow(1.05,-x)+2.5*sqrt(pow(x-15,2)+pow(y,2)),y/2,1)
		}
	}
	finish{
		reflection 0.5
	}
	normal{
		bumps 0.001
		scale 0.1
	}
}
