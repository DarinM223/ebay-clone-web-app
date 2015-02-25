'use strict';

var getGoogleSuggestData = (function($, Promise) {

  /**
   * Parses google suggest xml and returns an array of suggestions
   * @param {string} xml the xml to parse
   * @return {Array.<string>} array of string suggestions
   */
  function parseXML(xml) {
    // TODO: implement this
    return ['hello', 'world'];
  }

  function retrieveData(q) {
    return new Promise(function(resolve, reject) {
      $.ajax({
        type: 'GET',
        url: '/eBay/suggest',
        data: {
          q: q
        }
      }).success(function(data) {
        resolve(parseXML(data));
      }).error(function() {
        reject(new Error('Error retrieving Google Suggest data'));
      });
    });
  }

  return retrieveData;
})(jQuery, Promise);