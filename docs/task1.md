# Task 1
Your **first** task is the **manual** conversion of **Tic Tac Toe** into a RESTful service.

 > **WARNING!** Start your screen recording **now**. Your entire task activity must be captured. This includes your familiarization with the task description!

## Task Illustration (Restifying the Zoo)










I will now illustrate the steps of a **manual** conversion to a RESTful service on the example of the Zoo.  
I will use the previously shown [Zoo REST interface description](interface-zoo.txt).

 > Afterwards, your task will be to apply the same **manual** methodology on a **different** application. Your task is **not** to replicate the Zoo conversion while you are watching.

 * Please watch [this screencast](https://www.cs.mcgill.ca/~mschie3/restifyvideos/IntelliJ-1080p.mp4) where I demonstrate and explain the required code changes.
    * Below you find a summary of the main steps.
    * If anything does not work as expected, take a look at the [Troubleshoot section](#troubleshoot).
 * Additionally you can conveniently inspect both versions and the changes made:
    * Switch to *Desktop Zoo* version: ```git checkout master``` or [inspect code online](https://github.com/kartoffelquadrat/Zoo/tree/master/src/main/java/eu/kartoffelquadrat/zoo).
    * Switch to *RESTified Zoo* version: ```git checkout RESTified``` or [inspect code online](https://github.com/kartoffelquadrat/Zoo/tree/RESTified/src/main/java/eu/kartoffelquadrat/zoo).
    * Compare versions: ```git diff master..RESTified``` or [inspect changes online](https://github.com/kartoffelquadrat/Zoo/commit/8fe7675b65f795897910358ed089ea2a0e22aeff).


### Project Layout Overview

A manual RESTification is a series of five activites:

 * [Loading of legacy sources into Integrated Development Environment (IntelliJ IDE)](#loading-legacy-sources-into-ide)
 * [Adjustment of the build configuration file: ```pom.xml```](#build-configuration-changes)
 * [Replacement of the launcher class](#launcher)
 * [Removal of singleton pattern or creation of proxy controllers](#beans-and-singletons)
 * [Decoration of REST controllers and target functions with Spring annotations](#resource-mapping-with-annotations)

### Loading Legacy Sources into IDE

 * Start IntelliJ
 * Use the "*Open*" option to get to the selection dialogue
![open-1](captures/intellij/open-1.png)
 * Select the cloned project root folder, then click the "*Open*" button:  
![open-2](captures/intellij/open-2.png)

### Build Configuration Changes

 > Want to see all Zoo-RESTify ```pom.xml``` changes at a glance? Run ```git diff master..RESTified pom.xml```. Green lines were added for RESTification, red lines were removed.

 * Artifact properties:
    * Adjust ```artifactId```. Change suffix to "restified"
    * Adjust ```name```. Change suffix to "restified"
 * Update developer information:
    * Remove email, organization
    * Change name **to your personal codename**, e.g. ```blue snail``` (see my email)
    * Change organization to your university: ```mcgill.ca```
 * Parent:
    * Declare inheritance from spring boot parent.  
Place below snippet right *after* the ```<license>...</license>``` block:    
```xml
<!-- this parent block lets this maven project extend a prepared spring specific template.-->
<parent>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-parent</artifactId>
  <version>2.3.0.RELEASE</version>
</parent>
```
 * Dependencies:
    * Declare dependency towards spring boot artifact:  
```xml
<!-- This block adds spring boot as a dependency, so we can use the parent pom configuration and non-standard annotations.-->
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-web</artifactId>
  <version>2.3.0.RELEASE</version>
</dependency>
```
 * Final Name
    * **Add** "restified" to ```finalName``` attribute value
 * Build plugins:
    * **Remove** plugin for legacy launcher class:  
```xml
<!-- specify main class for exec goal -->
<plugin>
  <groupId>org.codehaus.mojo</groupId>
  <artifactId>exec-maven-plugin</artifactId>
  <version>1.6.0</version>
  <executions>
    <execution>
      <goals>
        <goal>java</goal>
      </goals>
    </execution>
  </executions>
  <configuration>
    <mainClass>eu.kartoffelquadrat.zoo.DesktopLauncher</mainClass>
  </configuration>
</plugin>
```
    * **Remove** plugin for legacy compilation to self contained JAR:  
```xml  
<!-- specify main class for JAR manifest-->
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-jar-plugin</artifactId>
  <version>3.2.0</version>
  <configuration>
    <archive>
      <manifest>
        <mainClass>eu.kartoffelquadrat.zoo.DesktopLauncher</mainClass>
      </manifest>
    </archive>
  </configuration>
</plugin>
```
    * **Add** plugin for spring-boot launcher class: (Don't create the new launcher class yet!)  
```xml  
<!-- Spring specific build plugin, produces self contained JAR with default launcher class.-->
<plugin>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-maven-plugin</artifactId>
  <configuration>
    <fork>true</fork>
    <!-- Replace "zoo" by actual package name in next line! -->
    <mainClass>eu.kartoffelquadrat.zoo.RestLauncher</mainClass>
  </configuration>
  <executions>
    <execution>
      <goals>
        <goal>repackage</goal>
      </goals>
    </execution>
  </executions>
</plugin>
```


### Java Code Changes

 > **Hint**: You can use ```git``` to see all ```java``` changes made to the Zoo for manual RESTification.  
Run: ```git diff master..RESTified *java```  
Green lines were added for RESTification, red lines were removed.

#### Remove conflicting files

You have to delete two things:

 * The legacy launcher, located in ```src/main/java/eu/karotffelquadrat/*/DesktopLauncher.java```
 * The legacy unit tests. Remove the entire test folder: ```src/test```  
(This part has been skipped in the Zoo explanatory video, since there were no test classes)

#### Launcher

First thing to do is the creation of a new launcher class. It should be placed anywhere within the ```src/main/java/eu/kartoffelquadrat/...``` directory. 

 * Create it by right clicking on the ```eu.kartoffelquadrat...``` package:  
![create](captures/intellij/launcher.png)

 * Enter ```RestLauncher``` as class name, **do not** type the ```.java``` extension. IntelliJ will handle that for you.  
![entername](captures/intellij/entername.png)

Code of the ```RestLauncher.java``` class. (Replaces the legacy launcher)

```java linenums="1"
package eu.kartoffelquadrat.zoo;  <----- Replace "zoo" by whatever application you are working on

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * This class powers up Spring and ensures the annotated controllers are detected.
 */
@SpringBootApplication
public class RestLauncher {
    public static void main(String[] args) {

        SpringApplication.run(RestLauncher.class, args);
    }
}
```

#### Beans and Singletons

 * Spring creates new instances of classes annotated with:  
```java
@RestController
```
 * The existing singleton pattern is bypassed, since Spring uses reflection to gain constructor access, even if the declared constructor is private.
 * Having both ```@RestController``` and a ```getInstance``` method in the same class is dangerous.  
There are two ways to side-step inconsistency issues:

=== "Autowiring (Recommended)"
     * If you chose *Autowiring*, you do not create new classes. You directly annotate the relevant existing classes with ```@RestController```.
     * This tells Spring to create one instance per annotated class, using a default constructor.
     * Any existing singleton pattern is therefore obsolete: If you annotated a class with ```@RestController```, make sure to remove the singleton pattern (the ```getInstance``` method) and make the default constructor public.
     * Whenever an instance of such an annotated class is required, you can obtain the spring maintained instance with ```@Autowired```.  
    Example:
    ```java linenums="1"
    package eu.kartoffelquadrat.zoo;
    
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.web.bind.annotation.RestController;
    
    @RestController
    public class FooController {
    
        /*
        @Autowired ensures the zoo field is set after instantiation of FooController, given Zoo is annotated with @RestController.
        */
        @Autowired
        Zoo zoo;
    
        public void bar() {
    	// Here you can access the zoo instance using the local, autowired field (instead of calling the obsolete getInstance method)
        zoo.getOpeningHours();
        }
    }
    ```
     > Autowired fields are only accessible **after** class instantiation. Do not invoke methods that require autowired values from a constructor, or you will get a ```NullPointerException``` at runtime. Instead annotate those methods with ```@PostConstruct```. This advises spring to invoke a method after class instantiation.


=== "Proxy Classes"
     * If you chose *Proxy Classes*, you do annotate the existing classes. You instead replicate every existing relevant class and place all annotations in the replica. The replica acts as proxy that forwards every method call to the original, using ```getInstance()```.
     * Keep the singleton pattern in the original java classes. They remain untouched. Instead place an ```@RestController``` annotation in every proxy class created.  
    Example:  
    ```java linenums="1"
    package eu.kartoffelquadrat.zoo;
    
    import org.springframework.web.bind.annotation.RestController;
    
    /**
    This Proxy class is decorated with @RestController, instead of the original singleton class. Any required method of the original class can be proxied with an internal getInstance call.
    */
    @RestController
    public class ZooController {
    
        /** Proxied access to a method of the original / singleton class.
	// Mapping annotation goes here.
        public OpeningHours getOpeningHours() {
            // Access to the original class is achieved with a call to getInstance.
            return Zoo.getInstance().getOpeningHours();
        }
    }
    ```

#### Resource Mapping with Annotations

 > Note: Below annotation syntax can only be used in classes annotated with ```@RestController```.

 * Resource mappings (these annotations decorate functions)
     * Annotations types:  

    | Get | Put | Post | Delete |
    |---|---|---|---|
    | ```@GetMapping("...")``` |  ```@PutMapping("...")``` | ```@PostMapping("...")``` | ```@DeleteMapping("...")``` |

     * Arguments:
        * Static: Full resource path within quotes, e.g.: ```"zoo/animals"```
        * Dynamic: Full resource path within quotes. Any dynamic placeholder on path is marked *by curly brackets*, e.g.:```"zoo/animals/{animalname}"```

 * Parameter mapping (these annotations decorate function parameters)
     * Pathvariable:  
```@PathVariable("animalname")```
     * Request body:  
```@RequestBody```

### Build and Run

These instructions are to build and run from command line. While developing in IntelliJ you can safly use the "green triangle button" next to your new spring launcher class.  
![greenbutton](captures/intellij/greenbutton.png)

The first time you start your REST application you might see a warning about incoming connections. Select "*Allow*".
![firewall](captures/intellij/firewall.png)  

At some point you also need to build your application into a self contained artifact:  

=== "Mac OS / Linux"
     * Build a self contained executable jar file: ```mvn clean package```
     * Run the jar file: ```java -jar target/zoorestified.jar```
     > ```zoorestified``` is the name you provided as ```finalName``` in your ```pom.xml```.

=== "Windows"
     * Build a self contained executable jar file: ```mvn clean package```
     * Run the jar file: ```java -jar target\zoorestified.jar```
     > ```zoorestified``` is the name you provided as ```finalName``` in your ```pom.xml```.




### Compile and Test

To compile and test your produced REST service:

 * Compile your project with: ```mvn clean package```
 * Open the newly generated ```target``` folder.
 * Run the generated JAR file with: ```java -jar YOUR-SERVICE-NAME.jar```
 * Test access with your browser. You can directly access any *[GET]* resource by typing this into the URL bar:  
```http://127.0.0.1:8080/zoo/animals```  
*(where ```zoo/animals``` is replaced by a valid GET-enabled resource of your application)*

## Your Task

Now it is your turn! 

 > **WARNING!** Make sure that your screen recording is **still running**. Your entire task activity must be captured.

### Instructions

 * All you need to do is replicate the above steps for the requested app.
 * Limits:
    * You may stop whenever you deem the task successfully completed.
    * You may also stop after 90 Minutes of refactoring, whatever the state of your refactoring - You are however also allowed to continue as long as you want.
 * The target REST interface description for your task is below.
 * Please now run a
**manual** conversion of **Tic Tac Toe** into a RESTful service.
### Legacy Application Details

Below diagram highlights classes and methods of the [legacy Tic Tac Toe application](https://github.com/kartoffelquadrat/XoxInternals), relevant to your RESTification task. For more information on theses methods, also consult the [Tic Tac Toe online documentation](https://kartoffelquadrat.github.io/XoxInternals/eu/kartoffelquadrat/xoxinternals/package-summary.html).  
![xox-classes](../captures/xox-bl.png)


### Interface Description: Tic Tac Toe Resources and Methods

 * Your interface should begin with a top-level resource "*xox*", offering two methods.
    * A *[GET]* request to the "*xox*" resource should result in a lookup of all currently running games, as a list of game-identifiers.
    * A *[POST]* request to the "*xox*" resource should allow adding of a new game instance. The identifier is generated on server side and does not need to be provided, however the request body should provide all parameters required as game settings.
 * The "*xox*" resource should possess a dynamic placeholder subresource, representing individual game instances by identifier.
    * A *[GET]* request on the identifier placeholder resource should retrieve scoring information for the targeted game.
    * A *[DELETE]* request on the identifier placeholder resource should remove the game from the list of all games.
 * The dynamic resource representing games by their identifier should have two subresources: "*players*" and "*board*".
    * A *[GET]* request on the "*players*" resource should return a list of player names involved into the specified game. The game instance is in this case provided by value of the parent placeholder resource.
    * A *[GET]* request on the "*board*" resource should return a snapshot of the current game board layout, is to say which cells empty or occupied by a given player. The game instance is in this case provided by value of the parent placeholder resource.
 * The "*players*" resource should possess a dynamic placeholder resource, encoding the name of a given player. This resource has no methods, but in its turn a subresource "*actions*".
    * A *[GET]* request on actions should return an array of possible actions for a given player in a given game. Each action represents the claim of an available field. The required player  name is provided by the parent dynamic resource representing a player name and the game instance is provided by the value of the dynamic sub resource of the root resource.
 * The "*actions*" resource should possess a dynamic placeholder resource that serves to identify the a specific selection of the actions available to a given player in a given game.
    * A *[POST]* request on that dynamic placeholder resource should allow the selection of a given action, to perform it. The precise action is then identified by an int value taken by the dynamic resource, representing the position in the array of all possible actions. The required player  name is provided by the parent dynamic resource representing a player name and the game instance is provided by the value of the dynamic sub resource of the root resource.
    
 > Click <a href="../interface-xox.txt" download>here to download interface description</a> as file.
## Troubleshoot

 * **Q**: I open the project with IntelliJ, but everything is underlined in red.  
**A**: The projet was not correctly opened. Delete the cloned folder, clone the repository again, then make sure to open the project [exactly as shown](#loading-legacy-sources-into-ide).
 * **Q**: I cannot compile / run the project, the green button is greyed out.  
**A**: The project has no launch configuration by default, therefore the arrow in the top bar is not available. Open the ```RestLauncher``` class instead and click on one of the green triangles, left of the code. 
 * **Q**: I RESTified the application, but when I start it there is a Nullpointer-Exception.  
**A**: Most likely one of the classes annotated with ```@RestController``` has constructor code that still cannot access ```@Autowired``` fields. E.g. if the constructor calls a method that initializes the service state, that method might require access to an ```@Autowired``` field, but that is only available after class initialization. Do not call that method in the constructor. Tell spring to call it after class initialization, when all fields are initialized. Use the ```@PostConstruct``` annotation. See [```@PostConstruct```](#beans-and-singletons).
 * **Q:** I've made a mistake on project import, how can I start from scratch?  
Delete the cloned folder, clone the repository again, then make sure to open the project [exactly as shown](#loading-legacy-sources-into-ide).