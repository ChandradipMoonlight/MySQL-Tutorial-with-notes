use fintrip;

--qr transactions month wise data in given date range

SELECT 
    company_id AS companyId,
    DATE_FORMAT(created_at, '%Y-%m') AS month,
    COUNT(DISTINCT employee_id) AS activeUsers,
    COUNT(*) AS totalQrTxnCount,
    SUM(amount) AS totalQrTxnAmt,

    SUM(transfer_status = 'SUCCESS') AS successQrTxnCount,
    SUM(CASE WHEN transfer_status = 'SUCCESS' THEN amount ELSE 0 END) AS successQrTxnAmt,

    SUM(transfer_status = 'FAILED') AS failedQrTxnCount,
    SUM(CASE WHEN transfer_status = 'FAILED' THEN amount ELSE 0 END) AS failedQrTxnAmt,

    SUM(transfer_status = 'ONGOING') AS ongoingQrTxnCount,
    SUM(CASE WHEN transfer_status = 'ONGOING' THEN amount ELSE 0 END) AS ongoingQrTxnAmt

FROM fintrip_upi_transactions
WHERE created_at BETWEEN FROM_UNIXTIME(1732991401) AND FROM_UNIXTIME(1747918481)
  AND company_id IN (1848, 1483)
GROUP BY company_id, DATE_FORMAT(created_at, '%Y-%m')
ORDER BY company_id, DATE_FORMAT(created_at, '%Y-%m');



--! to craete view table 

CREATE OR REPLACE VIEW qr_monthly_summary AS
SELECT 
  company_id,
  DATE_FORMAT(created_at, '%Y-%m') AS month,
  COUNT(DISTINCT employee_id) AS activeUsers,
  COUNT(*) AS totalQrTxnCount,
  SUM(amount) AS totalQrTxnAmt,

  SUM(CASE WHEN transfer_status = 'SUCCESS' THEN 1 ELSE 0 END) AS successQrTxnCount,
  SUM(CASE WHEN transfer_status = 'SUCCESS' THEN amount ELSE 0 END) AS successQrTxnAmt,

  SUM(CASE WHEN transfer_status = 'FAILED' THEN 1 ELSE 0 END) AS failedQrTxnCount,
  SUM(CASE WHEN transfer_status = 'FAILED' THEN amount ELSE 0 END) AS failedQrTxnAmt,

  SUM(CASE WHEN transfer_status = 'ONGOING' THEN 1 ELSE 0 END) AS ongoingQrTxnCount,
  SUM(CASE WHEN transfer_status = 'ONGOING' THEN amount ELSE 0 END) AS ongoingQrTxnAmt

FROM fintrip_upi_transactions
GROUP BY company_id, DATE_FORMAT(created_at, '%Y-%m')
ORDER BY company_id, month;


--! find distict empoyee group by month in given date range 

SELECT
  company_id,
  DATE_FORMAT(created_at, '%Y-%m') AS month,
  COUNT(DISTINCT email) AS totalDistinctUsers
FROM fintrip_employees
WHERE created_at >= FROM_UNIXTIME(1732991401)
  AND created_at <  FROM_UNIXTIME(1747918481)
  AND company_id = 1848
GROUP BY company_id, DATE_FORMAT(created_at, '%Y-%m')
ORDER BY company_id, DATE_FORMAT(created_at, '%Y-%m');


--! find month wise data in given date range, 
--* data -> totalAcitveUser, total pettyPaid and selfPaid couts and sum of its paid and non paid amounts

