const Joi = require("joi");

exports.addAirline = Joi.object({
  body: Joi.object({
    airline_id: Joi.number().required(),
    name: Joi.string().required(),
    fleet_size: Joi.number().required(),
    no_staff: Joi.number().required()
  }).required()
});
