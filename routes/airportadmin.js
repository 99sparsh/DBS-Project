const db = require("../config/conn");
const to = require("../utils/to");

exports.addAirline = async (req, res) => {
  [err, result] = await to(
    db.query("insert into airlines values(?,?,?,?)", [
      req.body.airline_id,
      req.body.name,
      req.body.fleet_size,
      req.body.no_staff
    ])
  );
  if (err) return res.sendError(err);
  return res.sendSuccess("Inserted Airline");
};
