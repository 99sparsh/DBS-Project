const router = require("express").Router();
const db = require("../config/conn");
const to = require("../utils/to");
const validator = require("../utils/validator");

const frontend = require("./frontend");
const auth = require("./auth");
const apadmin = require("./airportadmin");
const airlineAdmin = require("./airlineadmin");
const authSchema = require("../schemas/auth");
const apadminSchema = require("../schemas/airportadmin");
const airlineAdminSchema = require("../schemas/airlineadmin");

const redirectIfLoggedIn = (req, res, next) => {
  if (req.isAuthenticated()) {
    if (req.user.access == 1) return res.redirect("/airlinehome");
  }
  return next();
};
const authenticate = (req, res, next) => {
  if (req.isAuthenticated()) return next();
  else return res.redirect("/");
};
const access = level => (req, res, next) => {
  if (req.user && req.user.access >= level) return next();
  return res.sendError(null, "Unauthorized access");
};

router.get("/", redirectIfLoggedIn, frontend.index);

const checkAirline = (req, res, next) => {
  if (req.user.airline_id == req.body.airline_id) return next();
  return res.sendError(null, "You can only modify own airline");
};

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

router.post(
  "/admin/cancelbooking",
  authenticate,
  access(1),
  validator(airlineAdminSchema.cancelBooking),
  airlineAdmin.cancelBooking
);

router.get(
  "/admin/showschedule",
  authenticate,
  access(1),
  airlineAdmin.showScheduleToBook
);

router.post(
  "/admin/addcabincrew",
  authenticate,
  access(1),
  checkAirline,
  airlineAdmin.addCabincrew
);

router.post(
  "/admin/addpilot",
  authenticate,
  access(1),
  checkAirline,
  airlineAdmin.addPilot
);

router.post(
  "/admin/addgroundstaff",
  authenticate,
  access(1),
  checkAirline,
  airlineAdmin.addGroundstaff
);

router.get("/airlinehome", authenticate, access(1), frontend.airlineHome);
//airport admin routes
router.post(
  "/apadmin/addairline",
  authenticate,
  access(2),
  validator(apadminSchema.addAirline),
  apadmin.addAirline
);

router.post(
  "/apadmin/addsecurity",
  authenticate,
  access(2),
  apadmin.addSecurity
);

module.exports = router;
