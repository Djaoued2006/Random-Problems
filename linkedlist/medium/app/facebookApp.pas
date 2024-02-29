unit facebookApp;

interface

    type
        pPost = ^post;
        pUser = ^User;

        User = record 
            userId : integer;
            userName : string;
            followers , following : pUser;
            posts : pPost;
            numberOfFollowers : integer;
            next : pUser;
        end;


        post = record 
            poster : pUser;

            postId : integer;
            content : string;

            numberOfLikes : integer;
            likers : pUser;
            next : pPost;
        end;

        function createUser(name : string ; userId : integer) : pUser;
        function getUser(users : pUser ; userId : integer) : pUser;
        function createPost(users : pUser ; postId , userId : integer ; content : string) : pPost;
        function getPost(posts : pPost ; postId : integer) : pPost;
        function getUserFollowers(users : pUser ; userId : integer) : pUser;
        function getUserFollowing(users : pUser ; userId : integer) : pUser;
        function getUserPosts(users : pUser ; userId : integer) : pPost;
        procedure addUser(var users : pUser; name : string ; userId : integer);
        procedure addPost(var posts , postNode : pPost);
        procedure removeUser(var users : pUser ; userId : integer);
        procedure removePost(var posts : pPost ; postId : integer);
        procedure likePost(users : pUser ; var posts : pPost ; userId , postId : integer);
        procedure dislikePost(var posts : pPost ; userId , postId : integer);
        procedure editContentOfPost(posts : pPost; postId : integer ; newContent : string);
        procedure changeUserName(users : pUser; userId : integer ; newUserName : string);
        procedure followUser(users : pUser ; followeeId , followerId : integer);
        procedure addUserPost(users : pUser ; var posts : pPost ; userId , postId : integer ; content : string);
        procedure editPostContent(users : pUser ; posts : pPost ; userId , postId : integer ; newContent : string);
        procedure deleteUserPost(users : pUser ; var posts : pPost ; userId , postId : integer);
        procedure deleteUser(var users : pUser ; var posts : pPost ; userId : integer);


implementation

function createUser(name : string ; userId : integer) : pUser;

    var node : pUser;

    begin 
        new(node);

        node^.userId := userId;
        node^.userName := name;

        node^.followers := NIL;
        node^.following := NIL;
        node^.posts := NIL;
        node^.numberOfFollowers := 0;

        node^.next := NIL;

        createUser := node;

        node := NIL;
    end;

function getUser(users : pUser ; userId : integer) : pUser;

    var node : pUser;

    begin
        node := users;

        while (node <> NIL) do 
            if (node^.userId = userId) then break
            else 
                node := node^.next;

        getUser := node;

        node := NIL; 
    end;

function createPost(users : pUser ; postId , userId : integer ; content : string) : pPost;

    var node : pPost;
        userNode : pUser;

    begin
        new(node);
        
        node^.postId := postId; 
        userNode := getUser(users , userId);
        node^.poster := userNode;

        node^.content := content;
        node^.numberOfLikes := 0;
        node^.likers := NIL;

        node^.next := NIL;

        createPost := node;

        node := NIL;
    end;

function getPost(posts : pPost ; postId : integer) : pPost;

    var node : pPost;

    begin
        node := posts;

        while (node <> NIL) do 
            if (node^.postId = postId) then break
            else 
                node := node^.next;

        getPost := node; 

        node := NIL;
    end;

function getUserFollowers(users : pUser ; userId : integer) : pUser;
    
    var userNode : pUser;

    begin
        userNode := getUser(users , userId); 

        if (userNode <> NIL) then getUserFollowers := userNode^.followers
        else 
            getUserFollowers := NIL;
        
        userNode := NIL;
    end;

function getUserFollowing(users : pUser ; userId : integer) : pUser;

    var userNode : pUser;

    begin
        userNode := getUser(users , userId);

        if (userNode = NIL) then getUserFollowing := NIL 
        else 
            getUserFollowing := userNode^.following; 
        
        userNode := NIL;
    end;

function getUserPosts(users : pUser ; userId : integer) : pPost;

    var userNode : pUser;

    begin 
        userNode := getUser(users , userId);

        if (userNode = NIL) then getUserPosts := NIL
        else 
            getUserPosts := userNode^.posts;
        
        userNode := NIL;
    end;


