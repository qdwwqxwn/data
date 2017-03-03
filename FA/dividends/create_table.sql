
use FA; 

CREATE TABLE dividends
 (
 symbol    varchar(255) not null,
 datetime  datetime not null,
 dividends decimal(20, 6),     # USD
 PRIMARY KEY (symbol, datetime)
 );

