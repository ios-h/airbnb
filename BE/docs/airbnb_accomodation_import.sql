show global variables like 'local_infile';

set global local_infile = true;

set FOREIGN_KEY_CHECKS = 0;

truncate table accommodation;

set FOREIGN_KEY_CHECKS = 1;

LOAD DATA LOCAL INFILE '/Users/swjeong/Documents/workspace/codesquad/airbnb/BE/docs/airbnb_accommodation.csv'
    INTO TABLE accommodation
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;

select * from accommodation;
