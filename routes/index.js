const router = require("express").Router();
const db = require("../config/conn");
const to = require("../utils/to");
const validator = require("../utils/validator");

const auth = require("./auth");
const apadmin = require("./airportadmin");
const airlineAdmin = require("./airlineadmin");
const authSchema = require("../schemas/auth");
const apadminSchema = require("../schemas/airportadmin");
const airlineAdminSchema = require("../schemas/airlineadmin");

const redirectIfLoggedIn = (req, res, next) => {
  if (req.isAuthenticated()) return res.redirect("/home");
  return next();
};
const authenticate = (req, res, next) => {
  if (req.isAuthenticated()) return next();
  else return res.sendError(null, "Login First!");
};
const access = level => (req, res, next) => {
  if (req.user && req.user.access >= level) return next();
  return res.sendError(null, "Unauthorized access");
};

router.get("/home", async (req, res) => {
  //test route
  res.send("WORKING");
});

//auth routes
router.post(
  "/login",
  redirectIfLoggedIn,
  validator(authSchema.login),
  auth.login
);
router.get("/logout", auth.logout);
router.post(
  "/forgotpassword",
  redirectIfLoggedIn,
  validator(authSchema.forgotPassword),
  auth.forgotpassword
);
router.post(
  "/resetpassword",
  redirectIfLoggedIn,
  validator(authSchema.resetPassword),
  auth.resetpassword
);

//airline admin routes
router.post(
  "/admin/addbooking",
  authenticate,
  access(1),
  validator(airlineAdminSchema.addBooking),
  airlineAdmin.addBooking
);

//airport admin routes
router.post(
  "/apadmin/addairline",
  authenticate,
  access(2),
  validator(apadminSchema.addAirline),
  apadmin.addAirline
);

module.exports = router;
