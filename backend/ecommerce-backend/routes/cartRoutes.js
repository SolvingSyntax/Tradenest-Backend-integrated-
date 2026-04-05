const express = require('express');
const router = express.Router();
const cartController = require('../controllers/cartController');

// URL: POST /api/cart/add
router.post('/add', cartController.addToCart);

// URL: GET /api/cart/get/test_user_99
router.get('/get/:userId', cartController.getCartItems);

// URL: DELETE /api/cart/clear/TX8m9ydQ3TH...
router.delete('/clear/:userId', cartController.clearCart);

// URL: DELETE /api/cart/remove/test_user_99/shoes_001
router.delete('/remove/:userId/:productId', cartController.removeFromCart);

module.exports = router;