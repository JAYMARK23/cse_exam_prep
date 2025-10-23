const path = require('path');
const db = require('../db');
const fs = require('fs');

async function run() {
  const migrationsDir = path.resolve(__dirname, '..', 'migrations');
  const files = fs.readdirSync(migrationsDir).filter(f => f.endsWith('.js'));
  files.sort();
  for (const file of files) {
    const migration = require(path.join(migrationsDir, file));
    if (migration.up) {
      console.log('Running', file);
      await migration.up(db);
    }
  }
  console.log('Migrations complete');
  process.exit(0);
}

run().catch(err => { console.error(err); process.exit(1); });
