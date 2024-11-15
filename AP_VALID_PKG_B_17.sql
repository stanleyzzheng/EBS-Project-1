CREATE OR REPLACE PACKAGE BODY ap_valid_pkg_17 AS
	--        Global Variable Org ID
	gn_org_id NUMBER;
	gn_user_id NUMBER;
	PROCEDURE main(
--        Error Buffer Code parameter for log
		p_errbuf OUT NOCOPY VARCHAR2,
--        Error Ret code
		p_retcode OUT NOCOPY NUMBER
	) IS
		-- varible for invoice_id
		v_invoice_id      NUMBER;
		-- variable for invoice_line_id
		v_invoice_line_id NUMBER;
		--Create cursor for header table
		CURSOR cur_ap_order_header IS
			SELECT INVOICE_NUM,
				   invoice_type,
				   header_amount,
				   curr_code,
				   source,
				   vendor_number,
				   vendor_site
			FROM AP_INVOICE_IFACE_STG_17 apstg
			GROUP BY invoice_type,
					 invoice_num,
					 curr_code, header_amount, source, vendor_number, vendor_site;
		-- Create cursor for lines table
		CURSOR cur_ap_order_lines IS
			SELECT invoice_type,
				   invoice_num,
				   curr_code,
				   vendor_number,
				   vendor_site,
				   payment_term,
				   header_amount,
				   line_number,
				   description,
				   line_amount,
				   source
			FROM AP_INVOICE_IFACE_STG_17;
	BEGIN
		-- 		Create ORG ID, default to 204
		gn_org_id := nvl(fnd_profile.value('ORG_ID'), 204);
		gn_user_id := nvl(fnd_profile.value('USER_ID'), -1);
		FOR rec IN cur_ap_order_header
			LOOP

				BEGIN
					-- Get the next sequence value for the invoice ID
					SELECT AP_INVOICES_INTERFACE_S.NEXTVAL INTO v_invoice_id FROM dual;
					-- Insert into the AP_INVOICES_INTERFACE table
					INSERT INTO AP_INVOICES_INTERFACE(INVOICE_ID, INVOICE_NUM,
													  INVOICE_TYPE_LOOKUP_CODE,
													  INVOICE_AMOUNT,
													  PAYMENT_CURRENCY_CODE, INVOICE_DATE, SOURCE,
													  ORG_ID, VENDOR_SITE_CODE, VENDOR_NUM,
													  LAST_UPDATE_DATE, LAST_UPDATED_BY,
													  LAST_UPDATE_LOGIN, CREATION_DATE, CREATED_BY)
					VALUES (v_invoice_id, rec.invoice_num, rec.invoice_type,
							rec.header_amount, rec.curr_code,
							SYSDATE,
							rec.source, gn_org_id, rec.vendor_site, rec.vendor_number, SYSDATE,
							gn_user_id, gn_user_id, SYSDATE, gn_user_id);
					-- Now loop through the AP_ORDER_LINES cursor for the corresponding lines
					FOR j IN cur_ap_order_lines
						LOOP
							-- Get the next sequence value for the invoice Line ID
							SELECT AP_INVOICE_LINES_INTERFACE_S.NEXTVAL
							into v_invoice_line_id
							from DUAL;
							-- Insert into the AP_INVOICE_LINES_INTERFACE table
							INSERT INTO AP_INVOICE_LINES_INTERFACE(INVOICE_LINE_ID, INVOICE_ID,
																   LINE_NUMBER,
																   LINE_TYPE_LOOKUP_CODE,
																   AMOUNT, DESCRIPTION, ORG_ID,
																   ACCOUNTING_DATE)
							VALUES (v_invoice_line_id,
									v_invoice_id,
									j.line_number,
									'ITEM',
									j.line_amount,
									j.description,
									gn_org_id,
									SYSDATE);
							fnd_file.put_line(fnd_file.log, 'Line inserted: Invoice ID ' ||
															AP_INVOICES_INTERFACE_S.CURRVAL);
						end loop;

				EXCEPTION
					WHEN OTHERS THEN
						fnd_file.put_line(fnd_file.log, 'Error: ' || SQLERRM);
						RAISE; -- Re-raise to allow the outer process to handle it

				END;


			END LOOP;


		COMMIT;
	END main;

END ap_valid_pkg_17;