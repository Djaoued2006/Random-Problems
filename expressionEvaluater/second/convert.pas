unit convert;

interface

    uses sysUtils, mathematics;

    function toNumber(s: string): real;
    function toString(n: integer): string;
    function toString(n: real): string;
    function toInteger(s: string): integer;
    procedure removeEndingZeros(var s: string);
    function removeSpaces(s: string): string;

implementation

function toInteger(s: string): integer;

    var result: integer;
        i , start , end_ , slen : integer;
        negativeString : boolean;
    
    begin
        slen := length(s);

        negativeString := isNegative(s);

        if negativeString then
            begin 
                start := 3;
                end_ := slen - 1;
            end
        else 
            begin
                start := 1;
                end_ := slen; 
            end;

        result := 0;
        i := start;

        while (i <= end_) do 
            begin
                result := result * 10 + ord(s[i]) - ord('0');
                inc(i);
            end;
        
        if (negativeString) then result := result * (-1);

        toInteger := result;
    end;

function toString(n: integer): string;

    var isNegative: boolean;
        result: string;
    
    begin
        if (n = 0) then result := '0'
        else
            begin 
                isNegative := (n < 0); 
                if (isNegative) then  n := n * (-1);

                result := '';

                while (n <> 0) do 
                    begin
                        result := chr(n mod 10 + ord('0')) + result;
                        n := n div 10;
                    end;
                
                if (isNegative) then result := '-' + result;
            end;
        
        toString := result;
    end;

function toString(n: real): string;

    begin   
        toString := toString(intPart(n)) + '.' + toString(fracPart(n));
        if ((n < 0) and (intPart(n) = 0)) then 
            toString := '-' + toString;
    end;

function toNumber(s: string): real;

    begin
        if (isInteger(s)) then 
            toNumber := toInteger(s)
        else 
            if (isNegative(s)) then 
                toNumber := toInteger(intPart(s)) + toInteger(fracPart(s)) / power(10 , min(length(fracPart(s)) - 3, 3))
            else 
                toNumber := toInteger(intPart(s)) + toInteger(fracPart(s)) / power(10 , min(length(fracPart(s)), 3));
    end;

procedure removeEndingZeros(var s: string);

    var right: integer;

    begin         
        if (isReal(s)) then 
            begin 
                right := length(s);
                while (right > 0) do 
                    begin
                        if (s[right] <> '0') then break;
                        right := right - 1; 
                    end; 
                if (s[right] = '.') then dec(right);
                s := copy(s, 1, right);
            end;
    end;

function removeSpaces(s: string): string;

    var slen, i: integer;
        temp: string;
        
    begin
        slen := length(s); 
        temp := '';

        for i := 1 to slen do 
            if (s[i] <> ' ') then 
                temp := temp + s[i];
        
        removeSpaces := temp;
    end;

    

begin 
end.
