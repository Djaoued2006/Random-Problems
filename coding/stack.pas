unit stack;

interface

    type pNode = ^Node;
        Node = record 
            value : integer;
            next : pNode;
        end;
    
    procedure push(var top : pNode ; value : integer);
    function pop(var top : pNode): integer;
    function stackEmpty(top : pNode) : Boolean;

implementation

function createNode(value : integer) : pNode;

    var result : pNode;

    begin
        new(result);
        result^.value := value;
        result^.next := NIL;
        createNode := result;
        result := NIL; 
    end;

procedure push(var top : pNode ; value : integer);

    var newNode : pNode;

    begin 
        newNode := createNode(value);
        newNode^.next := top;
        top := newNode;
        newNode := NIL;
    end;


function pop(var top : pNode): integer;

    var result : integer;
        temp : pNode;

    begin
        result := top^.value;
        temp := top;
        top := top^.next;
        Dispose(temp);
        temp := NIL; 
    end;


function stackEmpty(top : pNode) : Boolean;

    begin
        stackEmpty := (top = NIL); 
    end;

begin 
end.