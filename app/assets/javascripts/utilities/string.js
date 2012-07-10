String.prototype.isEmpty = function() {
  return (!this || 0 === this.length);
};
String.prototype.isBlank = function() {
  return (!this || /^\s*$/.test(this));
};
String.prototype.isNotSpecified = function() {
  return (/not specified/i.test(this));
};