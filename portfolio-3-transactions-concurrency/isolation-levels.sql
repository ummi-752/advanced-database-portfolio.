BEGIN;

  UPDATE Account
  SET Balance = Balance - 999999.00
  WHERE Account_Number = 'ACC001'
    AND account_type = 'savings';

  -- This will violate the savings_no_overdraft check constraint
  -- The constraint will fire and reject this

ROLLBACK;

SELECT Account_Number, Balance FROM Account WHERE Account_Number = 'ACC001';
