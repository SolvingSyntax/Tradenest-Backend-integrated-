const admin = require('firebase-admin');

// Point this to your downloaded key file
const serviceAccount = require('./serviceAccountKey.json');

// Initialize the Firebase connection
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

console.log("✅ Firebase Connected Successfully!");

module.exports = { admin, db };