unit data;

interface 
    
    uses facebookApp;

    procedure printUsers(users : pUser);
    procedure printPosts(posts : pPost);
    function randomUsers(length : integer) : pUser;
    procedure printMenu();
    function readInteger(s : string) : integer;

implementation

procedure printMenu();

    var myFile : text;
        line: string;

    begin   
        assign(myFile , './user_interface/menu.txt');
        reset(myFile);

        while (not eof(myFile)) do 
            begin
                readln(myFile , line);
                writeln(line); 
            end; 
    end;

function readInteger(s : string) : integer;

    var result : integer;

    begin
        write(s) ; readln(result) ; readInteger := result; 
    end;


procedure writeTab();

    var i : integer;

    begin 
        for i := 1 to 4 do write(' ');
    end;

procedure printUsers(users : pUser);

    var userNode : pUser;

    begin
        userNode := users;

        if (users = NIL) then writeln('no users added !')
        else 
            while (userNode <> NIL) do 
                begin
                    writeln(userNode^.userId ,  '   :   ' , userNode^.userName); 
                    userNode := userNode^.next;
                end;
            
        userNode := NIL;
    end;

procedure printPosts(posts : pPost);

    var postNode : pPost;

    begin
        postNode := posts;
        

        if (posts = NIL) then writeln('no posts added !')
        else 
            while (postNode <> NIL) do 
                begin
                    writeln(postNode^.postId ,  '   :   ' , postNode^.poster^.userName); 
                    writeTab();
                    writeln(postNode^.content);
                    postNode := postNode^.next;
                end;
            
        postNode := NIL;
    end;

function getString(length : integer) : string;

    var result : string;
        i : integer;
    
    begin
        result := '';

        for i := 1 to length do 
            result := result + chr(random(26) + ord('A'));

        getString := result; 
    end;

function randomUsers(length : integer) : pUser;

    var i : integer;
        result : pUser;

    begin
        result := NIL;

        for i := 1 to length do 
            addUser(result , getString(3 + random(7)) , i);
        
        randomUsers := result;
    end;

procedure viewProfile(users : pUser ; userId : integer);

    var userNode : pUser;

    begin
        userNode := getUser(users , userId);

        if (userNode = NIL) then writlen('user not found!')
        else
            begin
                writeln('User Name : ' , userNode^.userName);
                writeln('User Id : ' , userNode^.userId);
                writeln('Number Of Followers : ' , userNode^.numberOfFollowers);
            end;
    end;

procedure executeFunctions(funcNumber : integer ; userId , postId : integer ; var posts : pPost ; var users : pUser);

    begin
        case funcNumber of 
            1 : addUser(userName , userId);
            2 : 
        end;
    end;



begin 
end.