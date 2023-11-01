IF OBJECT_ID('dbo.dim_date') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.dim_date
END

CREATE EXTERNAL TABLE [dbo].[dim_date] WITH(
    LOCATION = 'dim_date',
    DATA_SOURCE = [udacitywarehouse_udacitywarehouse_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT
        TRY_CONVERT(BIGINT, payment_id) AS date_id,
        TRY_CONVERT(Datetime, LEFT(date , 23)) AS date,
        DATEPART(DAY, TRY_CONVERT(Datetime, LEFT(date , 23))) AS day,
        DATEPART(MONTH, TRY_CONVERT(Datetime, LEFT(date , 23))) AS month, 
        DATEPART(QUARTER, TRY_CONVERT(Datetime, LEFT(date , 23))) AS quarter,
        DATEPART(YEAR, TRY_CONVERT(Datetime, LEFT(date , 23))) AS  year,
        DATEPART(DAYOFYEAR,TRY_CONVERT(Datetime, LEFT(date , 23))) AS day_of_year,
        DATEPART(WEEKDAY,TRY_CONVERT(Datetime, LEFT(date , 23))) AS day_of_week

    FROM
        dbo.staging_payment
);

SELECT TOP 10 * FROM [dbo].[dim_date];


