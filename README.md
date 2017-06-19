# Book-Reviews
Judge-a-book-by-its-cover app

Uses book data (cover art, author, description, title, ratings) from Google Books API to create book models.  Once books are extracted from online, they are stored in a Bookshelf, which is divided into seen and unseen books.  All "seen" books appear in the collection view past the Stats segue from the navigation bar. Unseen books are in a queue to be rated by the user.

The main screen is divided into a cover view, a rating view controller (which alternates between a slider view during ratings, and button view after rating 5 books), and a category label.  

Once 5 books are rated, the books are listed in a table view.

Delegates for table view, collection view, and search were used. 
