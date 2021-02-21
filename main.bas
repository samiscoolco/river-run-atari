   set kernel_options pfcolors

__Start_Restart
   COLUBK = $D2
   COLUPF = $C6

   player0x = 28
   player0y = 63

   player1x = 27
   player1y = 32


   a=0
   b=0
   c=0
   d=0
   e=0
   f=200

   playfield:
   ................................
   ................................
   ................................
   ................................
   ................................
   ................................
   ................................
   ................................
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
   pfcolors:
   $0E
   $0E
   $F8
   $F8
   $F8
   $F8
   $F8
   $F8
   $28
   $9A
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



 player1:
   %00111100
   %00111100
   %00111100
   %00111100
   %00111100
   %00111000
   %00111000
   %00111000
   %00111000
   %00111000
   %00111000
   %00011000
   %00011000
   %00011000
   %00011000
   %00011000
   %00001000
   %00001000
   %00001000
   %01011001
   %00111110
   %10111100
   %11111111
   %01111100
   %01110110
   %01100001
   %01000000
   %00000000
   %00000000
   %00000000
end



   
   
main
   if switchreset then goto __Start_Restart
   pfpixel 0 7 off
   pfpixel 0 5 off
   b=b+1
   d=d+1
   
   if d>=25 then d=0
   if b>=f then b=0 : gosub make_obs
   c=b//4
   c=temp1
   if c=2 then pfscroll left : player1x=player1x-1
   if player1x<=0 then player1x=160

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
   
   COLUPF = $0E
   COLUP0 = 28
   COLUP1 = $C0
   NUSIZ1=$4

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
   f=rand & 63
   f=f+50
   score=score+10
   e=rand & 3
   if e=3 then pfpixel 31 5 on : return
   pfpixel 31 7 on
   return


eog
   if switchreset then goto __Start_Restart
   drawscreen
   goto eog

reset
   drawscreen
   goto eog
