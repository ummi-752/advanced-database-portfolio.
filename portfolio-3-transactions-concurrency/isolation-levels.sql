SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT Transaction_ID, transaction_type, amount, transaction_ts
FROM Transaction
WHERE Account_Number = 'ACC001'
ORDER BY transaction_ts ASC;

SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SELECT Transaction_ID, transaction_type, amount, transaction_ts
FROM Transaction
WHERE Account_Number = 'ACC001'
ORDER BY transaction_ts ASC;
