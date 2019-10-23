const path = require("path");
require("dotenv").config({ path: path.join(__dirname, ".env") });

const express = require("express");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const session = require("express-session");
const morgan = require("morgan");
const passport = require("passport");
const redisStore = require("./config/redis")(session);
const response = require("./utils/response");
const routes = require("./routes");
const passConfig = require("./config/passport")(passport);
const app = express();

app.use(morgan("dev"));

app.use(
  session({
    resave: false,
    saveUninitialized: false,
    secret: "ams",
    store: redisStore,
    cookie: { maxAge: 604800000 }
  })
);

app.use(passport.initialize());
app.use(passport.session());
app.use(cookieParser("ams"));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(response);

app.use("/api", routes);

const port = process.env.PORT || 3000;

app.listen(port, err => {
  console.log(err || "Listening on port " + port);
});
