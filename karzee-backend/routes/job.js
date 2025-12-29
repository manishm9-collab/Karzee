const express = require("express");
const router = express.Router();

// 1. Test Route
router.get("/test", (req, res) => {
  res.json({ message: "Job route is working perfectly!" });
});

// 2. Create Job Route (Line 14 Fix)
// Maine 'auth' aur 'role' hata diye hain taaki pehle server start ho jaye
router.post("/create", async (req, res) => {
  try {
    const { title, description } = req.body;
    res.status(201).json({ 
      message: "Success! Job post received", 
      data: { title, description } 
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 3. Apply Route
router.post("/apply/:jobId", async (req, res) => {
  res.json({ message: "Applied to job: " + req.params.jobId });
});

module.exports = router;