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
  else return res.sendError(null, "Unauthorized access");
};

router.get("/", redirectIfLoggedIn, frontend.index);

const checkAirline = (req, res, next) => {
  if (req.user.airline_id == req.body.airline_id) return next();
  else return res.sendError(null, "You can only modify own airline");
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
router.post(
  "/admin/schedulehangar",
  authenticate,
  access(1),
  airlineAdmin.scheduleHangar
);

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
router.post(
  "/admin/addschedule",
  authenticate,
  access(1),
  airlineAdmin.addSchedule
);
router.get("/viewdetails", authenticate, airlineAdmin.showDetails);

//frontend routes
router.get("/airlinehome", authenticate, access(1), frontend.airlinehome);
router.get("/makebooking", authenticate, access(1), frontend.addbooking);
router.get("/addcabincrew", authenticate, access(1), frontend.addcabincrew);
router.get("/addgroundstaff", authenticate, access(1), frontend.addgroundstaff);
router.get("/addpilot", authenticate, access(1), frontend.addpilot);
router.get("/addairline", authenticate, access(2), frontend.addairline);
router.get("/addsecurity", authenticate, access(2), frontend.addsecurity);
router.get("/airporthome", authenticate, access(2), frontend.airporthome);
router.get("/cancelbooking", authenticate, access(1), frontend.cancelbooking);
router.get("/scheduleflight", authenticate, access(1), frontend.addschedule);
router.get("/showdetails", authenticate, access(1), frontend.showdetails);
router.get("/forgotpassword", frontend.forgotpassword);
router.get("/resetpassword", frontend.resetpassword);
router.get("/schedulehangar", authenticate, access(1), frontend.schedulehangar);
module.exports = router;
