#Question 3: Count records *
#How many taxi trips were there on January 15?

#ANSWER = 53024

# EXECUTED CODE
SELECT 
  CAST(tpep_pickup_datetime AS DATE) as "day",
  count(1) as "count" 
 
FROM 
   yellow_taxi_data t
   
WHERE

tpep_pickup_datetime BETWEEN '2021-01-15' AND '2021-01-16'
   
GROUP BY
  CAST(tpep_pickup_datetime AS DATE)
  ORDER BY "count" DESC 
LIMIT 1;
  

---------------------------------------------------------------------------------------------------------------------

#Question 4: Largest tip for each day *
#On which day it was the largest tip in January? (note: it's not a typo, it's "tip", not "trip")

#ANSWER = 2021-01-20

# EXECUTED CODE
SELECT 
  CAST(tpep_dropoff_datetime AS DATE) as "day",
  count(1) as "count" ,
  MAX(tip_amount) as "tip"
FROM 
   yellow_taxi_data t
   
GROUP BY
  CAST(tpep_dropoff_datetime AS DATE)
  ORDER BY "tip" DESC
LIMIT 1;
-------------------------------------------------------------------------------------------------------------------  
#Question 5: Most popular destination *
#What was the most popular destination for passengers picked up in central park on January 14?
#Enter the zone name (not id). If the zone name is unknown (missing), write "Unknown"

#ANSWER = Upper East Side North

# EXECUTED CODE
SELECT
   CAST(tpep_pickup_datetime AS DATE) AS "day",
   count(1) as "count",
   zones."Zone",
   CONCAT(zpu."Borough",  ' / ', zpu."Zone") AS "pickup_loc",
   CONCAT(zdo."Borough",  ' / ', zdo."Zone") AS "dropoff_loc"
  
FROM
yellow_taxi_data t,
zones,
zones zpu,
zones zdo

WHERE

  t."PULocationID" = zpu."LocationID" AND
  t."DOLocationID" = zdo."LocationID" AND
  zones."Zone"='Central Park' AND
tpep_pickup_datetime BETWEEN '2021-01-14' AND '2021-01-15'
  
GROUP BY
  CAST(tpep_pickup_datetime AS DATE),
  zones."Zone",
  CONCAT(zpu."Borough",  ' / ', zpu."Zone"),
  CONCAT(zdo."Borough",  ' / ', zdo."Zone")
  ORDER BY "day" ASC;

--------------------------------------------------------------------------------------------------------------------
#Question 6: Most expensive route *
#What's the pickup-dropoff pair with the largest average price for a ride (calculated based on total_amount)? 
#Enter two zone names separated by a slashFor example:"Jamaica Bay / Clinton East
#"If any of the zone names are unknown (missing), write "Unknown". For example, "Unknown / Clinton East".

#ANSWER = Alphabet City/Unknown

# EXECUTED CODE
SELECT 
  CAST(tpep_pickup_datetime AS DATE) AS "day",
  count(1) as "count",
  MAX(tpep_dropoff_datetime),
  MAX(total_amount) AS "amount",
  MAX(trip_distance) AS "distance",
  MAX(passenger_count) AS "passenger",
  CONCAT(zpu."Borough",  ' / ', zpu."Zone") AS "pickup_loc",
  CONCAT(zdo."Borough",  ' / ', zdo."Zone") AS "dropoff_loc"
  
FROM 
   yellow_taxi_data t,
   zones,
   zones zpu,
   zones zdo
  
WHERE
  t."PULocationID" = zpu."LocationID" AND
  t."DOLocationID" = zdo."LocationID" 
  
  
GROUP BY
  CAST(tpep_pickup_datetime AS DATE),
  CONCAT(zpu."Borough",  ' / ', zpu."Zone"),
  CONCAT(zdo."Borough",  ' / ', zdo."Zone")
  ORDER BY "amount" DESC
  LIMIT 100;
