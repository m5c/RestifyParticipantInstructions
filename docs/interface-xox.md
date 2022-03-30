

## Interface Description: Tic Tac Toe Resources and Methods

 * Your interface should begin with a top-level resource "*xox*", offering two methods.
    * A *[GET]* request to the "*xox*" resource should result in a lookup of all currenlty running games, as a list of game-identifiers.
    * A *[POST]* request to the "*xox*" resource shouls allow adding of a new game instance. The identifier is generated on server side and does not need to be provided, however the request body should provide all parameters required as game settings.
 * The "*xox*" resource should posess a dynamic placeholder subresource, representing individual game instances by identifier.
    * A *[GET]* request on the identifier placeholder resource should retrieve a scoring information for the targeted game.
    * A *[DELETE]* request on the identifier placeholder resource should remove the game from the list of all games.
 * The dynamic resource representing games by their identifier should have two subresources: "*players*" and "*board*".

