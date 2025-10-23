const express = require('express');
const router = express.Router();
const db = require('../db');

router.get('/', async (req, res) => {
  const alerts = await db('alerts').select('*').orderBy('created_at', 'desc');
  res.json(alerts);
});

router.post('/:id/ack', async (req, res) => {
  const { id } = req.params;
  await db('alerts').where({ id }).update({ acknowledged: true });
  res.json({ id, acknowledged: true });
});

module.exports = router;
