
3/14/2016

   Steps to download SEC filings

1. Download the quarterly master file: 

 URL example: ftp://ftp.sec.gov/edgar/full-index/2015/QTR1/master.gz

 Sample content: 

CIK|Company Name|Form Type|Date Filed|Filename
--------------------------------------------------------------------------------
1000032|BINCH JAMES G|4|2015-03-03|edgar/data/1000032/0001209191-15-021425.txt
1000045|NICHOLAS FINANCIAL INC|10-Q|2015-02-09|edgar/data/1000045/0001193125-15-038970.txt
...
96793|SUNLINK HEALTH SYSTEMS INC|10-Q|2015-02-18|edgar/data/96793/0001193125-15-052611.txt

The last field can be used to construct the URL to the file by appending "ftp://ftp.sec.gov/" or "https://www.sec.gov/Archives/". 


2. Upload to Cassandra with upload_masterfile_to_db.sh. 

Sample query: 

select date_filed, filename from master_table where company_name ='GAP INC' and form_type='10-Q' allow filtering;



