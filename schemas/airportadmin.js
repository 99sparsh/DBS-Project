const Joi = require("joi");

exports.addAirline = Joi.object({
	body: Joi.object({
		airline_id: Joi.number().required(),
		name: Joi.string().required()
	}).required()
});
