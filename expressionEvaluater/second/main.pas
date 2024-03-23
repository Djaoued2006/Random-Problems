uses mathematics, convert, equation;


procedure main();
    
    var s : string;

    begin
        write('type the equation: ');readln(s);
        writeln('x = ', solveFirstOrderEquation(s));
    end;


begin
    main();
end.
