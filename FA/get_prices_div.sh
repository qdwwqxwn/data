
# Get all the symbols from database, then 
# Download monthly prices and quarterly dividend from Yahoo starting from Jan. 1990 to last month
# 
# To be put in cron for monthly runs.   
# 


# get all symbols from database 
export MYSQL_HOME=/home/yudong 

symbols=`mysql -udb -pallpublic -N <<EOF
use FA;
select symbol from companies;
EOF`

for symbol in $symbols; do 
 /data1/yudong/FA/prices/get_prices_from_yahoo.sh $symbol 
 /data1/yudong/FA/dividends/get_div_from_yahoo.sh $symbol
done 




