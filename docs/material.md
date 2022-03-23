# Task Material

This page brings all the material you need for your refactoring tasks.

 * Code and documentation of the legacy applications you must restify.
 * Interface description of your expected task outcome. Your code will be testes agains these interfaces.

 > **Make sure to realize the two engineering tasks in the correct order and using the correct tools. This does not necessarily correspond to the order of appearance on this page!**

## Applications

In this section you find the source code and prepared models for both refactoring tasks.

 * Begin with the application [corresponding your first task](../#your-main-tasks).
 * Only look at the remaining application once you finished your first task.

### The Book Store

 * [Sources on GitHub](https://github.com/kartoffelquadrat/BookStoreInternals)
 * [Build and Run instructions](https://github.com/kartoffelquadrat/BookStoreInternals#usage)
 * [Documentation of all classes and methods](https://kartoffelquadrat.github.io/BookStoreInternals/eu/kartoffelquadrat/bookstoreinternals/package-summary.html)
 * Class Diagram and [TouchCORE model](linkhere).  
![bookstore](../captures/bs-bl.png)
*Class Diagram of the Book Store: All relevant functionality is in the marked classes: ```AssortmentImpl```, ```CommentsImpl```, ```GlobalStockImpl```.*

### Tic Tac Toe (xox)

 * [Sources on GitHub](https://github.com/kartoffelquadrat/XoxInternals)
 * [Build and Run instructions](https://github.com/kartoffelquadrat/XoxInternals#documentation). 
TODO: Add maven inclusion block to instructions.
 * [Java Doc](https://kartoffelquadrat.github.io/XoxInternals/index.html)
 * Class Diagram and [TouchCORE model](linkhere).  
![xox](../captures/xox-bl.png)
*Class Diagram of the Tic Tac Toe game: All relevant functionality is in the marked class: ```XoxManagerImpl```.*

## REST Interface Descriptions

In this section you find an informal description of the REST interfaces you must realize.

 * Your submission will be tested against these interfaces.
 * Respect them as closely as possible.
    * Double-Check resource spelling, it is case sensitive.
    * Double-Check resource hierarchy and layout.

### Interface Description: Book Store Resources and Methods


 * Your interface should begin with a top-level resource "*bookstore*", not offering any methods.  
 * "*bookstore*" has two subresources, "*isbns*" and "*stocklocations*", both offering a *[GET]* method.  
    * A *[GET]* request to *"isbns"* should result in a listing of all isbn numbers stored in the system.  
    * A *[GET]* request to "*stocklocations*" should result in a listing of all geographic store locations.
 * The "*isbns*" resource should have a single dynamic placeholder subresource representing an isbn number,
    * A *[GET]* request to the dynamic placeholder subresource should provide details on a given book, identified by isbn number which serves as input parameter.
    * A *[PUT]* request to the dynamic placeholder subresource should allow adding a new book to the system. All details on the book are passed as request body payload.
 * The dynamic placeholder resource should have a child resource "*comments*", representing comments for a given book, identified by isbn. The value of the parent placeholder resource determines which book is targeted.
    * A *[GET]* request to the "*comments*" resource should result in a listing of all comments for the specified book. The value of the parent resource representing an isbn number servers as input parameter. The result should index comments by their id.
    * A *[POST]* request to the "*comments*" resource should allow the creation of new comments. The id of the new comment is generated on server side and not required, however, again the parent placeholder resource encodes the isbn of the targeted book. The comment itself is to be transmitted as request body payload.
    * A *[DELETE]* request to the "*comments*" resource should delete all comments for a given book, identified by the isbn number of the parent dynamic placeholder resource.
 * The "*comments* resource should have a dynamic subresource representing a specific comment by id. It offers two methods: *[POST]* and *[DELETE]*.
    * A *[POST]* request to specific comment should allow to alter the content of that comment. Target book and target comment are respectively identified by the dynamic resource itself and the corresponding grandparent placeholder resource. Similar to comment creation, the new comment content is tranmitted as request body payload.
    * A *[DELETE]* request to specific comment should allow removal of an existing comment. Target book and target comment are respectively identified by the dynamic resource itself and the corresponding grandparent placeholder resource.
 * The *"stocklocations"* resource shoud have a dynamic subresource representing a specific geographic location (city name).
    * A *[GET]* request to a specific location should return the exact amount of book copies in stock for the given location, as a map indexed by isbn number. The path variable itself providing the target location can serve as argument for a corresponding method call.
 * Finally, the dynamic resource representing a specific geographic location should itself have a dynamic subresource representing the stock for a given book at the given location.
    * A *[GET]* request on this dynamic resource should return the amount of copies in stock for a book specified by isbn (the value of this placeholder resources) and stock location (the value of this resource's parent placeholder resource)
    * A *[POST]* request on this dynamic resource should update the current amount of copies for a given book. Target location and isbn are likewise encoded by this placeholder resource and its parent placeholder resource. The new amount is provided as request body payload.

### Interface Description: Tic Tac Toe Resources and Methods


