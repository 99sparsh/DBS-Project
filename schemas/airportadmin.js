const Joi = require("joi");

exports.addAirline = Joi.object({
  body: Joi.object({
    flight_id: Joi.number().required(),
    name: Joi.string().required(),
    age: Joi.number().required(),
    phone: Joi.number().required()
  }).required()
});
