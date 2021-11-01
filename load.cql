LOAD CSV WITH HEADERS FROM 'https://nyc-tlc.s3.amazonaws.com/trip+data/fhv_tripdata_2021-01.csv' AS row

WHERE NOT row.pulocationid IS NULL 
  AND NOT row.dolocationid IS NULL 
  AND NOT row.pickup_datetime IS NULL 
  AND NOT row.dropoff_datetime IS NULL

MERGE (:PULocationID {id: row.pulocationid})-[r:TO]->(:DOLocationID {id: row.dolocationid})

ON CREATE SET r.pickup_datetimes  = [apoc.date.parse(row.pickup_datetime,  "ms", "MM/dd/yyyy hh:mm:ss aa", 'America/New York')], 
              r.dropoff_datetimes = [apoc.date.parse(row.dropoff_datetime, "ms", "MM/dd/yyyy hh:mm:ss aa",'America/New York')]

ON MATCH SET r.pickup_datetimes  = r.pickup_datetimes  + [apoc.date.parse(row.pickup_datetime, "ms", "MM/dd/yyyy hh:mm:ss aa", 'America/New York')], 
             r.dropoff_datetimes = r.dropoff_datetimes + [apoc.date.parse(row.dropoff_datetime, "ms", "MM/dd/yyyy hh:mm:ss aa",'America/New York')]
