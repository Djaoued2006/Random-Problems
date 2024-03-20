unit convert;

interface 

    uses sysUtils, checks;

    const NAN = 'Nan';

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

function isFloat(s :string): boolean;

    begin
        isFloat := (pos('.' , s) <> 0); 
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
        isNegative : boolean;

    begin
        result := '';
        isNegative := (number < 0);

        if (number = 0) then result := '0'
        else
            begin 
                if (isNegative) then number := number * (-1);
                while (number <> 0) do 
                    begin
                        result := chr(number mod 10 + ord('0')) + result;
                        number := number div 10; 
                    end;  
            end;
        
        if (isNegative) then result := '_' + result;
            
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

    var isNegative : boolean;

    begin
        isNegative := FALSE;

        if (number < 0) then 
            begin
                number := number * (-1);
                isNegative := TRUE; 
            end;
            
        str := removeEndingZeros(str(int(number)) + '.' + str(frac(number , precision)));

        if (isNegative) then 
            str := '_' + str;
    end;

function float(s : string) : real;

    begin
        if (isFloat(s)) then 
            float := int(copy(s, 1, pos('.' , s) - 1)) + int(Copy(s , pos('.' , s) + 1, 3)) / power(10 , 3)
        else 
            float := int(s);
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
        add := str(float(a) + float(b) , 3); 
    end;

function sub(a , b : string): string;

    begin
        sub := str(float(a) - float(b) , 3); 
    end;

function multiply(a , b : string) : string;

    begin
        multiply := str(float(a) * float(b) , 3); 
    end;

function divide(a, b: string; precision : integer) : string;

    begin
        if (float(b) = 0) then 
            divide := NAN
        else 
            divide := removeEndingZeros(str(float(a) / float(b) , precision)); 
    end;


//this will serve as a multiplexer!
function makeBasicCalculation(op1 , op2 : string ; operation : char): string;

    begin
        if ((op1 = NAN) or (op2 = NAN)) then 
            makeBasicCalculation := NAN
        else
            case operation of  
                '+' : makeBasicCalculation := add(op1, op2);
                '-' : makeBasicCalculation := sub(op1 , op2);
                '*' : makeBasicCalculation := multiply(op1, op2);
                '/' : makeBasicCalculation := divide(op1, op2 , 3);
            end; 
    end;

begin 
end.



