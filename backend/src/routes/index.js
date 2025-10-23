const express = require('express');
const router = express.Router();
const health = require('./health');
const products = require('./products');
const stocks = require('./stocks');
const alerts = require('./alerts');

router.use('/health', health);
router.use('/products', products);
router.use('/stocks', stocks);
router.use('/alerts', alerts);

module.exports = router;
