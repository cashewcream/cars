*/
This is car dealership startup venture Coursera Worksheet. For this assignment, I cleaned the automobile_data CSV using BigQuery. 
*/
#fuel type
SELECT DISTINCT fuel_type
FROM `my-data-project-1-343921.cars.car_info`

#length
SELECT 
MIN(length) AS min_length,
MAX(length) AS max_length
FROM  `my-data-project-1-343921.cars.car_info`

#missing data
SELECT *
FROM `my-data-project-1-343921.cars.car_info`
WHERE num_of_doors IS NULL;

#update to 4 doors
UPDATE `my-data-project-1-343921.cars.car_info`
SET num_of_doors ="four"
WHERE make = "dodge"
  AND fuel_type = "gas"
  AND body_style = "sedan"
--query will only run with BigQuery Sandbox

#Errors
SELECT DISTINCT num_of_cylinders
FROM `my-data-project-1-343921.cars.car_info`
--mispelling at row 7

# update
UPDATE `my-data-project-1-343921.cars.car_info`
SET num_of_cylinders = "two"
WHERE num_of_cylinders = "tow" 
--query will only run with BigQuery Sandbox

#compression ratio 
SELECT 
MIN(compression_ratio) AS min_compression_ratio,
MAX(compression_ratio) AS max_compression_ratio
FROM `my-data-project-1-343921.cars.car_info`
--returned 70 which is an error 

SELECT 
MIN(compression_ratio) AS min_compression_ratio,
MAX(compression_ratio) AS max_compression_ratio
FROM `my-data-project-1-343921.cars.car_info`
WHERE compression_ratio <> 70;
--min_compression_ratio = 7.0
--max_compression_ratio = 23

#check how many rows with compression_ratio = 70 should be deleted
SELECT COUNT(*) AS num_of_rows_to_delete
FROM `my-data-project-1-343921.cars.car_info`
WHERE compression_ratio = 70;

# Identify the row with error
SELECT *
FROM`my-data-project-1-343921.cars.car_info`
WHERE compression_ratio = 70;

# code to delete error
DELETE *
FROM`my-data-project-1-343921.cars.car_info`
WHERE compression_ratio = 70;
--query will only run with BigQuery Sandbox

# check for inconsistencies
SELECT DISTINCT drive_wheels
FROM `my-data-project-1-343921.cars.car_info`
-- returned: rwd, fwd. 4wd. 4wd

# check for length of string variables 
SELECT DISTINCT drive_wheels,
LENGTH(drive_wheels) AS string_lengths
FROM `my-data-project-1-343921.cars.car_info`

# update 
UPDATE `my-data-project-1-343921.cars.car_info`
SET drive_wheels = TRIM(drive_wheels)
WHERE TRUE
--query will only run with BigQuery Sandbox
