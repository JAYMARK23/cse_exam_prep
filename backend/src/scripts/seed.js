const db = require('../db');

async function run() {
  // insert a supplier
  const [supplierId] = await db('suppliers').insert({ name: 'Acme Supplies', contact: 'acme@example.com', phone: '1234567890' });
  // insert a product with low threshold
  const [productId] = await db('products').insert({ name: 'Paper Towels', sku: 'PT-001', supplier_id: supplierId, unit: 'pack', threshold: 5 });
  // insert some stock movements
  await db('stocks').insert({ product_id: productId, change: 10, type: 'in', note: 'Initial stock' });

  console.log('Seed complete');
  process.exit(0);
}

run().catch(err => { console.error(err); process.exit(1); });
