-- ============================================================
-- TimaPay — Portfolio 2: SQL Queries
-- MIT 8103 Advanced Database Systems
-- ============================================================

-- QUERY 1: Account Statement
-- Shows all transactions for ACC001 between two dates
SELECT
    Transaction_ID,
    transaction_type,
    amount,
    transaction_ts,
    Post_Balance
FROM Transaction
WHERE Account_Number = 'ACC001'
  AND transaction_ts >= '2026-01-01 00:00:00+00'
  AND transaction_ts <  '2026-03-01 00:00:00+00'
ORDER BY transaction_ts ASC;


-- QUERY 2: Aggregate Summary
-- Total deposits, withdrawals, and net change for ACC001
SELECT
    SUM(CASE WHEN transaction_type = 'deposit'    THEN amount ELSE 0 END) AS total_deposits,
    SUM(CASE WHEN transaction_type = 'withdrawal' THEN amount ELSE 0 END) AS total_withdrawals,
    COUNT(*) AS transaction_count,
    SUM(CASE WHEN transaction_type = 'deposit'    THEN  amount
             WHEN transaction_type = 'withdrawal' THEN -amount
             ELSE 0 END) AS net_change
FROM Transaction
WHERE Account_Number = 'ACC001'
  AND transaction_ts >= '2026-01-01 00:00:00+00'
  AND transaction_ts <  '2026-03-01 00:00:00+00';


-- QUERY 3: Top 10 Accounts by Transaction Volume
-- Which accounts had the most transactions this month
SELECT
    t.Account_Number,
    c.full_name,
    COUNT(*) AS transaction_count,
    SUM(t.amount) AS total_volume
FROM Transaction t
JOIN Account  a ON t.Account_Number = a.Account_Number
JOIN Customer c ON a.Customer_ID    = c.Customer_ID
WHERE DATE_TRUNC('month', t.transaction_ts) = DATE_TRUNC('month', NOW())
GROUP BY t.Account_Number, c.full_name
ORDER BY transaction_count DESC
LIMIT 10;


-- QUERY 4: Customers Whose Balance Dropped Below 500
-- Find accounts that went dangerously low in the last 30 days
SELECT
    c.full_name,
    t.Account_Number,
    MIN(t.Post_Balance) AS min_balance_observed
FROM Transaction t
JOIN Account  a ON t.Account_Number = a.Account_Number
JOIN Customer c ON a.Customer_ID    = c.Customer_ID
WHERE t.transaction_ts >= NOW() - INTERVAL '30 days'
GROUP BY c.full_name, t.Account_Number
HAVING MIN(t.Post_Balance) < 500.00
ORDER BY min_balance_observed ASC;
