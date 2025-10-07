create database credit2;

use credit2;

-- Create the table structure with credit_ID as primary key

CREATE TABLE credit_risk (
    credit_ID INT AUTO_INCREMENT PRIMARY KEY,
    person_age INT,
    person_income DECIMAL(15,2),
    person_home_ownership VARCHAR(50),
    person_emp_length DECIMAL(5,2),
    loan_intent VARCHAR(50),
    loan_grade VARCHAR(2),
    loan_amnt DECIMAL(15,2),
    loan_int_rate DECIMAL(5,2),
    loan_status BOOLEAN,
    loan_percent_income DECIMAL(5,2),
    cb_person_default_on_file VARCHAR(1),
    cb_person_cred_hist_length INT
);

Select * from credit_risk;

/*Cleaning the data*/

/*1. Check for Duplicate Entries*/

SELECT 
    person_age,
    person_income,
    person_home_ownership,
    person_emp_length,
    loan_intent,
    loan_grade,
    loan_amnt,
    loan_int_rate,
    loan_status,
    loan_percent_income,
    cb_person_default_on_file,
    cb_person_cred_hist_length,
    COUNT(*) AS duplicate_count
FROM 
    credit_risk
GROUP BY 
    person_age,
    person_income,
    person_home_ownership,
    person_emp_length,
    loan_intent,
    loan_grade,
    loan_amnt,
    loan_int_rate,
    loan_status,
    loan_percent_income,
    cb_person_default_on_file,
    cb_person_cred_hist_length
HAVING 
    COUNT(*) > 1;
    
    /*2. Check for Missing Values*/

SELECT 
    SUM(CASE WHEN person_age IS NULL THEN 1 ELSE 0 END) AS missing_person_age,
    SUM(CASE WHEN person_income IS NULL THEN 1 ELSE 0 END) AS missing_person_income,
    SUM(CASE WHEN person_home_ownership IS NULL THEN 1 ELSE 0 END) AS missing_person_home_ownership,
    SUM(CASE WHEN person_emp_length IS NULL THEN 1 ELSE 0 END) AS missing_person_emp_length,
    SUM(CASE WHEN loan_intent IS NULL THEN 1 ELSE 0 END) AS missing_loan_intent,
    SUM(CASE WHEN loan_grade IS NULL THEN 1 ELSE 0 END) AS missing_loan_grade,
    SUM(CASE WHEN loan_amnt IS NULL THEN 1 ELSE 0 END) AS missing_loan_amnt,
    SUM(CASE WHEN loan_int_rate IS NULL THEN 1 ELSE 0 END) AS missing_loan_int_rate,
    SUM(CASE WHEN loan_status IS NULL THEN 1 ELSE 0 END) AS missing_loan_status,
    SUM(CASE WHEN loan_percent_income IS NULL THEN 1 ELSE 0 END) AS missing_loan_percent_income,
    SUM(CASE WHEN cb_person_default_on_file IS NULL THEN 1 ELSE 0 END) AS missing_cb_person_default_on_file,
    SUM(CASE WHEN cb_person_cred_hist_length IS NULL THEN 1 ELSE 0 END) AS missing_cb_person_cred_hist_length
FROM 
    credit_risk;

/*3. Verify Data Types and Ranges

a) Check for Invalid Values in Numeric Columns*/

SELECT 
    MIN(person_age) AS min_person_age,
    MAX(person_age) AS max_person_age,
    MIN(person_income) AS min_person_income,
    MAX(person_income) AS max_person_income,
    MIN(person_emp_length) AS min_person_emp_length,
    MAX(person_emp_length) AS max_person_emp_length,
    MIN(loan_amnt) AS min_loan_amnt,
    MAX(loan_amnt) AS max_loan_amnt,
    MIN(loan_int_rate) AS min_loan_int_rate,
    MAX(loan_int_rate) AS max_loan_int_rate,
    MIN(cb_person_cred_hist_length) AS min_cb_person_cred_hist_length,
    MAX(cb_person_cred_hist_length) AS max_cb_person_cred_hist_length
FROM 
    credit_risk;
    
    DELETE FROM credit_risk
