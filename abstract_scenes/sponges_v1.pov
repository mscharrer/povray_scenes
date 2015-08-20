/////////////////////////////////////////////
//
//     ~~ [ Sponges ] ~~
//        version 1 out of 1
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

global_settings {
	assumed_gamma 1
	max_trace_level 20
}

camera {
	right x*image_width/image_height
	location <0,0,-5>
	look_at <0, 0, 0>
}

light_source {
	<0,0,-2>
	color rgb 1
}

background {
	rgb <0,.2,0>
}

//generate spheres for the blob object
#macro fractal(pos,  d1,  d2,  d3, a1, a2,  level)
	#declare s = seed(42);
	#if(level = 0)
		sphere {
			pos
			#if((a1=0) & (a2!=2))
				(vlength(d1) + vlength(d2) + vlength(d3))*(1.1 + 0.2*abs(a2-a1))
			#else
				(vlength(d1) + vlength(d2) + vlength(d3))*(0.7 + 0.25*abs(a2-a1))
			#end
			1.2
		}
	#else
		#local l = level - 1;
		
		#local px = -1;
		#local nullcount = 0;
		#while(px<2)
			#local py = -1;
			#while(py<2)
				#local pz = -1;
				#while(pz<2)
					#local nset = abs(px) + abs(py) + abs(pz);
					#if(nset=a1 | nset=a2)
						#local npos = pos + px*d1 + py*d2 + pz*d3;
						#local rot = 0.3*<rand(s), rand(s), rand(s)>;
						#local nd1 = vrotate(d1, rot) / 3;
						#local nd2 = vrotate(d2, rot) / 3;
						#local nd3 = vrotate(d3, rot) / 3;
						fractal(npos, nd1, nd2, nd3, a1, a2, l)
					#end
					#local pz = pz + 1;
				#end
				#local py = py + 1;
			#end
			#local px = px + 1;
		#end
		
	#end
#end

#macro construct(siz, a, b, col, level)
	blob {
		fractal(<0,0,0>,  siz*x, siz*y, siz*z, a, b, level)
		pigment {
			rgb col
		}
		finish {
			diffuse 0.05
			ambient 0.01
			reflection 0.9
		}
	}
#end

#declare se = seed(24);
object {
	construct(0.3, 1, 2, <1.0, 0.8, 0.9>, 3)
	rotate (350*<rand(se), rand(se), rand(se)>)
	translate 1.7*y
	rotate (20 + 0 * 60)*z
}

object {
	construct(0.3, 0, 3, <0.9, 0.8, 1.0>, 4)
	rotate (360*<rand(se), rand(se), rand(se)>)
	translate 1.7*y
	rotate (20 + 1 * 60)*z
}


object {
	construct(0.3, 2, 3, <1.0, 0.8, 0.9>, 3)
	rotate (360*<rand(se), rand(se), rand(se)>)
	translate 1.7*y
	rotate (20 + 2 * 60)*z
}

object {
	construct(0.3, 0, 1, <1.3, 1.15, 1.45>, 5)
	rotate (360*<rand(se), rand(se), rand(se)>)
	scale 1.8
	translate 1.7*y
	rotate (20 + 3 * 60)*z
}

object {
	construct(0.3, 1, 3, <1.0, 0.8, 0.9>, 3)
	rotate (360*<rand(se), rand(se), rand(se)>)
	translate 1.7*y
	rotate (20 + 4 * 60)*z
}

object {
	construct(0.3, 0, 2, <1.0, 0.9, 1.1>, 3)
	rotate (360*<rand(se), rand(se), rand(se)>)
	translate 1.7*y
	rotate (20 + 5 * 60)*z
}

//background plane
plane {
	z
	1
	pigment {
		rgb 0.03
	}
	finish {
		reflection 0.3
	}
	normal {
		bumps 0.001
		scale 0.01
	}
}

//reflector behind camera
plane {
	z
	(-6)
	pigment {
		rgb 0
	}
	finish {
		reflection 0.5
	}
	normal {
		bumps 0.05
		scale 0.05
	}
}