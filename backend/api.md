# API Contract (minimal)

Base URL: /api

Resources:

- Users
  - POST /users/register - register new user { name, email, password, role }
  - POST /users/login - { email, password } -> { token }
  - GET /users/me - auth required

- Products
  - GET /products - list products
  - POST /products - create product { name, sku, supplier_id, unit, threshold }
  - GET /products/:id
  - PUT /products/:id
  - DELETE /products/:id

- Suppliers
  - GET /suppliers
  - POST /suppliers
  - PUT /suppliers/:id
  - DELETE /suppliers/:id

- Stocks
  - POST /stocks/movement - { product_id, change, type: 'in'|'out', note }
  - GET /stocks/:product_id - current stock

- Alerts
  - GET /alerts - list alerts
  - POST /alerts/:id/ack - acknowledge

- Reports
  - GET /reports/low-stock - list products below threshold

Authentication: Bearer JWT

Notifications: server emits alerts and can POST to /notifications/push (internal)
