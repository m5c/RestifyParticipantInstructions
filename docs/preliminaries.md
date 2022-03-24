# Preliminaries

## Software

Let's first check that you have all required software installed on your machine.

 > If you are not able to install the required software, you can still participate in the study. Please [contact the P.I.](mailto:maximilian.schiedermeier@mcgill.ca) to schedule access to a lab computer.

### Java

You need Java, version ```11.0.5```. Unfortunately it has to be exactly this version for compatibility with TouchCORE.

 > TODO: verify! Test TouchCORE with other versions.

 * Verify your java version with ```java -version```
 * Install java ```11.0.5``` if your version differs. INSTRUCTIONS HERE.
   * Verify the version again after installation.

### Maven

You need the build tool maven.

 * Verify that your system has the command: ```mvn```  
 If not found, install it:
     * [Mac](https://brew.sh/): ```brew install maven```
     * [Linux](https://linux.die.net/man/8/apt-get): ```sudo apt install maven```
     * [Windows](https://maven.apache.org/download.cgi): *follow the UI wizard*

### TouchCORE

You need a special TouchCORE release, built for this study. Older TouchCORE versions are not compatible.

 * Download the study release here: [UPDATE LINK HERE](...)
  * Verify you can start it with: ```java -jar TouchCORE.jar```

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

## Skills

Next I will provide you with the basic programming skills required for task completion.

 * Your job will be the conversion of a legacy java program into a RESTful service.
 * Depending on your task description you will either do this:
    * Manually, using an IDE.
    * Semi-automated, using TouchCORE.

No worries, I will now show you everything you need to know, based on a tiny sample program.

### Welcome to the Zoo!

The Zoo is a little illustration of your upcoming tasks and tools.

 * Please **now** [clone this sample project](https://github.com/kartoffelquadrat/Zoo):  
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

In the remainder of this section, I'll show you on the example of the Zoo how a legacy java program can be turned into a RESTful service.

 * Manually, using an IDE.
 * Semi-automated, using TouchCORE.

  > That's right, I'll show you exaclty what awaits you in your upcoming tasks and how to solve them! Bear with me :)        

### Manual Conversion
 * Whenever lost, you can use this command to see all changes made between the original and the RESTified version of the sample application:  
```git diff master..RESTified```





### Maven

#### Project Layout

#### Project Configuration

#### Changing for Spring Boot

#### Build / Run

### Spring Boot

#### Launcher

#### Beans and Singletons

#### Resource Mapping with Annotations

### Semi-Automated Conversion

