LOAD CSV WITH HEADERS FROM 'https://nyc-tlc.s3.amazonaws.com/trip+data/fhv_tripdata_2021-01.csv' AS row

WITH row
WHERE NOT row.PULocationID IS NULL
  AND NOT row.DOLocationID IS NULL
  AND NOT row.pickup_datetime IS NULL
  AND NOT row.dropoff_datetime IS NULL

MERGE (:PULocationID {id: row.PULocationID})-[r:TO]->(:DOLocationID {id: row.DOLocationID})

ON CREATE SET r.pickup_datetimes  = [apoc.date.parse(row.pickup_datetime,  "ms", "yyyy-MM-dd hh:mm:ss", 'America/New York')],
              r.dropoff_datetimes = [apoc.date.parse(row.dropoff_datetime, "ms", "yyyy-MM-dd hh:mm:ss",'America/New York')]

ON MATCH SET r.pickup_datetimes  = r.pickup_datetimes  + [apoc.date.parse(row.pickup_datetime, "ms", "yyyy-MM-dd hh:mm:ss", 'America/New York')],
             r.dropoff_datetimes = r.dropoff_datetimes + [apoc.date.parse(row.dropoff_datetime, "ms", "yyyy-MM-dd hh:mm:ss",'America/New York')]


