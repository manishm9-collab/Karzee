const express = require("express");
const Profile = require("../models/Profile");
const auth = require("../middleware/auth");

const router = express.Router();

/**
 * CREATE or UPDATE PROFILE
 */
router.post("/", auth, async (req, res) => {
  try {
    const profileData = {
      user: req.user.id,
      ...req.body
    };

    const profile = await Profile.findOneAndUpdate(
      { user: req.user.id },
      profileData,
      { new: true, upsert: true }
    );

    res.json(profile);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

/**
 * GET MY PROFILE
 */
router.get("/me", auth, async (req, res) => {
  try {
    const profile = await Profile.findOne({ user: req.user.id })
      .populate("user", ["name", "email", "role"]);

    if (!profile) {
      return res.status(404).json({ message: "Profile not found" });
    }

    res.json(profile);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
