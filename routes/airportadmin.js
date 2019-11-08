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
};

// exports.deleteFlights = asyn(req,res) =>{
//   [err,result] = await to(
//     db.query(`call `)
//   )
// }
