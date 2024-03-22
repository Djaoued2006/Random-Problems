uses convert, eval , mathematics;


procedure main();
    
    var s : string;

    begin
        s := '(2*3+(-1)+(-2)/2+12*4)';
        
        // writeln(s);
        writeln(s);

        s := evaluateExpression(s);
        // writeln(priorityEvaluation(s , '+'));


        writeln(s);

        // writeln(('1293.32'));

    end;


begin
    main();
end.
