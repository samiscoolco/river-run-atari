   set kernel_options pfcolors

   
   set smartbranching on

   q=3
   dim duration=a
   dim rand16=z
   dim _lives=q
   _lives = 3

   AUDV0=0
   AUDV1=0

   duration = 5


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

   pfcolors:
   $FC
   $FA
   $F8
   $F6
   $F4
   $FC
   $FA
   $F8
   $F6
   $8E
end




title
   z=1

   player0x=34
   player0y=58

   player1x=18
   player1y=72

   score = 0

   player0:
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

   playfield:
   XXX.X.X.X.XXX.XXX...............
   X.X.X.X.X.X...X.X...............
   XX..X.X.X.XX..XX................
   X.X.X..X..XXX.X.X...............
   ................................
   ...................XXX.X.X.X..X.
   ...................X.X.X.X.XX.X.
   ...................XX..X.X.X.XX.
   .......X...........X.X.XXX.X..X.
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end

   goto MusicSetup

titleloop
   if z=3 then goto GetMusic
GotMusic
   COLUP0 = 28
   COLUP1 = $C0
   NUSIZ1=$6
   drawscreen
   if joy0fire || switchreset then z=3
   goto titleloop

__Start_Restart
   missile0x = 255

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

   


   dim _Ch0_Sound = g
   dim _Ch0_Duration = h
   dim _C0 = i
   dim _V0 = j
   dim _F0 = k

   l=0
   m=0
   dim tempx=l
   dim tempy=m

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
   $00
   $F8
   $28
   $9A
end
   if z=1 then goto title  
main
   if _Ch0_Duration = 0 then AUDC0 = 8 : AUDV0 = 0 : AUDF0 = 19
   _Ch0_Duration = _Ch0_Duration-1
   
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
   
   if missile0x>70 && joy0fire then missile0x = player0x + 10 : missile0y=53 : _Ch0_Sound = 1 : _Ch0_Duration = 2 : AUDV0 = 4


   if missile0x<100 then missile0x=missile0x+1 : tempx = (missile0x/4)-4 : tempy = (missile0y/8) : pfpixel tempx tempy off : tempx=tempx-1 : pfpixel tempx tempy off else missile0y=0 : tempx = 0 : tempy = 0



   if joy0up && a=0 then a=34 : AUDC0 = 4 : AUDV0 = 5 : _Ch0_Duration = 5
   if joy0up && a>100 then a=34 : AUDC0 = 4 : AUDV0 = 5 : _Ch0_Duration = 5
   if a > 17 && a < 100 then player0y = player0y-1 : a = a-1 : AUDF0 = a-34 /* slide the jump audio using the jump timer :) -sam*/
   if a > 0 && a <= 17 then player0y = player0y+1 : a = a-1

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
   if collision(player0,playfield) then goto collide
   goto main

collide
   _lives = _lives-1
   if _lives = 0 then goto eog
   if _lives >0 then goto __Start_Restart
   return



make_obs
   f=rand & 63
   f=f+17 ;17 seems to be the hardest possible difficult level, so start at 50 and tick down to 11
   score=score+10
   e=rand & 15
   if e<5 then pfpixel 31 6 on : return
   if e<10 then pfpixel 31 5 on : return
   pfpixel 31 7 on
   return

eog
   AUDV0 = 0
   if switchreset then goto title
   drawscreen
   goto eog

GetMusic
   duration = duration - 1
   if duration>0 then GotMusic

   temp4 = sread(musicData)
   temp5 = sread(musicData)
   temp6 = sread(musicData)

   if temp4=255 then duration = 1 : goto MusicSetup

   AUDV0 = temp4
   AUDC0 = temp5
   AUDF0 = temp6

   temp4 = sread(musicData)
   temp5 = sread(musicData)
   temp6 = sread(musicData)

   AUDV1 = temp4
   AUDC1 = temp5
   AUDF1 = temp6

   duration = sread(musicData)
   if duration = 50 then goto __Start_Restart
   goto GotMusic


MusicSetup
   sdata musicData=x
  4,5,29
  1,12,19
  12
  0,0,0
  0,0,0
  3
  4,5,29
  1,12,19
  12
  0,0,0
  0,0,0
  3
  4,5,23
  1,12,15
  12
  0,0,0
  0,0,0
  3
  4,5,23
  1,12,15
  12
  0,0,0
  0,0,0
  3
  4,5,29
  1,12,19
  12
  0,0,0
  0,0,0
  3
  4,5,29
  1,12,19
  12
  0,0,0
  0,0,0
  3
  4,5,23
  1,12,15
  18
  0,0,0
  0,0,0
  10
  4,5,29
  0,0,0
  12
  0,0,0
  0,0,0
  3
  4,5,23
  1,12,15
  12
  0,0,0
  0,0,0
  3
  4,5,31
  1,12,20
  12
  0,0,0
  0,0,0
  3
  4,5,26
  1,12,17
  12
  0,0,0
  0,0,0
  3
  4,5,29
  2,12,4
  26
  0,0,0
  0,0,0
  50
  255,255,255
  255,255,255
  1
end
   goto GotMusic
