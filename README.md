# RESTify Study Docs

Sources for experiment instructions

## Usage

 * Start server: ```mkdocs serve```
 * Access docs: [http://127.0.0.1:8000/~mschie3/restify](http://127.0.0.1:8000/~mschie3/restify)

## Internals

Deploy script iterates over colours and for each:

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
