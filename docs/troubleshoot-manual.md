## Troubleshoot

 * **Q**: I open the project with IntelliJ, but everything is underlined in red.  
**A**: The projet was not correctly opened. There are multiple potential fixes:  
    Option 1) Reload ```pom.xml```: Right click the file, then select ```Maven -> Reload Project```.  
![reload](../captures/intellij/reloadmaven.png)
    Option 2) Verify the JDK version: Select ```File``` -> ```Project Structure...```. Verify ```11.0.5``` is selected in the *Project* and *SDKs* tab:  
![sdk1](../captures/intellij/sdk1.png)  
![sdk2](../captures/intellij/sdk2.png)  
    Option 3) Invalidate IntelliJ caches: Select ```File``` -> ```Invalidate Caches...```. Then select the first two checkboxes:  
![invalidate1](../captures/intellij/invalidate1.png)  
![invalidate2](../captures/intellij/invalidate2.png)
    Option 4) Delete the cloned folder, clone the repository again, then make sure to open the project [exactly as shown](#loading-legacy-sources-into-ide).
 * **Q**: I cannot compile / run the project, the green button is greyed out.  
**A**: The project has no launch configuration by default, therefore the arrow in the top bar is not available. Open the ```RestLauncher``` class instead and click on one of the green triangles, left of the code. 
 * **Q**: I RESTified the application, but when I start it there is a Nullpointer-Exception.  
**A**: Most likely the constructor code in one of the classes annotated with ```@RestController``` invokes a call to an ```@Autowired``` field. Autowiring is only available after class initialization (after the constructor). Do not call any method with access to autowired fields in a constructor. Instead tell spring to call it after class initialization. Use the ```@PostConstruct``` annotation. See [```@PostConstruct```](#beans-and-singletons).
 * **Q**: I've made a mistake on project import, how can I start from scratch?  
Delete the cloned folder, clone the repository again, then make sure to open the project [exactly as shown](#loading-legacy-sources-into-ide).
 * **Q**: I've modified the ```pom.xml``` file as shown, but IntelliJ still does not seem to know about Spring.  
**A**: Sometimes the changes made to the ```pom.xml``` are not automatically detected. (See first question, ```pom.xml```reload```.)
 * **Q**: IntelliJ asks me whether I want to trust the project sources. Should I?  
**A**: Yes. This is just a security mechanism to prevent malicious code being executed on project import. The provided sources are all from us and can be trusted.  
![trust](../captures/intellij/trust.png)