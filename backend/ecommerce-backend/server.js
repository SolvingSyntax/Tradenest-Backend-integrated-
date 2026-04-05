const express = require('express');
const cors = require('cors');
const { db } = require('./firebase'); // This imports your Firebase connection

const app = express();
app.use(cors());
app.use(express.json()); // Allows your server to read JSON data

// ... existing imports ...
const adminRoutes = require('./routes/adminRoutes'); // 1. Import Admin Routes

// ... existing app.use calls ...
app.use('/api/admin', adminRoutes); // 2. Register the Admin endpoint

const productRoutes = require('./routes/productRoutes');
app.use('/api/products', productRoutes);

const authRoutes = require('./routes/authRoutes');
const cartRoutes = require('./routes/cartRoutes'); // 1. Import it

// ... down where your other app.use calls are ...
app.use('/api/cart', cartRoutes); 
app.use('/api/auth', authRoutes);

app.get('/', (req, res) => {
  res.send('eCommerce Backend is running!');
});

// Set the port and start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`🚀 Server is running on port ${PORT}`);
});