unit checks;

interface

    function removeSpaces(s : string) : string;
    function removeEndingZeros(s : string) : string;
    function replaceStrings(s1, s2 , s : string) : string;

implementation

function removeSpaces(s : string) : string;

    var i , slen: integer;
        result : string;
    
    begin   
        result := '';
        slen := length(s);

        for i := 1 to slen do 
            if (s[i] <> ' ') then 
                result := result + s[i];

        removeSpaces := result; 
    end;

function removeEndingZeros(s : string) : string;

    var i , slen : integer;
        result : string;
    
    begin
        slen := Length(s);
        i := slen;
        result := '';

        while (True) do 
            begin 
                if (i = 0) then break;
                if (s[i] <> '0') then break;

                dec(i);
            end;
        
        if (i <> 0) then 
            if (s[i] = '.') then dec(i);
        
        while (i <> 0) do 
            begin 
                result := s[i] + result;
                dec(i);
            end;
        
        removeEndingZeros := result;
    end;

//this function will replace the string s1 with s2 and return the new string
function replaceStrings(s1, s2 , s : string) : string;
    
    var i , s1len , slen ,index : integer;
        result : string;


    begin
        index := pos(s1 , s);

        if (index = 0) then result := s
        else 
            begin
                s1len := length(s1);
                slen := length(s);

                result := '';

                for i := 1 to index - 1 do 
                    result := result + s[i];

                result := result + s2;

                for i := index + s1len to slen do 
                    result := result + s[i]; 
            end; 

        replaceStrings := result;
    end;



begin 
end.