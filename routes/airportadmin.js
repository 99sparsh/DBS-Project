const db = require("../config/conn");
const to = require("../utils/to");

exports.addAirline = async (req, res) => {
  [err, result] = await to(
    db.query(`insert into airlines values(?,?,?,?)`, [
      req.body.airline_id,
      req.body.name,
      0,
      0
    ])
  );
  if (err) return res.sendError(err);
  return res.sendSuccess("Inserted Airline");
};

exports.addSecurity = async (req, res) => {
  [err, result] = await to(
    db.query(`insert into security values(?,?,?,?)`, [
      req.body.security_id,
      req.body.name,
      req.body.age,
      req.body.post
    ])
  );
  if (err) return res.sendError(err);
  return res.sendSuccess("Security Added");
};

exports.deleteFlights = async (req, res) => {
  [err, result] = await to(db.query(`call remove_flights()`));
  if (err) return res.sendError(err);
  return res.sendSuccess(null, "done");
};

exports.showSchedule = async (req, res) => {
  [err, schedule] = await to(db.query(`select * from schedule`));
  if (err) return res.sendError(err);
  [err, today] = await to(db.query(`select scheduledFlights() as Count;`));
  if (err) return res.sendError(err);
  return res.render("adminschedule", {
    schedule: schedule,
    today: today
  });
};