procedure addUser(var users : pUser; name : string ; userId : integer);

    var node : pUser;

    begin
        node := createUser(name , userId);
        node^.next := users;
        users := node; 

        node := NIL;
    end;

procedure addPost(var posts , postNode : pPost);

    var node : pPost;

    begin
        postNode^.next := posts;
        posts := postNode; 

        node := NIL;
    end;

procedure removeUser(var users : pUser ; userId : integer);

    var current ,temp : pUser;

    begin
        if (users <> NIL) then 
            begin
                current := users;

                if (current^.userId = userId) then 
                    begin
                        users := current^.next;
                        dispose(current);
                    end
                else 
                    begin
                        while (current^.next <> NIL) do 
                            begin
                                if (current^.next^.userId = userId) then break;
                                current := current^.next; 
                            end;
                        
                        if (current^.next <> NIL) then 
                            begin
                                temp := current^.next;
                                temp^.next := current^.next;
                                dispose(current);
                            end;
                    end;
            end; 
        
        current := NIL;
        temp := NIL;
    end;

procedure removePost(var posts : pPost ; postId : integer);

    var current , temp : pPost;

    begin
        if (posts <> NIL) then 
            if (posts^.postId = postId) then 
                begin 
                    current := posts;
                    posts := posts^.next;
                    dispose(current);
                end
            else 
                begin   
                    current := posts;

                    while (current^.next <> NIL) do 
                        begin
                            if (current^.next^.postId = postId) then break;
                            current := current^.next; 
                        end; 
                    
                    if (current^.next <> NIL) then 
                        begin
                            temp := current^.next;
                            current^.next := temp^.next;
                            dispose(temp);
                        end;
                end;    
    
        current := NIL;
        temp := NIL;
    end;

function copyUser(users : pUser; userId : integer) : pUser;

    var userNode , myUser : pUser;

    begin
        myUser := getUser(users , userId);

        if (myUser <> NIL) then 
            begin 
                userNode^.userName := myUser^.userName;
                userNode^.userId := userId;
                userNode^.followers := myUser^.followers;
                userNode^.following := myUser^.following;
                userNode^.posts := myUser^.posts;
                userNode^.numberOfFollowers := myUser^.numberOfFollowers;
                userNode^.next := NIL;
            end
        else 
            userNode := NIL;
        
        copyUser := userNode;

        userNode := NIL;
        myUser := NIL;
    end;

// this function will check if the user has already liked a post!
function checkPostLikedByUser(users : pUser ; userId : integer): boolean;

    var node : pUser;

    begin
        node := users;

        while (node <> NIL) do  
            begin
                if (node^.userId = userId) then break;
                node := node^.next; 
            end;
        
        checkPostLikedByUser := (node <> NIL);
        node := NIL;
    end;

procedure likePost(users : pUser ; var posts : pPost ; userId , postId : integer);

    var postNode : pPost;
        userNode : pUser;

    begin
        postNode := getPost(posts , postId);

        if (postNode <> NIL) then
            if (not checkPostLikedByUser(postNode^.likers , userId)) then 
                begin
                    userNode := copyUser(users , userId);
                    if (userNode <> NIL) then 
                        begin
                            inc(postNode^.numberOfLikes);
                            userNode^.next := postNode^.likers;
                            postNode^.likers := userNode;
                        end; 
                end
            else 
                writeln('the user has already liked the post!');
        
        postNode := NIL;
        userNode := NIL;
    end;

procedure dislikePost(var posts : pPost ; userId , postId : integer);

    var postNode : pPost;
        userNode : pUser;
    
    begin
        postNode := getPost(posts , postId);

        if (postNode <> NIL) then 
            begin
                userNode := getUser(postNode^.likers , userId);

                if (userNode <> NIL) then 
                    begin
                        removeUser(postNode^.likers , userId);
                        dec(postNode^.numberOfLikes);
                    end
            end;
        
        userNode := NIL;
        postNode := NIL;
    end;

procedure editContentOfPost(posts : pPost; postId : integer ; newContent : string);

    var postNode : pPost;

    begin
        postNode := getPost(posts , postId);

        if (postNode <> NIL) then 
            postNode^.content := newContent
        else 
            writeln('post not found!');
        
        postNode := NIL;
    end;

