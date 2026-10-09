-- ============================================================
-- TimaPay — Portfolio 2: Indexes
-- MIT 8103 Advanced Database Systems
-- ============================================================

-- INDEX 1: Speeds up account statement queries
-- When you ask "show me ACC001 transactions in January"
-- PostgreSQL jumps straight to those rows instead of reading everything
CREATE INDEX idx_transaction_account_ts
ON Transaction (Account_Number ASC, transaction_ts DESC);


-- INDEX 2: Speeds up customer login
-- When a customer logs in with their email, PostgreSQL finds them instantly
CREATE INDEX idx_customer_email
ON Customer (email);


-- INDEX 3: Speeds up audit log lookups
-- When bank staff search for a specific transaction in the audit log
CREATE INDEX idx_auditlog_txid_ts
ON Audit_Log (Transaction_ID ASC, Event_Timestamp DESC);


-- INDEX 4: Speeds up queries on open accounts only
-- A partial index — only indexes rows where status = 'open'
-- Smaller and faster than indexing all accounts
CREATE INDEX idx_account_open
ON Account (Customer_ID, Account_Number)
WHERE status = 'open';
