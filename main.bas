
   COLUBK = 3
   COLUPF = 144

   player0x = 28
   player0y = 63


   a=0
   b=0
   c=0

   playfield:
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   ................................
   ................................
   ................................
   ................................
   ................................
   ................................
   ................................
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end

   player0:
    %00011100
    %00011000
    %00011000
    %01011010
    %00111100
    %00011000
    %00010100
    %00011100
end

   
   
main

   b=b+1
   score=0
   if b>=200 then b=0 : gosub make_obs
   c=b//8
   c=temp1
   if c=2 then pfscroll left
   

   COLUP0 = 28
   COLUP1 = 28

   /* written by Nat V */
   if joy0fire && a=0 then a=40
   if a > 20 then player0y = player0y-1 : a = a-1
   if a > 0 && a <= 20 then player0y = player0y+1 : a = a-1

   drawscreen

   if collision(player0,playfield) then gosub eog

   

   goto main


make_obs
   pfpixel 31 7 on
   return


eog
   drawscreen
   goto eog