procedure changeUserName(users : pUser; userId : integer ; newUserName : string);

    var userNode : pUser;

    begin
        userNode := getUser(users , userId);

        if (userNode <> NIL) then userNode^.userName := newUserName
        else 
            writeln('user not found!');
        
        userNode := NIL;
    end;

procedure followUser(users : pUser ; followeeId , followerId : integer);

    var followerNode , followeeNode , temp : pUser;
    
    begin
        followerNode := getUser(users , followerId);

        if (followerNode <> NIL) then 
            begin
                followeeNode := getUser(users , followeeId);

                if (followeeNode <> NIL) then 
                    begin
                        temp := copyUser(users , followerId);

                        temp^.next :=  followeeNode^.followers;
                        followeeNode^.followers := temp;

                        temp := copyUser(users , followeeId);

                        temp^.next := followeeNode^.following;
                        followeeNode^.following := temp;

                        inc(followeeNode^.numberOfFollowers);
                    end
                else 
                    writeln('can''t make the last operation! (error : can''f find the followee id)')
            end
        else 
            writeln('can''t make the last operation!! (error : can''t find the follower id)');
        

        followerNode := NIL;
        followeeNode := NIL;
        temp := NIL;
    end;

// procedure unfollowUser(users : pUser ; followeeId , followerId : integer);

//     var followerNode , followeeNode , temp : pUser;

//     begin
//         followerId 
//     end;

procedure addUserPost(users : pUser ; var posts : pPost ; userId , postId : integer ; content : string);

    var postNode : pPost;
        userNode : pUser;
    
    begin
        userNode := getUser(users , userId);

        if (userNode <> NIL) then 
            begin
                postNode := createPost(users , postId , userId , content);
                addPost(posts , postNode);
                addPost(userNode^.posts , postNode); 
            end
        else 
            writeln('no user found!');
        
        postNode := NIL;
        userNode := NIL;
    end;

procedure editPostContent(users : pUser ; posts : pPost ; userId , postId : integer ; newContent : string);

    var postNode : pPost;
        userNode : pUser;
    
    begin
        postNode := getPost(posts , postId);

        if (postNode <> NIL) then 
            begin
                postNode^.content := newContent;

                userNode := getUser(users , userId);

                postNode := getPost(userNode^.posts , postId);

                postNode^.content := newContent;

            end
        else 
            writeln('post not found!');
        
        postNode := NIL;
        userNode := NIL;
    end;


procedure deleteUserPost(users : pUser ; var posts : pPost ; userId , postId : integer);

    var userNode : pUser ; 
        postNode : pPost;
    
    begin
        postNode := getPost(posts , postId);

        if (postNode = NIL) then writeln('post not found!')
        else 
            begin
                userNode := getUser(users , userId);

                removePost(posts , postId);

                removePost(userNode^.posts , postId); 

                writeln('post removed succesfully!')
            end;
        
        userNode := NIL;
        postNode := NIL;
    end;

procedure deleteUser(var users : pUser ; var posts : pPost ; userId : integer);

    var userNode : pUser;
        postNode : pPost;
        temp : pPost;
        userTemp : pUser;

    begin

        userNode := getUser(users , userId);

        if (userNode <> NIL) then 
            begin
                postNode := posts;

                if (posts <> NIL) then 
                    begin
                        while (postNode^.next <> NIL) do 
                            begin
                                if (postNode^.next^.poster = userNode) then 
                                    begin
                                        temp := postNode^.next;
                                        postNode^.next := temp^.next;
                                        dispose(temp); 
                                    end
                                else
                                    postNode := postNode^.next;
                            end; 
                        
                        if (posts^.poster = userNode) then 
                            begin
                                temp := posts;
                                posts := posts^.next;
                                dispose(temp); 
                            end;
                    end;
                
                removeUser(users , userId);
                
                while (userNode <> NIL) do 
                    begin
                        userTemp := getUserFollowers(userNode , userId);
                        removeUser(userTemp , userId);
                        userTemp := getUserFollowing(userNode , userId);
                        removeUser(userTemp , userId);
                        userNode := userNode^.next;
                    end;
            end;

        temp := NIL;
        postNode := NIL;
    end;

begin 
end.



