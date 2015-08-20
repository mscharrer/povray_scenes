/////////////////////////////////////////////
//
//     ~~ [ Woven Sines ] ~~
//        version 2 out of 2
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.6;

global_settings {
	max_trace_level 20
	//assumed_gamma 1.5
} 

camera{
	right x*image_width/image_height
	location <0,0,-25>
	look_at <0,0,0>
}

light_source{
	2*<0,0,-11>
	color rgb 1
}

#macro blobTex(reflectionColor)
	pigment{
		color rgb 0
	}
	finish{
		reflection reflectionColor
	}
#end

blob{
	#declare i=0;
	#while(i<2*2*pi)
		#declare xPos = sin(11*i);
		#declare yPos = sin(10*i);
		#declare zPos = sin(9*i);
		sphere{
			3.5*<3*xPos,2*yPos,zPos>
			0.7
			1
		}
		//#declare i = i+0.004;
		#declare i = i+0.004;
	#end
	translate <0,0,-4>
	no_shadow
	/*texture{
		gradient z
		texture_map{
			[-1 blobTex(<1,.95,.8>)]
			[1 blobTex(<.9,.9,.9>)]
		}
	}*/
	blobTex(<1,.95,.8>)
}

#declare pigm = function{
	pattern {
		granite
		turbulence 1
		scale 0.3
	}
}

plane{
	z 0
	pigment{
		function{
			0.3*pigm(3*x+4*pow(1.05,-x)+2.5*sqrt(pow(x-15,2)+pow(y,2)),y/2,1)
		}
	}
	finish{
		reflection 0.5
	}
	normal{
		bumps 0.01
		scale 0.01
	}
}

plane{-z 30
	pigment{
		granite
		color_map{
			[0 rgb 0]
			[1 rgb <.9,.9,1.2>]
		}
		turbulence 1
		scale 0.1
	}
	finish{
		reflection <0.5,0.5,0.55>
	}
	normal{
		bumps 0.001
		scale 0.1
	}
}