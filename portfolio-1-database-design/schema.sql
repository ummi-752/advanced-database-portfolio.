-- ============================================================
-- TimaPay Database Schema
-- MIT 8103 Advanced Database Systems — Portfolio 1
-- ============================================================

-- Drop tables if they exist (for clean re-runs)
DROP TABLE IF EXISTS Audit_Log CASCADE;
DROP TABLE IF EXISTS Transaction CASCADE;
DROP TABLE IF EXISTS Account CASCADE;
DROP TABLE IF EXISTS Customer CASCADE;

-- ============================================================
-- CUSTOMER TABLE
-- Stores all registered TimaPay customers
-- ============================================================
CREATE TABLE Customer (
    Customer_ID     SERIAL          PRIMARY KEY,
    full_name       VARCHAR(255)    NOT NULL,
    date_of_birth   DATE            NOT NULL,
    national_id     VARCHAR(50)     NOT NULL UNIQUE,
    email           VARCHAR(254)    NOT NULL UNIQUE,
    phone           VARCHAR(20)     NOT NULL,
    registered_at   TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- ============================================================
-- ACCOUNT TABLE
-- Each customer can have one or more accounts
-- ============================================================
CREATE TABLE Account (
    Account_Number  VARCHAR(20)     PRIMARY KEY,
    Customer_ID     INT             NOT NULL REFERENCES Customer(Customer_ID),
    account_type    VARCHAR(10)     NOT NULL CHECK (account_type IN ('savings', 'current')),
    opening_date    DATE            NOT NULL,
    Balance         DECIMAL(18,2)   NOT NULL DEFAULT 0.00,
    status          VARCHAR(10)     NOT NULL DEFAULT 'open'
                                    CHECK (status IN ('open', 'closed')),
    overdraft_limit DECIMAL(18,2)   NOT NULL DEFAULT 0.00,

    -- Savings accounts cannot go below zero
    CONSTRAINT savings_no_overdraft CHECK (
        account_type != 'savings' OR Balance >= 0.00
    )
);

-- ============================================================
-- TRANSACTION TABLE
-- Every financial event (deposit, withdrawal, transfer, etc.)
-- ============================================================
CREATE TABLE Transaction (
    Transaction_ID      SERIAL          PRIMARY KEY,
    Account_Number      VARCHAR(20)     NOT NULL REFERENCES Account(Account_Number),
    transaction_type    VARCHAR(20)     NOT NULL CHECK (transaction_type IN (
                            'deposit', 'withdrawal', 'transfer_debit',
                            'transfer_credit', 'fee', 'reversal'
                        )),
    amount              DECIMAL(18,2)   NOT NULL CHECK (amount > 0.00),
    transaction_ts      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    Post_Balance        DECIMAL(18,2)   NOT NULL,
    Transfer_Reference  VARCHAR(36),
    Idempotency_Key     VARCHAR(64)
);

-- ============================================================
-- AUDIT LOG TABLE
-- Immutable record of every data-changing operation
-- ============================================================
CREATE TABLE Audit_Log (
    Log_ID          BIGSERIAL       PRIMARY KEY,
    Transaction_ID  INT             REFERENCES Transaction(Transaction_ID),
    User_Identity   VARCHAR(255)    NOT NULL,
    Operation_Type  VARCHAR(50)     NOT NULL,
    Affected_Table  VARCHAR(100)    NOT NULL,
    Old_Value       JSONB,
    New_Value       JSONB,
    Event_Timestamp TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

