module.exports = (req, res, next) => {
  res.sendError = (err, msg = 'Internal server error') => {
    err && console.log('[ERROR] ', err);
    console.log(msg);
    res.send({ success: false, msg });
  };
  res.sendSuccess = (data, msg) => {
    console.log(msg);
    let user = req.user;
    if(user) {
      user.password = undefined;
      delete user.password;
    }
    res.send({ success: true, msg, ...(data && { data }) });
  };
  next();
};
