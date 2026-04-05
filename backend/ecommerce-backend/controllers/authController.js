const { db } = require('../firebase');
const bcrypt = require('bcryptjs'); // Add this line at the top

exports.signup = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const userRef = db.collection('users');
    const snapshot = await userRef.where('email', '==', email).get();
    
    if (!snapshot.empty) {
      return res.status(400).json({ success: false, message: 'Email already registered' });
    }

    // --- NEW SECURITY STEP ---
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);
    // -------------------------

    const newUser = {
      name,
      email,
      password: hashedPassword, // Save the scrambled version!
      createdAt: new Date().toISOString()
    };

    const docRef = await userRef.add(newUser);

    res.status(201).json({ 
      success: true, 
      message: 'User created successfully!',
      userId: docRef.id 
    });
  } catch (error) {
    res.status(500).json({ success: false, error: 'Signup failed' });
  }
};

// Function to Log In a user
exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    // 1. Find user by email
    const userRef = db.collection('users');
    const snapshot = await userRef.where('email', '==', email).get();

    if (snapshot.empty) {
      return res.status(404).json({ success: false, message: 'User not found' });
    }

    const user = snapshot.docs[0].data();
    const userId = snapshot.docs[0].id;

    // 2. Compare passwords (typed vs hashed)
    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
      return res.status(401).json({ success: false, message: 'Invalid credentials' });
    }

    // 3. Success!
    res.status(200).json({ 
      success: true, 
      message: 'Login successful!', 
      user: { id: userId, name: user.name, email: user.email } 
    });

  } catch (error) {
    res.status(500).json({ success: false, error: 'Login failed' });
  }
};
const { OAuth2Client } = require('google-auth-library');
const client = new OAuth2Client(process.env.GOOGLE_CLIENT_ID); // We will set this ID later

exports.googleLogin = async (req, res) => {
  try {
    const { idToken } = req.body; // The token sent from the Flutter app

    // 1. Verify the token with Google
    const ticket = await client.verifyIdToken({
        idToken: idToken,
        audience: process.env.GOOGLE_CLIENT_ID, 
    });
    const payload = ticket.getPayload();
    const { email, name, picture } = payload;

    // 2. Check if user exists in our Firestore
    const userRef = db.collection('users');
    const snapshot = await userRef.where('email', '==', email).get();

    let user;
    let userId;

    if (snapshot.empty) {
      // 3. AUTO-SIGNUP: If new user, create their account immediately
      const newUser = {
        name,
        email,
        profilePic: picture,
        authType: 'google',
        createdAt: new Date().toISOString()
      };
      const docRef = await userRef.add(newUser);
      user = newUser;
      userId = docRef.id;
    } else {
      // 4. LOG IN: If they exist, just grab their data
      user = snapshot.docs[0].data();
      userId = snapshot.docs[0].id;
    }

    res.status(200).json({
      success: true,
      message: 'Google Login Successful',
      user: { id: userId, ...user }
    });

  } catch (error) {
    console.error("Google Auth Error:", error);
    res.status(401).json({ success: false, message: 'Invalid Google Token' });
  }
};