/*
=================================================================================
DDL Script: Create Bronze Tables
=================================================================================
 >> This scripts create tables in the 'bronze' schema,dropping existing tables 
 if they already exists.
 Run this scripts to re-define the DDL structure of 'bronze' Tables
 =================================================================================
*/
CREATE TABLE bronze.crm_lab_test(
report_agency VARCHAR(50),
location NVARCHAR(50),
test_type NVARCHAR(50),
number_patient INT,
gender VARCHAR(50),
month VARCHAR(50),
test_id INT

);

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
