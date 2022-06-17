## Troubleshoot

 * **Q**: I open the project with IntelliJ, but everything is underlined in red.  
**A**: The projet was not correctly opened. Delete the cloned folder, clone the repository again, then make sure to open the project [exactly as shown](#loading-legacy-sources-into-ide).
 * **Q**: I cannot compile / run the project, the green button is greyed out.  
**A**: The project has no launch configuration by default, therefore the arrow in the top bar is not available. Open the ```RestLauncher``` class instead and click on one of the green triangles, left of the code. 
 * **Q**: I RESTified the application, but when I start it there is a Nullpointer-Exception.  
**A**: Most likely one of the classes annotated with ```@RestController``` has constructor code that still cannot access ```@Autowired``` fields. E.g. if the constructor calls a method that initializes the service state, that method might require access to an ```@Autowired``` field, but that is only available after class initialization. Do not call that method in the constructor. Tell spring to call it after class initialization, when all fields are initialized. Use the ```@PostConstruct``` annotation. See [```@PostConstruct```](#beans-and-singletons).
 * **Q:** I've made a mistake on project import, how can I start from scratch?  
Delete the cloned folder, clone the repository again, then make sure to open the project [exactly as shown](#loading-legacy-sources-into-ide).