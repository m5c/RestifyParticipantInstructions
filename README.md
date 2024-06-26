# RESTify Study Docs

Sources for experiment instructions. The markdown sources compile to four websites, one for each experiment group.

## Usage

### Official Deployment

Original versions of the participant instructions, as used by each of the four experiment groups are accessible here:

 * [Red](https://www.cs.mcgill.ca/~mschie3/red/restify-study/)
 * [Green](https://www.cs.mcgill.ca/~mschie3/green/restify-study/)
 * [Blue](https://www.cs.mcgill.ca/~mschie3/blue/restify-study/)
 * [Yellow](https://www.cs.mcgill.ca/~mschie3/yellow/restify-study/)

### Local deployment (single group)

 * Start server: ```mkdocs serve```
 * Access docs: [http://127.0.0.1:8000/~mschie3/restify/red](http://127.0.0.1:8000/~mschie3/restify/red)

## Build and Deploy

The `deploy.sh` script iterates over colours and for each:

 * Places colour specific css themes to ```docs/stylesheets/extra.css```
 * Overrides task order in ```index.md```
 * Overrides ```task1.md``` / ```task2.md``` content.
   * pipes heading + disclaimer into new task1/2.md file.
   * Appends task1/2.md file by zoo example for corresponding task, using:
     * docs/convert-manual-example.md
     * docs/convert-touchcore-example.md
     * zoo IF description ?
   * Appends task1/2.md file by pointer to target app + disclaimer + app IF descr.
 * Builds
 * Deploys to server

  > You can also use the deploy script to generate local static snapshots. The script produces four local websites site-red, site-green, site-blue, site-yellow.

## Other

 * Theme adjustments:
   * [Logo](logo.graffle): ```docs/assets/logo.png```
   * McGill Red: ```docs/stylesheets/extra.css```  
```css
[data-md-color-scheme="mcgill"] {
  --md-primary-fg-color:        #ed1b2f;
  --md-code-hl-number-color:    #ed1b2f;
  --md-accent-fg-color:         #ed1b2f;
  --md-primary-fg-color--light: #ed1b2f;
  --md-primary-fg-color--dark:  #ed1b2f;
}
```

## License

This software is under open source [MIT License](LICENSE.txt).

## Author

Maximilian Schiedermeier: [https://github.com/m5c](https://github.com/m5c)
