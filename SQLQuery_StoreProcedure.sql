CREATE PROCEDURE DailyTransaction(
    @start_date DATE,
    @end_date DATE
)
AS
BEGIN
    SELECT 
        CONVERT(VARCHAR, TransactionDate) AS Date,  
        COUNT(*) AS TotalTransactions, 
        SUM(Amount) AS TotalAmount 
    FROM 
        Transactions  
    WHERE 
        TransactionDate BETWEEN @start_date AND @end_date
    GROUP BY 
        CONVERT(VARCHAR, TransactionDate)
    ORDER BY 
        Date;
END;


EXEC DailyTransaction @start_date='2024-01-18', @end_date='2024-01-20';





CREATE PROCEDURE BalancePerCustomer(
    IN customer_name VARCHAR(255)
)
BEGIN
    SELECT 
        c.CustomerName,
        a.AccountType,
        a.Balance,
        a.Balance - COALESCE(SUM(CASE WHEN t.transaction_type = 'Deposit' THEN t.amount ELSE -t.amount END), 0) AS CurrentBalance
    FROM 
        DimCustomer c
        JOIN DimAccount a ON c.customer_id = a.customer_id
        LEFT JOIN FactTransaction t ON a.account_id = t.account_id
    WHERE 
        c.CustomerName = customer_name
        AND a.status = 'active'
    GROUP BY 
        c.CustomerName, a.AccountType, a.Balance;
END




EXEC BalancePerCustomer @name = 'Shelly';