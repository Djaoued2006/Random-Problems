type arr = array[1..size] of integer;

procedure print(nums: arr);

    var i: integer;

    begin
        write('[');
        for i := 1 to size - 1 do 
            write(nums[i], ', ');
        writeln(nums[size] , ']');
    end;

procedure main();

    var nums: arr;
        i: integer;

    begin
        randomize;

        for i := 1 to size do 
            nums[i] := random(size);
        
        print(nums);
    end;

begin
    main();
end.