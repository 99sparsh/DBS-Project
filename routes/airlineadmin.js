const db = require("../config/conn");
const to = require("../utils/to");

exports.addBooking = async (req, res) => {
  [err, result] = await to(
    db.query(`select airline_id from schedule where flight_id=?`, [
      req.body.flight_id
    ])
  );
  if (err) return res.sendError(err);
  if (result[0].airline_id != req.user.airline_id)
    return res.sendError("Unauthorized Access!");
  [err, result] = await to(
    db.query(`call ticket_booking(?,?,?,?)`, [
      req.body.flight_id,
      req.body.name,
      req.body.age,
      req.body.phone
    ])
  );
  if (err) return res.sendError(err);
  return res.sendSuccess(result[0].Message);
};

exports.cancelBooking = async (req, res) => {
  [err, result] = await to(
    db.query(`select airline_id from schedule where flight_id=?`, [
      req.body.flight_id
    ])
  );
  if (err) return res.sendError(err);
  if (result[0].airline_id != req.user.airline_id)
    return res.sendError("Unauthorized Access!");
  [err, result] = await to(
    db.query(`call delete_booking(?)`, [req.body.booking_id])
  );
  if (err) return res.sendError(err);
  return res.sendSuccess(result[0].Message);
};

exports.showScheduleToBook = async (req, res) => {
  [err, result] = await to(
    db.query(`select * from schedule_view where airline_id=?`, [
      req.user.airline_id
    ])
  );
  if (err) return res.sendError(err);
  return res.sendSuccess(result, "Sent all flights");
};

exports.addCabincrew = async (req, res) => {
  [err, result] = await to(
    db.query(`insert into cabincrew values(?,?,?,?,?)`, [
      req.body.crew_id,
      req.body.airline_id,
      req.body.name,
      req.body.age,
      req.body.salary
    ])
  );
  if (err) return res.sendError(err);
  return res.sendSuccess("Cabincrew added");
};

exports.addPilot = async (req, res) => {
  [err, result] = await to(
    db.query(`insert into pilot values(?,?,?,?,?)`, [
      req.body.pilot_id,
      req.body.airline_id,
      req.body.name,
      req.body.age,
      req.body.salary
    ])
  );
  if (err) return res.sendError(err);
  return res.sendSuccess("Pilot added");
};

exports.addGroundstaff = async (req, res) => {
  [err, result] = await to(
    db.query(`insert into groundStaff values(?,?,?,?,?,?)`, [
      req.body.staff_id,
      req.body.airline_id,
      req.body.name,
      req.body.work,
      req.body.age,
      req.body.salary
    ])
  );
  if (err) return res.sendError(err);
  return res.sendSuccess("Groundstaff added");
};
