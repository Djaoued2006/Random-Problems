//this program will remove the nth node from the given list from the end of the list

uses lib;

procedure remove(var head : pNode ; n : integer);

    var len  : integer;
        current , temp : pNode;
    
    begin
        len := length(head);

        if (head <> NIL) then 
            if (n >= len) then 
                begin
                    temp := head;
                    head := head^.next;
                    dispose(temp);
                    temp := NIL; 
                end
            else 
                begin
                    current := getNode(head , len - n);
                    temp := current^.next;
                    current^.next := temp^.next;
                    dispose(temp);
                    temp := NIL; 
                end;
    end;

procedure main();

    var head : pNode;

    begin
        head :=  NumberToList(10332);
        remove(head , 1);

        print(head);
        free(head);
    end;

begin
    main();
end.