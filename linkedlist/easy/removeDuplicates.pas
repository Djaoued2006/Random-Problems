uses lib;

procedure removeDuplicates(var head : pNode);

    var current , prev , temp : pNode;

    begin
        current := head;

        if (head <> NIL) then
            while (current^.next <> NIL) do 
                begin
                    temp := current^.next;
                    prev := current;
                    
                    while (temp <> NIL) do 
                        if (current^.value = temp^.value) then 
                            begin
                                prev^.next := temp^.next;
                                dispose(temp);
                                temp := prev^.next; 
                            end
                        else 
                            begin
                                prev := temp;
                                temp := temp^.next; 
                            end;
                        
                    current := current^.next;
                end; 
    end;

procedure main();

    var head : pNode;

    begin
        randomize;
        head := getRandomList(10); 
        print(head);
        removeDuplicates(head);
        print(head);
        free(head);
    end;

begin
    main()
end.