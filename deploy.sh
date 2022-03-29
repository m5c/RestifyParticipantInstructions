#!/bin/bash
# rest study deploy script
# M.Schiedermeier, 2022
set -x

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
            TASK2='App: TicTacToe, Tool: Manual'
	    echo "red matched"
	    ;;

	  green )
            TASK1='App: BookStore, Tool: Manual'
            TASK2='App: TicTacToe, Tool: TouchCORE'
	    echo "green matched"
	    ;;

	  blue )
            TASK1='App: TicTacToe, Tool: TouchCORE'
            TASK2='App: BookStore, Tool: Manual'
	    echo "blue matched"
	    ;;

	  yellow )
            TASK1='App: TicTacToe, Tool: Manual'
            TASK2='App: BookStore, Tool: TouchCORE'
	    echo "yellow matched"
	    ;;

	  *)
	    echo "Invalid Colour: $COLOUR"
	    ;;
	esac


	# actualy modify content:
	echo "Patching task order for $COLOUR"
        sed -i '' "s/TASK1/$TASK1/g" docs/index.md
        sed -i '' "s/TASK2/$TASK2/g" docs/index.md
	
}

# deploys one colour group on server
function deploy
{

	# zip and push to server, unzip there
	rm site.zip
	zip -r site.zip site
	scp site.zip mschie3@132.206.51.22:/home/2019/mschie3/public_html
	ssh mschie3@132.206.51.22 "cd public_html; rm -rf $COLOUR; mkdir -p $COLOUR; unzip -o site.zip; mv site $COLOUR/restify-study"
}

# Main logic. Build and deploy all colour-groups.
COLOURS=('red' 'green' 'blue' 'yellow')
for COLOUR in "${COLOURS[@]}"; do
    build
    deploy
done

# Update browser tabs and link location
echo "Uploaded and access granted - locations:"
for COLOUR in "${COLOURS[@]}"; do
        LOCATION=https://www.cs.mcgill.ca/~mschie3/$COLOUR/restify-study/
        echo -e ' \t '-$COLOUR: ' \t '$LOCATION
        open $LOCATION
done
