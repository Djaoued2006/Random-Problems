unit stack;

interface

    type pNode = ^Node;
        Node = record 
            value : string;
            next : pNode;
        end;
    
    procedure push(var top : pNode ; value : string);
    function pop(var top : pNode): string;
    function stackEmpty(top : pNode) : Boolean;
    procedure freeStack(var top : pNode);

implementation

function createNode(value : string) : pNode;

    var result : pNode;

    begin
        new(result);
        result^.value := value;
        result^.next := NIL;
        createNode := result;
        result := NIL; 
    end;

procedure push(var top : pNode ; value : string);

    var newNode : pNode;

    begin 
        newNode := createNode(value);
        newNode^.next := top;
        top := newNode;
        newNode := NIL;
    end;


function pop(var top : pNode): string;

    var temp : pNode;

    begin
        pop := top^.value;
        temp := top;
        top := top^.next;
        Dispose(temp);
        temp := NIL; 
    end;


function stackEmpty(top : pNode) : Boolean;

    begin
        stackEmpty := (top = NIL); 
    end;

procedure freeStack(var top : pNode);   

    var value : string;

    begin
        while (not stackEmpty(top)) do 
            value := pop(top);
    end;

begin 
end.