LOAD DATA INFILE 'C:\\db_data1\\payments.csv' 
INTO TABLE payments 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';

LOAD DATA INFILE 'C:\\db_data1\\sessions.csv' 
INTO TABLE sessions 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';