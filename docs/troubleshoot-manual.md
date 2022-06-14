## Troubleshoot

 * I open the project with IntelliJ, but everything is underlined in red.
 * I cannot compile / run the project, the green button is greyed out.
 * I RESTified the application, but when I start it there is a Nullpointer-Exception: Most likely one of the classes annotated with @RestController has constructor code that still cannot access @Autowire fields. E.g. if the constructor calls a method that initializes the service state, that method might require access to an @Autowired field, but that is only available after class initialization.  
*Workaround:** Do not call that method in the constructor. Tell spring to call it after class initialization, when all fields are initialized. Use the @PostContruct annotation.