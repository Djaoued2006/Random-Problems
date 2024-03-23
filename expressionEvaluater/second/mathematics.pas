unit mathematics;


interface

    function intPart(n: real): integer;
    function fracPart(n: real): integer;
    function intPart(s: string): string;
    function fracPart(s: string): string;
    
    function power(base, expo: integer): longint;
    function isInteger(s: string): boolean;
    function isNegative(s: string): boolean;
    function min(a, b : integer): integer;


implementation

function isNegative(s: string): boolean;

    begin
        isNegative := length(s) >= 4; // minimum '(-1)'
        if isNegative then 
            isNegative := (s[1] = '(') and (s[length(s)] = ')') and (s[2] = '-'); 
    end;

function power(base, expo: integer): longint;

    var i : integer;

    begin
        power := 1;
        for i := 1 to expo do power := power * base; 
    end;

function intPart(n: real): integer;

    begin
        intPart := trunc(n); 
    end;

function fracPart(n: real): integer;

    begin
        fracPart := trunc(abs((n - intPart(n))) * power(10 , 3));
    end;

function intPart(s: string): string;

    begin
        intPart := copy(s , 1 , pos('.' , s) - 1); 
        if (isNegative(s)) then intPart := intPart + ')';
    end;

function fracPart(s: string): string;

    begin
        if (isNegative(s)) then 
            fracPart := '(-' + copy(s , pos('.' , s) + 1 , 255)
        else 
            fracPart := copy(s , pos('.' , s) + 1 , 3);
    end;

function isInteger(s: string): boolean;

    begin
        isInteger := (pos('.' ,s) = 0); 
    end;

function min(a, b : integer): integer;

    begin
        if (a < b) then 
            min := a
        else 
            min := b; 
    end;


begin 
end.




