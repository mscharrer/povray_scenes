/////////////////////////////////////////////
//
//     ~~ [ Downward Spiral ] ~~
//        version 1 out of 1
//
//  by Michael Scharrer
//  https://mscharrer.net
//
/////////////////////////////////////////////

camera{
	right x*image_width/image_height
 location <2,5,-10>
 look_at <0,-2.5,0>
}

global_settings {
 photons {
  count 20000
  media 500
  autostop 100
  jitter .2
 }
}

light_source{
 <0,0,0>
 color rgb <-0.4,-0.4,-0.4>
}

light_source{
 <0,-10,0>
 color rgb <-0.4,-0.4,-0.4>
}

light_source{
 <1000,0,3000>
 color rgb <3,3,3>
}

light_source{
 <0,30,-30>
 color rgb <0.7,0.3,0.3>
}

light_source{
 <0,-30,-30>
 color rgb <0.3,0.5,0.3>
}

light_source{
 <-30,0,-30>
 color rgb <0.3,0.3,0.7>
}

#declare s = seed(69);
#declare s2 = seed(69);

#declare ab = 0;
#declare bb = 0;
#declare cb = 0;
#declare a = 0;
#declare b = 0;
#declare c = 0;

#declare n=1;
#while (n<=1000000)
 #declare ab = a;
 #declare bb = b;
 #declare cb = c;
 #declare a = sin(sqrt(n))*n/40;
 #declare b = -n/200 -100/n -10/sqrt(n);
 #declare c = cos(sqrt(n))*n/40;
 #declare ab = ab-a;
 #declare bb = bb-b;
 #declare cb = cb-c;
 sphere{
  <a,b,c> 0.4*(1-1/sqrt(sqrt(n)))
  #if (rand(s)+n*n/100000000>0.85)
   #if(rand(s)>0.5)
    pigment { color <0.3,0.3,0.4> }
    finish {
     reflection 0.8
    }
    normal{
     bumps 1/20
     scale 1/5.5
    }
    photons {
     target
     refraction on
     reflection on
    }
   #else
    pigment { color <0.95,1,0.95,0.9> }
    finish { reflection 0.1 }
    interior { ior 1.4 }
    normal{
     bumps 1/50
     scale 1/5
    }
    photons {
     target
     refraction on
     reflection on
    }
   #end
  #else
  pigment{
   marble
   turbulence 2+rand(s)
   color_map {
    #declare rc = rand(0.5);
    [0.0  color <rc+rand(s)/2,rc+rand(s)/2,rc+rand(s)/5,0.5*rand(s)>]
    #declare rc = rand(0.5);
    [0.25 color <rc+rand(s)/2,rc+rand(s)/2,rc+rand(s)/5,0.5*rand(s)>]
    #declare rc = rand(0.5);
    [0.5  color <rc+rand(s)/2,rc+rand(s)/2,rc+rand(s)/5,rand(s)>/3+2/3]
    #declare rc = rand(0.5);
    [0.75 color <rc+rand(s)/2,rc+rand(s)/2,rc+rand(s)/5,0.5*rand(s)>]
    #declare rc = rand(0.5);
    [1.0  color <rc+rand(s)/2,rc+rand(s)/2,rc+rand(s)/5,0.5*rand(s)>]
   }
  }
  #end
 }
 #declare n = n+4;
#end

/*#declare ab = 0;
#declare bb = 0;
#declare cb = 0;
#declare a = 0;
#declare b = 0;
#declare c = 0;

#declare n=1;
//blob{
//threshold 0.3
#while (n<=1000) //missing 00
 #declare ab = a;
 #declare bb = b;
 #declare cb = c;
 #declare a = sin(sqrt(n))*n/40;
 #declare b = -n/200 -100/n -10/sqrt(n);
 #declare c = cos(sqrt(n))*n/40;
 #declare ab = ab-a;
 #declare bb = bb-b;
 #declare cb = cb-c;
 sphere{
  <a,b,c> 2*(1-1/sqrt(sqrt(n)))
  hollow
  pigment{ color <1,1,1,1> }
  interior { media{
   emission 0.05
   density { spherical
      color_map {
        [0.0 rgbt <0,0,0.5,1>]
        [0.5 rgbt <0.8, 0.8, 0.4,0>]
        [1.0 rgbt <1,1,1,0>]
      }
    }
  }}
 }
 #declare n = n+4;
#end

//}*/

sky_sphere {
 pigment {
  marble
  color_map { //bg "clouds"
   [ 0.0  color <0.0,0.0,0.0,1> ]
   [ 0.7  color <0.0,0.0,0.1,0.5> ]
   [ 1.0  color <0.0,0.0,0.0,1> ]
  }
  turbulence 2
  scale 1
 }
 pigment { //small stars
  granite
  color_map {
   [ 0.0  color <0.0,0.0,0.0,1> ]
   [ 0.8  color <0.0,0.0,0.0,1> ]
   [ 1.0  color <0.5,0.5,0.5,0> ]
  }
  turbulence 1
  scale 1/50
 }
 pigment { //large stars
  granite
  color_map {
   [ 0.0  color <0.0,0.0,0.0,1> ]
   [ 0.8  color <0.0,0.0,0.0,1> ]
   [ 1.0  color <1,0.9,0.8,0> ]
  }
  //turbulence 1
  scale 1/20
 }
 pigment { //red stuff
  granite
  color_map {
   [ 0.0  color <0.0,0.0,0.0,1> ]
   [ 0.5  color <0.0,0.0,0.0,1> ]
   [ 1.0  color <1,0,0,0.0.95>  ]
  }
  turbulence 1
  scale 1/3
 }
}
