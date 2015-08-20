/////////////////////////////////////////////
//
//     ~~ [ Tree of Squares ] ~~
//        version 3 out of 4
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

#declare sq = sqrt(2);
#declare cs = seed(42);

global_settings {
	assumed_gamma 1
}

camera {
	right x*image_width/image_height
	location <0,0,-5>
	look_at <0, 0, 0>
}

#macro plate(level, extralen)
	union {
		box {
			<-1,-1,-0.00001*level>
			<1,1+extralen,0.00001*level>
			pigment {
				#local checker_scale = 1/max(pow(2, floor(level / 2 - 3))+0.5,1.5);
				checker
				pigment {
					checker
					rgb 0.5
					rgb 0.3
					scale 1/4
				}
				pigment {
					checker
					rgb 0.1
					rgb 0.0
					scale 1/4
				}
				translate <0.5,0.5,0>
				scale checker_scale
			}
			finish {
				ambient 1
			}
		}
		triangle {
			#local lenextra = 0;
			#if(level=0)
				#local lenextra = 12;
			#end
			<1,1+extralen,0.001*level>
			<-1,1+extralen,0.001*level>
			<0,2+extralen+lenextra,0.001*level>
			
			pigment {
				spherical
				color_map {
					#local rcolor = <1,1,0>;
					#if(rand(cs) > 0.25)
						#local rcolor = <2,0,0>;
					#end
					#if(rand(cs) > 0.50)
						#local rcolor = <0,2,0>;
					#end
					#if(rand(cs) > 0.75)
						#local rcolor = <0,0,2>;
					#end
					#if(level<=4)
						[0 rgbt <rcolor.x, rcolor.y, rcolor.z,0.99>]
						[1 rgbt <rcolor.x, rcolor.y, rcolor.z,1 - 1/(level+1)>]
					#else
						[0 rgbt <0,0,0,1.0>]
						[1 rgbt <rcolor.x/pow(1.25,level), rcolor.y/pow(1.25,level), rcolor.z/pow(1.25,level), 0.4>]
					#end
				}
				scale 0.8
				translate 1.2*y
				scale (1+lenextra/2.5)*y+x+z
			}
			finish {
				ambient 1
			}
		}
		no_shadow
	}
#end

#macro pythagoras_tree(pos, siz, rot, level)
	object {
		plate(level, 0)
		rotate rot*z
		scale siz
		translate pos
	}
	#if(level > 0)
		pythagoras_tree(pos + siz*vrotate(<1,2,0>,rot*z), siz/sq, rot - 45, level - 1)
		pythagoras_tree(pos + siz*vrotate(<-1,2,0>,rot*z), siz/sq, rot + 45, level - 1)
	#end
#end

//tree
pythagoras_tree(<0,-1.4,0>,0.5,0,14)

//base
object {
	plate(14,10)
	scale -0.5
	translate -1.4*y
}

//background
plane {
	z
	1
	pigment {
		hexagon
		rgb 1, rgb 0.95, rgb 0.9
		rotate 90*x
		scale 0.03
	}
	finish {
		ambient 1
	}
	no_shadow
	hollow
}
