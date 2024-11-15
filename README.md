# AP Invoice Data Loading Project

## Overview
This project involves loading Accounts Payable (AP) invoice data into the **Oracle E-Business Suite (EBS)** using **PL/SQL** and executing it through a **Concurrent Program**. The solution was designed to automate the process of importing invoice data into the EBS AP interface tables, ensuring efficient data processing and integration with existing AP workflows.

## Features
- **Data Loading**: Utilized PL/SQL scripts to load AP invoice data into the appropriate interface tables in Oracle EBS.
- **Concurrent Executable**: Integrated with the EBS concurrent processing framework to enable the automated execution of the data load.
- **Error Handling**: Built-in error checks and logging to capture issues during the data load process and provide easy troubleshooting.
- **Scalability**: Can handle large volumes of invoice data, designed to run as a concurrent program for batch processing.

## Prerequisites
Before running the project, ensure the following:
- Oracle **E-Business Suite (EBS)** is properly configured.
- Access to the **AP Interface Tables** in the EBS database (e.g., `AP_INVOICES_INTERFACE`, `AP_INVOICE_LINES_INTERFACE`).
- Adequate privileges for creating and executing **Concurrent Programs**.
- **PL/SQL** environment set up for executing the scripts.
- Oracle **SQL*Plus** or a similar SQL client for testing the PL/SQL code.

## Setup

### 1. **Prepare Data**
Ensure that the invoice data is structured and ready to be loaded into the AP interface tables. This typically involves:
- Mapping external invoice data to the structure of the EBS AP tables.
- Ensuring data integrity (correct vendor IDs, valid invoice amounts, etc.).

### 2. **PL/SQL Script for Data Loading**
The core of this project is the PL/SQL script that loads invoice data into the interface tables. Below is a basic structure for the script:

```sql
DECLARE
    -- Declare necessary variables for processing invoices
BEGIN
    -- Loop through invoice data and insert into AP interface tables
    FOR i IN 1..:invoice_count LOOP
        INSERT INTO AP_INVOICES_INTERFACE
            (INVOICE_ID, VENDOR_ID, INVOICE_AMOUNT, INVOICE_DATE, ...) 
        VALUES
            (:invoice_id(i), :vendor_id(i), :invoice_amount(i), :invoice_date(i), ...);
        
        INSERT INTO AP_INVOICE_LINES_INTERFACE
            (LINE_ID, INVOICE_ID, LINE_AMOUNT, LINE_DESCRIPTION, ...) 
        VALUES
            (:line_id(i), :invoice_id(i), :line_amount(i), :line_description(i), ...);
    END LOOP;
    
    -- Commit the transaction to save changes
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        -- Handle errors, rollback if necessary
        ROLLBACK;
        -- Log the error
        DBMS_OUTPUT.PUT_LINE('Error loading invoice data: ' || SQLERRM);
END;
