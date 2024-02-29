uses lib;

procedure rotateNTimes(var head : pNode ; n : integer);

    begin
        while (n <> 0) do 
            begin
                rotateOnce(head);
                n := n - 1; 
            end; 
    end;

procedure main();

    var head : pNode;

    begin
        head := NumberToList(5432);
        print(head);
        rotateNTimes(head , 2); 
        print(head);
        free(head);
    end;

begin
    main();;
end.