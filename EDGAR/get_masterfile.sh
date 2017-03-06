
# sample URL:  ftp://ftp.sec.gov/edgar/full-index/2015/QTR1/master.gz
for year in `seq 1993 2016`; do 
#for year in 2016;  do 
  for qtr in 1 2 3 4; do 
  
  mkdir -p $year/QTR$qtr
  wget -O $year/QTR$qtr/master.gz https://www.sec.gov/Archives/edgar/full-index/$year/QTR$qtr/master.gz
  gunzip $year/QTR$qtr/master.gz

 done 
done 

