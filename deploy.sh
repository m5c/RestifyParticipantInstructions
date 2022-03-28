#!/bin/bash
# rest study deploy script
# M.Schiedermeier, 2022

# Patches the css in docs folder for a given colour
function build
{
	# patch css colour
        cp extra-$COLOUR.css docs/stylesheets/extra.css

	# adapt section order

	# build locally
	mkdocs build
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
