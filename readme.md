# Google maps loader for Systemjs

## Introduction

When importing an es2015 module the following steps (hooks) are done to get the code:

- Normalize the module name
- Locate, get the url of the file name to load
- Fetch, load the file
- Translate, make any source modifications.
- Instantiate, determine its dependencies, and how to execute it.

Each step/hook can either return a result directly, or a promise for the result.


## Module loader config

The use of a custom loader can be done in two ways:

- When configuring systemjs.
    ```
    System.config({
      // locate the plugin via map configuration
      // (alternatively have it in the baseURL)
      map: {
        text: '/path/to/text-plugin.js'
      },
      // use meta configuration to reference which modules
      // should use the plugin loader
      meta: {
        'templates/*.html': {
          loader: 'text'
        }
      }
    });
    ```
- When importing a module
    `System.import('some/file.txt!text')`, the exclamation mark separates the url of the module and the loader.


## Google maps

The script `http://maps.googleapis.com/maps/api/js?v=3.exp&sensor=true&language=nl` does not provide the javascript directly, it creates a couple of script tags.
When these scripts are loaded Google Maps is ready to use, the object google.maps will be available to use.
As a URL get parameter a javascript function name can be given, it will be called when Google Maps is ready to use.
`callback=onMapsReady`

To create a loader for systemjs, we have to hook into the fetch step. Because when we fetch the url and the script is loaded, the dynamicly created script tags are not loaded. A promise must be returned that will resolve when the callback function is called by the google maps script.


```
System.config({
    baseURL: '../',

    transpiler: 'babel',

    map: {
        'google-maps-loader': 'dist/google-map-loader.js'
    },

    paths: {
        'google-maps': 'http://maps.googleapis.com/maps/api/js?v=3.exp&sensor=true&language=nl'
    },

    meta: {
        'google-maps': {
            build: false,
            loader: 'google-maps-loader'
        }
    }
});
```


```
import google from 'google-maps';

new google.maps.Map(document.getElementById('map'), {
    center: {lat: -34.397, lng: 150.644},
    zoom: 8
});
```
