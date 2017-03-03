
use FA; 

# all numbers in millions except share data

CREATE TABLE annual_reports
 (
 symbol    		varchar(255) not null,
 datetime		datetime not null,
 net_sales          	decimal(20, 6),     
 cost_of_sales      	decimal(20, 6),     
 gross_profit       	decimal(20, 6),     
 operating_expenses 	decimal(20, 6),     
 net_income         	decimal(20, 6),     
 total_assets       	decimal(20, 6),     
 total_liabilities  	decimal(20, 6),     
 current_liabilities  	decimal(20, 6),     
 long_term_liabilities 	decimal(20, 6),     
 long_term_debt        	decimal(20, 6),     
 total_equity       	decimal(20, 6),     
 cash               	decimal(20, 6),     
 inventories        	decimal(20, 6),     
 accounts_receivable	decimal(20, 6),     
 number_of_employees	bigint, 
 PRIMARY KEY (symbol, datetime)
 );

