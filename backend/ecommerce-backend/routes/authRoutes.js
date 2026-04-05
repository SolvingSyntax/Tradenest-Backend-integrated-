const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

// URL route: POST /api/auth/login
router.post('/login', authController.login);

// URL route: POST /api/auth/google
router.post('/google', authController.googleLogin);

// URL route: POST /api/auth/signup
router.post('/signup', authController.signup);

module.exports = router;