unit edit;

interface 

    function editString(originalString, currString, newString: string): string;
    procedure editFile(filePath: string; currString, newString: string);
    
    function getNewPath(filePath: string): string;
    function getExecutableName(filePath: string): string;

implementation

function editString(originalString, currString, newString: string): string;

    var result: string; 
        index: integer;
    
    begin 
        index := pos(currString, originalString);

        if (index <> 0) then 
            result := copy(originalString, 1, index - 1) + newString + copy(originalString, index+length(currString), 256)
        else 
            result := originalString;
        
        editString := result;
    end;


function getNewPath(filePath: string): string;

    begin
        getNewPath := 'n' + filePath; 
    end;

function getExecutableName(filePath: string): string;

    begin
        getExecutableName := editString(getNewPath(filePath), '.pas' , ''); 
    end;


procedure editFile(filePath: string; currString, newString: string);

    var myFile, myNewFile: text;
        line: string;
    
    begin
        assign(myFile, filePath);
        assign(myNewFile, getNewPath(filePath));
        reset(myFile);
        rewrite(myNewFile);

        while (not eof(myFile)) do 
            begin
                readln(myFile, line);
                line := editString(line, currString, newString);
                writeln(myNewFile, line); 
            end; 
        
        close(myFile);
        close(myNewFile);
    end;

begin
end.