/////////////////////////////////////////////
//
//     ~~ [ Tree of Squares ] ~~
//        version 1 out of 4
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

#macro pythagoras_tree(pos, siz, rot, level)
	object {
		box {
			<-1,-1,-0.00001>
			<1,1,0.00001>
			pigment {
				rgb 0.3
			}
		}
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


