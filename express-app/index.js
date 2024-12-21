const express = require("express");
const cors = required("cors");
const app = express();

app.use(cors());

app.get("/", (req, res) => {
  res.send("Hello from the Express Backend");
});

app.listen(5000, () => {
  console.log("Server is running on port 5000");
});