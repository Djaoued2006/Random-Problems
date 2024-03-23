unit eval;

interface 

    uses mathematics , convert , stack;

    const NAN = 'NAN';
          operations : array of string = ('+' , '-' , '*' , '/');


    function evaluateExpression(s: string): string;
    function calculate(operand1, operand2, operation: string): string;
    function getLeftOperand(s: string; OpPosition: integer): string;
    function getRightOperand(s: string; OpPosition: integer): string;


    function priorityEvaluation(s, operation: string): string;
    function evaluateString(s: string): string;

implementation

function calculate(operand1, operand2, operation: string): string;

    var result : real;
        isNan : boolean;

    begin
        isNan := FALSE;

        case operation of 
            '+' : result := toNumber(operand1) + toNumber(operand2);                        
            '-' : result := toNumber(operand1) - toNumber(operand2);
            '*' : result := toNumber(operand1) * toNumber(operand2);
            '/' : begin 
                    isNan := toNumber(operand2) = 0;
                    if (not isNan) then result := toNumber(operand1) / toNumber(operand2);
                  end;
        end;
            
        if (not isNan) then 
            begin 
                calculate := toString(result);
                if (result < 0) then calculate := '(' + calculate + ')';
            end 
        else 
            calculate := NAN;
    end;

function isOperation(op: string): boolean;    

    var i : integer;

    begin
        i := 0;
        isOperation := FALSE;

        while (i < 4) do 
            begin
                isOperation := (op = operations[i]);
                if isOperation then i := 3;
                inc(i); 
            end;
    end;

function getLeftOperand(s: string; OpPosition: integer): string;

    var j: integer;
        result: string;
        negativeString : boolean;

    begin
        j := OpPosition - 1;
        result := '';

        negativeString := (s[j] = ')');

        while (j > 0) do 
            begin 
                if (isOperation(s[j])) then 
                    if (negativeString) then 
                        negativeString := FALSE
                    else 
                        break;
                result := s[j] + result;
                dec(j);
            end;

        getLeftOperand := result;
    end;


function getRightOperand(s: string; OpPosition: integer): string;

    var j , slen : integer;
        result: string;
        negativeString : boolean;

    begin
        j := OpPosition + 1;
        slen := length(s);

        result := '';
        negativeString := (s[j] = '(');
        

        while (j <= slen) do 
            begin 
                if (isOperation(s[j])) then 
                    if (negativeString) then 
                        negativeString := FALSE
                    else 
                        break;
                result := result + s[j];
                inc(j);
            end;

        getRightOperand := result;
    end;

function getNextOperation(s: string; index: integer): integer;

    var slen, result: integer;

    begin
        slen := length(s);
        result := index + 1;

        while (result <= slen) do 
            if (isOperation(s[result])) then break 
            else 
                inc(result); 
    
        getNextOperation := result;
    end;

function priorityEvaluation(s, operation: string): string;

    var i, nextOpIndex , lastOpIndex: integer;
        result: string;
        operand1, operand2: string;
        slen : integer;
    
    begin
        slen := length(s);

        lastOpIndex := 0;
        i := 1;

        while (i <= slen) do  
            begin
                if (s[i] = operation) then 
                    begin
                        operand1 := getLeftOperand(s , i);
                        operand2 := getRightOperand(s , i);
                        result := calculate(operand1 , operand2 , operation);   

                        if (result = NAN) then 
                            begin 
                                s := result;
                                break;     
                            end;
                        
                        nextOpIndex := getNextOperation(s , i);

                        writeln(operand1 , operation , operand2 , ' = ' , result);

                        if (isNegative(operand1)) then lastOpIndex := lastOpIndex - 2;
                        if (isNegative(operand2)) then nextOpIndex := nextOpIndex + length(operand2) - 1;
                    
                        
                        
                        s := copy(s , 1 , lastOpIndex) + result + copy(s , nextOpIndex , 256);  
                        slen := length(s);

                        i := lastOpIndex;
                    end
                else
                    if (isOperation(s[i])) then
                        lastOpIndex := i;

                inc(i);
            end;
        
        priorityEvaluation := s;
    end;

function evaluateString(s: string): string;

    var result: string;

    begin
        result := s;
        result := priorityEvaluation(result, '/');
        if not (result = NAN) then 
            begin
                result := priorityEvaluation(result , '*');
                result := priorityEvaluation(result , '+'); 
            end;
        
        evaluateString := result;
    end;


function evaluateExpression(s: string): string;

    var i, index , slen: integer;
        operand1 , operand2 , operation: string;
        result, temp : string;
        opStack , operandStack: pNode;
        parenthesesStack : pNode;

    begin
        opStack := NIL;
        operandStack := NIL;

        temp := '';

        // for i := 1 to length(s) do 
        //     begin
        //         if isOperation(s[i]) then 
        //             if not (s[i-1] = '(') then
        //                 begin 
        //                     if (not isEmpty(opStack)) then 
        //                         begin
        //                             operand2 := temp;
        //                             operand1 := pop(operandStack);
        //                             operation := pop(opStack);
        //                             result := calculate(operand1 , operand2 , operation);
        //                             if (result = NAN) then 
        //                                 break 
        //                             else 
        //                                 push(operandStack , result);
        //                             writeln(operand1 , operation , operand2 , ' = ' , result);
        //                         end
        //                     else 
        //                         push(operandStack, temp);
                        
        //                     push(opStack , s[i]);
        //                     temp := '';
        //                 end
        //             else 
        //                 temp := temp + s[i]
        //         else 
        //             temp := temp + s[i];
        //     end;
        
        parenthesesStack := NIL;

        i := 1;
        slen := length(s);

        while (i <= slen) do 
            begin
                if (s[i] = '(') then 
                    push(parenthesesStack , toString(i));

                if (s[i] = ')') then 
                    begin
                        index := toInteger(pop(parenthesesStack));
                        temp := copy(s , index ,i - index + 1);

                        if not (isNegative(temp)) then 
                            temp := copy(temp , 2 , length(temp) - 2);

                        result := evaluateString(temp);

                        if (result = NAN) then 
                            begin 
                                s := result;
                                break;
                            end;

                        s := copy(s, 1 , index - 1) + result + copy(s , i + 1 , 255);
                        slen := length(s);
                        i := index + length(result) - 1; 

                        writeln(s);
                        writeln;
                    end;

                inc(i);     
            end;
        
        // empty(operandStack);
        // empty(opStack);
        evaluateExpression := evaluateString(s);
    end;

begin 
end.


