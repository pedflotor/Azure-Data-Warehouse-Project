IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'udacitywarehouse_udacitywarehouse_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [udacitywarehouse_udacitywarehouse_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://udacitywarehouse@udacitywarehouse.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.staging_trip (
	[trip_id] nvarchar(4000),
	[rideable_type] nvarchar(4000),
	[start_at] nvarchar(4000),
	[ended_at] nvarchar(4000),
	[start_station_id] nvarchar(4000),
	[end_station_id] nvarchar(4000),
	[rider_id] nvarchar(4000)
	)
	WITH (
	LOCATION = 'publictrip.csv',
	DATA_SOURCE = [udacitywarehouse_udacitywarehouse_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.staging_trip
GO
