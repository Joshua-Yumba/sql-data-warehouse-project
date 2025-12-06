/*
===========================================================
Store Procedure : Load Bronze Layer (Source -> Brone)
===========================================================
*/

CREATE TABLE bronze.crm_screening_rslt(
location NVARCHAR(50),
hospital NVARCHAR(50),
result_status VARCHAR(50),
gender VARCHAR(50),
number_patient INT,
month VARCHAR(50),
screening_id INT,
screening_rslt_id INT

);

CREATE TABLE bronze.crm_screeningdescription(
location NVARCHAR(50),
county NVARCHAR(50),
sub_county VARCHAR(50),
village VARCHAR(50),
number_patient INT,
month VARCHAR(50),
screening_id INT,

);

CREATE TABLE bronze.erp_stocks(
location NVARCHAR(50),
stocks_period NVARCHAR(50),
quantity INT,
month VARCHAR(50),
stock_id INT,

);

CREATE TABLE bronze.erp_treatement(
category NVARCHAR(50),
hospital NVARCHAR(50),
month VARCHAR(50),
gender VARCHAR(50),
number_patient INT,
treatement_id INT,

);

CREATE TABLE bronze.erp_report(
location NVARCHAR(50),
week VARCHAR(50),
start_date date,
end_date date,
adm_prim_kala_azar INT,
gender VARCHAR(50),
Adm_pkdl INT,
Amd_relapse_kala_azar INT,
adm_age_under_five_years INT,
adm_age_between_five_and_fourteen_years INT,
Adm_age_under_five_years_and_above INT,
Treat_and_drug_adv_rx_ka_patients_with_treatment_failure INT,
Treat_and_drug_adv_rx_adverse_event_reported_during_treatment INT,
Treat_and_drug_adv_rx_reported_adverse_events_received_medical_attentions INT,
Exits_discharge INT,
Exits_death INT,
Exits_defaulter INT,
Exits_transfer_out_referal_male INT,
Program_sum_reviously_under_treatment INT,
Program_total_admissions INT,
Program_total_exits INT,
Program_currently_under_treatment INT,
Program_total_cumulative INT,
report_id INT
);

CREATE OR ALTER PROCEDURE bronze.load_bronze AS

BEGIN
    DECLARE @start_time DATETIME,@end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME;
	BEGIN TRY 
	     
        SET @batch_start_time=GETDATE()
		PRINT '=================================================================='
		PRINT 'LOADING BRONZE Layer'
		PRINT '=================================================================='

		PRINT '------------------------------------------------------------------'
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------------------------------------'
		   
				SET @start_time=GETDATE();
				PRINT '>> Truncating Table : bronze.crm_lab_test'
				TRUNCATE TABLE bronze.crm_lab_test ;

				PRINT '>> Inserting Data Into : bronze.crm_lab_test'
				BULK INSERT bronze.crm_lab_test 
				FROM 'E:\CRM\Lab_test.csv'
				WITH(
				FIRSTROW=2,
				FIELDTERMINATOR=',',
				TABLOCK
				);

				SET @end_time=GETDATE();
				PRINT '>> Load Duration'+ CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
				PRINT'>> -------------------------'


				SET @start_time=GETDATE();
				PRINT '>> Truncating Table : bronze.crm_screening'
				TRUNCATE TABLE bronze.crm_screening ;

				PRINT '>> Inserting Data Into : bronze.crm_screening'
				BULK INSERT bronze.crm_screening 
				FROM 'E:\CRM\Screening.csv'
				WITH(
				FIRSTROW=2,
				FIELDTERMINATOR=',',
				TABLOCK

				);
				SET @end_time=GETDATE();
				PRINT '>> Load Duration'+ CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
				PRINT'>> -------------------------'


				
				SET @start_time=GETDATE();
				PRINT '>> Truncating Table : bronze.crm_screening_rslt'
				TRUNCATE TABLE bronze.crm_screening_rslt ;

				PRINT '>> Inserting Data Into : bronze.crm_screening'
				BULK INSERT bronze.crm_screening_rslt 
				FROM 'E:\CRM\Screen_rslt.csv'
				WITH(
				FIRSTROW=2,
				FIELDTERMINATOR=',',
				TABLOCK

				);
				SET @end_time=GETDATE();
				PRINT '>> Load Duration'+ CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
				PRINT'>> -------------------------'



				PRINT '------------------------------------------------------------------'
				PRINT 'Loading ERP Tables';
				PRINT '------------------------------------------------------------------'


				
				SET @start_time=GETDATE();
				PRINT '>> Truncating Table : bronze.erp_report'

				TRUNCATE TABLE bronze.erp_report ;

				PRINT '>> Inserting Data Into : bronze.erp_report'

				BULK INSERT bronze.erp_report 
				FROM 'E:\ERP\Weekly_report_Good_sharped.csv'
				WITH(
				FIRSTROW=2,
				FIELDTERMINATOR=',',
				TABLOCK

				);


				ALTER TABLE bronze.erp_stocks
				ALTER COLUMN stocks_period VARCHAR(100);

				SET @end_time=GETDATE();
				PRINT '>> Load Duration'+ CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
				PRINT'>> -------------------------'
				
				
				
				SET @start_time=GETDATE();
				PRINT '>> Truncating Table : bronze.erp_stocks'
				TRUNCATE TABLE bronze.erp_stocks ;

				PRINT '>> Inserting Data Into : bronze.erp_stocks'
				BULK INSERT bronze.erp_stocks 
				FROM 'E:\ERP\Stocks.csv'
				WITH(
				FIRSTROW=2,
				FIELDTERMINATOR=',',
				TABLOCK

				);

				ALTER TABLE bronze.erp_treatement
				ALTER COLUMN category VARCHAR(200);
				SET @end_time=GETDATE();
				PRINT '>> Load Duration'+ CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
				PRINT'>> -------------------------'


				
				SET @start_time=GETDATE();
				PRINT '>> Truncating Table : bronze.erp_treatement'
				TRUNCATE TABLE bronze.erp_treatement ;

				PRINT '>> Inserting Data Into : bronze.erp_treatement'
				BULK INSERT bronze.erp_treatement 
				FROM 'E:\ERP\Treatement.csv'
				WITH(
				FIRSTROW=2,
				FIELDTERMINATOR=',',
				TABLOCK

				);
				SET @end_time=GETDATE();
				PRINT '>> Load Duration'+ CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
				PRINT'>> -------------------------'

				SET @batch_end_time=GETDATE();
				PRINT '================================================='
				PRINT 'Loading BronzeLayer is Completed'
				PRINT '      Total Load Duration : '+CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR) + 'seconds'
				PRINT '================================================='
	END TRY 
	BEGIN CATCH
		PRINT'================================================================'
		PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT'Error Message' + ERROR_MESSAGE();
		PRINT'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT'================================================================'
	END CATCH

END
