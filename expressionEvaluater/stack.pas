unit stack;

interface

    type pNode = ^Node;
        Node = record 
            value : string;
            next : pNode;
        end;
    
    function isEmpty(top: pNode): boolean;
    procedure push(var top: pNode; value: string);
    function pop(var top: pNode): string;
    procedure empty(var top: pNode);


implementation

function createNode(value: string): pNode;

    var result: pNode;

    begin
        new(result);
        result^.value := value;
        result^.next := NIL;
        createNode := result;
        result := NIL; 
    end;

function isEmpty(top: pNode): boolean;

    begin
        isEmpty := (top = NIL); 
    end;

procedure push(var top: pNode; value: string);

    var newNode: pNode;

    begin
        newNode := createNode(value);
        newNode^.next := top;
        top := newNode;
        newNode := NIL; 
    end;

function pop(var top: pNode): string;

    var temp: pNode;

    begin
        pop := top^.value;
        temp := top;
        top := top^.next;
        dispose(temp);
        temp := NIL;
    end;

procedure empty(var top: pNode);

    begin
        while (not isEmpty(top)) do 
            pop(top);
    end;

begin 
end.