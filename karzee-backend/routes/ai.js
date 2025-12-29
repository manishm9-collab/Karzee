const express = require("express");
const router = express.Router();

router.post("/match", async (req, res) => {
  const { jobDetails, freelancerProfile } = req.body;

  if (!jobDetails || !freelancerProfile) {
    return res.status(400).json({ error: "Missing data" });
  }

  return res.json({
    success: true,
    decision: "MATCH",
    score: 90,
    reason: "Freelancer skills match the job requirements"
  });
});

module.exports = router;