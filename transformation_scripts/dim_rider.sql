IF OBJECT_ID('dbo.dim_rider') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.dim_rider
END

CREATE EXTERNAL TABLE [dbo].[dim_rider] WITH(
    LOCATION = 'dim_rider',
    DATA_SOURCE = [udacitywarehouse_udacitywarehouse_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
        rider_id,
        first AS first_name,
        last AS last_name,
        address AS address,
        TRY_CONVERT(Datetime, LEFT(birthday , 23)) AS birthday,
        TRY_CONVERT(Datetime, LEFT(account_start_date , 23)) AS account_start_date,
        TRY_CONVERT(Datetime, LEFT(account_end_date , 23)) AS account_end_date,
        CASE
            WHEN [is_member] = 'True' THEN 1 
            WHEN [is_member] = 'False' THEN 0
            ELSE NULL
        END AS is_member

    FROM 
        dbo.staging_rider
);

SELECT TOP 10 * FROM [dbo].[dim_rider];
