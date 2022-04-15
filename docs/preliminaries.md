# Preliminaries

## Software

Let's first check that you have all required software installed on your machine.

 > If you are not able to install the required software, you can still participate in the study. Please [contact the P.I.](mailto:maximilian.schiedermeier@mcgill.ca) to schedule access to a lab computer.

### Java

You will need Java, version ```11.0.5```. Unfortunately it has to be **exactly** this version for compatibility with TouchCORE.

 * Verify your java version with ```java -version```
 * If the output is **not exactly 11.0.5**, install it:

=== "Mac OS"
     * Download the [JDK 11.0.5 MacOS package](https://www.cs.mcgill.ca/~mschie3/1105/OpenJDK11U-jdk_x64_mac_hotspot_11.0.5_10.pkg).
     * Double click the downloaded ```.pkg``` file.
     * Follow the install instructions.

=== "Linux"
     * Download the [JDK 11.0.5 Linux package](https://www.cs.mcgill.ca/~mschie3/1105/OpenJDK11U-jdk_x64_linux_hotspot_11.0.5_10.tar.gz).
     * Extract the file: ```tar xvf *.tar.gz```
     * [Add the contained commands to your path](https://docs.oracle.com/cd/E19062-01/sun.mgmt.ctr36/819-5418/gaznb/index.html).

=== "Windows"
     * Download the JDK 11.0.5 [MSI](https://www.cs.mcgill.ca/~mschie3/1105/OpenJDK11U-jdk_x64_windows_hotspot_11.0.5_10.msi) or [ZIP](https://www.cs.mcgill.ca/~mschie3/1105/OpenJDK11U-jdk_x64_windows_hotspot_11.0.5_10.zip) installer.
     * Double click the downloaded file.
     * Follow the install instructions.

 > **After installation**, verify that **11.0.5 is now the default installed version**.  
Type again: ```java -version```, check the output.

### Maven

You will need the java build tool *Maven*.

 * Test if your system has the ```mvn``` command.
 * If missing, install it:

=== "Mac OS"
     * Unless already installed, [get the ```brew``` package manager](https://brew.sh/).
     * Install maven:  
    ```brew install maven```

=== "Linux"
     * Use the ```apt``` package manager to install maven:  
    ```sudo apt install maven```

=== "Windows"
     * Download the [graphical install wizard](https://maven.apache.org/download.cgi).
     * Double click it and follow the instructions.

### TouchCORE

You need a special TouchCORE release, built for this study. Older TouchCORE versions are not compatible.

 * Download the study release here: [TouchCORE (RESTify Study / JAR)](https://www.cs.mcgill.ca/~mschie3/TouchCORE-restify.jar)

 > You can not use an older version of TouchCORE. The required features are only contained in the above version.

 * Verify you can start it:

=== "Intel / AMD Processor"
     ```java -jar TouchCORE.jar```

=== "Apple M1 Processor"
     ```softwareupdate --install-rosetta``` (only first time)  
     ```java -jar TouchCORE.jar```

You should see this:  
![touchcore-start](captures/touchcore-start.png)

### IntelliJ

Any IDE can be used, but we strongly recommend IntelliJ. Also further instructions and guides on this page are exclusively for IntelliJ.

 * [Download and install IntelliJ](https://www.jetbrains.com/idea/download/).
    * The *community* version is sufficient.
    * If desired you can also use the *ultimate* version (registration with mcgill email required).

### Zoom

You'll need zoom, to record your task activity.

 * No worries you can stay offline, Zoom is only required to record your screen to disk.
 * Unless already installed, [install zoom](https://zoom.us/download) now.
 * Then try to record a short screencast, to test your setup:
    * Start a new meeting.  
    ![zoom1](captures/zoom1.png)
    * Click the record button.  
    ![zoom2a](captures/zoom2a.png)
    * Start to share your Desktop.  
    ![zoom2b](captures/zoom2b.png)
    * Wait some seconds.
    * End the zoom meeting

> **Verify that your *Desktop* recording to file worked. Watch your test recording now!**

## Source Code

For the upcoming two tasks you will need prepared source code to work on.  

 * Prepare a dedicated folder for your tasks, e.g. on your Desktop.
 * Clone these three repositories, but do not yet inspect their content:
    * [The Zoo](https://github.com/kartoffelquadrat/Zoo):  
```git clone https://github.com/kartoffelquadrat/Zoo.git```
    * [The Book Store](https://github.com/kartoffelquadrat/BookStoreInternals):  
```git clone https://github.com/kartoffelquadrat/BookStoreInternals.git```
    * [Tic Tac Toe](https://github.com/kartoffelquadrat/XoxInternals):  
```git clone https://github.com/kartoffelquadrat/XoxInternals.git```
 * You should now have three new directories in your study folder:
 * Finally, **for each** folder, verify you can build the code as is:
    * Open a terminal / command line in the project folder.
    * Run: ```mvn clean install```
    * Verify there are no error messages printed to screen.

## Task Illustration

In both of your tasks you will convert an existing java application to a RESTful service. This activity is also called *RESTify* or *RESTification*.  

 * At the start of each task I will provide you with the tools for this process and illustrate the requests activity on a sample application, the **Zoo**.

### The Zoo Application

The Zoo is a minimal java desktop application that offers some demo functionality, namely:

 * Looking up the Zoo's opening hours.
 * Looking up all names of Zoo animals.
 * Looking up details for a specific animal, identified by name.
 * Adding a new animal to the Zoo.

The above functionality is all provided by a singleton class: [```Zoo```](https://kartoffelquadrat.github.io/Zoo/eu/kartoffelquadrat/zoo/Zoo.html).  

 * For convenience, here is a class diagram of the ```Zoo``` class:  
![zoo](../captures/zoo-bl.png)
 * You can also inspect the [DesktopLauncher](https://github.com/kartoffelquadrat/Zoo/blob/master/src/main/java/eu/kartoffelquadrat/zoo/DesktopLauncher.java), to see how to invoke above methods.
 * Finally you can also run the provided Zoo implementation as is, to see a demo of above functionality:
    * Open a terminal in your cloned Zoo project
    * Type: ```mvn clean package exec:java```

### The Zoo REST interface description

The RESTification of an application (e.g. the Zoo) requires an interface description. An interface description tells you:

 * The expected arrangement of REST resources, and also their individual locations.
 * Which methods (```Get```, ```Put```, ```Post```, ```Delete```) are supported per resource.
 * What happens when a REST resource  method was called, and how required parameters are provided.

For example for the Zoo the interface description could look like this:  

 * Your interface should begin with a top-level resource "*zoo*", not offering any methods.
 * "*zoo*" should have two subresources, "*animals*" and "*openinghours*", both offering a *[GET]* method.
    * A *[GET]* request to *"animals"* should return the list of all animal names in the zoo.
    * A *[GET]* request to "*openinghours*" should return a description of the zoo's opening hours during the week and on weekends.
 * The "*animals*" resource should have a single **dynamic placeholder subresource** representing a specific animal, identified by name. Name it e.g. "*animalnames*". This dynamic subresource should offer a *[Get]* and a *[Put]* method.
    * A *[GET]* request to the dynamic placeholder subresource should provide details on the given animal, identified by the value of the dynamic resource (which serves as input parameter).
    * A *[PUT]* request to the dynamic placeholder subresource should allow adding a new animal to the zoo. The name of the new animal is again specified by the value of the dynamic resource, while further details on the animal are passed as request body payload.

Your task will be to formalize the provided interface description, and establish a semantic mapping on existing functionality and parameters.

 > It's a good practice to have the textual description open throughout your task. For your convenience the [Zoo description as is avaible as separate file](interface-zoo.txt) (as will be the case for the decriptions you'll work with throughout your tasks).

There are two ways to achieve this. In each task...

 * ... I'll first walk you through the required steps (using the Zoo).
 * ... then I'll ask you to convert a different application the same way.

You are now ready for [your first task](../task1)!


