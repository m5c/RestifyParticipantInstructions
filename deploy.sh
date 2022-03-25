rm site.zip
zip -r site.zip site
scp site.zip mschie3@132.206.51.22:/home/2019/mschie3/public_html
ssh mschie3@132.206.51.22 "cd public_html; rm -rf restify-study; unzip -o site.zip; mv site restify-study"
echo uploaded and access granted - location:
open https://www.cs.mcgill.ca/~mschie3/restify-study/