-- SELECT
--  company_id,
--  DATE_FORMAT(created_at, '%Y-%m') AS month,
--  SUM(CASE WHEN transaction_type IN ('SELFPAID', 'PETTYPAID') THEN 1 ELSE 0 END) AS totalExpenseCount,
--  SUM(CASE WHEN transaction_type IN ('SELFPAID', 'PETTYPAID') THEN amount ELSE 0 END) AS totalExpenseAmt,
--  SUM(CASE WHEN transaction_type = 'SELFPAID' THEN 1 ELSE 0 END) AS totalSelfPaidCount,
--  SUM(CASE WHEN transaction_type = 'PETTYPAID' THEN 1 ELSE 0 END) AS totalPettyPaidCount,
--  SUM(CASE WHEN transaction_type = 'SELFPAID' THEN amount ELSE 0 END) AS totalSelfPaidAmt,
--  SUM(CASE WHEN transaction_type = 'PETTYPAID' THEN amount ELSE 0 END) AS totalPettyPaidAmt,
--  SUM(CASE WHEN transaction_type = 'SELFPAID' AND EXISTS (
--    SELECT 1 FROM fintrip_expense_vouchers v 
--    WHERE v.id = fintrip_transactions.voucher_id 
--    AND v.settlement_id > 0
--  ) THEN 1 ELSE 0 END) AS totalSelfPaidPaidCount,
--  SUM(CASE WHEN transaction_type = 'PETTYPAID' AND EXISTS (
--    SELECT 1 FROM fintrip_expense_vouchers v 
--    WHERE v.id = fintrip_transactions.voucher_id 
--    AND v.settlement_id > 0
--  ) THEN 1 ELSE 0 END) AS totalPettyPaidPaidCount,
--  SUM(CASE WHEN transaction_type = 'SELFPAID' AND EXISTS (
--    SELECT 1 FROM fintrip_expense_vouchers v 
--    WHERE v.id = fintrip_transactions.voucher_id 
--    AND v.settlement_id > 0
--  ) THEN amount ELSE 0 END) AS totalSelfPaidPaidAmt,
--  SUM(CASE WHEN transaction_type = 'PETTYPAID' AND EXISTS (
--    SELECT 1 FROM fintrip_expense_vouchers v 
--    WHERE v.id = fintrip_transactions.voucher_id 
--    AND v.settlement_id > 0
--  ) THEN amount ELSE 0 END) AS totalPettyPaidPaidAmt,
 
-- FROM fintrip_transactions
-- WHERE created_at BETWEEN FROM_UNIXTIME(1732991401) AND FROM_UNIXTIME(1747918481)
-- GROUP BY company_id, DATE_FORMAT(created_at, '%Y-%m')
-- ORDER BY company_id, DATE_FORMAT(created_at, '%Y-%m');

-- !fintrip_transactions, transaction_type[SELFPAID, PETTYPAID], voucher_id, fintrip_expense_vouchers, settlement_id

-- Add these indexes if they don't exist
-- CREATE INDEX idx_transactions_created_at ON fintrip_transactions(created_at);
-- CREATE INDEX idx_transactions_company_id ON fintrip_transactions(company_id);
-- CREATE INDEX idx_transactions_type ON fintrip_transactions(transaction_type);
-- CREATE INDEX idx_vouchers_settlement ON fintrip_expense_vouchers(settlement_id);
-- CREATE INDEX idx_vouchers_id ON fintrip_expense_vouchers(id);

SELECT
    t.company_id,
    DATE_FORMAT(t.created_at, '%Y-%m') AS month,
    COUNT(DISTINCT CASE WHEN t.transaction_type IN ('SELFPAID', 'PETTYPAID') THEN t.id END) AS totalExpenseCount,
    SUM(CASE WHEN t.transaction_type IN ('SELFPAID', 'PETTYPAID') THEN t.amount ELSE 0 END) AS totalExpenseAmt,
    COUNT(CASE WHEN t.transaction_type IN ('SELFPAID', 'PETTYPAID') AND v.settlement_id > 0 THEN t.id END) AS totalExpensePaidCount,
    SUM(CASE WHEN t.transaction_type IN ('SELFPAID', 'PETTYPAID') AND v.settlement_id > 0 THEN t.amount ELSE 0 END) AS totalExpensePaidAmt,
    COUNT(DISTINCT CASE WHEN t.transaction_type = 'SELFPAID' THEN t.id END) AS totalSelfPaidCount,
    COUNT(DISTINCT CASE WHEN t.transaction_type = 'PETTYPAID' THEN t.id END) AS totalPettyPaidCount,
    SUM(CASE WHEN t.transaction_type = 'SELFPAID' THEN t.amount ELSE 0 END) AS totalSelfPaidAmt,
    SUM(CASE WHEN t.transaction_type = 'PETTYPAID' THEN t.amount ELSE 0 END) AS totalPettyPaidAmt,
    COUNT(DISTINCT CASE WHEN t.transaction_type = 'SELFPAID' AND v.settlement_id > 0 THEN t.id END) AS totalSelfPaidPaidCount,
    COUNT(DISTINCT CASE WHEN t.transaction_type = 'PETTYPAID' AND v.settlement_id > 0 THEN t.id END) AS totalPettyPaidPaidCount,
    SUM(CASE WHEN t.transaction_type = 'SELFPAID' AND v.settlement_id > 0 THEN t.amount ELSE 0 END) AS totalSelfPaidPaidAmt,
    SUM(CASE WHEN t.transaction_type = 'PETTYPAID' AND v.settlement_id > 0 THEN t.amount ELSE 0 END) AS totalPettyPaidPaidAmt
