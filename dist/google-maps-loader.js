System.register([], function (_export) {
    /*global window,document*/

    /**
     * Inject a script tag that points to the google maps file
     *
     * @param {string} src
     */
    'use strict';

    _export('fetch', fetch);

    /**
     * Fetch the javascript from the given load object
     *
     * @param {Object} load
     * @returns {Promise}
     */
    function injectScript(src) {
        var script = document.createElement('script');

        script.type = 'text/javascript';
        script.async = true;
        script.src = src;

        document.head.appendChild(script);
    }
    function fetch(load) {
        var callbackName = '__google_maps_callback__',
            src = load.address;

        src += src.indexOf('?') < 0 ? '?' : '&';
        src += 'callback=' + callbackName;

        return new Promise(function (resolve) {
            window[callbackName] = function () {
                resolve();
            };

            injectScript(src);
        }).then(function () {
            return 'module.exports = google';
        });
    }

    return {
        setters: [],
        execute: function () {}
    };
});