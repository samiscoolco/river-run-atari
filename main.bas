
   COLUBK = 3
   COLUPF = $C6

   player0x = 28
   player0y = 63


   a=0
   b=0
   c=0
   d=0

   playfield:
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   .....X.........X..........X.....
   .....X.....................X....
   ................................
   ................................
   ...............................X
   ................................
   ................................
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end

 player0:
   %01101100
   %01001000
   %00101000
   %00111000
   %00111000
   %00011000
   %00111000
   %01011000
   %01111100
   %01111010
   %01111000
   %00110000
   %00111100
   %00111100
   %00110100
   %00011000
end



   
   
main

   pfpixel 0 7 off
   b=b+1
   d=d+1
   if d>=25 then d=0
   if b>=200 then b=0 : gosub make_obs
   c=b//4
   c=temp1
   if c=2 then pfscroll left

   if d=0 then player0:
   %01101100
   %01001000
   %00101000
   %00111000
   %00111000
   %00011000
   %00111000
   %01011000
   %01111100
   %01111010
   %01111000
   %00110000
   %00111100
   %00111100
   %00110100
   %00011000
end

   if d>12 then player0:
   %11000110
   %10000100
   %11000100
   %01111000
   %00111000
   %00011000
   %00011000
   %00011110
   %01111100
   %10111000
   %01111000
   %00110000
   %00111100
   %00111100
   %00110100
   %00011000
end
   

   COLUP0 = 28

   /* written by Nat V */
   if joy0up && a=0 then a=40
   if joy0up && a>100 then a=40
   if a > 20 && a < 100 then player0y = player0y-1 : a = a-1
   if a > 0 && a <= 20 then player0y = player0y+1 : a = a-1

   if joy0down && a=0 then a=101
   if !joy0down && a>100 then a=0

   if a>0 then player0:
   %10000011
   %01000010
   %01100110
   %00111000
   %00111000
   %00011000
   %00011000
   %11011000
   %01111000
   %00111000
   %00111110
   %00110011
   %00111100
   %00111100
   %00110100
   %00011000
end

   if a>100 then player0:
   %11110001
   %11111011
   %11011110
   %11001100
   %11111111
   %11000000
   %11000000
   %11110000
   %11110000
   %11010000
   %01100000
   %00000000
   %00000000
   %00000000
   %00000000
   %00000000
end

   drawscreen

   if collision(player0,playfield) then gosub eog


   goto main


make_obs
   score=score+10
   pfpixel 31 7 on
   return


eog
   drawscreen
   goto eog