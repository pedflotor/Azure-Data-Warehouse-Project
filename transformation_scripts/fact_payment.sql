IF OBJECT_ID('dbo.fact_payment') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.fact_payment
END

CREATE EXTERNAL TABLE [dbo].[fact_payment] WITH(
    LOCATION = 'fact_payment',
    DATA_SOURCE = [udacitywarehouse_udacitywarehouse_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
        payment_id,
        TRY_CONVERT(BIGINT, payment_id) AS date_id,
        rider_id,
        TRY_CONVERT(DECIMAL(18, 2), amount) AS amount

    FROM 
        dbo.staging_payment
);

SELECT TOP 10 * FROM [dbo].[fact_payment];
