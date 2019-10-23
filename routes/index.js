const router = require("express").Router();
const db = require("../config/conn");
const to = require("../utils/to");
const authenticate = (req, res, next) => {
  if (req.isAuthenticated()) return next();
  else return res.sendError(null, "Login First!");
};

const access = level => (req, res, next) => {
  if (req.user && req.user.access >= level) return next();
  return res.sendError(null, "Unauthorized access");
};

router.get("/", async (req, res) => {
  //test route
  res.send("WORKING");
});

module.exports = router;
