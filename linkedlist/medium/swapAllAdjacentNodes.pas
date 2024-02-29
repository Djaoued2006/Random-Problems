uses lib;

procedure swapAllAdjacentNodes(var head : pNode);

    var i , len : integer;

    begin
        len := length(head);

        i := 1;
        while (i < len) do 
            begin
                swapAdjacentNodes(head , i);
                i := i + 2;
            end;
    end;

procedure main();

    var head : pNode;

    begin
        head := NumberToList(4321);
        print(head);
        swapAllAdjacentNodes(head);
        print(head);
        free(head); 
    end;

begin
    main();
end.