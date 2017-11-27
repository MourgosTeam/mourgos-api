
function checkUser(req, res) {
  if (!req.sessionUser) {
    res.status(403);
    res.send('You shall not pass');

return false;
  }

return true;
}

export default { checkUser };