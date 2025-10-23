const express = require('express');
const router = express.Router();
const db = require('../db');

router.get('/', async (req, res) => {
  const products = await db('products').select('*');
  res.json(products);
});

router.post('/', async (req, res) => {
  const { name, sku, supplier_id, unit, threshold } = req.body;
  const [id] = await db('products').insert({ name, sku, supplier_id, unit, threshold });
  res.status(201).json({ id });
});

module.exports = router;