WHERE 
    person_age > 60 -- Assuming 60 is the maximum valid age
    OR person_emp_length > person_age - 18; -- Assuming employment length cannot exceed possible working years

/* 3b Check for Unexpected Categorical Values*/

SELECT DISTINCT person_home_ownership FROM credit_risk;
SELECT DISTINCT loan_intent FROM credit_risk;
SELECT DISTINCT loan_grade FROM credit_risk;


/*4. Check for Logical Inconsistencies*/

SELECT * FROM credit_risk
WHERE 
    loan_percent_income < 0 OR loan_percent_income > 1;
    
    
/*5. Validate Relationships Between Columns*/    

SELECT * FROM credit_risk
WHERE 
    person_emp_length > person_age - 18;
    
-- Task 1: Analysis for Credit Monitoring
-- Create a risk score based on multiple factors

WITH risk_factors AS (
    SELECT 
        credit_ID,
        loan_status,
        CASE 
            WHEN cb_person_default_on_file = 'Y' THEN 3
            ELSE 0 
        END +
        CASE 
            WHEN loan_percent_income > 0.4 THEN 2
            WHEN loan_percent_income > 0.2 THEN 1
            ELSE 0
        END +
        CASE 
            WHEN person_emp_length < 1 THEN 2
            WHEN person_emp_length < 3 THEN 1
            ELSE 0
        END +
        CASE 
            WHEN cb_person_cred_hist_length < 2 THEN 2
            WHEN cb_person_cred_hist_length < 5 THEN 1
            ELSE 0
        END as risk_score
    FROM credit_risk
)
SELECT 
    risk_score,
    COUNT(*) as total_borrowers,
    AVG(loan_status) * 100 as default_rate,
    CASE 
        WHEN risk_score >= 6 THEN 'Monthly'
        WHEN risk_score >= 3 THEN 'Quarterly'
        ELSE 'Semi-annually'
    END as recommended_monitoring_frequency
FROM risk_factors
GROUP BY risk_score
ORDER BY risk_score DESC;   

-- Task 2: Loan Approval Analysis

-- 2.1 Calculate Loan Approval Score

WITH approval_scoring AS (
    SELECT 
        credit_ID,
        person_age,
        person_income,
        loan_amnt,
        loan_int_rate,
        loan_grade,
        loan_percent_income,
        cb_person_default_on_file,
        cb_person_cred_hist_length,
        person_emp_length,
        -- Income Score (0-3 points)
        CASE 
            WHEN person_income > 120000 THEN 3
            WHEN person_income > 80000 THEN 2
            WHEN person_income > 40000 THEN 1
            ELSE 0
        END +
        -- Debt-to-Income Score (0-3 points)
        CASE 
            WHEN loan_percent_income < 0.1 THEN 3
            WHEN loan_percent_income < 0.2 THEN 2
            WHEN loan_percent_income < 0.3 THEN 1
            ELSE 0
        END +
        -- Credit History Score (0-3 points)
        CASE 
            WHEN cb_person_default_on_file = 'N' AND cb_person_cred_hist_length > 5 THEN 3
            WHEN cb_person_default_on_file = 'N' AND cb_person_cred_hist_length > 2 THEN 2
            WHEN cb_person_default_on_file = 'N' THEN 1
            ELSE 0
        END +
        -- Employment Length Score (0-2 points)
        CASE 
            WHEN person_emp_length > 5 THEN 2
            WHEN person_emp_length > 2 THEN 1
            ELSE 0
        END +
        -- Age Score (0-1 point)
        CASE 
            WHEN person_age >= 25 THEN 1
            ELSE 0
        END as approval_score
    FROM credit_risk
)
SELECT 
    approval_score,
    COUNT(*) as number_of_loans,
    ROUND(AVG(loan_amnt), 2) as avg_loan_amount,
    ROUND(AVG(loan_int_rate), 2) as avg_interest_rate,
    CASE 
        WHEN approval_score >= 10 THEN 'Excellent - Approve with Preferred Rates'
        WHEN approval_score >= 8 THEN 'Good - Standard Approval'
        WHEN approval_score >= 6 THEN 'Fair - Careful Review Required'
        WHEN approval_score >= 4 THEN 'Poor - High Risk'
        ELSE 'Very Poor - Likely Decline'
    END as approval_recommendation,
    CASE 
        WHEN approval_score >= 10 THEN 'Up to 3% below standard rate'
        WHEN approval_score >= 8 THEN 'Standard rate'
        WHEN approval_score >= 6 THEN 'Standard rate + 1-2%'
        WHEN approval_score >= 4 THEN 'Standard rate + 3-4%'
        ELSE 'N/A - Not Recommended'
    END as rate_recommendation
