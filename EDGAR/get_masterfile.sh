#! /usr/bin/bash

# get last and current quarter's master files. 
# suitable to run in a cron job on a weekly or monthly basis

# sample URL:   https://www.sec.gov/Archives/edgar/full-index/2015/QTR1/master.gz
#for year in `seq 1993 2016`; do 
 # for qtr in 1 2 3 4; do 

for mon in -3 0; do   # last quater and current quarter  
  year=`date -d "$mon months" +%Y`
  month=`date -d "$mon months" +%m`
  qtr=`awk -v m=$month "BEGIN { print int(m/3.1)+1 ; }"`   # get quarter from month
  
  mkdir -p $year/QTR$qtr
  wget -O $year/QTR$qtr/master.gz https://www.sec.gov/Archives/edgar/full-index/$year/QTR$qtr/master.gz
  gunzip -f $year/QTR$qtr/master.gz

done 

