const { db } = require('../firebase'); // This connects to your database

// Function to add a new product to Firestore
exports.addProduct = async (req, res) => {
  try {
    const { title, price, stock, category } = req.body;
    
    // Create the product data object
    const newProduct = {
      title,
      price,
      stock,
      category,
      createdAt: new Date().toISOString()
    };

    // Save to Firestore in a collection called 'products'
    const docRef = await db.collection('products').add(newProduct);
    
    res.status(201).json({ 
      success: true, 
      message: 'Product added successfully!',
      productId: docRef.id 
    });
  } catch (error) {
    console.error("Error adding product:", error);
    res.status(500).json({ success: false, error: 'Failed to add product' });
  }
};
// Function to fetch all products from Firestore
exports.getProducts = async (req, res) => {
  try {
    const productsSnapshot = await db.collection('products').get();
    const productsList = productsSnapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data()
    }));

    res.status(200).json({
      success: true,
      data: productsList
    });
  } catch (error) {
    console.error("Error fetching products:", error);
    res.status(500).json({ success: false, error: 'Failed to fetch products' });
  }
};
// Function to fetch a SINGLE product by its ID
exports.getProductById = async (req, res) => {
  try {
    const productId = req.params.id; // Get the ID from the URL
    const doc = await db.collection('products').doc(productId).get();

    if (!doc.exists) {
      return res.status(404).json({ success: false, message: 'Product not found' });
    }

    res.status(200).json({
      success: true,
      data: { id: doc.id, ...doc.data() }
    });
  } catch (error) {
    res.status(500).json({ success: false, error: 'Failed to fetch product' });
  }
};
// Function to update an existing product
exports.updateProduct = async (req, res) => {
  try {
    const productId = req.params.id;
    const updatedData = req.body; // The fields to change (e.g., price or stock)

    await db.collection('products').doc(productId).update(updatedData);

    res.status(200).json({ 
      success: true, 
      message: 'Product updated successfully!' 
    });
  } catch (error) {
    res.status(500).json({ success: false, error: 'Failed to update product' });
  }
};
// Function to delete a product
exports.deleteProduct = async (req, res) => {
  try {
    const productId = req.params.id;
    await db.collection('products').doc(productId).delete();

    res.status(200).json({ 
      success: true, 
      message: 'Product deleted successfully!' 
    });
  } catch (error) {
    res.status(500).json({ success: false, error: 'Failed to delete product' });
  }
};