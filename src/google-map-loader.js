/*global document*/

/**
 * Inject a script tag that points to the google maps file
 *
 * @param {string} src
 */
function injectScript(src) {
    let script = document.createElement('script');

    script.type = 'text/javascript';
    script.async = true;
    script.src = src;

    document.head.appendChild(script);
}

/**
 * Fetch the javascript from the given load object
 *
 * @param {Object} load
 * @returns {Promise}
 */
export function fetch(load) {
    let src = load.address;

    src += (src.indexOf('?') < 0) ? '?' : '&';
    src += 'callback=__google_maps_callback__';

    return new Promise((resolve) => {
        window['__google_maps_callback__'] = function () {
            resolve();
        };

        injectScript(src);
    }).then(() => {
        return 'module.exports = google';
    });
}