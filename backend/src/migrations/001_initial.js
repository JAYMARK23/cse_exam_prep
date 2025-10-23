exports.up = function(knex) {
  return knex.schema
    .createTable('users', (table) => {
      table.increments('id').primary();
      table.string('name').notNullable();
      table.string('email').notNullable().unique();
      table.string('password').notNullable();
      table.string('role').notNullable().defaultTo('owner');
      table.timestamps(true, true);
    })
    .createTable('suppliers', (table) => {
      table.increments('id').primary();
      table.string('name').notNullable();
      table.string('contact');
      table.string('phone');
      table.string('email');
      table.timestamps(true, true);
    })
    .createTable('products', (table) => {
      table.increments('id').primary();
      table.string('name').notNullable();
      table.string('sku').unique();
      table.integer('supplier_id').references('id').inTable('suppliers').onDelete('SET NULL');
      table.string('unit');
      table.integer('threshold').defaultTo(0);
      table.timestamps(true, true);
    })
    .createTable('stocks', (table) => {
      table.increments('id').primary();
      table.integer('product_id').references('id').inTable('products').onDelete('CASCADE');
      table.integer('change').notNullable();
      table.string('type');
      table.string('note');
      table.timestamps(true, true);
    })
    .createTable('alerts', (table) => {
      table.increments('id').primary();
      table.integer('product_id').references('id').inTable('products').onDelete('CASCADE');
      table.integer('stock_snapshot');
      table.boolean('acknowledged').defaultTo(false);
      table.timestamps(true, true);
    });
};

exports.down = function(knex) {
  return knex.schema
    .dropTableIfExists('alerts')
    .dropTableIfExists('stocks')
    .dropTableIfExists('products')
    .dropTableIfExists('suppliers')
    .dropTableIfExists('users');
};
