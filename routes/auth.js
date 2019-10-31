const db = require("../config/conn");
const bcrypt = require("bcryptjs");
const to = require("../utils/to");
const nodemailer = require("nodemailer");
const cryptoRandomString = require("crypto-random-string");

exports.login = async (req, res) => {
  let err, user, result;
  [err, result] = await to(
    db.query(`SELECT * FROM users WHERE username = ?`, [req.body.username])
  );
  if (err) return res.sendError(err);
  if (result.length == 0) return res.sendError(null, "User does not exist");
  user = result[0];
  //[err, result] = await to(bcrypt.compare(req.body.password, user.password));
  //if (err) return res.sendError(err);
  if (req.body.password === user.password) {
    //plain text password
    delete user.password;
    delete user.token;
    req.logIn(user, err => {
      if (err) return res.sendError(err);
      if (user.access == 1) return res.redirect("/airlinehome");
    });
  } else return res.sendError(null, "Invalid email/password combination");
};

exports.logout = (req, res) => {
  req.session.destroy(err => {
    if (err) return res.sendError(err);
    req.logout();
    return res.sendSuccess(null, "Logged Out");
  });
};

exports.forgotpassword = async (req, res) => {
  let err, result;
  [err, result] = await to(
    db.query(`SELECT * FROM users WHERE username = ?`, [req.body.username])
  );
  if (result.length == 0) return res.sendError(null, "User does not exist");

  var newtoken = cryptoRandomString({ length: 16 });
  [error, result] = await to(
    db.query(`UPDATE users SET token = ? WHERE username = ?`, [
      newtoken,
      req.body.username
    ])
  );
  if (err) return res.sendError(err);

  var transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
      user: process.env.MAILER,
      pass: process.env.MAIL_PASS
    }
  });
  var mailOptions = {
    from: process.env.MAILER,
    to: req.body.email,
    subject: "AMS Password Reset",
    // text: 'Follow the link to reset your password ',
    html:
      '<p>Click <a href="https://ams/resetpassword?token=' +
      newtoken +
      '">here</a> to reset your password</p>'
  };

  transporter.sendMail(mailOptions, function(error, info) {
    if (error) return res.sendError(error);
    else return res.sendSuccess(info.response, "Email sent");
  });
};

exports.resetpassword = async (req, res) => {
  if (req.body.password.length < 8)
    return res.sendError(null, "Password should be at least 8 characters long");
  if (req.body.password != req.body.password2)
    return res.sendError(null, "Passwords do not match");
  else {
    [error, result] = await to(
      db.query(`UPDATE users SET password = ?, token = ? WHERE token = ?`, [
        req.body.password,
        null,
        req.query.token
      ])
    );
    if (error) return res.sendError(error);
    else return res.sendSuccess(null, "Password reset successful");
  }
};
