   const pfscore = 1
   
   set kernel_options pfcolors
   
   set smartbranching on

   data _winner
   $EE,$AE,$5A ;cycle colors on jungle gem
end
   data _grad
   $D2,$D4,$D6,$E6,$E4,$F0,$20,$32,$C4 ;all 8 levels of color
end
   data _speedmod
   60,45,33,30,28,27,25,20,0 ;all 8 levels block spawn modifiers
end
   data _pfspeed
   4,4,4,4,2,2,2,2,0 ;all 8 levels block spawn modifiers
end
   data _pfscoremod
   32,30,25,20,15,10,20,10,0 ;scaling length of each level
end
   data _pfjumph
   40,40,40,40,30,30,30,30,30  ;jump height of player per level. (glitch if change occurs mid jump probably? maybe give life to account for that)
end

   dim duration=a
   dim _collideTimer = t
   dim _batTimer = w
   dim _difficulty = v
   dim _diffScaleTime = i
   dim _diffScale = j
   dim _song = o

   dim _fire_restrain = k
   dim _duck_restrain = n

__Full_Restart
   if switchreset goto __Full_Restart ; Restrain reset switch
   
   COLUBK = 00 ; 00 = black color for title screen

   _batTimer=0
   _difficulty=0
   _diffScale=0
   _diffScaleTime=0
   _song=1
   score=0

   pfscore1 = %10101010
   pfscore2 = %00000000

   _collideTimer=0

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
   ................................
end


title ;title screen loop
   z=1

   player0x=34
   player0y=58

   player1x=18
   player1y=72

   goto IntroMusic
titleloop
   if z=3 then goto GetMusic
GotMusic
   COLUP0 = 28
   COLUP1 = $C0
   NUSIZ1=$6
   
   ;force playfield colors every frame, idk why but pfscore affects them??
   pfcolors:
   $38
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
   drawscreen
   if joy0fire || switchreset then z=3 ; start the game!
   goto titleloop

__Start_Restart
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

   missile0x = 255
   ;YELLOW PLAYER/MISSILE
   COLUPF = $C6

   player0x = 28
   player0y = 63
   player1x = 27
   player1y = 32

   _fire_restrain=0
   _duck_restrain=0
   
   a=0
   b=0
   c=0
   d=0
   e=0
   f=50

   dim _Ch0_Duration = h
   dim _Ch1_Duration = g

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
   COLUBK = _grad[_difficulty]
   pfscore2 = %00000000

   if _Ch0_Duration = 0 then AUDC0 = 8 : AUDV0 = 0 : AUDF0 = 19
   if _Ch1_Duration = 0 then AUDC1 = 8 : AUDV1 = 0 : AUDF1 = 19
   _Ch0_Duration = _Ch0_Duration-1
   _Ch1_Duration = _Ch1_Duration-1
   
   if switchreset then goto __Full_Restart
   pfpixel 0 7 off
   pfpixel 0 5 off
   b=b+1
   d=d+1
   
   if d>=25 then d=0
   if b>=f then b=0 : gosub make_obs

   if _pfspeed[_difficulty] = 4 then c=b//4 else c=b//2
   c=temp1
   temp5=_pfspeed[_difficulty]-2
   if c=temp5 then pfscroll left : player1x=player1x-1

   if player1x<=0 then player1x=160

   _batTimer=_batTimer-1
   if _difficulty=8 then b=0 : _batTimer=1
   if _batTimer = 0 then gosub make_bat

   COLUPF = $0E
   COLUP0 = 28
   COLUP1 = $C0
   NUSIZ1=$4

   if _diffScaleTime>100 then _diffScaleTime=0 : _diffScale = _diffScale + 1 : _difficulty = _diffScale/8 : gosub checkGem
   if _difficulty=8 then if collision(player0,player1) then _song=2 : score=score+50 : goto winner
   if _difficulty=8 then COLUP1 = $AE : NUSIZ1 = $0 : player1x=player1x-1

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


   if !joy0fire then _fire_restrain=0
   if _fire_restrain=0 then if missile0x>70 && joy0fire then missile0x = player0x + 10 : missile0y=53 : _Ch1_Duration = 2 : AUDV1 = 5 : _fire_restrain=1
   
   ;Missile logic, move forward until 100, if it hits pixels, reset.
   if missile0x<100 then missile0x=missile0x+1 : tempx = (missile0x/4)-4 : tempy = (missile0y/8) else missile0y=0 : tempx = 0 : tempy =0
   if missile0x<100 then if pfread(tempx,tempy) then pfpixel tempx tempy off : missile0x=101 : missile0y=0 : tempx = 0 : tempy = 0 else tempx=tempx-1
   if missile0x<100 then if pfread(tempx,tempy) then pfpixel tempx tempy off : missile0x=101 : missile0y=0 : tempx = 0 : tempy = 0

   if joy0up && a=0 then a=_pfjumph[_difficulty] : AUDC0 = 4 : AUDV0 = 5 : _Ch0_Duration = 5 ; Set voice to 4, Volume to 5, and Duration to 5
   if joy0up && a>100 then a=_pfjumph[_difficulty] : AUDC0 = 4 : AUDV0 = 5 : _Ch0_Duration = 5 ; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   if a > _pfjumph[_difficulty]/2 && a < 100 then player0y = player0y-1 : a = a-1 : AUDF0 = a-_pfjumph[_difficulty] ;slide the jump audio using the jump timer
   if a > 0 && a <= _pfjumph[_difficulty]/2 then player0y = player0y+1 : a = a-1


   if !joy0down && _duck_restrain=1 then _duck_restrain=0
   if _duck_restrain>1 then _duck_restrain=_duck_restrain-1
   if joy0down && a=0 && _duck_restrain=0 then a=101 : _duck_restrain= 21-_difficulty
   if a>100 && _duck_restrain=1 then a=0


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
   if collision(player0,playfield) then AUDC1 = 1 : AUDV1 = 5 : _collideTimer = 55 : pfscore1 = pfscore1/4 : goto collide ; show where you got hit
   goto main

