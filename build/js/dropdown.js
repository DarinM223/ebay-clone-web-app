'use strict';

/**
 * Represents a dropdown control that autocompletes based on a event function
 * @param {function(string, callback)} getData function call to retrieve dropdown data
 * @constructor
 */
function DropdownControl(textbox, getData) {
  this.layer = null; // dropdown box DOM element
  this.textbox = textbox; // text box DOM element
  this.getData = getData;
  this._init();
  this.highlightedNodeIndex = -1;
}

(function(document) {

  DropdownControl.prototype._initDropdown = function() {
    this.layer = document.createElement('div');
    this.layer.className = 'suggestions';
    this.layer.style.visibility = 'hidden';
    this.layer.style.width = this.textbox.offsetWidth;
    document.body.appendChild(this.layer);
  };

  DropdownControl.prototype.moveHighlight = function(direction) {
    if (this.highlightedNodeIndex !== -1) { // if there is an already selected highlight deselect it
      this.layer.childNodes[this.highlightedNodeIndex].className = '';
    } else {
      return;
    }

    var newIndex = this.highlightedNodeIndex + direction;

    if (newIndex < 0) 
      newIndex = 0;
    else if (newIndex >= this.layer.childNodes.length) 
      newIndex = this.layer.childNodes.length - 1;

    this.highlightedNodeIndex = newIndex;
    this.layer.childNodes[this.highlightedNodeIndex].className = 'current';
  };

  DropdownControl.prototype.completeTextFromHighlight = function() {
    if (this.highlightedNodeIndex === -1) return;

    var completeText = this.layer.childNodes[this.highlightedNodeIndex].childNodes[0].nodeValue;
    this.textbox.value = completeText;
    this.toggleDropdown(false);
  };

  DropdownControl.prototype._initTextbox = function() {
    var that = this;

    this.textbox.onkeydown = function(e) {
      if (!e) {
        e = window.event;
      }

      switch (e.keyCode) {
        case 13: // enter key
          that.completeTextFromHighlight();
          break;
        case 38: // up key
          that.moveHighlight(-1);
          break;
        case 40: // down key
          that.moveHighlight(1);
          break;
      }
    };

    this.textbox.onkeyup = function(e) {
      if (e.keyCode !== 38 && e.keyCode !== 40 && e.keyCode !== 13) {
        if (that.textbox.value.length === 0 || !that.textbox.value.trim()) {
          that.toggleDropdown(false);
        } else {
          // send ajax request to retrieve suggestions then set the dropdown to the suggestions
          that.getData(that.textbox.value, function(err, suggestions) {
            if (err) {
              console.log(err);
              that.setDropdownList(['test1', 'test2', 'test3']);
              that.toggleDropdown(true);
              return;
            }

            that.setDropdownList(suggestions);
            that.toggleDropdown(true);
          });
        }
      }
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

    node.onmouseover = function() {
      if (that.highlightedNodeIndex !== -1) { // if there is already a highlighted item, remove the highlight
        that.layer.childNodes[that.highlightedNodeIndex].className = '';
      }

      node.className = 'current';
      that.highlightedNodeIndex = index; // set the highlighted node index the current node index
    };

    node.onclick = function() {
      if (that.highlightedNodeIndex !== -1) { // if there is already a highlighted item, remove the highlight
        that.layer.childNodes[that.highlightedNodeIndex].className = '';
      }

      node.className = 'current';
      that.highlightedNodeIndex = index; // set the highlighted node index the current node index
      that.completeTextFromHighlight();
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
      this.createSuggestionNode(suggestions[i], i);
    }

    // highlight the first child
    if (this.layer.firstChild) {
      this.layer.firstChild.className = 'current';
      this.highlightedNodeIndex = 0;
    } else {
      this.highlightedNodeIndex = -1;
    }
  };

})(document);
