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

## **Prepare Data**

1. Create the staging table
   
   
    - run AP_INVOICE_IFACE_STG_17.SQL script in your IDE

![image](https://github.com/user-attachments/assets/541e426e-ec8a-4c15-b026-f3f94a523c32)

2. Move the Files (.csv & .ctl) into the EBS Server with WinSCP application
   
- copy the AP17.ctl file into $FND_TOP/bin

![image](https://github.com/user-attachments/assets/5fc24058-e0a4-4cf4-bdc3-ffa60479f12d)
    
     
- copy the AP_DATA_17.csv file into /home/oracle

![image](https://github.com/user-attachments/assets/6c5ef624-1dc8-4f36-9c76-861291fbbaed)
     
3. Create the Concurrent Executable
   ```
   Replace XX with your team number
   Responsibility: Application Developer > Concurrent > Executable
   Executable: Ap_Data_loader_XX
   Short Name: AP_DL_XX
   Application: Application Object Library
   Execution Method: SQL* Loader
   Execution File Name: AP17 ( referencing AP17.CTL file)
   File: Save
![image](https://github.com/user-attachments/assets/ad9acda1-817c-4360-b6ed-2fd014c35bce)

4. Create the Concurrent Program
   ```
   Replace XX with your team number
   Responsibility: Application Developer > Concurrent > Program
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
   ```
   Replace XX with your team number
   Responsibility: Application Developer > View > Requests > Submit a New Request
   Name: AP_Data_Loader_XX
   Parameter: /home/oracle/AP_DATA_XX.csv
   Submit
![image](https://github.com/user-attachments/assets/f2075978-1236-438e-a354-fb40622360b4)
![image](https://github.com/user-attachments/assets/fa5873ce-8c86-4e4f-9b60-4c6506d76ca7)


## AP Interface Inbound Loader
1. Create Package Specification, and run script
![image](https://github.com/user-attachments/assets/76dbd09f-f270-4f0a-b04c-7eb8a23b20ee)

2. Create Package Body, and run script
![image](https://github.com/user-attachments/assets/1182be80-cd2e-49c3-90ac-e971aca1bf80)

3. Create Concurrent Executable in EBS UI
    ```
    Replace XX with your team number
    Responsibility: Application Developer > Concurrent > Executable
    Executable: AP_Interface_XX
    Short Name: AP_Interface_XX
    Application: Application Object Library
    Execution Method: PL/SQL Stored Procedure
    Execution File Name: ap_valid_pkg_XX.main
![image](https://github.com/user-attachments/assets/9569f9ab-1e47-414c-8395-a417866aabef)

4. Create Concurrent Program
    ```
   Replace XX with your team number
   Responsibility: Application Developer > Concurrent > Program
   Program: AP_Interface_XX
   Short name: AP_Interface_XX
   Application: Application Object Library
   Executable Name: AP_Interface_XX
   
![image](https://github.com/user-attachments/assets/463279c3-c1f0-4546-84bc-32445c5b9bea)

5. Submit new Concurrent Request
    ```
    Responsibility: Application Developer > View > Request > Submit a new Request
    Name: AP_Interface_17
    Submit
![image](https://github.com/user-attachments/assets/02c3930b-44f8-442f-a03f-f16020020f90)



    

