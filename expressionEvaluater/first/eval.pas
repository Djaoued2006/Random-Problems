unit eval;

interface

    uses sysUtils , checks , convert , stack;

    const operations : array of char = ('+' , '-' , '*' , '/');

    function evaluateSingleExpression(s : string): string;
    function evaluateBasicExpression(s : string): string;
    function evaluateComplexExpression(s : string) : string;

implementation

function checkIn(c : char) : boolean;

    var i : integer;
        result : boolean;
    
    begin
        result := FALSE;
        i := 0;

        while ((not result) and (i < 4)) do 
            begin
                result := (c = operations[i]);
                inc(i); 
            end;
        
        checkIn := result;
    end;

function checkForOperation(operation : char ; s :string) : Boolean;

    var i , slen : integer;
        result : Boolean;
    
    begin
        i := 1;
        slen := length(s);
        result := FALSE;

        while ((not result) and (i <= slen)) do 
            begin
                result := (operation = s[i]);
                inc(i); 
            end; 
        
        checkForOperation := result;
    end;


function countNumberOfOperations(s : string) : integer;

    var i : integer;
        result : integer;
        slen : integer;
    
    begin
        i := 1;
        result := 0;    
        slen := length(s);

        while (i <= slen) do 
            begin 
                if (checkIn(s[i])) then inc(result); 
                inc(i);
            end;

        countNumberOfOperations := result;
    end;

function getOperand1(operation : char ; s: string) : string;

    var i , index : integer;
        result : string;
    
    begin
        result := ''; 
        index := pos(operation , s);
        i := index - 1;

        while (i <> 0) do 
            begin
                if (checkIn(s[i])) then break 
                else 
                    result := s[i] + result;
                i := i - 1; 
            end;
        
        getOperand1 := result;
    end;

function getOperand2(operation : char ; s: string) : string;

    var i , index, slen : integer;
        result : string;
    
    begin
        result := ''; 
        index := pos(operation , s);
        slen := length(s);
        i := index + 1;

        while (i <= slen) do 
            begin
                if (checkIn(s[i])) then break 
                else 
                    result := result + s[i];
                i := i + 1; 
            end;
        
        getOperand2 := result;
    end;



function evaluateSingleExpression(s : string): string;

    var operand1 , operand2 : string;
        i , slen: integer;
        operation : char;
        whichOperand : Boolean;
    
    begin
        s := removeSpaces(s); // this will convert this : '22 +  33' into this '22+33' (simpler)

        slen := length(s);
        i := 1;

        operand1 := '';
        operand2 := '';

        whichOperand := TRUE; // means the operand number 1

        while (i <= slen) do 
            begin
                if (checkIn(s[i])) then 
                    begin 
                        whichOperand := FALSE; //means the operand number 2
                        operation := s[i];
                    end
                else 
                    if (whichOperand) then 
                        operand1 := operand1 + s[i]
                    else 
                        operand2 := operand2 + s[i];
                
                inc(i);
            end; 
    
        
        evaluateSingleExpression := makeBasicCalculation(operand1 , operand2 , operation)
    end;

function calculateAllOperations(s: string ; operation : char) : string;

    var op1 , op2 : string;
        temp : string;

    begin
        while (checkForOperation(operation , s)) do 
            begin
                op1 := getOperand1(operation , s);
                op2 := getOperand2(operation , s); 
                temp := makeBasicCalculation(op1 , op2 , operation);

                if (temp = NAN) then 
                    begin 
                        s := temp;
                        break;
                    end
                else
                    s := replaceStrings(op1 + operation + op2 , temp , s);
            end; 

        calculateAllOperations := s;
    end;

function evaluateBasicExpression(s : string): string;

    var result : integer;
        i : integer;
        temp , op1, op2: string;
        numberOfOperations : integer;
    
    begin
        s := removeSpaces(s);
        numberOfOperations := countNumberOfOperations(s);

        if (numberOfOperations = 0) then evaluateBasicExpression := s
        else 
            begin
                s := calculateAllOperations(s , '/');
                if (s <> NAN) then
                    begin 
                        s := calculateAllOperations(s , '*');
                        s := calculateAllOperations(s , '-');
                        s := calculateAllOperations(s , '+'); 
                    end;
            end;
            
        evaluateBasicExpression := s;
    end;


function evaluateComplexExpression(s : string) : string;

    var parenthesesStack , indexStack : pNode;
        i , slen , index : integer;
        tempString , operationString , result : string;

    begin
        //suppose the parentheses are good!
        evaluateComplexExpression := NAN;

        {the idea is , each time i encouter '(' , i push it to the stack and an index of it 
        then when i encounter ')' with no '(' available in the stack, i go back to the last
        index (top of the stack) and start making calculations!}

        writeln('the mathematical operations : ' , s);

        writeln;

        s := removeSpaces(s);
        
        if (checkParentheses(s)) then 
            begin 
                parenthesesStack := NIL;
                indexStack := NIL;

                i := 1;

                slen := length(s);

                while ((i <= slen) and (hasParentheses(s))) do 
                    begin

                        if (s[i] = '(') then 
                            begin
                                push(parenthesesStack , s[i]);
                                push(indexStack , str(i)); 
                            end; 
                        
                        if (s[i] = ')') then 
                            begin
                                pop(parenthesesStack); 

                                index := int(pop(indexStack));

                                tempString := copy(s , index , i - index + 1);

                                

                                operationString := copy(tempString , 2 , i - index - 1);
                                result := evaluateBasicExpression(operationString);

                                if (result = NAN) then 
                                    begin
                                        s := result;
                                        break;
                                    end;


                                writeln(tempString , ' = ' , result);
                                s := replaceStrings(tempString , result , s);
                                slen := length(s);
                                writeln('the strings is now : ' , s);

                                writeln;
                                i := 0;
                            end;
                        
                        inc(i);
                    end;
            end;

        evaluateComplexExpression := evaluateBasicExpression(s);
        freeStack(indexStack);
        freeStack(parenthesesStack);
    end;





begin 
end.