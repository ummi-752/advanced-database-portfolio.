# Normalisation — TimaPay Database

## What is Normalisation?
Normalisation is the process of organising a database to reduce data
repetition and ensure data is stored logically.

---

## First Normal Form (1NF)
Rule: Every column must hold one single value. No lists or groups in a column.

**TimaPay example:**
- The Customer table stores one email per row, one phone per row.
- We do not store multiple account numbers in one Customer column.
- Each Transaction is a separate row, not a list inside an Account row.

✅ TimaPay satisfies 1NF.

---

## Second Normal Form (2NF)
Rule: Every non-key column must depend on the whole primary key, not just part of it.

**TimaPay example:**
- The Account table has Account_Number as its primary key.
- Balance, account_type, and status all describe the Account — not the Customer.
- Customer details (name, email) are stored in the Customer table, not repeated in Account.
- This means there is no partial dependency.

✅ TimaPay satisfies 2NF.

---

## Third Normal Form (3NF)
Rule: No column should depend on another non-key column (no transitive dependency).

TimaPay example:
- In the Transaction table, Post_Balance depends on Transaction_ID (the primary key),
  not on Account_Number or amount independently.
- Customer name is not stored in the Account or Transaction table.
  It is only in the Customer table and retrieved via a JOIN when needed.
- This removes all transitive dependencies.

✅ TimaPay satisfies 3NF.

---

## Summary
| Normal Form | Rule | TimaPay Status |
|-------------|------|----------------|
| 1NF | No repeating groups or lists | ✅ Satisfied |
| 2NF | No partial dependencies | ✅ Satisfied |
| 3NF | No transitive dependencies | ✅ Satisfied |
