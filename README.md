# nyctripdata
NYC trips

# Design Decisions
1. The dataset was chosen due to some parallels with a network access data
2. Nodes represent locations. It represents the real world more closely and also helps writing queries such as which nodes are most frequenly visited
3. Columns other than timestamps and locationid's were dropped

# Known Issues

1. The timezone is captured as UTC+5:30. It is actually NY time. How do we deal with Daylight Savings?
2. Rows with null values are not captured. 
