1 REM ZX Maze by Vincent Audergon
2 REM This software is open source. You can redistribute it and / or modify it
10 BORDER 7 : PAPER 7 : INK 0 : CLS

20 PRINT AT 5,2; "ZX Maze by Vincent Audergon" 
21 PRINT AT 7,9; PAPER 7; INK 0; "W - Up"
22 PRINT AT 8,9; PAPER 7; INK 0; "S - Down"
23 PRINT AT 9,9; PAPER 7; INK 0; "A - Left"
24 PRINT AT 10,9; PAPER 7; INK 0; "D - Right"
25 PRINT AT 15,3; PAPER 7; INK 0; "Press any key to start"

30 LET WSCREEN = 256
31 LET HSCREEN = 192
32 LET WIDTH = 8

40 LET j$ = INKEY$
41 IF j$ = "" THEN GOTO 40: END IF

49 REM DRAW BORDER, START AND END
50 BORDER 0 : CLS : INK 2
51 REM PRINT AT 0,0; CHR$(143)
52 REM PRINT AT HSCREEN,WSCREEN; CHR$(143) : INK 0
54 REM FOR lin = 0 TO HSCREEN + 1
55 REM PRINT AT lin,WSCREEN+1; CHR$(143)
56 REM NEXT lin
57 REM FOR col = 0 TO WSCREEN + 1
58 REM PRINT AT HSCREEN+1,col; CHR$(143)
59 REM NEXT col

68 REM RANDOM PATH IN THE WALL
69 divide(0,0,WSCREEN/WIDTH,HSCREEN/WIDTH)
70 REM vWall(5,0,HSCREEN/WIDTH, 10)


REM Returns a numbre between min and max (max must be < 100 and min must be >= 0)
FUNCTION randBet(min AS BYTE, max AS BYTE)
    max = max+1 : min = min -1
    RETURN INT (RND * (max-min)) + min
END FUNCTION

REM Draw a vertical wall with a door (if you don't want any door, door must = 0)
REM Params: x => The x coord ON THE GRID, starty => The first y coord ON THE GRID
REM endy => The end y coord ON THE GRID, door => The door position relative to the first y position
FUNCTION vWall(x AS UBYTE,starty AS UBYTE, endy AS UBYTE, door AS UBYTE)
    x = x * WIDTH : starty = starty * WIDTH : endy = endy * WIDTH : door = door * WIDTH
    PLOT x, starty : DRAW 0,door-starty
    PLOT x, starty+door+WIDTH : DRAW 0, endy-1-(starty+door+WIDTH)
END FUNCTION

REM Draw an horizontal wall with a door (if you don't want any door, door must = 0)
FUNCTION hWall(y AS UBYTE,startx AS UBYTE, endx AS UBYTE, door AS UBYTE)
    y = y * WIDTH : startx = startx * WIDTH : endx = endx * WIDTH : door = door * WIDTH
    PLOT startx, y : DRAW door-startx,0
    PLOT startx + door + WIDTH,y : DRAW endx-1-(startx+door+WIDTH),0
END FUNCTION

FUNCTION divide(x AS UBYTE, y as UBYTE, w as UBYTE, h as UBYTE)
    IF w < 2 or h < 2 THEN
    ELSE
        LET d = randBet(0,1)
        IF d = 1 THEN
            LET row = randBet(y, y+h) 
            LET door = randBet(x, x+w)
            hWall(row, x, x + w, door)
            divide(x,y, w, row) : REM Upper grid
            divide(x,y+row, w, h-row) : REM Lower grid
        ELSE
            LET col = randBet(x, x+w)
            LET door = randBet(y, y+h)
            vWall(col, y, y + h, door)
            divide(x,y, col, h) : REM Left grid
            divide(x+col, y, w-col, h):REM Right grid
        END IF
    END IF
END FUNCTION

150 GOTO 40

