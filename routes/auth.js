const db = require("../config/conn");
const bcrypt = require("bcryptjs");
const to = require("../utils/to");
//const validator = require("../utils/validator");
const nodemailer = require("nodemailer");
const cryptoRandomString = require("crypto-random-string");

exports.login = async (req, res) => {
  let err, user, result;
  [err, result] = await to(
    db.query(`SELECT * FROM users WHERE email = ?`, [req.body.email])
  );
  if (err) return res.sendError(err);
  if (result.length == 0) return res.sendError(null, "User does not exist");
  user = result[0];
  [err, result] = await to(bcrypt.compare(req.body.password, user.password));
  if (err) return res.sendError(err);
  if (!result) return res.sendError(null, "Invalid email/password combination");
  delete user.password;
  delete user.token;
  req.logIn(user, err => {
    if (err) return res.sendError(err);
    return res.sendSuccess(user.access, "Login Successful!");
  });
};

exports.logout = (req, res) => {
  req.session.destroy(err => {
    if (err) return res.sendError(err);
    req.logout();
    return res.sendSuccess(null, { access: 0 });
  });
};
