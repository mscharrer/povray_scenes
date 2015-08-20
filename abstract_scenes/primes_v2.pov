/////////////////////////////////////////////
//
//     ~~ [ Primes ] ~~
//        version 2 out of 2
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

#include "textures.inc"
//number of spheres
#declare n = 10000;
#declare s = seed(72);

//primes
#debug "calculating prime numbers\n"
#declare primes = array[n];
#declare primes[0] = 2;
#declare primes[1] = 3;
#declare i=2;
#declare p=4;
#while(i<n)
	#declare isprime = true;
	#declare q = 0;
	#declare l = sqrt(p);
	#while(primes[q]<=l)
		#if(mod(p,primes[q])=0)
			#declare isprime = false;
		#end
		#declare q = q+1;
	#end
	#if(isprime)
		#declare primes[i] = p;
		#declare i = i+1;
	#end
	#declare p = p+1;
#end

//calculate number of prime factors
#debug "calculating prime factors\n"
#declare factors = array[n];
#declare factors[0] = 0;
#declare factors[1] = 0;
#declare factors[2] = 1;
#declare f = 3;
#while(f<n)
		#local i = 0;
		#local p = 2;
		#while(primes[i]<=f)
			#if(mod(f,primes[i])=0)
				#local p = primes[i];
			#end
			#local i = i+1;
		#end
/*		#debug str(i,5,5)
		#debug "\t"
		#debug str(i,5,5)*/
		#declare factors[f] = factors[f/p]+1;
	#declare f = f+1;
#end

camera{
	right x*image_width/image_height
	location <0,-30,30>
	look_at <0,0,0>
}

light_source{
	<0,-70,25>
	color rgb 0.8
}

light_source{
	<0,-50,-50>
	color rgb <0,0,2>
}

global_settings {
	max_trace_level 7
}

//prime spheres
#debug "creating visible spheres based on prime factors\n"
union{
	#declare i = 2;
	#while(i<n)
		#declare sq = sqrt(i);
		#declare pos = <sq*sin(2*pi*sq),sq*cos(2*pi*sq),0>;
		sphere{
			pos+<0,0,0.5>
			0.5
			pigment{
				#switch (factors[i])
					#case (1)
						color rgb 0
					#break
					#case (2)
						color rgb <.8,.2,.2>
					#break
					#case (3)
						color rgb <.6,.6,.1>
					#break
					#case (4)
						color rgb <.4,.4,.9>
					#break
					#case (5)
						color rgb <.5,.8,.5>
					#break
					#range (6,8)
						color rgb .9
					#break
					#else
						color rgb 1.5
				#end
			}
			finish{
				reflection 0.6
			}
			normal{
				bumps
				0.6 * (1-1/sqrt(factors[i]))
				scale 0.00001
			}
			no_shadow
			#if((factors[i])=1)
				no_reflection
			#end
		}
		#if((factors[i])=1)
			sphere{
				pos+<0,0,0.5>
				0.49
				pigment{
					color rgb -3
				}
				finish{
					ambient 1
					diffuse 0
				}
				no_image
				no_shadow
			}
		#end
		#declare i = i+1;
	#end
	rotate <0,0,-33>
}

//random spheres
#debug "creating other objects\n"

//ground
plane{
	z
	0
	texture{
		pigment{
			color
			rgb 0.5
		}
		normal{
			bumps 1.5
			scale 0.00001
		}
		finish{
			ambient 0.5
			diffuse 0.1
			reflection 1
		}
	}
}

//sky
sphere{
	0
	1
	pigment{
		bozo
		color_map{
			[0.0 rgb 0]
			[0.8 rgb 0]
			[0.85 rgb <1,0,0>]
			[1.0 rgb 4]
		}
		scale 0.005
	}
	finish{
		ambient 1
		diffuse 0
	}
	scale 1000
}