const Joi = require("joi");

exports.login = Joi.object({
  body: Joi.object({
    username: Joi.string().required(),
    password: Joi.string().required()
  }).required()
});

exports.forgotPassword = Joi.object({
  body: Joi.object({
    username: Joi.string().required()
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
  }).required(),
  query: Joi.object({
    token: Joi.string().required()
  })
});
