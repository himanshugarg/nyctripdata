![image](https://user-images.githubusercontent.com/2392803/139659140-e259feb0-2a87-474e-b5b8-78b65bac33e7.png)


# TLC Trip Record Data
[CQL](https://github.com/himanshugarg/nyctripdata/blob/main/load.cql) to populate neo4j database with [TLC Trip Record Data](https://www1.nyc.gov/site/tlc/about/tlc-trip-record-data.page)

# Sample
dispatching_base_num	| pickup_datetime | 	dropoff_datetime	| PULocationID	| DOLocationID	| SR_Flag |	Affiliated_base_number
--|--|--|--|--|--|--
B00419	| 1/1/2021 0:00 | 1/1/2021 0:00 | 60  | 60  |	B00419
B00419	| 1/1/2021 0:14	| 1/1/2021 0:14	| 241 | 241	|	B00419
B00419	| 1/1/2021 0:21	| 1/1/2021 0:21	| 18  | 18	|	B00419
B00419	| 1/1/2021 0:34	| 1/1/2021 0:34	| 159	| 159	|	B00419
B00445	| 1/1/2021 0:27	| 1/1/2021 0:42 | 152 | 16	|	B00445
B00445	| 1/1/2021 0:36	| 1/1/2021 0:40	| 15  | 252	| B00445

# Design Considerations
1. We chose this dataset due to some parallels with a network access data.
2. Nodes represent locations. It represents the real world more closely and also helps writing queries such as which nodes are most frequenly visited. An alternative was to record timestamps as nodes.
3. We dropped columns other than timestamps and locationid's. They are probably useful but add more complexity than we need to deal with now. We record trips as relationships. Tracking providers would require storing it a as an array parallel to the pickup and drop time arrays.
4. We didn't write glue scripts to clean the data to reduce the moving parts. That makes the `load csv` complex.

# TODO: Queries of Interest
1. In a time interval what are the locations that are destinations of most trips?
2. What are the busiest routes?
3. What are the busiest time intervals?

# Known Issues
1. The timezone is captured as UTC+5:30. It is actually NY time. How do we deal with Daylight Savings?
2. Rows with null values are not captured. 

# Notes for Later
1. Populate a small subset of the dataset
2. Run the queries you planned 
3. Refine the model
4. Populate the full dataset
