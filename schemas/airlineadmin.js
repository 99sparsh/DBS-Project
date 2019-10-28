const Joi = require("joi");

exports.addBooking = Joi.object({
  body: Joi.object({
    flight_id: Joi.string().required(),
    name: Joi.string().required(),
    fleet_size: Joi.number().required(),
    no_staff: Joi.number().required()
  }).required()
});

exports.cancelBooking = Joi.object({
  body: Joi.object({
    booking_id: Joi.number.required()
  }).required()
});
