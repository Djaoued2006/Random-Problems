uses lib;

procedure reorderList(var head : pNode);    

    var head1 , head2 : pNode;
        current , temp , current2 : pNode;

    begin
        divideList(head , head1 , head2);
        reverse(head2);

        current := head1;

        while (head2 <> NIL) do 
            begin
                current2 := head2;

                head2 := head2^.next;

                current2^.next := current^.next;
                current^.next := current2;
                
                current := current2^.next;
            end;
        
        head := head1;
    end;

procedure main();

    var head : pNode;

    begin
        head := getRandomList(10);
        print(head);
        reorderList(head);
        print(head);
        free(head); 
    end;

begin 
    main();
end.