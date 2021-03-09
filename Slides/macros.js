remark.macros['scale'] = function(w) {
  var url = this;
  return '<img src="' + url + '" style="width: ' + w + '" />';
};

remark.macros['class'] = function(cl) {
  var url = this;
  return '<img src="' + url + '" class="' + cl + '" />';
};

remark.macros['gen'] = function(w, cl="") {
  var url = this;
  return '<img src="' + url + '" style="width: ' + w + '" class="' + cl + '" />';
};