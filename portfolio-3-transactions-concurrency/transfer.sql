BEGIN;

  -- Step 1: Debit source account
  UPDATE Account 
  SET Balance = Balance - 500.00
  WHERE Account_Number = 'ACC002';

  -- Step 2: Insert debit transaction row
  INSERT INTO Transaction (Account_Number, transaction_type, amount, transaction_ts, Post_Balance, Transfer_Reference)
  VALUES ('ACC002', 'transfer_debit', 500.00, NOW(),
          (SELECT Balance FROM Account WHERE Account_Number = 'ACC002'),
          'TRF-UUID-001');

  -- Step 3: Credit destination account
  UPDATE Account 
  SET Balance = Balance + 500.00
  WHERE Account_Number = 'ACC003';

  -- Step 4: Insert credit transaction row
  INSERT INTO Transaction (Account_Number, transaction_type, amount, transaction_ts, Post_Balance, Transfer_Reference)
  VALUES ('ACC003', 'transfer_credit', 500.00, NOW(),
          (SELECT Balance FROM Account WHERE Account_Number = 'ACC003'),
          'TRF-UUID-001');

COMMIT;
