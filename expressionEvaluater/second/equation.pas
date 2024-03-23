unit equation;

interface 

    uses convert, mathematics, eval;

    function solveFirstOrderEquation(s: string): string;

implementation

function solveFirstOrderEquation(s: string): string;

    var a, b, c: string;
        posX, posEqu: integer;
        temp, result: string;

    begin
        s := removeSpaces(s);

        posX := pos('X' , s);
        posEqu := pos('=' , s);

        a := copy(s, 1 , posX - 1);
        b := copy(s, posX + 2, posEqu - posX - 2);
        c := copy(s, posEqu + 1, 256);

        a := evaluateExpression(a);
        b := evaluateExpression(b);
        c := evaluateExpression(c);

        if (toInteger(a) = 0) then 
            if (toInteger(b) = toInteger(c)) then 
                solveFirstOrderEquation := 'R'
            else 
                solveFirstOrderEquation := '/O/'
        else 
            begin 
                b := changeSign(b);
                temp := c + '+' + b;
                temp := evaluateExpression(temp);
                result := temp +  '/'  + a;
                result := evaluateExpression(result);
                removeEndingZeros(result);
                solveFirstOrderEquation := result;
            end;
    end;

function solveSecondOrderEquation(s: string): string;

    var a, b, c, d: string;
        result, temp: string;
    
    begin
         
    end;

begin 
end.
