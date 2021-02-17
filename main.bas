   dim p0_x = b
   dim p0_y = c

   COLUBK = 0
   COLUPF = 144

   player0x = 92
   player0y = 47
   player1y = 47

   missile0height = 5
   missile0x = 75
   missile0y = 40

   playfield:
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   XX..............................
   XX..............................
   XX..............................
   XX..............................
   XX..............................
   XX..............................
   XX..............................
   XX..............................
   XX..............................
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

   player1:
    %11001101
    %11001100
    %11001100
    %11001100
    %11001100
    %11001100
    %11001100
    %11001100
end

   
main


   COLUP0 = 28
   COLUP1 = 28

   NUSIZ1 = $03

   p0_x = 0
   if joy0left then p0_x = 255
   if joy0right then p0_x = 1
   player0x = player0x + p0_x

   p0_y = 0
   if joy0up then p0_y = 255
   if joy0down then p0_y = 1
   player0y = player0y + p0_y

   player1x=player1x-1

   drawscreen

   if collision(player0,playfield) then gosub knock_player_back
   if collision(player0,player1) then goto eog

   /*pfscroll left*/

   goto main

knock_player_back
   temp5=(player0x-18)/4
   temp6=(player0y-1)/8
   pfpixel temp5 temp6 off
   player0x = player0x - p0_x
   player0y = player0y - p0_y
   return


eog
   drawscreen
   goto eog