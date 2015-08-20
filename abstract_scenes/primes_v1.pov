/////////////////////////////////////////////
//
//     ~~ [ Primes ] ~~
//        version 1 out of 2
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
#macro nfactors(n)
	#if(n<=1)
		0
	#else
		#local i = 0;
		#local p = 2;
		#while(primes[i]<=n)
			#if(mod(n,primes[i])=0)
				#local p = primes[i];
			#end
			#local i = i+1;
		#end
		(nfactors(n/p)+1)
	#end
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
				color rgb 1-1/nfactors(i)
			}
			finish{
				reflection 0.6
			}
			normal{
				bumps
				1 * (1-1/sqrt(nfactors(i)))
				scale 0.00001
			}
			no_shadow
			#if((nfactors(i))=1)
				no_reflection
			#end
		}
		#if((nfactors(i))=1)
			sphere{
				pos+<0,0,0.5>
				0.49
				pigment{
					color rgb -2
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
union{
	#declare i = 2;
	#while(i<n)
		#declare sq = sqrt(i);
		#declare pos = <sq*sin(2*pi*sq),sq*cos(2*pi*sq),0>;
		sphere{
			pos+<1-2*rand(s),10-2*rand(s),1-2*rand(s)>
			0.2
			pigment{
				color rgb <rand(s),rand(s),rand(s)>/2
			}
			finish{
				ambient 1
				diffuse 0
			}
		}
		#declare i=i+5;
	#end
	no_shadow
	no_image
}

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