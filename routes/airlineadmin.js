/*eslint quote-props: ["error", "always"]*/
/*eslint-env es6*/

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
  console.log(result[0][0].Message);
  if (err) return res.sendError(err);
  return res.sendSuccess(null, result[0][0]);
};

exports.cancelBooking = async (req, res) => {
  // [err, result] = await to(
  //   db.query(`select airline_id from schedule where flight_id=?`, [
  //     req.body.flight_id
  //   ])
  // );
  // if (err) return res.sendError(err);
  // if (result[0].airline_id != req.user.airline_id)
  //   return res.sendError("Unauthorized Access!");
  [err, result] = await to(
    db.query(`call delete_booking(?)`, [req.body.booking_id])
  );
  if (err) return res.sendError(err);
  return res.sendSuccess(null, result[0][0]);
};
exports.getCancelBooking = async (req, res) => {
  [err, bookings] = await to(
    db.query(
      `select * from booking where flight_id in (select flight_id from schedule where airline_id=?)`,
      [req.user.airline_id]
    )
  );
  if (err) return res.sendError(err);
  res.render("cancelbooking", bookings);
};
exports.showScheduleToBook = async (req, res) => {
  [err, result] = await to(
    db.query(
      `select * from schedule_view where airline=(select name from airlines where airline_id=?)`,
      [req.user.airline_id]
    )
  );
  console.log(result);
  if (err) return res.sendError(err);
  return res.render("addbooking", result);
};

exports.addCabincrew = async (req, res) => {
  [err, result] = await to(
    db.query(`insert into cabincrew values(?,?,?,?,?)`, [
      req.body.crew_id,
      req.user.airline_id,
      req.body.name,
      req.body.age,
      req.body.salary
    ])
  );
  if (err) return res.sendError(err);

  return res.sendSuccess(null, "success");
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
      req.user.airline_id,
      req.body.name,
      req.body.work,
      req.body.age,
      req.body.salary
    ])
  );
  if (err) return res.sendError(err);
  return res.sendSuccess("Groundstaff added");
};

exports.addSchedule = async (req, res) => {
  [err, airplanes] = await to(
    db.query(
      `select airplane_id from airplanes where airplane_id not in (select airplane_id from schedule where date(departure)=?) and airline_id=?`,
      [req.body.date, req.user.airline_id]
    )
  );
  if (err) return res.sendError(err);
  [err, pilots] = await to(
    db.query(
      `select pilot_id from pilot where pilot_id not in (select pilot_id from schedule where date(departure)=?) and airline_id=?`,
      [req.body.date, req.user.airline_id]
    )
  );
  if (err) return res.sendError(err);
  [err, fare] = await to(
    db.query(`select fare from fare where airline_id=? and destination=?`, [
      req.user.airline_id,
      req.body.destination
    ])
  );
  if (err) return res.sendError(err);
  [err, buses] = await to(
    db.query(
      `select bus_id from buses where bus_id not in (select bus_id from schedule where ? > date_add(departure,INTERVAL -2 HOUR) and ? < date_add(departure,INTERVAL 2 HOUR) and airline_id=?)`,
      [req.body.date, req.body.date, req.user.airline_id]
    )
  );
  if (err) return res.sendError(err);
  [err, gates] = await to(
    db.query(
      `select id from boarding_gates where id not in (select boarding_gate from schedule where ? > date_add(departure,INTERVAL -2 HOUR) and ? < date_add(departure,INTERVAL 2 HOUR))`,
      [req.body.date, req.body.date, req.user.airline_id]
    )
  );
  if (err) return res.sendError(err);
  var resources = {
    airplanes: airplanes,
    pilots: pilots,
    buses: buses,
    gates: gates
  };
  return res.render("schedule", resources);
};

exports.scheduleHangar = async (req, res) => {
  [err, result] = await to(
    db.query(`call schedule_hangar(?,?,?)`, [
      req.body.hid,
      req.body.aid,
      req.body.date
    ])
  );
  if (err) return res.sendError(err);
  else return res.sendSuccess(result[0][0].Message);
};

exports.showDetails = async (req, res) => {
  [err, pilots] = await to(
    db.query(
      `select pilot_id,pilot.name,age,salary,airlines.name as airline from pilot,airlines where pilot.airline_id=airlines.airline_id`
    )
  );
  if (err) return res.sendError(err);
  [err, crew] = await to(
    db.query(
      `select crew_id,cabincrew.name,age,salary,airlines.name as airline from cabincrew,airlines where cabincrew.airline_id=airlines.airline_id`
    )
  );
  if (err) return res.sendError(err);
  [err, staff] = await to(
    db.query(
      `select staff_id,groundStaff.name,work,age,salary,airlines.name as airline from groundStaff,airlines where groundStaff.airline_id=airlines.airline_id`
    )
  );

  if (err) return res.sendError(err);
  var airportView = {
    pilots: pilots,
    crew: crew,
    staff: staff
  };
  [err, pilots] = await to(
    db.query(
      `select pilot_view.name,age from pilot_view where pilot_view.airline=(select name from airlines where airline_id=?)`,
      [req.user.airline_id]
    )
  );
  if (err) return res.sendError(err);
  [err, crew] = await to(
    db.query(
      `select crew_view.name,age from crew_view where crew_view.airline=(select name from airlines where airline_id=?)`,
      [req.user.airline_id]
    )
  );
  if (err) return res.sendError(err);
  [err, staff] = await to(
    db.query(
      `select staff_view.name,age,work from staff_view where staff_view.airline=(select name from airlines where airline_id=?)`,
      [req.user.airline_id]
    )
  );
  if (err) return res.sendError(err);
  var airlineView = {
    pilots: pilots,
    crew: crew,
    staff: staff
  };
  if (req.user.access == 1) {
    return res.render("details", { access: 1, view: airlineView });
  } else {
    return res.render("details", { access: 2, view: airportView });
  }
};
