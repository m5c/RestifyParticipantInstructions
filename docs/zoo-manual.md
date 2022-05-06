I will now illustrate the steps of a **manual** conversion to a RESTful service on the example of the Zoo.  
I will use the previously shown [Zoo REST interface description](interface-zoo.txt).

 * Please watch [this short screencast](https://www.cs.mcgill.ca/~mschie3/restifyvideos/IntelliJ-1080p.mp4) where I demonstrate and explain the required code changes.
 * Below you additionally find a recapitulation of the main steps.
 * Additionally you can conveniently inspect both versions and the changes made:
    * Switch to *Desktop Zoo* version: ```git checkout master``` or [inspect code online](https://github.com/kartoffelquadrat/Zoo/tree/master/src/main/java/eu/kartoffelquadrat/zoo).
    * Switch to *RESTified Zoo* version: ```git checkout RESTified``` or [inspect code online](https://github.com/kartoffelquadrat/Zoo/tree/RESTified/src/main/java/eu/kartoffelquadrat/zoo).
    * Compare versions: ```git diff master..RESTified``` or [inspect changes online](https://github.com/kartoffelquadrat/Zoo/commit/8fe7675b65f795897910358ed089ea2a0e22aeff).

### Project Layout Overview

### Build Configuration Changes

 > Want to see all Zoo-RESTify ```pom.xml``` changes at a glance? Run ```git diff master..RESTified pom.xml```. Green lines were added for RESTification, red lines were removed.

#### Build and Run

These instructions are to build and run from command line. While developing in IntelliJ you can safly use the "green triangle button" next to your new spring launcher class.  
![greenbutton](captures/intellij/greenbutton.png)

The first time you start your REST application you might see a warning about incoming connections. Select "*Allow*".
![firewall](captures/intellij/firewall.png)  

  * Build a self contained executable jar file: ```mvn clean package```
  * Run the jar file: ```java -jar target/zoorestified.jar```  
```zoorestified``` is the name you provided as ```finalName``` in your ```pom.xml```.

### Java Code Changes

 > Want to see all Zoo-RESTify ```java``` changes at a glance? Run ```git diff master..RESTified *java```. Green lines were added for RESTification, red lines were removed.

#### Launcher

#### Beans and Singletons

#### Resource Mapping with Annotations

### Compile / Run / Verify (possibly master template)

