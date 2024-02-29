uses lib;

procedure partitionList(var head : pNode ; value : integer);

    var left, right , target , current: pNode;

    begin
        target := head;
        
        while (target <> NIL) do 
            begin
                if (target^.value = value) then break;
                target := target^.next; 
            end;
        
        if (target <> NIL) then 
            begin 
                right := NIL;
                left := NIL;

                current := head;

                while (current <> NIL) do 
                    begin
                        if (current^.value > value) then addLast(right , current^.value)
                        else    
                            addLast(left, current^.value);
                        current := current^.next; 
                    end;
                
                addLast(left, value);

                current := left;

                while (current^.next <> NIL) do current := current^.next;
                current^.next := right;

                free(head);
                head := left;
            end;
    end;

procedure main();

    var head : pNode;
        value : integer;

    begin
        randomize;
        head := getRandomList(10);
        print(head); 
        write('type a value : ');readln(value);
        partitionList(head , value);
        print(head);
        free(head);
    end;

begin
    main();
end.