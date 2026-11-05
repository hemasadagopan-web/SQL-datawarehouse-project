/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None.
      This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;

Note:
    The BULK INSERT paths point to 'C:\sql\dwh_project\01_datasets\'.
    Change them to the folder where you saved the datasets.
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze as 

Begin 

DECLARE @START_TIME DATETIME,@END_TIME DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
Begin TRY 
        SET @batch_start_time= GETDATE();
		PRINT '======================================';
		PRINT 'Loading Bronze Layer';
		PRINT '======================================';

		PRINT '-------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-------------------------------------';

		SET @START_TIME= GETDATE();

		PRINT '>>Truncating Table:bronze.crm_cust_info ';

		Truncate table bronze.crm_cust_info

		PRINT '>>Inserting Data into:bronze.crm_cust_info ';

		bulk insert bronze.crm_cust_info 
		from 'C:\Users\HESAD\OneDrive - Inter IKEA Group\Desktop\Hema learning\DataWareHouse Project\source_crm\cust_info.csv'
		with (
		firstrow =2,
		FIELDTERMINATOR = ',',
		TABLOCK

		);

		SET @END_TIME = GETDATE();

		PRINT '>> Load duration: ' + CAST (DATEDIFF (SECOND,@START_TIME,@END_TIME) AS NVARCHAR ) + 'Seconds';
		PRINT '>>---------------------------------------------------';


		SET @START_TIME= GETDATE();

		PRINT '>>Truncating Table:bronze.crm_prd_info ';

		truncate table  bronze.crm_prd_info 

		PRINT '>>Inserting Data into:bronze.crm_prd_info ';

		bulk insert bronze.crm_prd_info 
		from 'C:\Users\HESAD\OneDrive - Inter IKEA Group\Desktop\Hema learning\DataWareHouse Project\source_crm\prd_info.csv'
		with (
		firstrow=2,
		fieldterminator=',',
		tablock

		);

		SET @END_TIME = GETDATE();
		PRINT '>> Load duration: ' + CAST (DATEDIFF (SECOND,@START_TIME,@END_TIME) AS NVARCHAR ) + 'Seconds';
		PRINT '>>---------------------------------------------------';

		SET @START_TIME= GETDATE();

		PRINT '>>Truncating Table:bronze.crm_sales_details ';

		truncate table bronze.crm_sales_details

		PRINT '>>Inserting Data into:bronze.crm_sales_details ';

		bulk insert bronze.crm_sales_details
		from 'C:\Users\HESAD\OneDrive - Inter IKEA Group\Desktop\Hema learning\DataWareHouse Project\source_crm\sales_details.csv'
		with (
		firstrow=2,
		fieldterminator = ',',
		tablock
		);

		SET @END_TIME = GETDATE();
		PRINT '>> Load duration: ' + CAST (DATEDIFF (SECOND,@START_TIME,@END_TIME) AS NVARCHAR ) + 'Seconds';
		PRINT '>>---------------------------------------------------';


		PRINT '-------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '-------------------------------------';


		SET @START_TIME= GETDATE();

		PRINT '>>Truncating Table:bronze.erp_cust_az12 ';

		truncate table bronze.erp_cust_az12

		PRINT '>>Inserting Data into:bronze.erp_cust_az12 ';


		bulk insert bronze.erp_cust_az12
		from 'C:\Users\HESAD\OneDrive - Inter IKEA Group\Desktop\Hema learning\DataWareHouse Project\source_erp\cust_az12.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);

		SET @END_TIME = GETDATE();
		PRINT '>> Load duration: ' + CAST (DATEDIFF (SECOND,@START_TIME,@END_TIME) AS NVARCHAR ) + 'Seconds';
		PRINT '>>---------------------------------------------------';


		PRINT '>>Truncating Table:bronze.erp_loc_a101 ';

		SET @START_TIME= GETDATE();

		truncate table bronze.erp_loc_a101

		PRINT '>>Inserting Data into:bronze.erp_loc_a101 ';

		bulk insert bronze.erp_loc_a101
		from 'C:\Users\HESAD\OneDrive - Inter IKEA Group\Desktop\Hema learning\DataWareHouse Project\source_erp\loc_a101.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);

		SET @END_TIME = GETDATE();
		PRINT '>> Load duration: ' + CAST (DATEDIFF (SECOND,@START_TIME,@END_TIME) AS NVARCHAR ) + 'Seconds';
		PRINT '>>---------------------------------------------------';


		SET @START_TIME= GETDATE();

		PRINT '>>Truncating Table:bronze.erp_px_cat_g1v2 ';

		truncate table bronze.erp_px_cat_g1v2

		PRINT '>>Inserting Data into:bronze.erp_px_cat_g1v2 ';

		bulk insert bronze.erp_px_cat_g1v2 
		from 'C:\Users\HESAD\OneDrive - Inter IKEA Group\Desktop\Hema learning\DataWareHouse Project\source_erp\px_cat_g1v2.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);

		SET @END_TIME = GETDATE();
		PRINT '>> Load duration: ' + CAST (DATEDIFF (SECOND,@START_TIME,@END_TIME) AS NVARCHAR ) + 'Seconds';
		PRINT '>>---------------------------------------------------';

		SET @batch_end_time=GETDATE();
		PRINT '================================================================';
		PRINT 'Loading Bronze Layer is completed';
		PRINT ' - Total Load Duration: ' + CAST (DATEDIFF (SECOND ,@batch_start_time ,@batch_end_time) AS NVARCHAR ) + 'Seconds';
		PRINT '================================================================';



END TRY

BEGIN CATCH
    PRINT '================================================================'
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT 'Error Message: ' + ERROR_MESSAGE();
    PRINT 'Error Number: ' + CAST (ERROR_NUMBER() AS NVARCHAR);
    PRINT 'Error State: ' + CAST (ERROR_STATE() AS NVARCHAR);

	PRINT '================================================================'
END CATCH

END
