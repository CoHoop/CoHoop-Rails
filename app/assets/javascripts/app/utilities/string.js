/**
 * Public: checks if a string is empty
 *
 * Returns a Boolean.
 */
String.prototype.isEmpty = function() {
  return (!this || 0 === this.length);
};

/**
 * Public: checks if a string is blank
 *
 * Returns a Boolean.
 */
String.prototype.isBlank = function() {
  return (!this || /^\s*$/.test(this));
};

/**
 * Public: checks if a string contains "not specified"
 *
 * Returns a Boolean.
 */
String.prototype.isNotSpecified = function() {
  return (/not specified/i.test(this));
};
