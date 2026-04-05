const express = require('express');
const router = express.Router();

// Import the controller we just made
const productController = require('../controllers/productController');

// Define the URL route: POST /api/products/add
router.post('/add', productController.addProduct);

// --- PASTE THE NEW LINE BELOW THIS ---
router.get('/all', productController.getProducts);

// Define the URL route: GET /api/products/:id
router.get('/:id', productController.getProductById);

// Define the URL route: PUT /api/products/:id
router.put('/:id', productController.updateProduct);

// Define the URL route: DELETE /api/products/:id
router.delete('/:id', productController.deleteProduct);

module.exports = router;