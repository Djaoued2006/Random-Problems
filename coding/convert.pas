unit convert;

interface 

    uses sysUtils, checks;

    function min(a , b : integer) : integer;

    function add(a , b : integer) : integer;
    function sub(a , b : integer): integer;
    function multiply(a , b : integer) : integer;
    function divide(a, b: integer) : real;

    function add(a , b : string) : string;
    function sub(a , b : string): string;
    function multiply(a , b : string) : string;
    function divide(a, b: string ; precision : integer) : string;

    function power(base , expo : integer) : longint;
    function int(s : string) : integer;
    function str(number : integer) : string;   

    function int(number : real) : integer;
    function frac(number : real; precision : integer) : Integer;
    function str(number : real ; precision : integer) : string;
    function float(s : string) : real;

    function makeBasicCalculation(op1 , op2 : string ; operation : char): string;

implementation

function min(a , b : integer) : integer;

    begin
        if (a > b) then min := b
        else 
            min := a; 
    end;

function power(base , expo : integer) : longint;

    var i : integer;

    begin
        power := 1;
        for i := 1 to expo do 
            power := power * base; 
    end;

function int(s : string) : integer;

    var result : integer;
        i , slen : integer;
        negative : boolean;

    begin
        result := 0;
        slen := length(s);

        negative := (s[1] = '-');

        if (negative) then i := 2 
        else 
            i := 1;
        
        while (i <= slen) do 
            begin 
                result := result * 10 + ord(s[i]) - ord('0');
                inc(i);
            end;
        
        if (negative) then 
            result := result * (-1);
        
        int := result;
    end;

function str(number : integer) : string;   
    
    var result : string;

    begin
        result := '';
        if (number = 0) then result := '0'
        else 
            while (number <> 0) do 
                begin
                    result := chr(number mod 10 + ord('0')) + result;
                    number := number div 10; 
                end;  
            
        str := result;
    end;

function int(number : real) : integer;

    begin
        int := Trunc(number); 
    end;

function frac(number : real; precision : integer) : Integer;

    begin
        frac := int((number - int(number)) * power(10 , min(precision,  3)));
    end;

function str(number : real ; precision : integer) : string;

    begin
        str := str(int(number)) + '.' + str(frac(number , precision));
    end;

function float(s : string) : real;

    begin
        float := int(copy(s, 1, pos('.' , s) - 1)) + int(Copy(s , pos('.' , s) + 1, 3)) / power(10 , 3) ;
    end;

function add(a , b : integer) : integer;

    begin
        add := a + b; 
    end;

function sub(a , b : integer): integer;

    begin
        sub := a - b; 
    end;

function multiply(a , b : integer) : integer;

    begin
        multiply := a * b; 
    end;

function divide(a, b: integer) : real;

    begin
        divide := a / b; 
    end;

function add(a , b : string) : string;

    begin
        add := str(int(a) + int(b)); 
    end;

function sub(a , b : string): string;

    begin
        sub := str(int(a) - int(b)); 
    end;

function multiply(a , b : string) : string;

    begin
        multiply := str(int(a) * int(b)); 
    end;

function divide(a, b: string; precision : integer) : string;

    begin
        if (int(b) = 0) then 
            divide := 'Nan'
        else 
            divide := removeEndingZeros(str(int(a) / int(b) , precision)); 
    end;


//this will serve as a multiplexer!
function makeBasicCalculation(op1 , op2 : string ; operation : char): string;

    begin
        case operation of  
            '+' : makeBasicCalculation := add(op1, op2);
            '-' : makeBasicCalculation := sub(op1 , op2);
            '*' : makeBasicCalculation := multiply(op1, op2);
            '/' : makeBasicCalculation := divide(op1, op2 , 3);
        end; 
    end;

begin 
end.



