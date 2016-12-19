This repo have six files:
  * d3js-converter.py (This script is responsible of the generation of the json file from the datasheet).

Web files
---------
* celegans-hierarchy.html (the rendering of the DataViz)
* style.css (Style of celegans-hierarchy.html)
* d3.js (Module of D3JS - www.d3js.org)
* d3_002.js (Module of D3JS - www.d3js.org)
* celegans.json (json file is used for celegans-hierarchy.html to generate the DataViz, thanks to D3JS).
    
Running the code
----------------
* Because of [browser restrictions on loading JSON locally](https://github.com/mrdoob/three.js/wiki/How-to-run-things-locally), the DataViz only works if is executed from a web server or for tests in the localhost. (With XAMPP, LAMPP...others)
* <pre>python -m SimpleHTTPServer</pre> run from within the directory is a good way to run this 
* Then you can navigate to http://localhost:8000 to see the content
