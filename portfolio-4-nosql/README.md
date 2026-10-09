# Portfolio 4 — NoSQL and Advanced Data Models

Case Study: TimaPay

## Contents
- `schema-validation.js` — MongoDB collection with JSON Schema validation
- `insert-valid.js` — Valid document insertion
- `insert-invalid.js` — Invalid document showing validation rejection
- `indexes.js` — Compound index creation
- `multi-doc-transaction.js` — Multi-document ACID transaction
- `sql-vs-nosql-comparison.md` — Trade-off analysis between PostgreSQL and MongoDB
- Screenshots of insertions, validation errors, and query results

## Multi-Document Transactions
MongoDB multi-document ACID transactions require a replica set configuration.
In a standalone development instance, transactions are not supported.

The two transaction log documents (TXN-003 and TXN-004) representing a 
fund transfer were inserted successfully as individual operations.

In a production TimaPay deployment, MongoDB would be configured as a 
replica set (minimum 3 nodes), enabling full multi-document ACID transactions
as required by Requirement 9 criterion 4.
