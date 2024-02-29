unit lib;

interface 

    type pNode = ^Node;
        Node = record
            value : integer;
            next : pNode;
        end;
    
    function length(head : pNode) : integer;
    function getNode(head : pNode ; pos : integer) : pNode;
    procedure print(head : pNode);
    procedure free(var head : pNode);
    function NumberToList(value : integer) : pNode; 
    procedure rotateOnce(var head : pNode);
    procedure swapAdjacentNodes(var head : pNode ; pos : integer);
    function getRandomList(length : integer) : pNode;
    procedure reverse(var head : pNode);
    procedure divideList(var head : pNode ; var head1 , head2 : pNode);
    
implementation

function make(value : integer)  : pNode;

    var node : pNode;

    begin
        new(node);
        node^.value := value;
        node^.next := NIL;
        make := node;
        node := NIL;
    end;

procedure add(var head: pNode ; value : integer ; pos : integer);

    var node : pNode;
        current : pNode;
    
    begin 
        node := make(value);
        if (head = NIL) then head := node 
        else
            if (pos = 1) then 
                begin
                    node^.next := head;
                    head := node;
                end
            else
                begin
                    current := head;
                    pos := pos - 2;
                    while ((pos <> 0) and (current^.next <> NIL)) do 
                        begin
                            current := current^.next;
                            pos := pos - 1; 
                        end; 
                    
                    node^.next := current^.next;
                    current^.next := node;
                end;
    end;

function length(head : pNode) : integer;

    var current : pNode;

    begin
        length := 0;
        current := head;
        while (current <> NIL) do 
            begin   
                current := current^.next;
                length := length + 1; 
            end; 
        current := NIL;
    end;

procedure addBeg(var head : pNode ; value : integer);

    begin
        add(head , value , 1); 
    end;

procedure addLast(var head : pNode; value : integer);

    begin
        add(head , value , length(head) + 1); 
    end;

procedure print(head : pNode);

    var current : pNode;

    begin
        if (head = NIL) then writeln('empty!')
        else    
            begin
                current := head;
                while (current^.next <> NIL) do 
                    begin   
                        write(current^.value , ' -> ');
                        current := current^.next;
                    end;   
                writeln(current^.value);
            end;
    end;

procedure free(var head : pNode);

    var temp : pNode;

    begin
        while (head <> NIL) do 
            begin
                temp := head;
                head := head^.next;
                dispose(temp); 
            end; 
        temp := NIL;
    end;

function NumberToList(value : integer) : pNode; 
    
    var head : pNode;

    begin
        head := NIL;

        if (value = 0) then add(head , value , 1)
        else 
            begin
                while (value <> 0) do 
                    begin
                        addLast(head , value mod 10);
                        value := value div 10; 
                    end;
            end;
        
        NumberToList := head;
    end;

function max(a , b : integer) : integer;

    begin
        if (a > b) then max := a
        else 
            max := b; 
    end;

function getNode(head : pNode ; pos : integer) : pNode;

    var result : pNode;

    begin
        result := head;
        if (head <> NIL) then 
            begin
                while ((pos <> 1) and (result^.next <> NIL)) do  
                    begin 
                        pos := pos - 1;
                        result := result^.next;
                    end;
            end; 
        
        getNode := result;
    end;

procedure swapAdjacentNodes(var head : pNode ; pos : integer);

    var node1 , node2 , before1 , temp : pNode;

    begin 
        if (length(head) >= 2) then 
            if (pos = 1) then 
                begin
                    node1 := head^.next;
                    head^.next := node1^.next;
                    node1^.next := head;
                    head := node1; 
                end
            else 
                begin
                    before1 := getNode(head , pos - 1);
                    node1 := before1^.next;
                    node2 := node1^.next;

                    temp := node2^.next;
                    before1^.next := node2;
                    node2^.next := node1;
                    node1^.next := temp;
                end;
    end;

procedure rotateOnce(var head : pNode);

    var len : integer ; current , node : pNode;

    begin
        len := length(head);

        if (len >= 2) then 
            begin
                current := getNode(head , len - 1);
                node := current^.next;

                current^.next := NIL;
                node^.next := head;
                head := node;
            end;
    end;

function getRandomList(length : integer) : pNode;

    var head : pNode;
        i : integer;

    begin
        head := NIL;
        for i := 1 to length do 
            addBeg(head , random(100));
        getRandomList := head; 
    end;

procedure reverse(var head : pNode);

    var prev , next , current : pNode;

    begin
        prev := NIL;
        current := head;

        while (current <> NIL) do 
            begin
                next := current^.next;
                current^.next := prev;
                prev := current;
                current := next; 
            end;
        head := prev;
    end;

procedure divideList(var head : pNode ; var head1 , head2 : pNode);

    var len : integer;

    begin
        len := length(head);
        head1 := getNode(head , len div 2);
        head2 := head^.next;
        head1^.next := NIL; 
    end;

BEGIN 
END.


