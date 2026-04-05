const { db, admin } = require('../firebase');

exports.addToCart = async (req, res) => {
    try {
        const { userId, productId, name, price, image } = req.body;
        
        // Path: users/{userId}/cart/{productId}
        const cartRef = db.collection('users').doc(userId).collection('cart').doc(productId);

        await cartRef.set({
            productId,
            name,
            price,
            image,
            quantity: admin.firestore.FieldValue.increment(1),
            addedAt: admin.firestore.FieldValue.serverTimestamp()
        }, { merge: true });

        res.status(200).json({ message: "Item added to cart" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
// Function to fetch all items in a user's cart
exports.getCartItems = async (req, res) => {
    try {
        const { userId } = req.params; // We'll get the ID from the URL

        // Path: users/{userId}/cart
        const cartSnapshot = await db.collection('users').doc(userId).collection('cart').get();

        if (cartSnapshot.empty) {
            return res.status(200).json([]); // Return empty list if no items
        }

        const items = [];
        cartSnapshot.forEach(doc => {
            items.push({ id: doc.id, ...doc.data() });
        });

        res.status(200).json(items);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
// Function to remove a specific item from the cart
exports.removeFromCart = async (req, res) => {
    try {
        const { userId, productId } = req.params;

        // Path: users/{userId}/cart/{productId}
        const cartItemRef = db.collection('users').doc(userId).collection('cart').doc(productId);

        await cartItemRef.delete();

        res.status(200).json({ message: "Item removed from cart" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
// Function to clear the entire cart for a user
exports.clearCart = async (req, res) => {
    try {
        const { userId } = req.params;
        const cartRef = db.collection('users').doc(userId).collection('cart');
        
        // Get all items in the cart
        const snapshot = await cartRef.get();

        if (snapshot.empty) {
            return res.status(200).json({ message: "Cart is already empty" });
        }

        // Delete each document in the cart
        const batch = db.batch();
        snapshot.forEach(doc => {
            batch.delete(doc.ref);
        });

        await batch.commit();

        res.status(200).json({ message: "Cart cleared successfully" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};