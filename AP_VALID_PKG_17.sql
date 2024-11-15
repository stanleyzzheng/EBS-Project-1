create or replace package AP_VALID_PKG_17 as
	--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Package for Inserting Data from Staging table to Interface Table
-- Author  : Stanley
-- Package Specification and Body AP_VALID_PKG_17
-- History----Version---Author---Comment
-- 04/11/2024   1.0      Stanley     Current as per specification provided
--
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- This procedure will validate and Insert data into Accounts Payable Interface table

	Procedure main(p_errbuf OUT NOCOPY Varchar2,
				   p_retcode OUT NOCOPY Number);
end AP_VALID_PKG_17;