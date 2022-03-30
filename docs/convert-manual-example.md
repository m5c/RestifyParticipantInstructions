## Instructions and Examples

this section... demonstrate how to manually convert... exemplified on Zoo demo code. Carefully read through instructinos, then convert the requested sample application the same way... using the provided interface description.

 * Whenever lost, you can use this command to see all changes made between the original and the RESTified version of the sample application:
```git diff master..RESTified```



Please only clone these three repositories for now, do not inspect the code yet

Next I will provide you with the basic programming skills required for task completion.

 * Your job will be the conversion of a legacy java program into a RESTful service.
 * Depending on your task description you will either do this:
    * Manually, using an IDE.
    * Semi-automated, using TouchCORE.

No worries, I will now show you everything you need to know, based on a tiny sample program.

### Welcome to the Zoo!

The Zoo is a little illustration of your upcoming tasks and tools.

 * Please **now** [clone this sample project]():  
```git clone https://github.com/kartoffelquadrat/Zoo.git```  
 * The repository aready has both versions preparedL
    * A classic java application:
       * On branch ```master```: ```git checkout master```
       * Compile it with: ```mvn clean install```
       * Start it with: ```java -jar target/zoo.jar```
    * A restful version:
       * On branch ```RESTified```: ```git checkout RESTified```
       * Compile it with: ```mvn clean package```
       * Start it with: ```java -jar target/zoo-restified.jar```

#### Project Layout

#### Project Configuration

#### Build and Run






### Maven Changes

project layout tree reminder.

All changes... ```pom.xml```

### Code Changes

#### Launcher

#### Beans and Singletons

#### Resource Mapping with Annotations

### Compile / Run / Verify
