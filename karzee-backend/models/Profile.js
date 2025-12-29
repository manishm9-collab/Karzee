const mongoose = require("mongoose");

const profileSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true
  },

  role: {
    type: String,
    enum: ["freelancer", "client"],
    required: true
  },

  // Freelancer fields
  skills: [String],
  bio: String,
  hourlyRate: Number,
  portfolio: [String],

  // Client fields
  companyName: String,
  companyWebsite: String,

  createdAt: {
    type: Date,
    default: Date.now
  }
});

module.exports = mongoose.model("Profile", profileSchema);
