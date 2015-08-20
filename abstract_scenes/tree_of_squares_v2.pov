/////////////////////////////////////////////
//
//     ~~ [ Tree of Squares ] ~~
//        version 2 out of 4
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#version 3.7;

#declare sq = sqrt(2);

global_settings {
	assumed_gamma 1
}

camera {
	right x*image_width/image_height
	location <0,0,-5>
	look_at <0, 0, 0>
}

background {
	rgb 1
}

#macro plate(level)
	union {
		box {
			<-1,-1,-0.00001*level>
			<1,1,0.00001*level>
			pigment {
				checker
				rgb 0.4
				rgb 0
				translate <0.5,0.5,0>
				scale 1/(pow(2, floor(level / 2 - 1))+0.5)
			}
			finish {
				ambient 1
			}
		}
		triangle {
			#local lenextra = 0;
			#if(level=0)
				#local lenextra = 7;
			#end
			<1,1,0.001*level>
			<-1,1,0.001*level>
			<0,2+lenextra,0.001*level>
			
			pigment {
				spherical
				color_map {
					[0 rgbt <0,0,0,1>]
					[1 rgbt <0,0,0,0.5>]
				}
				scale 0.8
				translate 1.2*y
				scale (1+lenextra/2.5)*y+x+z
			}
			finish {
				ambient 1
			}
		}
	}
#end

#macro pythagoras_tree(pos, siz, rot, level)
	object {
		plate(level)
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
pythagoras_tree(<0,-1.4,0>,0.5,0,12)

//base
box {
	<-0.5,-1.9,-0.001>
	<0.5,-10,0.001>
	pigment {
		checker
		rgb 0.4
		rgb 0
		translate <0.5,0.5,0>
		scale 1/(pow(2, floor(14 / 2 - 1))+0.5)
	}
	finish {
		ambient 1
	}
}
