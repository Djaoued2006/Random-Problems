unit exec;

interface

    uses CRT, edit, Process;

    procedure run(filePath: string; currString, newString: string);

implementation 


procedure compile(filePath: string);

    var outString: ansiString;
        command: string;

    begin
        command := 'fpc ' + getNewPath(filePath);
        runCommand(command, outString);
    end;

procedure execute(filePath: string);

    var outString: ansiString;
        command: string;
    
    begin
        command := './' + getExecutableName(filePath);
        runCommand(command, outString); 
        write(outString);
    end;

procedure deleteNewFiles(filePath: string);

    var outString: ansiString;

    begin
        runCommand('rm *.ppu *.o', outString);
        runCommand('rm ' + getNewPath(filePath), outString);
        runCommand('rm ' + getExecutableName(filePath), outString);
    end;

procedure run(filePath: string; currString, newString: string);

    begin
        editFile(filePath, currString, newString);
        compile(filePath);

        writeln;
        writeln('Compiling...');
        writeln('Executing...');
        writeln;

        execute(filePath);

        writeln;
        deleteNewFiles(filePath);
    end;

begin 
end.

