const express = require('express');
const cors = require('cors');
const app = express();
app.use(cors());
app.use(express.json());

const routes = require('./routes');

app.use('/api', routes);

app.get('/', (req, res) => {
  res.json({ message: "Restock 'n' Roll backend running" });
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => console.log(`Server listening on ${PORT}`));
