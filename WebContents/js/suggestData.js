'use strict';

var getGoogleSuggestData = (function() {

  /**
   * Parses google suggest xml and returns an array of suggestions
   * @param {DOMNode} xml the xml to parse
   * @return {Array.<string>} array of string suggestions
   */
  function parseXML(xml) {
    // TODO: implement this
    if (xml === null) return [];
    var elements = xml.getElementsByTagName('suggestion');
    var result = [];
    for (var i = 0; i < elements.length; i++) {
      var attr = elements[i].getAttribute('data');
      if (attr) {
        result.push(attr);
      }
    }
    return result;
  }

  function retrieveData(q, callback) {
    var xmlhttp = new XMLHttpRequest();

    console.log('/eBay/suggest?q=' + encodeURIComponent(q));
    xmlhttp.open('GET', '/eBay/suggest?q=' + encodeURIComponent(q), true);

    xmlhttp.onload = function(e) {
      if (xmlhttp.readyState === 4) {
        if (xmlhttp.status === 200) {     
          callback(null, parseXML(xmlhttp.responseXML));
        } else {
          callback(new Error('Error retrieving Google Suggest data'));
        }
      }
    };

    xmlhttp.onerror = function(e) {
      callback(new Error(xmlhttp.statusText));
    };

    xmlhttp.send();
  }

  return retrieveData;
})();