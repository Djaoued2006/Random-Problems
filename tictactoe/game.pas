unit game;


interface 

    uses CRT;


    type matrix = array[1..3 , 1..3] of char;

        couple = record 
            x : char;  
            value : integer;
        end;

        couples = array[1..3] of couple;

        position = record 
            row , col : integer;
        end;
    
    const size = 30;
          scores : couples = ((x : 'X' ; value : 1),
                             (x : 'O' ; value : -1),
                             (x : ' ' ; value : 0));
          MIN_VALUE = -32765;
          MAX_VALUE = 32765; 

    procedure run();


implementation

function readInteger(s:  string) : integer;

    var result : integer;

    begin
        write(s);
        readln(result);
        readInteger := result; 
    end;


function initGrid() : matrix;

    var result : matrix;
        i , j : integer;
        
    begin
        for i := 1 to 3 do 
            for j := 1 to 3 do 
                result[i , j] := ' ';

        initGrid := result; 
    end;

procedure printTab(size : integer);

    var i : integer;

    begin
        for i := 1 to size do 
            write(' '); 
    end;

procedure printGrid(grid : matrix);

    var i , j : integer;

    begin
        

        for i := 1 to 3 do 
            begin 
                printTab(size + 1);
                for j := 1 to 3 do 
                    if (j <> 3) then 
                        write(grid[i , j] , '  ||  ')
                    else 
                        writeln(grid[i , j]);
            end;
    end;

function getX() : char;

    begin
        getX := 'X'; 
    end;

function getO() : char;

    begin
        getO := '0'; 
    end;

function checkHorizontally(grid : matrix ; playerChar : char) : boolean;

    var i , j : integer;

    begin
        i := 1;

        while (i <= 3) do 
            begin 
                j := 1;
                while (j <= 4) do 
                    if (grid[i , j] <> playerChar) then 
                        break
                    else 
                        inc(j);
                
                if (j = 4) then 
                    break;

                inc(i);
            end;
        
        checkHorizontally := (j = 4);
    end;


function checkVertically(grid : matrix ; playerChar : char) : boolean;

    var i , j : integer;

    begin
        i := 1;

        while (i <= 3) do 
            begin
                j := 1;

                while (j <= 3) do  
                    if (grid[j , i] <> playerChar) then 
                        break
                    else 
                        inc(j);
                
                if (j = 4) then 
                    break;
                
                inc(i);
            end;
        
        checkVertically := (j = 4);
    end;

function checkDiagonal1(grid : matrix ; playerChar : char) : boolean;

    var i : integer;

    begin
        i := 1;

        while (i <= 3) do 
            if (grid[i , i] <> playerChar) then 
                break
            else 
                inc(i);
         
         checkDiagonal1 := (i = 4);
    end;

function checkDiagonal2(grid : matrix ; playerChar : char) : boolean;

    var i : integer;

    begin
        i := 1;

        while (i <= 3) do 
            if (grid[i , 4 - i] <> playerChar) then 
                break
            else 
                inc(i);

        checkDiagonal2 := (i = 4); 
    end;

function checkDiagonal(grid : matrix ; playerChar : char) : boolean;    

    begin
        checkDiagonal := (checkDiagonal1(grid , playerChar) or checkDiagonal2(grid , playerChar));  
    end;

//this will return TRUE if the cell is free , FALSE else!
function checkCell(grid : matrix ; pos : position) : boolean;

    begin
        checkCell := (grid[pos.row , pos.col] = ' '); 
    end;

function getInput() : position;

    var result : position;

    begin
        result.row := readInteger('type the row : ');
        result.col := readInteger('type the column : ');
        getInput := result;
    end;

procedure setInput(var grid : matrix ; pos : position ; playerChar : char);

    begin
        if (checkCell(grid , pos)) then 
            grid[pos.row , pos.col] := playerChar
        else 
            writeln('bla bla');
    end;

function checkWinner(grid : matrix ; playerChar : char) : boolean;

    begin
        checkWinner := (checkHorizontally(grid , playerChar) or checkVertically(grid, playerChar) or checkDiagonal(grid , playerChar)); 
    end;

function getWinner(grid : matrix) : char;

    var playerChar : char;

    begin 
        playerChar := getX();
        getWinner := ' ';

        if (checkWinner(grid , playerChar)) then 
            getWinner := playerChar
        else 
            begin 
                playerChar := getO();
                if (checkWinner(grid , playerChar)) then 
                    getWinner := playerChar;
            end;
    end;

function checkAvailable(grid : matrix ; pos : position) : boolean;

    begin
        checkAvailable := (grid[pos.row , pos.col] = ' '); 
    end;