FROM approval_scoring
GROUP BY approval_score
ORDER BY approval_score DESC;

-- 2.2 Identify Potential Policy Violations Based on Approval Score
 -- [Same scoring CTE as above]

WITH approval_scoring AS (
    SELECT 
        credit_ID,
        person_age,
        person_income,
        loan_amnt,
        loan_int_rate,
        loan_grade,
        loan_percent_income,
        cb_person_default_on_file,
        cb_person_cred_hist_length,
        person_emp_length,
        -- Income Score (0-3 points)
        CASE 
            WHEN person_income > 120000 THEN 3
            WHEN person_income > 80000 THEN 2
            WHEN person_income > 40000 THEN 1
            ELSE 0
        END +
        -- Debt-to-Income Score (0-3 points)
        CASE 
            WHEN loan_percent_income < 0.1 THEN 3
            WHEN loan_percent_income < 0.2 THEN 2
            WHEN loan_percent_income < 0.3 THEN 1
            ELSE 0
        END +
        -- Credit History Score (0-3 points)
        CASE 
            WHEN cb_person_default_on_file = 'N' AND cb_person_cred_hist_length > 5 THEN 3
            WHEN cb_person_default_on_file = 'N' AND cb_person_cred_hist_length > 2 THEN 2
            WHEN cb_person_default_on_file = 'N' THEN 1
            ELSE 0
        END +
        -- Employment Length Score (0-2 points)
        CASE 
            WHEN person_emp_length > 5 THEN 2
            WHEN person_emp_length > 2 THEN 1
            ELSE 0
        END +
        -- Age Score (0-1 point)
        CASE 
            WHEN person_age >= 25 THEN 1
            ELSE 0
        END as approval_score
    FROM credit_risk
),
loan_statistics AS (
    SELECT 
        loan_grade,
        AVG(loan_int_rate) as avg_rate,
        STDDEV(loan_int_rate) as std_rate
    FROM credit_risk
    GROUP BY loan_grade
)
SELECT 
    cr.credit_ID,
    cr.loan_grade,
    aps.approval_score,
    cr.loan_amnt,
    cr.loan_int_rate,
    cr.person_income,
    cr.loan_percent_income,
    ls.avg_rate as grade_avg_rate,
    CASE 
        WHEN aps.approval_score >= 10 AND cr.loan_int_rate > 
        ls.avg_rate THEN 'Interest rate too high for excellent score'
        WHEN aps.approval_score < 6 AND cr.loan_amnt > 20000 THEN 'Loan amount too high for poor score'
        WHEN aps.approval_score < 4 AND cr.loan_status = 0 THEN 'Loan approved despite very poor score'
        WHEN cr.loan_percent_income > 0.4 AND cr.loan_amnt > 50000 THEN 'High DTI with large loan amount'
        ELSE 'Within policy guidelines'
    END as policy_assessment
FROM credit_risk cr
JOIN approval_scoring aps ON cr.credit_ID = aps.credit_ID
JOIN loan_statistics ls ON cr.loan_grade = ls.loan_grade
WHERE 
    (aps.approval_score >= 10 AND cr.loan_int_rate > ls.avg_rate) OR
    (aps.approval_score < 6 AND cr.loan_amnt > 20000) OR
    (aps.approval_score < 4 AND cr.loan_status = 0) OR
    (cr.loan_percent_income > 0.4 AND cr.loan_amnt > 50000)
ORDER BY cr.credit_ID;

