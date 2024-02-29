uses lib;

function checkPalindrome(var head : pNode) : boolean;

    var len: integer;
        first, mid , second , current1 , current2 : pNode;
        result : boolean;

    begin
        len := length(head);
        result := true;

        if (len mod 2 = 0) then 
            begin
                mid := getNode(head , len div 2);

                first := head;
                second := mid^.next;

                mid^.next := NIL;
                reverse(first);

                current1 := first;
                current2 := second;

                while ((result) and (current1 <> NIL)) do 
                    begin
                        result := (current1^.value = current2^.value);
                        current1 := current1^.value;
                    end;
            end
        else 
            begin
                mid := getNode(head , len div 2);

                first := head;
                second := mid^.next^.next;
                mid^.next := NIL; 
            end;
    end;