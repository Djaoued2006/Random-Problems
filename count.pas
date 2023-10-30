program countWordsChars;

function countWords(s : string): integer;

    var i , len , count: integer;
        w : string;

    begin 

        i := 1;
        len := length(s);
        count := 0;
        w := '';

        while True do 
            begin
                if (i = len + 1) then 
                    begin
                        if (w <> '') then 
                            count := count + 1;
                        break;
                    end;

                if (s[i] <> ' ') then 
                    w := w + s[i]
                else 
                    if (w <> '') then 
                        begin
                            count := count + 1;
                            w := '' 
                        end;
                i := i + 1;
            end;
            countWords := count;
        end;

procedure listWords(s : string);
    
    var i , len: integer;
        w : string;
    
    begin

        i := 1;
        w := '';
        len := length(s);

        while True do 
            begin
                if (i = len + 1) then  
                    begin
                        if (w <> '') then 
                            writeln(w);
                        break;
                    end;
                
                if (s[i] <> ' ') then 
                    w := w + s[i]
                else
                    begin  
                        if (w <> '') then 
                            writeln(w);
                        w := '';
                    end;

                i := i + 1
            end; 
    end;

begin 
    listWords('Hello I am djaoued  this is me '); // list of all words with new lines
    writeln(countWords('follow me')) // output : 2
end.