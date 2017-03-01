
use FA; 

CREATE TABLE prices
 (
 symbol    varchar(255) not null,
 datetime  datetime not null,
 open      decimal(20, 6),     
 high      decimal(20, 6),     
 low       decimal(20, 6),     
 close     decimal(20, 6),     
 volume    bigint, 
 adj_close   decimal(20, 6),     
 PRIMARY KEY (symbol, datetime)
 );

