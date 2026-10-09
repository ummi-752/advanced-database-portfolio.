BEGIN;

  -- Record a reversal of the original deposit (Transaction_ID 1)
  INSERT INTO Transaction (Account_Number, transaction_type, amount, transaction_ts, Post_Balance)
  VALUES ('ACC001', 'reversal', 1000.00, NOW(),
          (SELECT Balance - 1000.00 FROM Account WHERE Account_Number = 'ACC001'));

  -- Update the balance
  UPDATE Account
  SET Balance = Balance - 1000.00
  WHERE Account_Number = 'ACC001';

  -- Write audit log entry
  INSERT INTO Audit_Log (Transaction_ID, User_Identity, Operation_Type, Affected_Table, New_Value)
  VALUES (
    (SELECT MAX(Transaction_ID) FROM Transaction),
    'bank_staff_user',
    'REVERSAL',
    'Transaction',
    '{"note": "Reversal of Transaction 1"}'
  );

COMMIT;

-- Confirm new balance
SELECT Account_Number, Balance FROM Account WHERE Account_Number = 'ACC001';
