# Task 1
Your **first** task is the**manual** conversion of **Tic Tac Toe** into a RESTful service.

 > **WARNING!** Start your screen recording **now**. Your entire task actvity must be captured. This includes your familiarization with the task description!

## Task Illustration (Restifying the Zoo)










I will now illustrate the steps of a **manual** conversion to a RESTful service on the example of the Zoo.  
I will use the previously shown [Zoo REST interface description](interface-zoo.txt).

 * Please watch [this short screencast](...) where I demonstrate and explain the required code changes.
 * Below you additionally find a recapitulation of the main steps.
 * Additionally you can conveniently inspect both versions and the changes made:
    * Switch to *Desktop Zoo* version: ```git checkout master``` or [inspect code online](https://github.com/kartoffelquadrat/Zoo/tree/master/src/main/java/eu/kartoffelquadrat/zoo).
    * Switch to *RESTified Zoo* version: ```git checkout RESTified``` or [inspect code online](https://github.com/kartoffelquadrat/Zoo/tree/RESTified/src/main/java/eu/kartoffelquadrat/zoo).
    * Compare versions: ```git diff master..RESTified``` or [inspect changes online](https://github.com/kartoffelquadrat/Zoo/commit/8fe7675b65f795897910358ed089ea2a0e22aeff).

### Project Layout Overview

### Build Configuration Changes

#### Build and Run

### Java Code Changes

#### Launcher

#### Beans and Singletons

#### Resource Mapping with Annotations

### Compile / Run / Verify (possibly master template)
## Your Task

Not it is your turn! 

 * The target REST interface description for your task is below.
 * All you need to do is replicate the above steps.
 * Please now run a
**manual** conversion of **Tic Tac Toe** into a RESTful service.


### Interface Description: Tic Tac Toe Resources and Methods

 * Your interface should begin with a top-level resource "*xox*", offering two methods.
    * A *[GET]* request to the "*xox*" resource should result in a lookup of all currently running games, as a list of game-identifiers.
    * A *[POST]* request to the "*xox*" resource should allow adding of a new game instance. The identifier is generated on server side and does not need to be provided, however the request body should provide all parameters required as game settings.
 * The "*xox*" resource should possess a dynamic placeholder subresource, representing individual game instances by identifier.
    * A *[GET]* request on the identifier placeholder resource should retrieve scoring information for the targeted game.
    * A *[DELETE]* request on the identifier placeholder resource should remove the game from the list of all games.
 * The dynamic resource representing games by their identifier should have two subresources: "*players*" and "*board*".
    * A *[GET]* request on the "*board*" resource should return a list of player names involved into the specified game. The game instance is in this case provided by value of the parent placeholder resource.
    * A *[GET]* request on the "*board*" resource should return a snapshot of the current game board layout, is to say which cells empty or occupied by a given player. The game instance is in this case provided by value of the parent placeholder resource.
 * The "*player*" resource should possess a dynamic placeholder resource, encoding the name of a given player. This resource has no methods, but in its turn a subresource "*actions*".
    * A *[GET]* request on actions should return an array of possible actions for a given player in a given game. Each action represents the claim of an available field. The required player  name is provided by the parent dynamic resource representing a player name and the game instance is provided by the value of the dynamic sub resource of the root resource.
 * The "*actions*" resource should possess a dynamic placeholder resource that serves to identify the a specific selection of the actions available to a given player in a given game.
    * A *[POST]* request on that dynamic placeholder resource should allow the selection of a given action, to perform it. The precise action is then identified by an int value taken by the dynamic resource, representing the position in the array of all possible actions. The required player  name is provided by the parent dynamic resource representing a player name and the game instance is provided by the value of the dynamic sub resource of the root resource.
    