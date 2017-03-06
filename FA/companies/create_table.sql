
use FA; 

CREATE TABLE companies
 (
 symbol    		varchar(255) not null,
 name    		varchar(255), 
 analysis		varchar(8192), 
 PRIMARY KEY (symbol)
 );

