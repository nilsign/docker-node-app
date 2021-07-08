const express = require("express");
const app = express();
const port = process.env.PORT || 2000;

console.log("ENV: ", process?.env);
console.log("ENV-PORT: ", process?.env?.PORT);

const mongoose = require("mongoose");
const connectWithRetry = () => {
  mongoose
    .connect("mongodb://admin:root@mongo:27017/?authSource=admin")
    .then(() => console.log("Successfully connected to Mongo DB."))
    .catch((e) => {
      console.log(e);
      setTimeout(connectWithRetry, 5000);
    });
};
connectWithRetry();

app.get("/", (req, res) => {
  res.send("<h2>Hi Quinscape! Docker!</h2>");
});

app.listen(port, () => console.log(`listen on port ${port}`));
