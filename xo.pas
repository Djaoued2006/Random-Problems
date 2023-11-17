// XO game

//what do i need : 
//i need a counter that counts the number of places filled so i can apply the winner function after filling all the places (i.e counter = 9)
//Function that checks who's the winner
//Procedure that display the matrix 
//Procedure that  fill the matrix with an X or O in some specific place
//the clear screen function (use the crt package)

program XO;

uses crt;

type 
    matrix = array[1..3 , 1..3] of char;

var XOmatrix : matrix;   
    i , k , j : integer;
    countX , countO : integer;


//checking the lines and searching for triple X
function checkXLines() : boolean;

    var xWins : boolean;
        i : integer;

    begin
        k := 1;
        xWins := False;

        while (k < 4) and (not xWins) do 
            begin
                xWins := True;
                for i := 1 to 3 do 
                    if (XOmatrix[k , i] <> 'X') then 
                        begin
                            xWins := False; 
                            break; 
                        end;
                k := k + 1;
            end;

        checkXLines := xWins;
    end;

//same for columns and diagonals in the next function
function checkXcols() : boolean;

    var Xwins : boolean;
        i : integer;

    begin
        k := 1 ; xWins := False;

        while (k < 4) and (not xWins) do 
            begin
                xWins := True;
                for i := 1 to 3 do 
                    begin
                        if (XOmatrix[i ,k] <> 'X') then 
                            begin
                                xWins := False;
                                break; 
                            end; 
                    end; 
                k := k + 1;
            end; 
        
        checkXcols := xWins;
    end;

function checkXDiag() : boolean;

    var xWins : boolean;
        i : integer;

    begin
        xWins := True;

        for i := 1 to 3 do  
            begin
                if (XOmatrix[i , i] <> 'X') then 
                    begin
                        xWins := False;
                        break;
                    end; 
            end; 
        
        if not xWins then 
            begin
                xWins := True;
                for i := 1 to 3 do 
                    begin
                        if (XOmatrix[i , (4 - i)] <> 'X') then 
                            begin
                                xWins := False; 
                                break; 
                            end;
                    end;
            end;
        
        checkXDiag := xWins;
    end;


function checkXwins() : boolean;

    begin
        checkXwins := checkXcols or checkXDiag or checkXLines; 
    end;


function checkOLines() : boolean;

    var OWins : boolean;
        i : integer;

    begin
        k := 1;
        OWins := False;

        while (k < 4) and (not OWins) do 
            begin
                OWins := True;
                for i := 1 to 3 do 
                    if (XOmatrix[k , i] <> 'O') then 
                        begin
                            OWins := False; 
                            break; 
                        end;
                k := k + 1;
            end;

        checkOLines := OWins;
    end;

function checkOcols() : boolean;

    var Owins : boolean;
        i : integer;

    begin
        k := 1 ; OWins := False;

        while (k < 4) and (not OWins) do 
            begin
                OWins := True;
                for i := 1 to 3 do 
                    begin
                        if (XOmatrix[i ,k] <> 'O') then 
                            begin
                                OWins := False;
                                break; 
                            end; 
                    end; 
                k := k + 1;
            end; 
        
        checkOcols := OWins;
    end;

function checkODiag() : boolean;

    var OWins : boolean;
        i : integer;

    begin
        OWins := True;

        for i := 1 to 3 do  
            begin
                if (XOmatrix[i , i] <> 'O') then 
                    begin
                        OWins := False;
                        break;
                    end; 
            end; 
        
        if not OWins then 
            begin
                OWins := True;
                for i := 1 to 3 do 
                    begin
                        if (XOmatrix[i , (4 - i)] <> 'O') then 
                            begin
                                OWins := False; 
                                break; 
                            end;
                    end;
            end;
        
        checkODiag := OWins;
    end;

function checkOwins() : boolean;

    begin
        checkOwins := checkOcols() or checkODiag() or checkOLines(); 
    end;


procedure displayXO();

    var i , j : integer;

    begin
        writeln('                                             ---------------');
        for i := 1 to 3 do 
            begin
                write('                                             ');
                for j := 1 to 3 do 
                    write('| ' , XOmatrix[i , j] , ' |'); 
                writeln;
            end;
        writeln('                                             ---------------');
    end;

procedure fillMatrix(player : integer);

    var x , y : integer;
        filled : boolean;
        check : boolean;

    begin
        repeat 
            repeat
                writeln('Enter the coordinates : ');
                write('row : ');readln(x);
                write('column : ');readln(y);

                check := (x > 0) and (x < 4) and (y > 0) and (y < 4);

                if not check then 
                    begin
                        writeln('Invalid input! ');
                        writeln();
                    end;

            until(check);

            filled := XOmatrix[x , y] <> ' ' ;

            if filled then 
                writeln('The place does already contain "' , XOmatrix[x , y] , '" please make sure to fill an empty space!');
                writeln;
        until(not filled);

        if (player mod 2 = 1) then 
            XOmatrix[x , y] := 'X'
        else 
            XOmatrix[x , y] := 'O';
    end;

begin

    for i := 1 to 3 do 
        for j := 1 to 3 do
            XOmatrix[i , j] := ' ';
    
    i := 1;
    countX := 0;
    countO := 0;
    
    clrscr;

    while (i < 10) do 
        begin
            fillMatrix(i);
            clrscr;
            displayXO();
            countX := countX + 1;

            if (countX > 2) then
                if checkXwins() then 
                    begin
                      writeln('The player "X" won the game');
                      writeln;
                      break;
                    end;

            i := i + 1;

            fillMatrix(i);
            clrscr;
            displayXO();
            countO := countO + 1;

            if (countO > 2) then 
                if checkOwins() then
                    begin 
                        writeln('The player "O" won the game!');
                        writeln;
                        break;
                    end;

            
            if (i = 8) then 
                begin
                    writeln('No one has won the game!!');
                    break;
                end;
            
            i := i + 1;
             
        end;
end.
    
