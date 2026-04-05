const express = require('express');
const router = express.Router();
const { db } = require('../firebase'); // Using your existing firebase.js connection

// GET all orders for the Admin Dashboard
router.get('/orders', async (req, res) => {
    try {
        const snapshot = await db.collection('orders')
            .orderBy('createdAt', 'desc')
            .get();

        const orders = snapshot.docs.map(doc => ({
            id: doc.id,
            ...doc.data()
        }));

        res.status(200).json(orders);
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

// PATCH update order status (e.g., mark as Shipped)
router.patch('/orders/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { status } = req.body;

        await db.collection('orders').doc(id).update({
            status: status,
            updatedAt: new Date().toISOString() // Or use admin.firestore.FieldValue if available
        });

        res.status(200).json({ success: true, message: `Order ${status}` });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

module.exports = router;