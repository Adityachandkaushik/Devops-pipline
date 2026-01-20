const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

const PORT = 5000;

// MongoDB connection
mongoose.connect("mongodb://mongo:27017/devops-db", {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => console.log("MongoDB connected"))
  .catch(err => console.log(err));

app.get("/", (req, res) => {
  res.send("Backend is ning!");
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
