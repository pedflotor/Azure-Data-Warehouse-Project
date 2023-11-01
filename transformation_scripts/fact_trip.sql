IF OBJECT_ID('dbo.fact_trip') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.fact_trip
END

CREATE EXTERNAL TABLE [dbo].[fact_trip] WITH(
    LOCATION = 'fact_trip',
    DATA_SOURCE = [udacitywarehouse_udacitywarehouse_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT
        st.trip_id, 
        st.rider_id, 
        st.start_station_id, 
        st.end_station_id, 
        TRY_CONVERT(Datetime, LEFT(st.start_at , 23)) AS started_at, 
        TRY_CONVERT(Datetime, LEFT(st.ended_at , 23)) AS ended_at, 
        st.rideable_type,
        DATEDIFF(SECOND , TRY_CONVERT(Datetime, LEFT(st.start_at , 23)), TRY_CONVERT(Datetime, LEFT(st.ended_at , 23))) / 60 AS duration_in_min,
        DATEDIFF(DAY,  TRY_CONVERT(Datetime, LEFT(sr.birthday , 23)), TRY_CONVERT(Datetime, LEFT(st.start_at , 23))) / 365 AS rider_age

    FROM dbo.staging_trip st
    JOIN dbo.staging_rider sr ON sr.rider_id = st.rider_id
);

SELECT TOP 10 * FROM [dbo].[fact_trip];

