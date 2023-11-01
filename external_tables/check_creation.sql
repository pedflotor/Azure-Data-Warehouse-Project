SELECT COUNT (1) AS Count, 'staging_payment' AS Table_name FROM staging_payment
UNION
SELECT COUNT (1) AS Count, 'staging_rider' AS Table_name FROM staging_rider
UNION
SELECT COUNT (1) AS Count, 'staging_station' AS Table_name FROM staging_station
UNION
SELECT COUNT (1) AS Count, 'staging_trip' AS Table_name FROM staging_trip