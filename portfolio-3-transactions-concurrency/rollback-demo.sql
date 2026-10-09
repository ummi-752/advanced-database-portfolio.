SELECT Account_Number, Balance 
FROM Account 
WHERE Account_Number = 'ACC001';

BEGIN;
  UPDATE Account 
  SET Balance = Balance - 99999.00
  WHERE Account_Number = 'ACC001';
ROLLBACK;

SELECT Account_Number, Balance 
FROM Account 
WHERE Account_Number = 'ACC001';
