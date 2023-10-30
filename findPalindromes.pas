program findpalindrome;

uses sysUtils;

function isPalindrome(number : integer) : boolean;

    var i : integer;
        s : string;

    begin

        isPalindrome := True;
        s := inttostr(number); 
        for i := 1 to (length(s) div 2) do 
            begin
                if (s[i] <> s[length(s) - i + 1]) then 
                    begin 
                        isPalindrome := False;
                        exit;
                    end;
            end;
    end;

procedure findPalindromes(number : integer);

    var i : integer;

    begin

        i := 0;
        while i <= number do 
            begin 
                if isPalindrome(i) then 
                    writeln(i);
                i := i + 1;
            end; 
    end;



begin 
    writeln(isPalindrome(1001));
    findPalindromes(1012)
end.