const express = require('express');
const router = express.Router();
const db = require('../db');

// helper to compute current stock
async function currentStock(productId) {
  const rows = await db('stocks').where({ product_id: productId }).select('change');
  return rows.reduce((s, r) => s + r.change, 0);
}

router.post('/movement', async (req, res) => {
  const { product_id, change, type, note } = req.body;
  await db('stocks').insert({ product_id, change, type, note });
  // check threshold
  const product = await db('products').where({ id: product_id }).first();
  const stock = await currentStock(product_id);
  if (product && typeof product.threshold === 'number' && stock <= product.threshold) {
    await db('alerts').insert({ product_id, stock_snapshot: stock });
  }
  res.json({ product_id, stock });
});

router.get('/:productId', async (req, res) => {
  const { productId } = req.params;
  const stock = await currentStock(productId);
  res.json({ productId, stock });
});

module.exports = router;
