uses eval;


procedure main();

    var s : string;
        i : integer;

    begin 
        if (paramCount = 0) then 
            begin 
                writeln('error');
                writeln('./main <mathematical operation>');
            end 
        else 
            begin 
                s := evaluateComplexExpression(paramStr(1)); 
                writeln('the result is : ' , s);
            end;

        // s := '6 - 21.3';
        // writeln(evaluateBasicExpression(s));
        // writeln(trunc(-1.22));
    end;


begin
    main();
end.