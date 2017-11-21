function createError(msg, input, extra) {
	var error = {};
	error.msg = msg;
	if(input) error.input = input;
	if(extra) error.extra = extra;
	return error;
}

module.exports = {
	createError : createError
}