## Intro to LAMP Stack
The LAMP stack stands for Linux, Apache, MySQL, and PHP. Together, they make up the "stack" which can serve an interactive, data-driven web application.

 - **Linux**- operating system. Windows or MacOS can also be used just as easily.
 - **Apache** - web server. Nginx can be used instead.
 - **MySQL** - the most popular relational database software.
 - **PHP** - a server-side scripting language. Python, Perl, and Ruby are also popular choices for web scripting languages, but PHP is very easy to get started with.
 ## Installing the stack
 - Get started by installing [XAMPP
](https://www.apachefriends.org/index.html). MAMP is another popular choice for mac users.
 - This provides a ready to go *AMP stack on Mac or Windows, and are the fastest way to set up a dev environment.
 - Can also be installed via command line, using homebrew, or in a virtual machine like Vagrant or Docker
 - Already set up on most commercial web hosts
## What is a relational (SQL) database?
 - A database is like a spreadsheet full of spreadsheets. 
 - Information is organized into tables with columns and rows.
 - Each row is identified by a unique primary key, or ID.
 - We interact with the database using Structured Query Language, or SQL (pronounced "sqeuel")
 - English-like query language
## Example Database
**students**

| id | name         | email                |
|----|--------------|----------------------|
| 1  | caleb savage | caleb.savage@nyu.edu |
| 2  | suzie sample | suzie@nyu.edu        |
| 3  | jane doe     | jane@nyu.edu         |
**courses**

| id | title        | instructor |
|----|--------------|------------|
| 1  | Pcomp        | Dan        |
| 2  | Applications | Nancy      |
| 3  | ICM          | Tom        |
| 4  | Thesis       | Dan        |
**registration**
| id | student_id | course_id |
|----|------------|----------|
| 1  | 1          | 3        |
| 2  | 1          | 2        |
| 3  | 3          | 1        |
| 4  | 2          | 3        |

    SELECT * FROM STUDENTS;
This SQL statement will give us the whole students table, exactly like above. What if we wanted to get only one student's data?

    SELECT * FROM classes WHERE instructor= 'Dan';
    
  results in:
| id | title        | instructor |
|----|--------------|------------|
| 1  | Pcomp        | Dan        |
| 4  | Thesis       | Dan        |

That was easy! Let's try something a bit more interesting....
What is Caleb's class list? We have a table of students, a table of courses, and a table of registrations. All we know is our student's name.

Since *students can have many courses* and *courses can have many students*, we can describe this as a **many to many relationship**. This is one of the trickiest kind of relationships to work with, but also very common. In order to relate these tables, we need an intermediary, or *join* table. 

    SELECT 
	    students.id, students.first_name, students.last_name
	     courses.title, courses.instructor
    FROM 
	     students, courses, registration
    WHERE
	     registration.student_id = students.id
	AND
	     registration.course_id = courses.id;
| id |namename| title | instructor
|--|--|--|--|
|1| Caleb Savage | ICM | Tom
|1| Caleb Savage | Applications| Nancy
|2|Suzie Sample | Pcomp | Dan
etc etc etc

## Let's Build a Twitter Clone
What database tables and fields do we need for our minimum viable product?
**users**
 - ID (Auto Increment- Primary Key)
 - username
 - email
 - password.... more on this later
 - Profile pic

**tweets**

 - ID (A.I. P.K.)
 - User ID
 - Contents
 - Date & time posted

To create a "real" web app, we'd typically need a lot more tables and fields. But these will be enough for us to get started with. Copy the SQL code from **schema.sql** and paste it into a PhpMyAdmin query to get started. Read over the code and you should get a pretty good idea of what it does.

  ## Key PHP Basics
  

 - Dynamically typed server-side scripting language
 - `$variables` prefixed by $
 - Lines end with  semicolon`;`
 - `echo	` prints out a string variable
 - `print_r($arrayOrObject)` prints out a multidimensional variable
 - Foreach loop -- very convenient
  `foreach($array as $element){
	print_r($element);}
	`
 - 500 Internal Server Error-- you probably forgot a $ or ; someplace
 - Make PHP dump out descriptive error messages: `ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
`
## Passing Data Around
 - GET and POST are two types of HTTP request. 
 - When you click on a link, you're sending a GET request 
 - In a GET request, Data can be appended to the URL with a query string-- `http://website.com?variable=somedata&anothervariable=somemoredata`
 - When you submit a form, you're sending a POST request.
 - In most cases, you'll use GET requests to get something from the server, and POST to send something to it. 

## Security
![SQL injection](https://imgs.xkcd.com/comics/exploits_of_a_mom.png)
SQL injection is perhaps the most common type of vulnerability you need to watch out for. Consider this example:

URL: http://example.com/show_user?id=12

    <?php $id=$_GET['id'];
    $query = "SELECT * FROM user WHERE id= $id";
This will work fine as long as the ID GET parameter is truly an ID. Since $_GET['id'] is set to 12, it will generate

    SELECT * FROM user WHERE id = 12;

But what if a malicious user types this URL:

    http://example.com/show_user?id=12;DROP%20TABLE%20users

Then we'd actually generate two queries, one of which is maliciously crafted to destroy our database using the DROP TABLE command

    SELECT * FROM user WHERE id = 12;
    DROP TABLE user;
To avoid this pitfall, we're going to use **prepared statements** which is a feature given to us by the PDO Database Driver. This allows us to craft our queries in such a way that the database knows not to trust user input, and to always treat it as text even if it looks like a SQL command.
http://php.net/manual/en/pdo.prepared-statements.php

# Code Snippets
Basic HTML form:

    <form action="process.php" method="POST">
    <input name="username" type="text" placeholder="username">
    <input name="message" type="text" placeholder="Type your message here">
    <input type="submit">
    </form>
Connecting to a database (connection.php):

    /* Connect to a MySQL database using driver invocation */  
    $dsn = 'mysql:dbname=testdb;host=127.0.0.1';  
    $user = 'dbuser';  
    $password = 'dbpass';  
      
    try {  
    $dbh = new PDO($dsn, $user, $password);  
    } catch (PDOException $e) {  
    echo 'Connection failed: ' . $e->getMessage();  
    }

Processing the form data:

    <?php
    include('connection.php') //run the connection.php file and make all its variables accessible here
    
    print_r($_POST); //print all of our POST data to the screen so we can see it
    
    $query = "INSERT INTO tweets(username, message) VALUES(:username, :message); //write out our query, using :placeholders
    $stmt = $dbh->prepare($query); 
    $stmt->bindParam(':username', $_POST['username']); //let the database know to treat the POST inputs as text, not as commands
    $stmt->bindParam(':message', $_POST['message']);
    $stmt->execute(); //insert the data into our database

## Notes on enterprise implementation
-   When we talk about the LAMP stack, it’s usually in the context of a smaller application, with the database server and web server running on the same physical (or virtual) machine.
-   Once you start getting to be gigantic, performance considerations require splitting the workload across multiple servers—tools like load balancing, reverse proxies, caching and database redundancy become important. This adds a number of additional complications in the stack, although it will often still be using the same elements (Linux, apache, MySQL, and php) just with more stuff in between.
-   Facebook began in Zuck’s dorm room with very modest early 2000s era PHP and MySQL. Its incredibly rapid growth likely meant there was no time to pause and say “What technologies should we use to make this as robust and scalable as possible”. Most likely a compiled language like Java would make the most sense for creating an enterprise-scale application from scratch.
-   There’s almost certainly no code left in Facebook’s production environment which dates back to the earliest days, but they do still make extensive use of the same basic technologies.
-   Being an interpreted language, PHP code is going to run into performance bottlenecks fairly quickly once you reach a certain scale. Even though the performance hit from an interpreted scripting language (versus a compiled language) is only a few milliseconds per request, once you’re getting thousands of requests per minute this starts to add up.
-   In the past 5-6 years, Facebook has created and released its own dialect of PHP, called Hack. Its syntax and features are identical, but Hack adds support for stricter typing. It’s similar to the difference between TypeScript and JavaScript.
-   Having strict typing—where you specify if a variable or parameter or function result is a string, integer, float, etc (rather than “duck typing” like you find in vanilla PHP or JS) has a number of advantages with regards to programmer discipline, clean code, and preventing hard-to-diagnose errors related to variable typing.
-   In addition to the improvements they’ve put into Hack, the Facebook team has also created HHVM (HipHop Virtual Machine) which is a new way of compiling PHP code into 1s and 0s (with a couple of intermediary steps) for the best possible performance.