module.exports = function (allowedRole) {
  return (req, res, next) => {
    if (!req.user || !req.user.role) {
      return res.status(403).json({ message: "Access denied" });
    }

    if (req.user.role !== allowedRole) {
      return res.status(403).json({
        message: `Only ${allowedRole}s can perform this action`
      });
    }

    next();
  };
};
