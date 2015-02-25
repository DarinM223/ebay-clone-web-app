'use strict';

/**
 * Represents a dropdown control that uses Google suggest for autocompletion
 * @constructor
 */
function DropdownControl(textbox) {
  this.layer = null; // dropdown box DOM element
  this.textbox = textbox; // text box DOM element
  this._init();
  this.highlightedNodeIndex = -1;
}

(function($, document) {

  /**
   * Parses google suggest xml and returns an array of suggestions
   * @param {string} xml the xml to parse
   * @return {Array.<string>} array of string suggestions
   */
  function parseXML(xml) {
    // TODO: implement this
  }

  DropdownControl.prototype._initDropdown = function() {
    this.layer = document.createElement('div');
    this.layer.className = 'suggestions';
    this.layer.style.visibility = 'hidden';
    this.layer.style.width = this.textbox.offsetWidth;
    document.body.appendChild(this.layer);
  };

  DropdownControl.prototype._initTextbox = function() {
    var that = this;

    this.textbox.onkeyup = function() {
      // send ajax request to retrieve suggestions then set the dropdown to the suggestions
      $.ajax({
        type: 'GET',
        url: '/suggest',
        data: {
          q: that.textbox.value
        }
      }).success(function(data) {
        var suggestions = parseXML(data);

        that.setDropdownList(suggestions);
        that.toggleDropdown(true); // enable dropdown
      }).error(function() {
        console.log('Error retrieving suggestion data from server!');
        that.setDropdownList(['hello', 'world', 'foo']);
        that.toggleDropdown(true);
      });
    };
  };

  DropdownControl.prototype._init = function() {
    this._initDropdown();
    this._initTextbox();
  };

  /**
   * Sets a range of selected text in the text box
   * @param {integer} start the character index to start at
   * @param {length} the length of selected text
   */
  DropdownControl.prototype._selectRange = function(start, length) {
    if (this.textbox.createTextRange) {
      var range = this.textbox.createTextRange();
      range.moveStart('character', start);
      range.moveEnd('character', length - this.textbox.value.length);
      range.select();
    } else if (this.textbox.setSelectionRange) {
      this.textbox.setSelectionRange(start, length);
    }

    this.textbox.focus();
  };

  /**
   * Sets the visiblity of the dropdown
   * @param {boolean} enabled if true, then dropdown is set to visible, if false, dropdown is set to hidden
   */
  DropdownControl.prototype.toggleDropdown = function(enabled) {
    if (enabled === true) {
      this.layer.style.visibility = 'visible';
    } else if (enabled === false) {
      this.layer.style.visibility = 'hidden';
    } else {
      // if enabled is not specified, then toggle between visible and hidden
      if (this.layer.style.visibility === 'hidden') {
        this.layer.style.visibility = 'visible';
      } else if (this.layer.style.visibility === 'visible') {
        this.layer.style.visiblity = 'hidden';
      } else {
        this.layer.style.visibility = 'hidden';
      }
    }
  };

  /**
   * Creates a new suggestion node that highlights itself when clicked and sets text autocomplete
   * @param {string} text the text of the node
   */
  DropdownControl.prototype.createSuggestionNode = function(text, index) {
    var that = this;

    var node = document.createElement('div');

    var textNode = document.createTextNode(text);

    node.appendChild(textNode);

    node.onclick = function() {
      if (that.highlightedNodeIndex !== -1) { // if there is already a highlighted item, remove the highlight
        console.log('There is an already hightlighted node!');
        that.layer.childNodes[that.highlightedNodeIndex].className = '';
      }

      node.className = 'current';
      console.log(index);
      that.highlightedNodeIndex = index; // set the highlighted node index the current node index
    };

    this.layer.appendChild(node);
  };

  /**
   * Sets the dropdown suggestion list
   * @param {Array.<string>} suggestions a list of string suggestions to populate the dropdown list
   */
  DropdownControl.prototype.setDropdownList = function(suggestions) {
    // if there are existing nodes, clear them
    if (this.layer.childNodes.length > 0) {
      while (this.layer.firstChild) {
        this.layer.removeChild(this.layer.firstChild);
      }
    }
    // push new nodes
    for (var i = 0; i < suggestions.length; i++) {
      console.log(suggestions[i]);
      this.createSuggestionNode(suggestions[i], i);
    }

    // highlight the first child
    if (this.layer.firstChild) {
      this.layer.firstChild.className = 'current';
      this.highlightedNodeIndex = 0;
    }
  };

})(jQuery, document);