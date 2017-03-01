
# Download monthly prices from Yahoo starting from Jan. 1990 to last month
# 
# Usage: 
# get_prices_from_yahoo.sh SYMBOL 

# Example: 
# get_prices_from_yahoo.sh GPS

syear=1990   # starting year

sym=$1

if [ "$sym" == "" ]; then 
  echo Usage
  echo $0 SYMBOL 
  exit -1 
fi 

SYM=${sym^^}    # change to uppercase

wget -O ${SYM}_raw.csv http://chart.finance.yahoo.com/table.csv?s=$SYM\&a=0\&b=1\&c=$syear\&g=m\&ignore=.csv

# insert symbol to first column to match sql table 
awk -v sym=$SYM -v OFS=, '{print sym, $0}' ${SYM}_raw.csv  > ${SYM}.csv 

# load to database

mysql <<EOF
use FA; 
load data local infile '${SYM}.csv' into table prices fields terminated by ',' ignore 1 rows;
EOF


