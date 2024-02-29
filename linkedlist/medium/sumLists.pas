uses lib;


function SumLists(head1 , head2 : pNode) : pNode;

    var carry , sum : integer;
        maxLength : integer;
        current1 , current2 , result : pNode;

    
    begin
        maxLength := max(length(head1) , length(head2));

        while (length(head1) <> maxLength) do 
            addLast(head1 , 0);
        
        while (length(head2) <> maxLength) do 
            addLast(head2 , 0);
        
        current1 := head1;
        current2 := head2;
        result := NIL;
        carry := 0;

        while (current1 <> NIL) do 
            begin
                sum := (current1^.value + current2^.value + carry);

                addLast(result , (sum) mod 10);
                carry := sum div 10;

                current1 := current1^.next;
                current2 := current2^.next;
            end; 
        
        if (carry <> 0) then addLast(result , carry);
        
        SumLists := result;
    end;

procedure main();

    var head1 , head2 , sum : pNode;

    begin 
        head1 := NumberToList(32765);
        head2 := NumberToList(32765);
        sum := SumLists(head1 , head2);

        print(head1);
        print(head2);
        print(sum);

        free(head1);
        free(head2);
        free(sum);
    end;

begin
    main();
end.
