'use strict';

function AutoSuggestControl(oTextbox, oProvider) {
	this.layer = null; // stores the div
	this.provider = oProvider;
	this.textbox = oTextbox;
	this.init();
}

AutoSuggestControl.prototype.init = function() {

};

AutoSuggestControl.prototype.hideSuggestions = function() {
	this.layer.style.visibility = 'hidden';
};

AutoSuggestControl.prototype.highlightSuggestion = function(node) {
	for (var i = 0; i < this.layer.childNodes.length; i++) {
		var n = this.layer.childNodes[i];
		if (n == node) {
			n.className = 'current';
		} else if (n.className == 'current') {
			n.className = "";
		}
	}
};

AutoSuggestControl.prototype.createDropdown = function() {
	this.layer = document.createElement('div');
	this.layer.className = 'suggestions';
	this.layer.style.visibility = 'hidden';
	this.layer.style.width = this.textbox.offsetWidth;
	document.body.appendChild(this.layer);
};