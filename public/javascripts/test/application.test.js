var shouldCompileTo = function(string, hash, result, message) {
  var template = Handlebars.compile(string);
  var params = Object.prototype.toString.call(hash) === "[object Array]" ? hash : [hash, undefined];
  equal(template.apply(this, params), result, message);
}

var shouldThrow = function(fn, exception, message) {
  var caught = false;
  try {
    fn();
  }
  catch (e) {
    if (e instanceof exception) {
      caught = true;
    }
  }

  ok(caught, message || null);
}


module("