function availbleMoves(grid : matrix) : boolean;

    var i , j : integer;
        pos : position;

    begin
        availbleMoves := FALSE;

        i := 1;
        
        while ((i <= 3) and (not availbleMoves)) do 
            begin
                j := 1;
                pos.row := i;
                while ((j <= 3) and (not availbleMoves)) do 
                    begin   
                        pos.col := j;
                        availbleMoves := checkAvailable(grid , pos);
                        j := j + 1;
                    end;
                i := i + 1;            
            end;
    end;

function checkTie(grid : matrix) : boolean; 

    begin
        checkTie := ((getWinner(grid) = ' ') and (not availbleMoves(grid))) 
    end;

function endGame(grid : matrix) : boolean;

    begin
        endGame := ((getWinner(grid) <> ' ') or (not availbleMoves(grid))); 
    end;


function findIndex(winner : char) : integer;

    var i : integer;

    begin
        for i := 1 to 3 do 
            if (scores[i].x = winner) then 
                break;
            
        findIndex := i;
    end;

function max(a , b : integer) : integer;

    begin
        if (a > b) then max := a
        else 
            max := b;
    end;

function min(a , b : integer) : integer;

    begin
        if (a > b) then min := b 
        else 
            min := a; 
    end;


//minimax algorithm isn't working!
function minimax(var grid : matrix ; depth : integer ; isMaximizing : boolean) : integer;

    var winner : char;
        i , j , score,  bestScore : integer;
        pos : position;

    begin
        if ((endGame(grid)) or (depth = 0)) then 
            begin
                winner := getWinner(grid);
                bestScore := scores[findIndex(winner)].value;
            end
        else 
            if (isMaximizing) then 
                begin 
                    bestScore := MIN_VALUE; // -2 will do the job also!! 
                    for i := 1 to 3 do 
                        begin 
                            pos.row := i;
                            for j := 1 to 3 do 
                                begin 
                                    pos.col := j;
                                    if (checkAvailable(grid , pos)) then 
                                        begin
                                            grid[i , j] := getX();
                                            score := minimax(grid, depth - 1 , FALSE);
                                            writeln(i , ' , ' , j , ' -> score : ' , score);
                                            bestScore := max(score , bestScore);
                                            grid[i , j] := ' ';
                                        end
                                end;
                        end;
                end
            else 
                begin   
                    bestScore := MAX_VALUE;
                    for i := 1 to 3 do 
                            begin 
                                pos.row := i;
                                for j := 1 to 3 do 
                                    begin 
                                        pos.col := j;
                                        if (checkAvailable(grid , pos)) then 
                                            begin
                                                grid[i , j] := getO();
                                                score := minimax(grid, depth - 1,  TRUE);
                                                writeln(i , ' , ' , j , ' -> score : ' , score);
                                                bestScore := min(score , bestScore);
                                                grid[i , j] := ' ';
                                            end
                                    end;
                            end;
                    end;

        minimax := bestScore;
    end;
    
function findBestMove(grid : matrix) : position;

    var i , j , score , bestScore: integer;
        bestMove : position;

    begin
        bestScore := MAX_VALUE;

        for i := 1 to 3 do 
            for j := 1 to 3 do 
                if (grid[i , j] = ' ') then 
                    begin
                        grid[i , j] := getO();
                        score := minimax(grid , 10 ,  FALSE); 

                        if (score < bestScore) then 
                            begin 
                                bestMove.row := i;
                                bestMove.col := j;
                                bestScore := score;
                            end;
                        
                        grid[i , j] := ' ';
                    end;

        findBestMove := bestMove;
    end;


procedure run();

    var grid : matrix; 
        move : position;
        round : boolean;
        winner : char;
    
    begin
        grid := initGrid();

        round := TRUE;

        repeat
            printGrid(grid);
            
            if (round) then 
                begin
                    repeat
                        move := getInput();

                        writeln;

                        if (not checkAvailable(grid , move)) then 
                            writeln('wrong input!');
                        
                        writeln;
                    until(checkAvailable(grid , move));
                    setInput(grid , move , getX()); 
                end 
            else 
                begin
                    writeln('the score is : ' , minimax(grid , 10 , FALSE));
                    move := findBestMove(grid);
                    setInput(grid , move , getO()); 
                end;

            // clrscr;

            winner := getWinner(grid);

            if (winner = getX()) then writeln('the X player has won the game!')
            else 
                if (winner = getO()) then 
                    writeln('the O player has won the game!');
            
            if ((not availbleMoves(grid)) and (winner = ' ')) then 
                writeln('it''s a tie!');
            
            round := not round;

        until (endGame(grid));
    end;






begin 
end.