FROM fintrip_transactions t
LEFT JOIN fintrip_expense_vouchers v ON t.voucher_id = v.id
WHERE t.created_at BETWEEN FROM_UNIXTIME(1732991401) AND FROM_UNIXTIME(1747918481)
  AND t.company_id = 1848
GROUP BY t.company_id, DATE_FORMAT(t.created_at, '%Y-%m')
ORDER BY t.company_id, DATE_FORMAT(t.created_at, '%Y-%m');




--? find total travel booking data from fintrip_transactions table month wise in given date range in this table we have service column which have vaules as
--* Hotel, Flight, Cab, train, Bus 
--* find total count and amount of these services
--* find distinct ownerIds these services which will be owner_id in fintrip_transaction_owners as table
--* there is join between fintrip_transactions as t0 and fintrip_transaction_owners t1 table on t0.id = t1.transaction_id

SELECT
    t0.company_id,
    DATE_FORMAT(t0.created_at, '%Y-%m') AS month,
    COUNT(DISTINCT CASE WHEN t0.service IN ('Hotel', 'Flight', 'Cab', 'Train', 'Bus') THEN t0.id END ) AS totalBookingCount,
    SUM(CASE WHEN t0.service IN ('Hotel', 'Flight', 'Cab', 'Train', 'Bus') THEN t0.amount ELSE 0 END) AS totalBookingAmt,
    GROUP_CONCAT(DISTINCT CASE WHEN t0.service IN ('Hotel', 'Flight', 'Cab', 'Train', 'Bus') THEN t1.owner_id END) AS ownerIds,
    COUNT(DISTINCT CASE WHEN t0.service = 'Hotel' THEN t0.id END) AS totalHotelBookingCount,
    COUNT(DISTINCT CASE WHEN t0.service = 'Flight' THEN t0.id END) AS totalFlightBookingCount,
    COUNT(DISTINCT CASE WHEN t0.service = 'Cab' THEN t0.id END) AS totalCabBookingCount,
    COUNT(DISTINCT CASE WHEN t0.service = 'Train' THEN t0.id END) AS totalTrainBookingCount,
    COUNT(DISTINCT CASE WHEN t0.service = 'Bus' THEN t0.id END) AS totalBusBookingCount,
    SUM(CASE WHEN t0.service = 'Hotel' THEN t0.amount ELSE 0 END) AS totalHotelBookingAmt,
    SUM(CASE WHEN t0.service = 'Flight' THEN t0.amount ELSE 0 END) AS totalFlightBookingAmt,
    SUM(CASE WHEN t0.service = 'Cab' THEN t0.amount ELSE 0 END) AS totalCabBookingAmt,
    SUM(CASE WHEN t0.service = 'Train' THEN t0.amount ELSE 0 END) AS totalTrainBookingAmt,
    SUM(CASE WHEN t0.service = 'Bus' THEN t0.amount ELSE 0 END) AS totalBusBookingAmt
FROM fintrip_transactions t0
LEFT JOIN fintrip_transaction_owners t1 ON t0.id = t1.transaction_id
WHERE t0.created_at BETWEEN FROM_UNIXTIME(1732991401) AND FROM_UNIXTIME(1747918481)
  AND t0.company_id = 1848
GROUP BY t0.company_id, DATE_FORMAT(t0.created_at, '%Y-%m')
ORDER BY t0.company_id, DATE_FORMAT(t0.created_at, '%Y-%m');


--? find total employee from fintrip_employees table month wise in given date range
--* employee count should be distinct and all employee till till month last date
--! here we require two query one for total employee count and other for total employee count till month last date then will do sum of last month employee count with current month employee count





CREATE TABLE company_analytics (
  id BIGINT NOT NULL AUTO_INCREMENT,
  company_id BIGINT NOT NULL,
  date DATE NOT NULL,
  type VARCHAR(100) NOT NULL,
  content TEXT,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  deleted tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);


CREATE TABLE company_analytics (
  id BIGINT NOT NULL AUTO_INCREMENT,
  company_id BIGINT NOT NULL,
  month VARCHAR(50) NOT NULL,
  start_date datetime(6) NOT NULL,
  end_date datetime(6) NOT NULL,
  type VARCHAR(100) NOT NULL,
  content TEXT,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  deleted tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE KEY unique_company_month_type (company_id, month, type)
);

CREATE TABLE events.company_analytics (
  id BIGINT NOT NULL AUTO_INCREMENT,
  company_id BIGINT NOT NULL,
  month VARCHAR(50) NOT NULL,
  start_date datetime(6) NOT NULL,
  end_date datetime(6) NOT NULL,
  type VARCHAR(100) NOT NULL,
  content TEXT,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  deleted tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE KEY unique_company_month_type (company_id, month, type)
);