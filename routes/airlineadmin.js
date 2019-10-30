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
  [err, result] = await to(db.query(`select * from schedule_view`));
  if (err) return res.sendError(err);
  return res.sendSuccess(result, "Sent all flights");
};
