/*global System*/

System.config({
    baseURL: '../',

    transpiler: 'babel',

    map: {
        'google-maps-loader': 'dist/google-maps-loader.js'
    },

    paths: {
        'google-maps': 'http://maps.googleapis.com/maps/api/js'
    },

    meta: {
        'google-maps': {
            build: false,
            loader: 'google-maps-loader'
        }
    }
});