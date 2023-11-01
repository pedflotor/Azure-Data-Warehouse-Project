IF OBJECT_ID('dbo.dim_station') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.dim_station
END

CREATE EXTERNAL TABLE [dbo].[dim_station] WITH(
    LOCATION = 'dim_station',
    DATA_SOURCE = [udacitywarehouse_udacitywarehouse_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
        station_id,
        name,
        TRY_CAST([latitude] AS DECIMAL(8, 6)) AS latitude,
        TRY_CAST([longitude] AS DECIMAL(9, 6)) AS longitude

    FROM 
        dbo.staging_station
);

SELECT TOP 10 * FROM [dbo].[dim_station];
