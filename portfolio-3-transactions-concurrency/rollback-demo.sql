BEGIN;

  UPDATE Account 
  SET Balance = Balance - 99999.00
  WHERE Account_Number = 'ACC001';

  -- Check what the balance looks like mid-transaction
  SELECT Account_Number, Balance FROM Account WHERE Account_Number = 'ACC001';

ROLLBACK;

-- Confirm balance is back to original
SELECT Account_Number, Balance FROM Account WHERE Account_Number = 'ACC001';
