## Troubleshoot

 * **Q**: I can't start TouchCORE. Nothing happens when I double-click the JAR.  
**A**: Start by double click is unfortunately not supported. Instead open a terminal in the unzipped TouchCORE folder, then type: ```java -jar TouchCORE.jar```
 * **Q**: TouchCORE crashes with an exception, right after start.  
**A**: Most likely you are [not using a compatible Java version](../preliminaries/#java). Run ```java -version``` and verify the output is ```11.0.5```.
 * **Q**: I can't resize the TouchCORE window.  
**A**: The window can not be resized while TouchCORE is running, but if your screen is big enough, you can change the resolution in the file ```Settings.txt```, next to the ```TouchCORE.jar``` file.
 * **Q**: Nothing happens when I click elements in TouchCORE.  
**A**: TouchCORE was developed for touch screens, therefore some elements require time gestures, e.g. *Tap-and-Hold*. Try a long click on the element.
 * **Q**: I cannot scroll around.  
**A**: Click with the right mouse button, while moving the mouse to scroll.
 * **Q**: I cannot zoom.  
**A**: Use the mouse wheel or a two-finger drag up or down on your touchpad to zoom in or out.
 * **Q**: I can not find how to open the prepared models.  
**A**: By default TouchCORE shows only models that are in the same location as where the software was launched. Use the *upward arrow* in the top left corner of the TouchCORE file-explorer to navigate to a different folder on your file-system.
 * **Q**: TouchCORE says it generated code, but I do not find the output folder.  
**A**: The java code is always generated inside the model project. Locate the folder with the original models, inside you will find a folder named *generated-maven-project*.
 * **Q**: The code is generated, but when I compile it with Maven, it complains about the bookstore/xox-internals not found. What went wrong?  
**A**: The generated sources use the legacy sources as library. Maven needs to know about the legacy sources , therefore you need to compile the *original* sources at least once with: ```mvn clean install```.