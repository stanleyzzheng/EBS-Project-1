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

1. Create the staging table
- run the SQL script in your preferred IDE of choice

![image](https://github.com/user-attachments/assets/541e426e-ec8a-4c15-b026-f3f94a523c32)

2. Move the Files (*.csv & *.ctl) into the EBS Server with WinSCP application
- copy the AP17.ctl file into $FND_TOP/bin

  ![image](https://github.com/user-attachments/assets/5fc24058-e0a4-4cf4-bdc3-ffa60479f12d)
- Copy the AP_DATA_17.csv file into /home/oracle
  
  ![image](https://github.com/user-attachments/assets/6c5ef624-1dc8-4f36-9c76-861291fbbaed)
     
3. Create the Concurrent Executable
- Responsibility: Application Developer > Concurrent > Executable
   ```
   Executable: Ap_Data_loader_XX
   Short Name: AP_DL_XX
   Application: Application Object Library
   Execution Method: SQL* Loader
   Execution File Name: AP17 ( referencing AP17.CTL file)
   File: Save
![image](https://github.com/user-attachments/assets/ad9acda1-817c-4360-b6ed-2fd014c35bce)

4. Create the Concurrent Program
   - Responsibility: Application Developer > Concurrent > Program
   ```
   Program: AP_Data_Loader_XX
   Short Name: APDL_XX
   Application: Application Object Library
   Executable Name: AP_DL_17
      
![image](https://github.com/user-attachments/assets/c4f991c4-c8a7-4430-8098-9a891cafe3be)
- Parameters(G):
  ```
  Seq: 10
  Parameter: P_DATA_FILE
  Value Set: 30 Characters
  Display Size: 30
  Prompt: P_DATA_FILE
  LOV Prompt: P_DATA_FILE
![image](https://github.com/user-attachments/assets/89e63d05-9bf0-41eb-bd6a-b34bed821e43)


5. Create a new request for the concurrent program
   - Responsibility: Application Developer > View > Requests > New Request
     ![image](https://github.com/user-attachments/assets/44c1e202-97b6-4d6d-9be1-ea7453b81f04)


### 2. **PL/SQL Script for Data Loading**

