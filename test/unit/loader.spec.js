/*global describe, it, expect*/

import google from 'google-maps';

describe('google maps', function () {
    'use strict';

    it('The google object should be available when importing "google-maps"', function () {
        expect(google).toBeDefined();
    });

    it('The google.maps object should be available when importing "google-maps"', function () {
        expect(google.maps).toBeDefined();
    });

    it('The google.maps.Map object should be available when importing "google-maps"', function () {
        expect(google.maps.Map).toBeDefined();
    });
});