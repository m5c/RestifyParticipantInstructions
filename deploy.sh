#!/bin/bash
# rest study deploy script
# M.Schiedermeier, 2022

# | Group / Task | Red | Green | Yellow | Blue |
# |---|---|---|---|---|
# | First | App: BookStore, Tool: TouchCORE | App: BookStore, Tool: Manual | App: TicTacToe, Tool: TouchCORE | App: TicTacToe, Tool: Manual |
# | Second | App: TicTacToe, Tool: Manual | App: TicTacToe, Tool: TouchCORE | App: BookStore, Tool: Manually | App: BookStore, Tool: TouchCORE |

# Patches the css in docs folder for a given colour
function build
{
	# patch css colour
        cp extra-$COLOUR.css docs/stylesheets/extra.css

	# adapt section order
        patchTask

	# build locally
	mkdocs build
}

# Patches the task page contents (task1/2) and task descriptions on landing page (index)
function patchTask
{
        # copy template file into place, to erase all traces of previous colours.
	cp docs/index-template.md docs/index.md

        # Change task description in index file, depending on colour
	case $COLOUR in

	  red )
            TASK1='App: BookStore, Tool: TouchCORE'
            TASK1VERBOSE=' **TouchCORE assisted** conversion of the **Book Store** into a RESTful service.'
            TASK2='App: TicTacToe, Tool: Manual'
            TASK2VERBOSE=' **manual** conversion of the **Tic Tac Toe** into a RESTful service.'
	    METHOD1=touchcore
	    METHOD2=manual
            APP1=bookstore
            APP2=xox
	    echo "red matched"
	    ;;

	  green )
            TASK1='App: BookStore, Tool: Manual'
            TASK1VERBOSE=' **manual** conversion of the **Book Store** into a RESTful service.'
            TASK2='App: TicTacToe, Tool: TouchCORE'
            TASK2VERBOSE=' **TouchCORE assisted** conversion of **Tic Tac Toe** into a RESTful service.'
	    METHOD1=manual
	    METHOD2=touchcore
            APP1=bookstore
            APP2=xox
	    echo "green matched"
	    ;;

	  blue )
            TASK1='App: TicTacToe, Tool: TouchCORE'
            TASK1VERBOSE=' **TouchCORE assisted** conversion of **Tic Tac Toe** into a RESTful service.'
            TASK2='App: BookStore, Tool: Manual'
            TASK2VERBOSE=' **manual** conversion of the **BookStore** into a RESTful service.'
	    METHOD1=touchcore
	    METHOD2=manual
            APP1=xox
            APP2=bookstore
	    echo "blue matched"
	    ;;

	  yellow )
            TASK1='App: TicTacToe, Tool: Manual'
            TASK1VERBOSE=' **manual** conversion of **Tic Tac Toe** into a RESTful service.'
            TASK2='App: BookStore, Tool: TouchCORE'
            TASK2VERBOSE=' **TouchCORE assisted** conversion of the **Book Store** into a RESTful service.'
	    METHOD1=manual
	    METHOD2=touchcore
            APP1=xox
            APP2=bookstore
	    echo "yellow matched"
	    ;;

	  *)
	    echo "Invalid Colour: $COLOUR"
	    ;;
	esac


	# actualy modify content:
        cat docs/preliminaries-start.md > docs/preliminaries.md
        cat docs/interface-zoo.txt >> docs/preliminaries.md
        cat docs/preliminaries-end.md >> docs/preliminaries.md

	# prepare task descriptions contents, based on group colour
	# task 1 markdown
	echo '# Task 1' > docs/task1.md
        echo -n 'Your **first** task is the ' >> docs/task1.md
        echo $TASK1VERBOSE >> docs/task1.md
        cat docs/task-preamble.md >> docs/task1.md
        cat docs/zoo-$METHOD1.md >> docs/task1.md
        cat docs/task-description.md >> docs/task1.md
        echo $TASK1VERBOSE >> docs/task1.md
        cat docs/diagram-$APP1.md >> docs/task1.md
        cat docs/interface-$APP1.txt >> docs/task1.md
        echo "" >> docs/task1.md
	echo " > Click <a href=\"../interface-$APP1.txt\" download>here to download interface description</a> as file". >> docs/task1.md
        # troubleshoot appendix task 1
        cat docs/troubleshoot-$METHOD1.md >> docs/task1.md

	# task 2 markdown
	echo '# Task 2' > docs/task2.md
        echo -n 'Your **second** task is the ' >> docs/task2.md
        echo $TASK2VERBOSE >> docs/task2.md
        cat docs/task-preamble.md >> docs/task2.md
        cat docs/zoo-$METHOD2.md >> docs/task2.md
        cat docs/task-description.md >> docs/task2.md
        echo $TASK2VERBOSE >> docs/task2.md
        cat docs/diagram-$APP2.md >> docs/task2.md
        cat docs/interface-$APP2.txt >> docs/task2.md
        echo "" >> docs/task2.md
	echo " > Click <a href=\"../interface-$APP2.txt\" download>here to download interface description</a> as file". >> docs/task2.md
        # troubleshoot appendix task 2
        cat docs/troubleshoot-$METHOD2.md >> docs/task2.md

}

# deploys one colour group on server
function deploy
{

	# zip and push to server, unzip there
	rm site.zip
	zip -r site.zip site

	# push to mcgill
	scp site.zip mschie3@132.206.51.22:/home/2019/mschie3/public_html
	ssh mschie3@132.206.51.22 "cd public_html; rm -rf $COLOUR; mkdir -p $COLOUR; unzip -o site.zip; mv site $COLOUR/restify-study"

        # push to KQ
	scp -P 28518 site.zip root@85.214.243.137:/home/tomcat/webservices/webapps/ROOT/mirror
	ssh -p 28518 root@85.214.243.137 "cd /home/tomcat/webservices/webapps/ROOT/mirror; rm -rf $COLOUR; mkdir -p $COLOUR; unzip -o site.zip; mv site $COLOUR/restify-study; cd /; chown -R tomcat /home/tomcat/webservices/webapps/ROOT/mirror; chmod -R a+rx /home/tomcat/webservices/webapps/ROOT/mirror"
}

# Main logic. Build and deploy all colour-groups.
COLOURS=('red' 'green' 'blue' 'yellow')
for COLOUR in "${COLOURS[@]}"; do
    build
    deploy
done

# Update browser tabs and link location
echo "Uploaded and access granted - locations:"
echo http://127.0.0.1:8000/~mschie3/restify/
for COLOUR in "${COLOURS[@]}"; do
        LOCATION=https://www.cs.mcgill.ca/~mschie3/$COLOUR/restify-study/
        echo -e ' \t '-$COLOUR: ' \t '$LOCATION
        open $LOCATION
done
