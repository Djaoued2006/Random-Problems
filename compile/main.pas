uses exec;

procedure main();   

    var filePath, currString, newString: string;

    begin
        write('type the name of the file: ');readln(filePath);
        write('type the current string: ');readln(currString);
        write('type the new string: ');readln(newString);

        run(filePath, currString, newString); 
    end;

begin
    main();
end.