; if player collides, -1 life and then go restart round.
collide
   if _collideTimer = 35 then AUDV1=0 ; kind of a silly way to put the colide sound on a timer
   _collideTimer=_collideTimer-1
   drawscreen
   if _collideTimer>0 then goto collide
   if pfscore1 = %00000000 then goto eog
   goto __Start_Restart

make_bat
   _batTimer=rand & 63
   _batTimer=_batTimer + _speedmod[_difficulty]
   score=score+5
   _diffScaleTime=_diffScaleTime+10
   pfpixel 31 6 on
   return

make_obs
   f=rand & 31
   f=f + _speedmod[_difficulty] ;apply difficulty
   score=score+10
   _diffScaleTime=_diffScaleTime+_pfscoremod[_difficulty]
   e=rand & 15
   if e<10 then pfpixel 31 5 on else pfpixel 31 7 on
   return

eog
   AUDV0 = 0 ; silence both audio channels
   AUDV1 = 0
   if switchreset then goto __Full_Restart
   drawscreen
   goto eog


winner
   duration=1
   goto WinnerMusic
winnerLoop
   goto GetMusic
GotMusic2
   b=b+1
   if b>13 then b=0
   if b=0 then c=c+1
   if c=4 then c=0
   COLUP1 = _winner[c]
   if switchreset then goto __Full_Restart
   drawscreen
   goto winnerLoop

conScreen
   b=b+1
   if b>13 then b=0
   if b=0 then c=c+1
   if c=4 then c=0
   COLUP1 = _winner[c]
   if switchreset then goto __Full_Restart
   _difficulty=0
   _diffScale=0
   _diffScaleTime=0
   if joy0fire then goto __Start_Restart
   drawscreen
   goto conScreen

checkGem
   if _diffScale=32 then goto __Start_Restart
   if _difficulty=8 then player1x=150 : player1y=54
   if _difficulty=8 then pfhline 0 5 31 off : pfhline 0 6 31 off : pfhline 0 7 31 off
   if _difficulty=8 then player1:
   %00011000
   %00111100
   %01011110
   %10111111
   %11111101
   %11111101
   %11111101
   %01111010
   %00110100
   %00011000
end
   return

GetMusic
   duration = duration - 1
   
   if duration>0 then if _song=1 then goto GotMusic
   if duration>0 then if _song=2 then goto GotMusic2

   temp4 = sread(musicData)
   temp5 = sread(musicData)
   temp6 = sread(musicData)

   ;if temp4=255 then duration = 1 : goto MusicSetup

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
   if duration = 51 then goto conScreen ;continue screen
   if _song=1 then goto GotMusic
   if _song=2 then goto GotMusic2

;THE JINGLE DATA ITS PERFECT
IntroMusic
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

;THE JINGLE DATA ITS PERFECT
WinnerMusic
   sdata musicData2=x
  4,5,19
  0,0,0
  15
  0,0,0
  0,0,0
  3
  4,5,19
  0,0,0
  7
  0,0,0
  0,0,0
  3
  4,5,17
  0,0,0
  20
  0,0,0
  0,0,0
  3
  4,5,19
  0,0,0
  20
  0,0,0
  0,0,0
  3
  4,5,15
  0,0,0
  22
  0,0,0
  0,0,0
  3
  4,5,14
  0,0,0
  22
  0,0,0
  0,0,0
  40
  0,0,0
  0,0,0
  51
  255,255,255
  255,255,255
  1
end
   goto GotMusic2
