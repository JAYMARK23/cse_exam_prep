const admin = require('firebase-admin');

async function main() {
  try {
    // Initialize admin SDK. It will use GOOGLE_APPLICATION_CREDENTIALS if set,
    // otherwise it will attempt Application Default Credentials.
    if (!admin.apps.length) {
      admin.initializeApp();
    }

    const firestore = admin.firestore();
    console.log('Initialized Firebase Admin SDK');

    // Create a supplier
    const supplierRef = await firestore.collection('suppliers').add({
      name: 'Acme Supplies',
      contact: 'acme@example.com',
      phone: '1234567890',
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    console.log(`Created supplier ${supplierRef.id}`);

    // Create a product
    const productRef = await firestore.collection('products').add({
      name: 'Paper Towels',
      sku: 'PT-001',
      barcode: 'PT001',
      category: 'Cleaning',
      reorderThreshold: 5,
      supplierId: supplierRef.id,
      imageUrl: null,
      notes: 'UAT seed product',
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    console.log(`Created product ${productRef.id}`);

    // Create initial stock record
    const stockRef = await firestore.collection('stocks').add({
      productId: productRef.id,
      change: 10,
      type: 'in',
      note: 'Initial stock',
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    console.log(`Created stock ${stockRef.id}`);

    console.log('Firestore admin seed complete');
    process.exit(0);
  } catch (err) {
    console.error('Error running admin seed:', err);
    process.exit(1);
  }
}

// Run the script if executed directly
if (require.main === module) {
  main();
}

module.exports = { main };
