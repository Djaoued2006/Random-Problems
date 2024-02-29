uses lib;

procedure reverseSubLinkedList(var head : pNode ; left , right : integer);

    var temp , list1 , list2 , start , endd : pNode;

    begin
        if (left = 1) then 
            begin
                endd := getNode(head , right);

                temp := endd^.next;
                endd^.next := NIL;

                endd := head;

                reverse(head);

                endd^.next:= temp;
            end
        else
            begin
                temp := getNode(head , left - 1);

                start := temp^.next;
                temp^.next := NIL;
                list1 := temp;

                temp := getNode(head , right);
                list2 := temp^.next;
                temp^.next := NIL;

                endd := start;
                reverse(start);

                endd^.next := list2;
                list1^.next := start;
            end; 
    end;

procedure main();

    var head : pNode;

    begin
        head := getRandomList(10);
        print(head);
        reverseSubLinkedList(head , 5 , 7);
        print(head);
        free(head); 
    end;

begin
    main();
end.