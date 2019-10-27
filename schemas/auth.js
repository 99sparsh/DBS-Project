const Joi = require("joi");

exports.login = Joi.object({
  body: Joi.object({
    email: Joi.string()
      .email()
      .required(),
    password: Joi.string().required()
  }).required()
});

exports.forgotPassword = Joi.object({
  body: Joi.object({
    email: Joi.string()
      .email()
      .required()
  }).required()
});

exports.resetPassword = Joi.object({
  body: Joi.object({
    password: Joi.string()
      .min(8)
      .required(),
    password2: Joi.string()
      .min(8)
      .required()
  }).required()
});
