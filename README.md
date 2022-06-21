This project is for web application development course at Ankara Yildrim Beyazit University
The following are the main user functions in the system:
-	Sign In / Sign Up
-	Browse Books by genre
-	Search for books by name
-	See Most popular books
-	Follow and unfollow other users
-	Message other users
-	Search for other users
-	Rate A Book
-	Write a review for a book
-	Comment on a review and reply to a comment on a review
-	Can delete a reply

Some Important Information for the instructor:
-Many of the tasks in the original requirement specification document were changed due to their hard implementation and due to not resembling how goodreads work.
-Above were the ones implemented in the system
-Similar to goodreads website, a user can only become an author if a user contacts the website and asks to become an author. It is done manually in the database by changing one Boolean parameter.
-To sign in through the system, use Hussein as username and password as Hussein, all names in the current database have the same passwords as the username/first name.

The following commands can be used to build the image of sql server and to run a container based on that image to create a database and create a valid connection:

docker run -d -p 1433:1433 -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=YourStrong**Passw0rd"  mcr.microsoft.com/mssql/server:2019-latest
docker run -p 1433:1433 --name my-sql-server-container -e "SA_PASSWORD=YourStrong**Passw0rd" my-sql-server-image
